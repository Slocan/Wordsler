import Qt 4.7
import "storage.js" as Storage

Rectangle {
    id: achievementPage
    signal achModified (int ach);
    anchors.fill: parent
    visible: false

    Column{
        anchors.fill: parent

        Row {
            width: parent.width
            height: settings.introButtonHeight+5

            Text {
                width: parent.width - button.width
                height: parent.height
                text: "Achievement page"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: settings.introFontSize
            }

            Item {
                id: button
                width: settings.introButtonWidth+25
                height: settings.introButtonHeight+5;
                //anchors.horizontalCenter: parent.horizontalCenter
                Rectangle {
                    id: closeButton
                    width: settings.introButtonWidth;
                    height: settings.introButtonHeight;
                    color: "#bbbbbb"
                    radius: 5
                    border.color: 'black'

                    Text {
                        id: text8
                        anchors.centerIn: parent
                        text: "Close"
                        font.pixelSize: settings.introFontSize
                    }

                    MouseArea {
                        id: closeButtonArea
                        anchors.fill: parent
                        onClicked: {
                            achievementPage.visible = false;
                        }
                    }
                }
            }
        }

        ListView {
            model: xmlModel
            delegate: achDelegate
            //anchors.fill: parent
            height: parent.height - closeButton.height
            width: parent.width
            clip: true
        }
    }

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
                    if (ach == index) { refresh(); console.log("refreshing "+ach) }
                }
            }
        }
    }

    XmlListModel {
        id: xmlModel
        source: "achievements.xml"
        query: "/achievements/achievement"

        XmlRole { name: "achIndex"; query: "index/string()" }
        XmlRole { name: "name"; query: "name/string()" }
        XmlRole { name: "fullname"; query: "fullname/string()" }
        XmlRole { name: "description"; query: "description/string()" }
        XmlRole { name: "caption"; query: "caption/string()" }
        XmlRole { name: "step1"; query: "steps/step[1]/string()" }
        XmlRole { name: "step2"; query: "steps/step[2]/string()" }
        XmlRole { name: "step3"; query: "steps/step[3]/string()" }
    }

    Connections {
        target:  board
        onEndGame: {
            // Increment achievement #1 (total games played)
            Storage.incrementAchievement(1);
            achievementPage.achModified(1);

            // Increment achievement #2 (online games played)
            if (board.state=="online") {
                Storage.incrementAchievement(2);
                achievementPage.achModified(2);
            }
        }
        onWordPlayed: {
            // Update best word achievement
            Storage.updateAchievement(3,wordScore,word);
            achievementPage.achModified(3);
        }
    }

}
