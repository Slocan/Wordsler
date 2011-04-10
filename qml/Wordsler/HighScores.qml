import Qt 4.7
import "storage.js" as Storage

ListView {
    anchors.centerIn: parent
    delegate: Rectangle {
        height: scoreText.height
        width: scoreText.width
        color: (index%2)? "#bbbbbb" : "#555555"
        Text {
            id: scoreText
            text: date + ": " + score
            font.pointSize: 20

        }
    }

}
