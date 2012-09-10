import Qt 4.7
import "Game.js" as Game
import "storage.js" as Storage
import "toolbar" as ToolBar

Rectangle {
    id: screen
    width: 600
    height: 380
    anchors.fill: parent

    Settings {
        id: settings
        Component.onCompleted: setValues(utility.getPlatform());
    }

    Column {
        width: parent.width
        height: parent.height

        ToolBar.ToolBar {
            id: toolBar; z: 7
            height: settings.toolBarHeight;
            width: screen.width;
            opacity: 0.9
            visible: (utility.getPlatform()=="maemo5")||(utility.getPlatform()=="playbook")?false:true

            onTaskSwitcherClicked: {
                utility.taskSwitcher();
            }
            onBackClicked: {
                        Qt.quit();
            }
        }

        Item {
            width: screen.width
            height: screen.height - toolBar.height

            function getScoreForLetter(letter) {
                return Game.score_definition[Storage.getSetting("language")][letter];
            }

            Board {
                id: board
                visible: false
                width: screen.width
                height: screen.height - toolBar.height
                property int uniqueCardId: 0

                property variant wordStackCopy;

                function updateCount() {
                    count= Game.current_deck.length;
                }

                onVerifyChanged: {
                    if (verify == true) {
                        //wordList.checkWord(getWord());
                        //console.log(wordList.isWord(getWord()));
                        board.verify = false;
                        var word = getWord();
                        if (wordList.isWord(word)) {
                            //score += 1
                            var curScore = board.getCurrentWordScore();
                            Game.wordStack.push(word);
                            wordStackCopy = Game.wordStack;
                            board.lastWordText = qsTr("Last Word: %1 / %2 points.").arg(word).arg(curScore);
                            board.score += curScore;
                            board.wordPlayed(curScore, word);
                            var newCardsCount = board.removeSelected();
                            for (var i=0; i<newCardsCount; i++) {
                                var nextCard = Game.getNextCard();
                                if (nextCard) {
                                    board.uniqueCardId += 1;
                                    board.pileModel.append( { cardText: nextCard,
                                                       selected: false,
                                                       gridId: board.uniqueCardId,
                                            cardValue: Game.score_definition[Storage.getSetting("language")][nextCard] } );
                                }
                            }
                            board.updateCount();
                            board.isValidWord = false;

                        } else {
                            board.clearSelected();
                            board.lastWordText = qsTr("Word is incorrect");
                        }

                        var newCards = board.resetChoices();
                    }
                }

                onEndGame: {
                    endScore.showScore(score);
                    if (board.state=="timer") {
                        Storage.setScore(score,"timer");
                    } else {
                        Storage.setScore(score,"none");
                    }
                    intro.visible = true;
                    board.visible = false;
                    board.stopTimer();

                    intro.updateScore();
                }
            }

            Intro {
                id: intro
                width: screen.width
                height: screen.height - toolBar.height
                property string prettyLanguage: (Storage.getSetting("language")==="fr")?qsTr("French"):qsTr("English")

                function startGame() {
                    board.state = "normal"
                    Game.initialize(Storage.getSetting("language"));
                    board.initialize();
                    for (var i=0; i<=7; i++) {
                        var nextCard = Game.getNextCard();
                        board.uniqueCardId += 1;
                        board.pileModel.append( { cardText: nextCard,
                                               selected: false,
                                               gridId: board.uniqueCardId,
                                               cardValue: Game.score_definition[Storage.getSetting("language")][nextCard]  } );
                    }
                    board.updateCount();
                    intro.visible = false;
                    board.visible = true;
                }

                function startTimerGame() {
                    startGame();
                    board.state = "timer"
                    board.setTimer();
                }

                function startOnlineGame(online_deck) {
                    Game.initializeOnline(online_deck);
                    board.initialize();
                    board.state = "online";
                    for (var i=0; i<=7; i++) {
                        var nextCard = Game.getNextCard();
                        board.uniqueCardId += 1;
                        board.pileModel.append( { cardText: nextCard,
                                               selected: false,
                                               gridId: board.uniqueCardId,
                                               cardValue: Game.score_definition[Storage.getSetting("language")][nextCard]  } );
                    }
                    board.updateCount();
                    intro.visible = false;
                    board.visible = true;
                }
                onEnglish: {
                    wordList.init("en")
                    Storage.setSetting("language", "en")
                    prettyLanguage= (Storage.getSetting("language")==="fr")?qsTr("French"):qsTr("English")
                }
                onFrench: {
                    wordList.init("fr")
                    Storage.setSetting("language", "fr")
                    prettyLanguage= (Storage.getSetting("language")==="fr")?qsTr("French"):qsTr("English")
                }
            }

            Achievements {
                id: achievementPage
            }
        }
    }

    Component.onCompleted: {
        Storage.initialize();
        if (Storage.getSetting("language")==="Unknown") {
            Storage.setSetting("language", (language==="fr")?"fr":"en");
        }
        wordList.init(Storage.getSetting("language"));
        intro.updateScore();
    }

    EndScore {
        id: endScore
        width: parent.width
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }

    Notification {
        id: notification
    }

}
