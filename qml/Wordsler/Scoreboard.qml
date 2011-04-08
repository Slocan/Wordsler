import Qt 4.7

Rectangle {
    height: 20

    Text {
        id: score

        text: "Score: " + board.score
        font.pixelSize: 20
    }
}
