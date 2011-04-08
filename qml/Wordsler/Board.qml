import Qt 4.7

Rectangle {
//    width: 600
//    height: 380
    property alias count: deckTotal.count;

    Image {
        function getBackgroundImage() {
            var backs = ["waterfall-tile.jpg",
                         "00-lucky-bamboo-background.jpg",
                         "00-lucky-clover-small.jpg",
                         "island-paradise-tile.jpg",
                         "waterfall-tile-blue.jpg",
                         "wood-repeating-fill-wavy.jpg"]
            //console.log(backs.length);
            //console.log(Math.random())
            var randValue = parseInt(Math.random() * backs.length);
            //console.log(randValue);
            return "images/" + backs[randValue];
        }

        anchors.fill: parent
        id: background
        source: getBackgroundImage();
        fillMode: Image.Tile
        opacity: 0.5
    }

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

    function getCurrentWordScore() {
        var tmp = 0;
        for (var i=choicesModel.count-1; i>=0; i--) {
            //console.log(pileModel.get(i).cardText);
            var t = choicesModel.get(i).card;
            tmp += parent.getScoreForLetter(t);
        }
        // Letter score + extra points for long words
        return tmp+choicesModel.count-1;
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

    Column {
        id: mainColumn
        width: parent.width
        height: parent.height

        Item {
            id: barRow
            width: parent.width
            height: 45

            Row {
                width: parent.width
                height: parent.height

                Scoreboard {
                    width: board.width - deckTotal.width
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

            delegate: PileDelegate {}
        }

        GridView {
            id: choices
            width: (parent.width>parent.height)? 8*66 : 4*66
            height: (parent.width>parent.height)? 106 : 212

            model: choicesModel
            cellWidth: 62; cellHeight: 100
            anchors.horizontalCenter: parent.horizontalCenter

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
            height: parent.height - pile.height - choices.height - statusRow.height - barRow.height
        }

        Row {
            id: statusRow
            width: parent.width
            Text {
                id: lastWord
                width: 80
                height: 20
                font.pixelSize: 20
            }

            Item {
                width: parent.width - lastWord.width - validateButton.width
                height: 20
            }

            Rectangle {
                id: validateButton
                width: 93
                height: 35
                color: (verify)? "red" : "#cacaca"
                radius: 5

                Text {
                    id: text1
                    anchors.centerIn: parent
                    text: "Validate"
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 20
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
