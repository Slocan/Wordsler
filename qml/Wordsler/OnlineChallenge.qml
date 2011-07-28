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
            getDeck();
        } else {
            state="NotLoggedIn";
        }
    }

    function getDeck() {
        OnlineChallenge.getChallengeDeck();
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
                Text {
                    id: textIntro
                    width: parent.width
                    wrapMode: Text.Wrap
                    text: "Welcome to the Daily Wordsler Challenge!

Compete against your peers using the same set of cards. Every day a new challenge!
When you complete a game in this mode, you score is submitted online at http://feedingit.marcoz.org .
No personal data other than the username provided below is being transmitted.

Register for a new Wordsler Online account
Please note that this mode requires an active internet connection."
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pointSize: settings.aboutPageFontSize
                }
            }

            Row {
                id: row1
                height: text1.height+10
                spacing: 8
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    id: text1
                    text: "Username: "
                    font.pointSize: settings.aboutPageFontSize
                }

                Rectangle {
                    width:  158
                    height: parent.height
                    radius: 6
                    border.color: "black"

                    TextInput {
                        id: usernameInput
                        text: ""
                        font.pointSize: settings.aboutPageFontSize
                        width:  150
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
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
                            text: "Register"
                            font.pointSize: settings.introFontSize
                        }

                        MouseArea {
                            id: registerButton
                            anchors.fill: parent
                            onClicked: {
                                registerButton.enabled = false;
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
                            text: "Cancel"
                            font.pointSize: settings.introFontSize
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

        MouseArea {
            id: emptyButton
            z:-1
            anchors.fill: parent
            onClicked: {
            }
        }

    }

    Item {
        id: submitOnline
        visible: false
        anchors.fill: parent

        Text {
            id: textOnline
            text: "Your score is being submitted online."
            font.pointSize: settings.aboutPageFontSize
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignHCenter
        }
    }
    Component.onCompleted: {
        setUsername();
        //        if (Storage.getSetting("unique_id") == "Unknown") {
//            state = "NotLoggedIn";
//        } else {
//            state = "LoggedIn";

//        }
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
                   console.log("xx");
                   getDeck();
               }
               }
       }
    ]

    onDeckChanged: {
        console.log(deck);
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
            OnlineChallenge.sendScore(challengeId,username,unique_id,board.score, board.wordStackCopy);
        }
    }
}
