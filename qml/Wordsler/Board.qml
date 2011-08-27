import Qt 4.7

Rectangle {
//    width: 600
//    height: 380
    property alias count: deckTotal.count;
    property bool isTimerGame: timerfuse.visible
    signal endGame (int score);
    signal wordPlayed (string wordScore, string word);
    signal cardMoved;

    Background {}

    property alias pileModel: pileModel
    property bool verify: false
    property bool isValidWord: false
    property alias lastWordText: lastWord.text
    property int score: 0;

    function getWord() {
        return choicesModel.getWord();
    }

    function resetChoices() {
        var tmp = choicesModel.count;
        choicesModel.clear();
        // Return the number of cards we need to deal
        return tmp
    }

    function getExtraPoints() {
        var extra_points = {2: 0, 3: 1, 4: 3, 5: 6, 6: 10, 7: 15, 8: 21 };
        return extra_points[choicesModel.count];
    }

    function getCurrentWordScore() {
        var tmp = 0;
        for (var i=choicesModel.count-1; i>=0; i--) {
            //console.log(pileModel.get(i).cardText);
            var t = choicesModel.get(i).card;
            tmp += parent.getScoreForLetter(t);
        }
        // Letter score + extra points for long words
        return tmp+getExtraPoints();
    }

    function removeSelected() {
        var tmp = 0;
        var cnt = 0;
        for (var i=pileModel.count-1; i>=0; i--) {
            //console.log(pileModel.get(i).cardText);
            if (pileModel.get(i).selected) {
                //console.log(i);

                // If the first 4 cards are being replaced, we need to workaround a gridview bug
                if (i<=3) {
                    cnt += 1;
                }
                tmp += 1;
                pileModel.remove(i);
            }
        }

        // If the first 4 cards are being replaced and we're in portrait mode, we need to workaround a gridview bug
        if ((cnt==4) && (height>width)) {
            pile.model = null;
            pile.model = pileModel;
        }

        validateArea.enabled = true;
        return tmp;
    }

    function clearSelected() {
        for (var i=pileModel.count-1; i>=0; i--) {
            //console.log(pileModel.get(i).selected);
            pileModel.get(i).selected = false;
            //console.log(pileModel.get(i).selected);
        }
        validateArea.enabled = true;
    }

    function initialize() {
        pileModel.clear();
        choicesModel.clear();
        lastWord.text = "";

        score = 0;
    }

    function setTimer() {
        timerfuse.visible = true;
        timerfuse.startTimer(120);
    }

    function stopTimer() {
        timerfuse.visible = false;
        timerfuse.stopTimer();
    }

    Column {
        id: mainColumn
        width: parent.width
        height: parent.height

        Item {
            id: barRow
            width: parent.width
            height: settings.barRowHeight+20;

            Row {
                width: parent.width
                height: parent.height

                Scoreboard {
                    id: scoreboard
                    //width: board.width - deckTotal.width
                }
                Item {
                    TimerFuse {
                        id: timerfuse
                        visible: false
                        width: parent.width - 30
                        anchors.horizontalCenter: parent.horizontalCenter

                        onTimerEnd: board.endGame(board.score);
                    }
                    height: parent.height
                    width: board.width - deckTotal.width - scoreboard.width

                }

                DeckInfo {
                    id: deckTotal
                }
            }
        }

        GridView {
            id: pile
            width: (parent.width>parent.height)? 8*(settings.cardWidth+4) : 4*(settings.cardWidth+4)
            height: (parent.width>parent.height)? settings.cardHeight+6 : (settings.cardHeight+6)*2
            model: pileModel
            cellWidth: settings.cardWidth+4; cellHeight: settings.cardHeight + 6
            anchors.horizontalCenter: parent.horizontalCenter
            interactive: false

            delegate: PileDelegate {}
            MouseArea {
                property int currentId: -1                // Original position in model
                property int newIndex                // Current Position in model
                property int index: pile.indexAt(mouseX, mouseY) // Item underneath cursor
                id: loc
                anchors.fill: parent
                onPressAndHold: currentId = pileModel.get(newIndex = index).gridId
                onReleased: currentId = -1
                onMousePositionChanged: {
                    if (loc.currentId != -1 && index != -1 && index != newIndex) {
                        //console.log(index + " " +newIndex+ " " + currentId + " "+pileModel.get(index).gridId)
                        pileModel.move(newIndex, newIndex = index, 1)
                    }
                }
                onClicked: {
                    var ind = pile.indexAt(mouseX, mouseY);
                    if (!pileModel.get(ind).selected) {
                        choicesModel.append( { card: pileModel.get(ind).cardText } );
                    } else {
                        choicesModel.remove( choicesModel.getIndex(pileModel.get(ind).cardText));
                    }
                    pileModel.get(ind).selected = !pileModel.get(ind).selected
                    board.cardMoved();
                 }
            }
        }

        GridView {
            id: choices
            width: (parent.width>parent.height)? 8*(settings.cardWidth+4) : 4*(settings.cardWidth+4)
            height: (parent.width>parent.height)? settings.cardHeight+6 : (settings.cardHeight+6)*2

            model: choicesModel
            cellWidth: settings.cardWidth; cellHeight: settings.cardHeight
            anchors.horizontalCenter: parent.horizontalCenter
            interactive: false

            delegate: Card { text: card }

        }

        ListModel {
            id: pileModel

        }

        ListModel {
            id: choicesModel
            function getIndex(text) {
                for (var i=count-1; i>=0; i--) {
                    if (get(i).card == text) {
                        return i;
                    }
                }
            }

            function getWord() {
                var word = "";
                for (var i=0; i<count; i++) {
                    word += get(i).card;
                }
                return word;
            }
        }

        Item {
            width: parent.width
            height: parent.height - pile.height - choices.height - statusRow.height - barRow.height - lastWord.height
        }

        Text {
            id: lastWord
            width: parent.width
            height: settings.statusRowHeight;
            verticalAlignment: Text.AlignBottom
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: settings.statusRowFontSize-2
        }

        Row {
            id: statusRow
            width: parent.width
            height: settings.statusRowHeight +4;

            Item {
                width: 4
                height: 20
            }

            Rectangle {
                id: endButton
                width: settings.statusRowButtonWidth;
                height: settings.statusRowHeight;
                //color: (verify)? "red" : "#cacaca"
                radius: 5
                border.color: "black"

                Text {
                    id: endGame
                    anchors.centerIn: parent
                    text: "End Game"
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: settings.statusRowFontSize
                }

                MouseArea {
                    id: endArea
                    anchors.fill: parent
                    onClicked: {
                        board.endGame(board.score);
                    }

                }

            }

            Item {
                width: parent.width - validateButton.width - endButton.width - 8
                height: 20
            }

            Rectangle {
                id: validateButton
                width: settings.statusRowButtonWidth;
                height: settings.statusRowHeight;
                //color: (verify)? "red" : "#cacaca"
                radius: 5
                border.color: "black"
                anchors.margins: 5
                color: board.isValidWord ? "#66FF99" : "#cacaca"

                Text {
                    id: text1
                    anchors.centerIn: parent
                    text: "Validate"
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: settings.statusRowFontSize
                }

                MouseArea {
                    id: validateArea
                    anchors.fill: parent
                    onClicked: {
                        if (choicesModel.count>1) {
                            validateArea.enabled = false;
                            verify = true;
                        }
                    }
                }

            }
        }

    }

    onCardMoved: isValidWord = wordList.isWord(getWord())
}
