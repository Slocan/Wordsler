import Qt 4.7

Rectangle {
    id: intro
    width: 600
    height: 380
    signal english
    signal french

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

            Column {
                id: leftPane
                height: (parent.rows==1)? parent.height : Math.floor(parent.height/2)
                width: (parent.rows==1)? Math.floor(parent.width/2) : parent.width

                BestScore {
                    id: bestScorePane
                    width: parent.width
                    height: parent.height - languageSelector.height
                    //anchors.centerIn: parent

                    MouseArea {
                        anchors.fill: parent
                        onClicked: achievementPage.visible=true
                    }
                }

                LanguageSelector {
                    id: languageSelector
                }
            }

            Item {
                height: (parent.rows==1)? parent.height : Math.floor(parent.height/2)
                width: (parent.rows==1)? parent.width-leftPane.width : parent.width

                Column {
                    anchors.centerIn: parent

                    Item {
                        width: settings.introButtonWidth+25
                        height: settings.introButtonHeight+5;
                        Rectangle {
                            anchors.horizontalCenter: parent.horizontalCenter
                            id: rectangle2
                            width: settings.introButtonWidth;
                            height: settings.introButtonHeight;
                            color: "#bbbbbb"
                            radius: 5
                            border.color: 'black'

                            Text {
                                id: text2
                                anchors.centerIn: parent
                                text: qsTr("New Game")
                                font.pixelSize: settings.introFontSize
                            }

                            MouseArea {
                                id: startButton
                                anchors.fill: parent
                                onClicked: {
                                    aboutpage.source = "";
                                    startGame();
                                }

                            }
                        }
                    }

                    Item {
                        width: settings.introButtonWidth+25
                        height: settings.introButtonHeight+5;
                        Rectangle {
                            anchors.horizontalCenter: parent.horizontalCenter
                            id: rectangle3
                            width: settings.introButtonWidth;
                            height: settings.introButtonHeight;
                            color: "#bbbbbb"
                            radius: 5
                            border.color: 'black'

                            Text {
                                id: text3
                                anchors.centerIn: parent
                                text: qsTr("Time Trial")
                                font.pixelSize: settings.introFontSize
                            }

                            MouseArea {
                                id: startTimerButton
                                anchors.fill: parent
                                onClicked: {
                                    aboutpage.source = "";
                                    startTimerGame();
                                }

                            }
                        }
                    }

                    Item {

                        width: settings.introButtonWidth+25
                        height: settings.introButtonHeight+5;
                        Rectangle {
                            anchors.horizontalCenter: parent.horizontalCenter
                            id: rectangle5
                            width: settings.introButtonWidth;
                            height: settings.introButtonHeight;
                            color: "#bbbbbb"
                            radius: 5
                            border.color: 'black'

                            Text {
                                id: text5
                                anchors.centerIn: parent
                                text: qsTr("Online<BR />Challenge")
                                horizontalAlignment: Text.AlignHCenter
                                font.pixelSize: settings.introFontSize -2
                            }

                            MouseArea {
                                id: onlineChallengeButton
                                anchors.fill: parent
                                onClicked: {
                                    aboutpage.source = "";
                                    aboutpage.source="OnlineChallenge.qml";
                                }

                            }
                        }
                    }

                    Item {

                        width: settings.introButtonWidth+25
                        height: settings.introButtonHeight+5;
                        Rectangle {
                            anchors.horizontalCenter: parent.horizontalCenter
                            id: rectangle4
                            width: settings.introButtonWidth;
                            height: settings.introButtonHeight;
                            color: "#bbbbbb"
                            radius: 5
                            border.color: 'black'

                            Text {
                                id: text4
                                anchors.centerIn: parent
                                text: "About"
                                font.pixelSize: settings.introFontSize
                            }

                            MouseArea {
                                id: aboutButton
                                anchors.fill: parent
                                onClicked: {
                                    aboutpage.source="About.qml";
                                }

                            }
                        }
                    }
                }
            }
        }
    }

    Loader {
        id: aboutpage
        width: parent.width
        height: parent.height
    }

    LanguageDialog { id: dialog }
}
