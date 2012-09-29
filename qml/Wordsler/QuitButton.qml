// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Item {
    width: 100
    height: 100

    Image {
        source: "images/closeButton.png"

    }

    MouseArea {
        anchors.top: parent.top
        anchors.right: parent.right
        width: 50
        height: 50
        onClicked: Qt.quit()
    }


}
