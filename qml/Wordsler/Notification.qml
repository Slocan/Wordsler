import Qt 4.7

Rectangle {

    height: 86
    gradient: Gradient {
        GradientStop {
            position: 0
            color: "#ffffff"
        }

        GradientStop {
            position: 0
            color: "#fbfbc5"
        }

        GradientStop {
            position: 1
            color: "#fbf846"
        }
    }
    width: parent.width
    y: 86
    z: 10
    opacity: 0

    function showNotification(text) {
        message = text;
        state="visible";
        timer.start()
    }

    Timer {
        id: timer
        interval: 2500; running: false; repeat: false
        onTriggered: state="";
    }

    id: rectangle1
    property string message: ""

    Text {
        text: parent.message
        horizontalAlignment: Text.AlignHCenter
        anchors.centerIn: parent
        font.bold: true;
    }

    states: State { name: "visible"
        PropertyChanges { target: rectangle1; opacity: 1; }
    }

    transitions: Transition {
            NumberAnimation {
                properties: "opacity"
                duration: 300
                easing.type: Easing.InQuart
            }
    }

}
