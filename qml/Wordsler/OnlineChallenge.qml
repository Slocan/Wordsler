import Qt 4.7
import "OnlineChallenge.js" as OnlineChallenge
import "storage.js" as Storage

Rectangle {
    id: challengePane
    anchors.fill: parent

    property string username: Storage.getSetting("username");
    property string unique_id: Storage.getSetting("unique_id");
    property int challengeId;

    property variant deck: "";

    property bool gameStarted: false;

    function setUsername() {
        username = Storage.getSetting("username");
        unique_id = Storage.getSetting("unique_id");
        if (username!="Unknown") {
            state="LoggedIn"; //getDeck();
        } else {
            state="NotLoggedIn";
        }
    }

    function getDeck() {
        OnlineChallenge.getChallengeDeck();
    }

    Item {
        id: loggedIn
        visible: false
        anchors.fill: parent
        width: parent.width
        property string text;

        signal setLogin;

        onSetLogin:  {
            textLog.text = text;
            loading.visible = false;
            textLog.visible = true;
        }

        Column {
            id: columnLoggedIn
            anchors.fill: parent
            spacing: 15


            Item {
                anchors.horizontalCenter: parent.horizontalCenter
                height: 150
                width: parent.width

                Image {
                    id: loading
                    visible: true
                    anchors.centerIn: parent
                    source: "toolbar/images/loading2.png"
                    NumberAnimation on rotation {
                                from: 0; to: 360; running: loading.visible == true; loops: Animation.Infinite; duration: 900
                            }
                }

                Text {
                    id: textLog
                    visible: false
                    width: parent.width
                    anchors.centerIn: parent
                    wrapMode: Text.Wrap
                    //text: "You are logged in as " + username
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: settings.aboutPageFontSize
                }
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                height: textLog.height
                //width: parent.width
                Item {
                    width: settings.introButtonWidth+25
                    height: settings.introButtonHeight+5;
                    Rectangle {
                        id: rectangleL
                        width: settings.introButtonWidth;
                        height: settings.introButtonHeight;
                        color: "#bbbbbb"
                        radius: 5
                        border.color: 'black'

                        Text {
                            id: textL
                            anchors.centerIn: parent
                            text: "Start"
                            font.pixelSize: settings.introFontSize
                        }

                        MouseArea {
                            id: startButton
                            anchors.fill: parent
                            onClicked: {
                                //registerButton.enabled = false;
                                //OnlineChallenge.register(usernameInput.text);
                                textLog.visible = false
                                loading.visible = true
                                getDeck();
    //                            gameStarted=true;
    //                            startOnlineGame(deck);
                            }
                        }
                    }
                }

                Item {
                    width: settings.introButtonWidth+25
                    height: settings.introButtonHeight+5;
                    Rectangle {
                        id: rectangleL2
                        width: settings.introButtonWidth;
                        height: settings.introButtonHeight;
                        color: "#bbbbbb"
                        radius: 5
                        border.color: 'black'

                        Text {
                            id: textL2
                            anchors.centerIn: parent
                            text: "Cancel"
                            font.pixelSize: settings.introFontSize
                        }

                        MouseArea {
                            id: cancelButton2
                            anchors.fill: parent
                            onClicked: {
                                challengePane.state = "idle";
                            }
                        }
                    }
                }
            }


        }
    }

    Item {
        id: askUsername
        visible: false
        anchors.fill: parent
        width: parent.width
        Column {
            id: columnUsername
            anchors.fill: parent
            spacing: 15
            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                height: textIntro.height
                width: parent.width
                Item {
                    //anchors.horizontalCenter: parent.horizontalCenter
                    height: textIntro.height
                    width: parent.width

                    Text {
                        id: textIntro
                        width: parent.width
                        wrapMode: Text.Wrap
                        text: qsTr("Welcome to the Daily Wordsler Challenge!

    Compete against your peers using the same set of cards. Every day a new challenge!
    When you complete a game in this mode, you score is submitted online at http://feedingit.marcoz.org .
    No personal data other than the username provided below is being transmitted.

    Register for a new Wordsler Online account
    Please note that this mode requires an active internet connection.")
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.pixelSize: 0
                    }

                    Image {
                        id: loading3
                        visible: !textIntro.visible
                        anchors.centerIn: parent
                        source: "toolbar/images/loading2.png"
                        NumberAnimation on rotation {
                                    from: 0; to: 360; running: loading3.visible == true; loops: Animation.Infinite; duration: 900
                                }
                    }

                }
            }

            Row {
                id: row1
                height: text1.height+10
                spacing: 8
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    id: text1
                    text: qsTr("Username: ")
                    font.pixelSize: settings.aboutPageFontSize
                }

                Rectangle {
                    width:  158
                    height: parent.height
                    radius: 6
                    border.color: "black"

                    TextInput {
                        id: usernameInput
                        text: ""
                        font.pixelSize: settings.aboutPageFontSize
                        width:  150
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        activeFocusOnPress: false
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                if (!usernameInput.activeFocus) {
                                    usernameInput.forceActiveFocus()
                                    usernameInput.openSoftwareInputPanel();
                                } else {
                                    usernameInput.focus = false;
                                }
                            }
                            //onPressAndHold: textInput.closeSoftwareInputPanel();
                        }
                    }
                }
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter

                Item {
                    width: settings.introButtonWidth+25
                    height: settings.introButtonHeight+5;
                    Rectangle {
                        id: rectangle6
                        width: settings.introButtonWidth;
                        height: settings.introButtonHeight;
                        color: "#bbbbbb"
                        radius: 5
                        border.color: 'black'

                        Text {
                            id: text6
                            anchors.centerIn: parent
                            text: qsTr("Register")
                            font.pixelSize: settings.introFontSize
                        }

                        MouseArea {
                            id: registerButton
                            anchors.fill: parent
                            onClicked: {
                                textIntro.visible = false
                                registerButton.enabled = false;
                                usernameInput.focus = false;
                                text6.forceActiveFocus();
                                usernameInput.closeSoftwareInputPanel()
                                OnlineChallenge.register(usernameInput.text);

                            }
                        }
                    }
                }

                Item {
                    width: settings.introButtonWidth+25
                    height: settings.introButtonHeight+5;
                    Rectangle {
                        id: rectangle7
                        width: settings.introButtonWidth;
                        height: settings.introButtonHeight;
                        color: "#bbbbbb"
                        radius: 5
                        border.color: 'black'

                        Text {
                            id: text7
                            anchors.centerIn: parent
                            text: qsTr("Cancel")
                            font.pixelSize: settings.introFontSize
                        }

                        MouseArea {
                            id: cancelButton
                            anchors.fill: parent
                            onClicked: {
                                challengePane.state = "idle";
                            }
                        }
                    }
                }
            }
        }

    }

    Item {
        id: submitOnline
        visible: false
        anchors.fill: parent

        Column {
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter

            Text {
                id: textOnline
                wrapMode: Text.WordWrap
                text: qsTr("Your score is being submitted online.")
                font.pixelSize: settings.aboutPageFontSize
                anchors.horizontalCenter: parent.horizontalCenter
                //anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                onLinkActivated: Qt.openUrlExternally(link)
            }

            Item {
                height: 60
                width: 60
                id: loading2
                anchors.horizontalCenter: parent.horizontalCenter
                visible: (textOnline.text == qsTr("Your score is being submitted online."))
                Image {
                    anchors.centerIn: parent
                    source: "toolbar/images/loading2.png"
                    NumberAnimation on rotation {
                                from: 0; to: 360; running: loading2.visible == true; loops: Animation.Infinite; duration: 900
                            }
                }
            }

            Item {
                width: settings.introButtonWidth+25
                height: settings.introButtonHeight+5;
                anchors.horizontalCenter: parent.horizontalCenter
                Rectangle {
                    id: rectangle8
                    width: settings.introButtonWidth;
                    height: settings.introButtonHeight;
                    color: "#bbbbbb"
                    radius: 5
                    border.color: 'black'

                    Text {
                        id: text8
                        anchors.centerIn: parent
                        text: qsTr("Close")
                        font.pixelSize: settings.introFontSize
                    }

                    MouseArea {
                        id: closeButton
                        anchors.fill: parent
                        onClicked: {
                            challengePane.state = "idle";
                        }
                    }
                }
            }
        }
    }

    MouseArea {
        id: emptyButton
        z:-1
        anchors.fill: parent
        onClicked: {
        }
    }

    Component.onCompleted: {
        setUsername();

    }

    states: [
        State {
            name: "NotLoggedIn"
            when: (user_id == "Unknown")
            PropertyChanges { target: askUsername; visible: true}
        },
        State {
            name: "LoggedIn"
            when: ((deck == "") && (user_id != "Unknown"))
            PropertyChanges { target: loggedIn; visible: true}
            //PropertyChanges { target: signal; color: "red"}
        },
        State {
            name: "gameStarted"
            when: ((deck != "") && (user_id != "Unknown"))
            PropertyChanges { target: challengePane; visible: false}
        },
        State {
            name: "idle"
            //when: ((deck != "") && (user_id != "Unknown"))
            PropertyChanges { target: challengePane; visible: false}
            PropertyChanges { target: askUsername; visible: false}
        },
        State {
            name: "online"
            PropertyChanges { target: submitOnline; visible: true}
        }
    ]

    transitions: [
        Transition {
           to: "LoggedIn"
           ScriptAction { script: {
                   OnlineChallenge.getIntro();
               }
               }
       }
    ]

    onDeckChanged: {
        //console.log(deck);
        if (deck!="") {
            gameStarted=true;
            startOnlineGame(deck);
        }
        //console.log(challengePane.state)
        //challengePane.visible = false;
    }

    Connections {
        target:  board
        onEndGame: {
            state = "online";
            //console.log(username + " " + unique_id)
            OnlineChallenge.sendScore(challengeId,username,unique_id,board.score, board.wordStackCopy);
        }
    }
}
