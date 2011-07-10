import Qt 4.7

Rectangle {
    id: intro
    width: 600
    height: 380

    function updateScore() {
        bestScorePane.updateScores();
    }

    Background {}

    Column {
        width: parent.width
        height: parent.height

        Item {
            id: title
            width: parent.width
            height: 100
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
                id: leftPane
                height: (parent.rows==1)? parent.height : Math.floor(parent.height/2)
                width: (parent.rows==1)? Math.floor(parent.width/2) : parent.width

                BestScore {
                    id: bestScorePane
                    width: parent.width
                    height: parent.height
                    anchors.centerIn: parent
                }

//                Column {
//                    width: parent.width
//                    height: parent.height
//                    anchors.centerIn: parent

//                    HighScores {
//                        id: highScore
//                        //width: parent.width/2
//                        width: 250
//                        height: parent.height/2
//                        //anchors.centerIn: parent
//                        model: highScoreModel
//                    }

//                    HighScores {
//                        //x: parent.height/2
//                        width: 250
//                        height: parent.height/2
//                        //anchors.centerIn: parent
//                        model: highScoreModel_tt
//                    }
//                }


            }

            Item {
                height: (parent.rows==1)? parent.height : Math.floor(parent.height/2)
                width: (parent.rows==1)? parent.width-leftPane.width : parent.width

                Column {
                    anchors.centerIn: parent

                    Item {
                        width: 200
                        height: 75

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
                                font.pointSize: 16
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
                        height: 75
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
                                font.pointSize: 16
                            }

                            MouseArea {
                                id: startTimerButton
                                anchors.fill: parent
                                onClicked: {
                                    startTimerGame();
                                }

                            }
                        }
                    }

                    Item {
                        width: 200
                        height: 75
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
                                font.pointSize: 16
                            }
                        }
                    }
                }
            }
        }
    }
}
