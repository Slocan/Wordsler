import Qt 4.7

Item {
    height: settings.barRowHeight
    width: score.width + 8
    Rectangle {
        anchors.fill: parent
        opacity: 0.5
    }

    Text {
        id: score
        text: qsTr("Score: ") + board.score
        font.pixelSize: settings.barRowFontSize;
        anchors.centerIn: parent;
    }
}
