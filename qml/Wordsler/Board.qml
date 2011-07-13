import Qt 4.7

Rectangle {
//    width: 600
//    height: 380
    property alias count: deckTotal.count;
    property bool isTimerGame: timerfuse.visible
    signal endGame;

    Background {}

    property alias pileModel: pileModel
    property bool verify: false
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
        for (var i=pileModel.count-1; i>=0; i--) {
            //console.log(pileModel.get(i).cardText);
            if (pileModel.get(i).selected) {
                //console.log(i);
                tmp += 1;
                pileModel.remove(i);
            }
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

                        onTimerEnd: board.endGame();
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
            width: (parent.width>parent.height)? 8*66 : 4*66
            height: (parent.width>parent.height)? 106 : 212
            model: pileModel
            cellWidth: 66; cellHeight: 106
            anchors.horizontalCenter: parent.horizontalCenter
            interactive: false

            delegate: PileDelegate {}
        }

        GridView {
            id: choices
            width: (parent.width>parent.height)? 8*66 : 4*66
            height: (parent.width>parent.height)? 106 : 212

            model: choicesModel
            cellWidth: 62; cellHeight: 100
            anchors.horizontalCenter: parent.horizontalCenter
            interactive: false

            delegate: Card { text: card
            }
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
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: settings.statusRowFontSize-2
        }

        Row {
            id: statusRow
            width: parent.width

            Rectangle {
                id: endButton
                width: settings.statusRowButtonWidth;
                height: settings.statusRowHeight;
                //color: (verify)? "red" : "#cacaca"
                radius: 5

                Text {
                    id: endGame
                    anchors.centerIn: parent
                    text: "End Game"
                    horizontalAlignment: Text.AlignHCenter
                    font.pointSize: settings.statusRowFontSize
                }

                MouseArea {
                    id: endArea
                    anchors.fill: parent
                    onClicked: {
                        board.endGame();
                    }

                }

            }

            Item {
                width: parent.width - validateButton.width - endButton.width
                height: 20
            }

            Rectangle {
                id: validateButton
                width: settings.statusRowButtonWidth;
                height: settings.statusRowHeight;
                color: (verify)? "red" : "#cacaca"
                radius: 5

                Text {
                    id: text1
                    anchors.centerIn: parent
                    text: "Validate"
                    horizontalAlignment: Text.AlignHCenter
                    font.pointSize: settings.statusRowFontSize
                }

                MouseArea {
                    id: validateArea
                    anchors.fill: parent
                    onClicked: {
                        if (choicesModel.count>0) {
                            validateArea.enabled = false;
                            verify = true;
                        }
                    }

                }

            }
        }

    }
}
