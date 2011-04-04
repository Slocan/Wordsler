import Qt 4.7

Rectangle {
    width: 62
    height: 100
    color: 'blue';
    property alias text: cardText.text

    Rectangle {
        width: parent.width-6;
        height: parent.height-6;
        color: 'white';
        anchors.centerIn: parent

        Text {
            id: cardText
            anchors.centerIn: parent
            text: "A"
            font.pixelSize: 24
        }
    }

}
