import QtQuick 1.0

Rectangle {

    property string scoreString: "";

    function showScore(score) {
        scoreString = score;
        visible = true;
    }

    height: 120
    visible: false

    gradient: Gradient {
        GradientStop {
            position: 0.00;
            color: "#a4a5fb";
        }
        GradientStop {
            position: 1.00;
            color: "#5f2efd";
        }
    }

    Text {
        id: scoreText
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        text: "Your score is: " + scoreString
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 12
    }

    MouseArea {
        id: scoreArea
        anchors.fill: parent
        onClicked: {
            parent.visible = false;
        }
    }

}
