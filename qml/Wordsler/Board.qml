import Qt 4.7

Rectangle {
    width: 600
    height: 380
    property alias count: deckTotal.text;
    property alias pileModel: pileModel

    Text {
        id: deckTotal
        x: 523
        y: 24
        width: 80
        height: 20
        text: "Count"
        font.pixelSize: 12
    }

    Rectangle {
        id: validateButton
        x: 467
        y: 315
        width: 93
        height: 35
        color: "#ffffff"

        Text {
            id: text1
            x: 7
            y: 10
            width: 80
            height: 20
            text: "Validate"
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 12
        }
    }

    GridView {
        id: choices
        x: 39
        y: 195
        width: 496
        height: 105
        model: choicesModel
        cellWidth: 62; cellHeight: 100

        delegate: Card { text: card
        }
    }

    GridView {
        id: pile
        x: 39
        y: 54
        width: 496
        height: 105
        model: pileModel
        cellWidth: 62; cellHeight: 100

        delegate: Item {
            //anchors.fill: parent
            Card { id: cardObject; text: cardText }
            MouseArea {
                anchors.fill: cardObject
                onClicked: {
                    if (!cardObject.selected) {
                        choicesModel.append( { card: cardObject.text } );
                    } else {
                        choicesModel.remove( choicesModel.getIndex(cardObject.text ));
                    }
                    cardObject.selected = !cardObject.selected;
                }

            }
        }
    }

    ListModel {
        id: pileModel

    }

    ListModel {
        id: choicesModel
        function getIndex(text) {
            for (var i=0; i<=count; i++) {
                if (get(i).card == text) {
                    return i;
                }
            }
        }
    }
}
