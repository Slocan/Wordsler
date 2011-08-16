import Qt 4.7
import "storage.js" as Storage

Rectangle {
    anchors.fill: parent

    ListView {
        model: xmlModel
        delegate: achDelegate
        anchors.fill: parent
    }

    Component {
        id: achDelegate

        Rectangle {
            //anchors.fill: parent
            width: screen.width
            height: cell.height
            radius: 5
            border.color: "black"

            Column {
                id: cell
                height: 80
                width: parent.width
                Text {
                    text: fullname
                }
                Text {
                    text: description.replace("%s", Storage.getAchievement(index)[0])
                }
            }
            Component.onCompleted: console.log(Storage.getAchievement(index))
        }

    }

    XmlListModel {
        id: xmlModel
        source: "achievements.xml"
        query: "/achievements/achievement"

        XmlRole { name: "name"; query: "name/string()" }
        XmlRole { name: "fullname"; query: "fullname/string()" }
        XmlRole { name: "description"; query: "description/string()" }
        XmlRole { name: "step1"; query: "steps/step[1]/string()" }
        XmlRole { name: "step2"; query: "steps/step[2]/string()" }
        XmlRole { name: "step3"; query: "steps/step[3]/string()" }
    }

}
