import Qt 4.7

Rectangle {
    width: 62
    height: 100
    color: 'blue';
    property alias text: cardText.text
    property bool isSelected: false
    property alias value: valueText.text

    Rectangle {
        width: parent.width-6;
        height: parent.height-6;
        color: (isSelected)? 'red' : 'white';
        anchors.centerIn: parent

        Text {
            id: cardText
            anchors.centerIn: parent
            //text: "A"
            font.pixelSize: 24
        }

        Text {
            id: valueText
            x: 32
            y: 79
            width: 80
            height: 20
            text: value
            font.pixelSize: 12
        }
    }



}
