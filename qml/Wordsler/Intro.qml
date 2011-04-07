import QtQuick 1.0

Rectangle {
    id: intro
    width: 600
    height: 380

    Column {
        width: parent.width
        height: parent.height

        Item {
            id: title
            width: parent.width
            height: 120
            Text {
                id: text1
                x: 260
                y: 51
                width: 80
                height: 20
                text: "Wordsler"
                font.family: "Impact"
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 34
            }

            Text {
                id: text2
                x: 198
                y: 39
                width: 80
                height: 20
                text: "Welcome to"
                rotation: -28
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 16
            }
        }
        Row {
            width: parent.width
            height: intro.height - title.height

            Component.onCompleted: console.log(height+" "+width)

            Rectangle {
                id: highScore
                width: 193
                height: 210
                color: "#bbbbbb"
            }

            Column {
                height: parent.height
                width: parent.width-highScore.width

                Rectangle {
                    id: rectangle2
                    width: 176
                    height: 50
                    color: "#ffffff"

                    Text {
                        id: text3
                        anchors.centerIn: parent
                        width: 80
                        height: 20
                        text: "New Game"
                        font.pixelSize: 20
                    }

                    MouseArea {
                        id: validateArea
                        anchors.fill: parent
                        onClicked: {
                            if (choicesModel.count>0) {
                                validateArea.enabled = false;
                                verify = true;
                            }
                        }

                    }
                }

                Rectangle {
                    id: rectangle3
                    width: 176
                    height: 45
                    color: "#ffffff"

                    Text {
                        id: text4
                        x: 40
                        y: 11
                        width: 80
                        height: 20
                        anchors.centerIn: parent
                        text: "Time Trial"
                        font.pixelSize: 20
                    }
                }

                Rectangle {
                    id: rectangle4
                    width: 176
                    height: 49
                    color: "#ffffff"
                }
            }
        }
    }
}
