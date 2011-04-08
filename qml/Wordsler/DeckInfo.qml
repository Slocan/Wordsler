import Qt 4.7

Rectangle {
    property int count
    width: 140
    height: 20

    Text {
        id: deckText
        font.pixelSize: 20
        text: "Cards left: " +parent.count
    }
}
