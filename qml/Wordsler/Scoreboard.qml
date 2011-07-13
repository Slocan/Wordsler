import Qt 4.7

Item {
    height: settings.barRowHeight
    width: score.width
    Rectangle {
        anchors.fill: parent
        opacity: 0.5
    }

    Text {
        id: score
        text: "Score: " + board.score
        font.pointSize: settings.barRowFontSize;
    }
}
