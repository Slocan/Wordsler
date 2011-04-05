import Qt 4.7

Rectangle {
    width: 600
    height: 380
    property alias count: deckTotal.text;
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
        return tmp;
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
        color: (verify)? "red" : "#ffffff"

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
            //property alias isSelected: cardObject.isSelected
            //anchors.fill: parent
            Card { id: cardObject; text: cardText; isSelected: pileModel.get(index).selected }
            MouseArea {
                anchors.fill: cardObject
                onClicked: {
                    if (!pileModel.get(index).selected) {
                        choicesModel.append( { card: cardText } );
                    } else {
                        choicesModel.remove( choicesModel.getIndex(cardText));
                    }
                    pileModel.get(index).selected = !pileModel.get(index).selected
                    //pileModel.setProperty(index,selected, !pileModel.get(index).selected)
                    //pileModel.sync();
                    //isSelected= pileModel.get(index).selected;
                    console.log(cardObject.isSelected)
                    //selected = !selected;
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

    Text {
        id: lastWord
        x: 51
        y: 335
        width: 80
        height: 20
        text: "text"
        font.pixelSize: 12
    }

    Text {
        id: score
        x: 263
        y: 24
        width: 80
        height: 20
        text: "Score: " + parent.score
        font.pixelSize: 20
    }
}
