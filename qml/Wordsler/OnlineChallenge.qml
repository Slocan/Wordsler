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

    function setUsername() {
        username = Storage.getSetting("username");
        unique_id = Storage.getSetting("unique_id");
        getDeck();
    }

    function getDeck() {
        OnlineChallenge.getChallengeDeck();
    }

    Item {
        id: askUsername
        visible: false
        anchors.fill: parent
        Column {
            id: columnUsername
            anchors.fill: parent
            Row {
                width: parent.width
                height: textIntro.height
                Text {
                    id: textIntro
                    text: "Register for a new Wordsler Online account
                    Please note that this requires an internet connection."
                    font.pointSize: 12
                }
            }

            Row {
                id: row1
                width: parent.width
                height: text1.height

                Text {
                    id: text1
                    text: "Username: "
                    font.pointSize: 12
                }
                TextInput {
                    id: usernameInput
                    text: ""
                    font.pointSize: 12
                    width:  row1.width - text1.width
                }
            }

            Row {
                width: parent.width
                height: text1.height

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
            }
        }

    }

    Component.onCompleted: {
        if (Storage.getSetting("unique_id") == "Unknown") {
            state = "NotLoggedIn";
        } else {
            state = "LoggedIn";

        }
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
        }
    ]

    onDeckChanged: {
        startOnlineGame(deck);
        //console.log(challengePane.state)
        //challengePane.visible = false;
    }

    Connections {
        target:  board
        onEndGame: { OnlineChallenge.sendScore(challengeId,username,unique_id,board.score);
            console.log("Send end game result: " + board.score);
        }
    }
}
