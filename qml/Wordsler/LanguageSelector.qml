// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    width: languageText.width + 10
    height: languageText.height + 10
    radius: 4
    color: "white"
    border.color: "black"
    anchors.horizontalCenter: parent.horizontalCenter

    Text {
        id: languageText
        anchors.centerIn: parent
        text: qsTr("You are using the %1 dictionary.<BR />Click to change").arg(prettyLanguage)
        horizontalAlignment: Text.AlignHCenter
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            dialog.show()
        }
    }
}
