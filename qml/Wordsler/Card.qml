import Qt 4.7

Rectangle {
    width: settings.cardWidth;
    height: settings.cardHeight; //100
    color: 'blue';
    property alias text: cardText.text
    property bool isSelected;
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
            font.pixelSize: settings.cardFontSize
        }

        Text {
            id: valueText
            x: 32
            y: 79
            width: 80
            height: 20
            text: value
            font.pixelSize: settings.cardBottomFontSize
        }
    }
}
