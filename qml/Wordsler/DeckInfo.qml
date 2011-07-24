import Qt 4.7

Item {
    property int count
    width: deckText.width + 15
    height: settings.barRowHeight

    Rectangle {
        anchors.fill: parent
        opacity: 0.5
    }

    Text {
        id: deckText
        font.pointSize: settings.barRowFontSize
        text: "Cards left: " +parent.count
    }
}
