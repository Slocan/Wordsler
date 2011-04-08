import Qt 4.7

Item {
    property int count
    width: 140
    height: 25

    Rectangle {
        anchors.fill: parent
        opacity: 0.5
    }

    Text {
        id: deckText
        font.pixelSize: 20
        text: "Cards left: " +parent.count
    }
}
