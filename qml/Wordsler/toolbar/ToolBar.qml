import Qt 4.7

Item {
    id: toolbar

    property alias taskSwitcherLabel: taskSwitcherButton.text

    property alias quitVisible: quitButton.visible

    signal backClicked
    signal taskSwitcherClicked

    //BorderImage { source: "images/titlebar.sci"; width: parent.width; height: parent.height + 14; y: -7 }
    Rectangle {
        anchors.fill: parent; color: "#343434";
        border.color: "black"
        gradient: Gradient {
            GradientStop {
                position: 0.00;
                color: "#343434";
            }
            GradientStop {
                position: 1.00;
                color: "#ffffff";
            }
        }

        Row {
            anchors.fill: parent
            Button {
                id: taskSwitcherButton
                /*anchors.left: parent.left;*/ anchors.leftMargin: 5; y: 3; width: 116; height: settings.toolBarHeight-6
                onClicked: toolbar.taskSwitcherClicked()
                imageSource: "images/wmTaskLauncherIcon.png"
            }
        }

        Row {
            anchors.right: parent.right
            Button {
                id: quitButton
                visible: true
                /*anchors.right: parent.right;*/ anchors.rightMargin: 5; y: 3; width: 116; height: settings.toolBarHeight-6
                onClicked: toolbar.backClicked()
                imageSource: "images/emblem-unreadable.png"
            }
        }
    }
}
