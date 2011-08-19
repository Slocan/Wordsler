import Qt 4.7
import "storage.js" as Storage

Component {
    id: achDelegate

    Rectangle {
        //anchors.fill: parent
        width: parent.width-8
        height: Math.max(cell.height,settings.medalSize) + 10
        anchors.horizontalCenter: parent.horizontalCenter
        radius: 5
        gradient: Gradient {
            GradientStop {
                position: 0.00;
                color: "#ffffff";
            }
            GradientStop {
                position: 0.82;
                color: "#d7d7d7";
            }
            GradientStop {
                position: 1.00;
                color: "#f3f3f3";
            }
        }
        border.color: "black"

        property int value;

        function refresh() {
            var ach = Storage.getAchievement(achIndex);
            value = ach[0];
            if (ach[0] == -1) {
                desc.text = description;
            } else {
                // Display the caption with the number and comment displayed
                desc.text = caption.replace("%s", ach[0]).replace("%c",ach[1]);
            }
        }
        Item {
            width: parent.width
            height: parent.height
            anchors.margins: 5

            Row {
                spacing: 10
                width: parent.width
                height: parent.height

                Item {
                    width: settings.medalSize
                    height: settings.medalSize
                    anchors.verticalCenter: parent.verticalCenter

                    Rectangle {
                        width: settings.medalSize
                        height: settings.medalSize
                        radius: settings.medalSize
                        anchors.verticalCenter: parent.verticalCenter
                        color: (value>=step3) ? "#FDD017" : (value>=step2) ? "#C0C0C0" : (value>=step1) ? "#9C6963" : "white"
                        opacity: (value>=step1) ? 1.0 : 0.0
                    }
                }

                Column {
                    id: cell
                    width: parent.width - 15 - settings.medalSize

                    Text {
                        id: full
                        text: fullname
                        wrapMode: Text.WordWrap
                        width: parent.width
                    }

                    Text {
                        id: desc
                        x: 8
                        wrapMode: Text.WordWrap
                        width: parent.width - 8
                    }
                }
            }
        }

        Component.onCompleted: {
            refresh();
        }

        Connections {
            target: achievementPage
            onAchModified: {
                // Receive the signal when an achievement has been changed, refresh if necessary
                if (ach == achIndex) { refresh(); }
            }
        }
    }
}
