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
                anchors.centerIn: parent
                width: 80
                height: 20
                text: "Wordsler"
                font.family: "Impact"
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 34
            }

            Text {
                id: text2
                anchors.centerIn: parent
                width: 80
                height: 20
                text: "Welcome to"
                rotation: -28
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 16
            }
        }
        Grid {
            width: parent.width
            height: intro.height - title.height
            rows: (parent.width>parent.height)? 1 : 2
            columns: (parent.width>parent.height)? 2 : 1

            Item {
                height: (parent.rows==1)? 210 : 210
                width: 300

                Rectangle {
                    id: highScore
                    //width: parent.width/2
                    width: parent.width
                    height: parent.height
                    color: "#bbbbbb"
                }
            }

            Item {
                height: parent.height
                width: parent.width-highScore.width

                Column {
//                    height: parent.height
//                    width: parent.width
                    anchors.centerIn: parent

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
                            id: startButton
                            anchors.fill: parent
                            onClicked: {
                                startGame();
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
}
