import Qt 4.7

Rectangle {
    width: 600
    height: 380
    property alias count: deckTotal.text;

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

    Grid {
        id: pile
        x: 39
        y: 40
        width: 390
        height: 105
        columns: 8
    }

    Grid {
        id: choices
        x: 39
        y: 188
        width: 390
        height: 127
        columns: 8
    }
}
