import Qt 4.7

Rectangle {
    id: intro
    width: 600
    height: 380

    property variant highScoreModel

    Background {}

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
                id: textWelcome
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
                height: (parent.rows==1)? parent.height : Math.floor(parent.height/2)
                width: (parent.rows==1)? Math.floor(parent.width/2) : parent.width

                HighScores {
                    id: highScore
                    //width: parent.width/2
                    width: 250
                    height: parent.height
                    anchors.centerIn: parent
                    model: highScoreModel
                }
            }

            Item {
                height: (parent.rows==1)? parent.height : Math.floor(parent.height/2)
                width: (parent.rows==1)? parent.width-highScore.width : parent.width

                Column {
                    anchors.centerIn: parent

                    Item {
                        width: 200
                        height: 80

                        Rectangle {
                            id: rectangle2
                            width: 176
                            height: 50
                            color: "#bbbbbb"
                            radius: 5
                            border.color: 'black'

                            Text {
                                id: text2
                                anchors.centerIn: parent
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
                    }

                    Item {
                        width: 200
                        height: 80
                        Rectangle {
                            id: rectangle3
                            width: 176
                            height: 50
                            color: "#bbbbbb"
                            radius: 5
                            border.color: 'black'

                            Text {
                                id: text3
                                anchors.centerIn: parent
                                text: "Time Trial"
                                font.pixelSize: 20
                            }
                        }
                    }

                    Item {
                        width: 200
                        height: 80
                        Rectangle {
                            id: rectangle4
                            width: 176
                            height: 50
                            color: "#bbbbbb"
                            radius: 5
                            border.color: 'black'

                            Text {
                                id: text4
                                anchors.centerIn: parent
                                text: "About"
                                font.pixelSize: 20
                            }
                        }
                    }
                }
            }
        }
    }
}