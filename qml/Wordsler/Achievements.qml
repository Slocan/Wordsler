import Qt 4.7
import "storage.js" as Storage

Rectangle {
    id: achievementPage
    signal achModified (int ach);
    anchors.fill: parent
    visible: false

    Column{
        anchors.fill: parent

        Grid {
            id: grid
            width: parent.width
            //height: (parent.width>parent.height) ? settings.introButtonHeight+5

            columns: (parent.width>parent.height) ? 2 : 1
            rows: (parent.width<=parent.height) ? 2 : 1

            Text {
                id: title
                width: (parent.columns==2) ? parent.width - button.width : parent.width
                //height: (parent.columns==2) ? parent.height
                text: "Achievement page"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: settings.introFontSize
            }

            Item {
                id: button
                //width: settings.introButtonWidth+25
                width: (parent.columns==2) ? settings.introButtonWidth+25 : parent.width
                height: settings.introButtonHeight+5;
                //
                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
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
            delegate: AchDelegate { }
            //anchors.fill: parent
            height: parent.height - grid.height
            width: parent.width
            clip: true
            spacing: 4
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
            if (score > 0) {
                Storage.incrementAchievement(1);
                achievementPage.achModified(1);

                // Achievement #4, highest game score
                Storage.updateAchievement(4,score,board.state);
                achievementPage.achModified(4);

                // Increment achievement #2 (online games played)
                if (board.state=="online") {
                    Storage.incrementAchievement(2);
                    achievementPage.achModified(2);
                }
                if (board.state=="timer") {
                    Storage.incrementAchievement(3);
                    achievementPage.achModified(3);

                    // Achievement #5, highest Time Trial score
                    Storage.updateAchievement(5,score,board.state);
                    achievementPage.achModified(5);
                }
            }
        }
        onWordPlayed: {
            // Update best word achievement
            Storage.updateAchievement(6,wordScore,word);
            achievementPage.achModified(6);
        }
    }

}
