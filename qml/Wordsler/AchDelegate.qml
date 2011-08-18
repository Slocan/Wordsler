import Qt 4.7
import "storage.js" as Storage

Component {
    id: achDelegate

    Rectangle {
        //anchors.fill: parent
        width: parent.width
        height: Math.max(cell.height,30) + 10
        radius: 5
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

                Rectangle {
                    width: 30
                    height: 30
                    radius: 30
                    color: (value>step3) ? "#FDD017" : (value>step2) ? "#C0C0C0" : (value>step1) ? "#9C6963" : "white"
                }

                Column {
                    id: cell
                    width: parent.width - 45

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
                        width: parent.width
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
