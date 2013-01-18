import Qt 4.7
import "storage.js" as Storage

Item {
    width: 120
    height: 250

    function updateScores() {
        highScore.text = Storage.getScore("reg");
        highScore_tt.text = Storage.getScore("timer");
    }

    Rectangle {

        height: mainCol.height+10
        width: mainCol.width+10
        anchors.centerIn: parent
        radius: 5
        border.color: 'black'

        Column {
            id: mainCol
            //anchors.horizontalCenter: parent.horizontalCenter
    //        width: parent.width
    //        height: parent.height
            anchors.centerIn: parent

            Text {
                id: text1
                text: qsTr("Highest Scores")
                font.bold: true
                font.italic: true
                font.pixelSize: settings.introFontSize - 2
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Item {
                height: 20
                width: 1
            }

            Text {
                id: text2
                text: qsTr("Regular Mode")
                font.bold: true
                font.italic: true
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: settings.introFontSize - 5
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                id: highScore
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: settings.introFontSize - 5
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Item {
                height: 15
                width: 1
            }

            Text {
                id: text3
                text: qsTr("Time Trial")
                font.bold: true
                font.pixelSize: settings.introFontSize - 5
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                id: highScore_tt
                font.pixelSize: settings.introFontSize - 5
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Item {
                height: 20
                width: 1
            }

            Text {
                id: link
                visible: utility.getPlatform() !== 'symbian'
                font.pixelSize: settings.introFontSize - 2
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Press to view Achievements!")
            }
        }
    }

    Component.onCompleted: updateScores();
}
