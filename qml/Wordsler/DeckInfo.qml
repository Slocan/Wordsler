import Qt 4.7

Item {
    property int count
    width: deckText.width + 8
    height: settings.barRowHeight

    Rectangle {
        anchors.fill: parent
        opacity: 0.5
    }

    Text {
        id: deckText
        font.pixelSize: settings.barRowFontSize
        text: qsTr("Cards left: ") +parent.count
        anchors.centerIn: parent
    }
}
