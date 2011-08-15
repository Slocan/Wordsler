import Qt 4.7

Rectangle {

    property string scoreString: "";

    function showScore(score) {
        scoreString = score;
        visible = true;
        enableClickTimer.start();
        removeBannerTimer.start();
    }

    height: 120
    visible: false

    gradient: Gradient {
        GradientStop {
            position: 0.00;
            color: "#5f2efd";
        }
        GradientStop {
            position: 1.00;
            color: "#a4a5fb";
        }
    }

    Text {
        id: scoreText
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        text: "Your score is: " + scoreString
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: settings.scoreFontSize;
    }

    MouseArea {
        id: scoreArea
        enabled: false
        anchors.fill: parent
        onClicked: {
            parent.visible = false;
        }
    }

    Timer {
        id: enableClickTimer
        interval: 500
        repeat: false
        onTriggered: scoreArea.enabled = true;
    }

    Timer {
        id: removeBannerTimer
        interval: 5000
        repeat: false
        onTriggered: parent.visible = false;
    }

}
