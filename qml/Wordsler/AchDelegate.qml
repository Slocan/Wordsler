import Qt 4.7
import "storage.js" as Storage

Component {
    id: achDelegate

    Rectangle {
        //anchors.fill: parent
        width: screen.width
        height: cell.height
        radius: 5
        border.color: "black"

        function refresh() {
            var ach = Storage.getAchievement(achIndex);
            if (ach[0] == -1) {
                desc.text = description;
            } else {
                // Display the caption with the number and comment displayed
                desc.text = caption.replace("%s", ach[0]).replace("%c",ach[1]);
            }
        }

        Column {
            id: cell
            height: 45
            width: parent.width
            Text {
                text: fullname
            }
            Text {
                id: desc
            }
        }

        Component.onCompleted: {
            refresh();
        }

        Connections {
            target: achievementPage
            onAchModified: {
                if (ach == achIndex) { refresh(); }
            }
        }
    }
}
