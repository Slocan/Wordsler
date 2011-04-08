import Qt 4.7

Item {
    height: 25
    Rectangle {
        anchors.fill: parent
        opacity: 0.5
    }

    Text {
        id: score
        text: "Score: " + board.score
        font.pixelSize: 20
    }
}
