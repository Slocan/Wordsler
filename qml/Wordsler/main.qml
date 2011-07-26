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
                return Game.score_definition[letter];
            }

            Board {
                id: board
                visible: false
                width: screen.width
                height: screen.height - toolBar.height

                function updateCount() {
                    count= Game.current_deck.length;
                }

                onVerifyChanged: {
                    if (verify == true) {
                        //wordList.checkWord(getWord());
                        //console.log(wordList.isWord(getWord()));
                        board.verify = false;
                        if (wordList.isWord(getWord())) {
                            //score += 1
                            board.lastWordText = "Last Word: " + getWord() + " / " + board.getCurrentWordScore() + " points.";
                            board.score += board.getCurrentWordScore();
                            var newCardsCount = board.removeSelected();
                            for (var i=0; i<newCardsCount; i++) {
                                var nextCard = Game.getNextCard();
                                if (nextCard) {
                                    board.pileModel.append( { cardText: nextCard,
                                                       selected: false,
                                            cardValue: Game.score_definition[nextCard] } );
                                }
                            }
                            board.updateCount();
                        } else {
                            board.clearSelected();
                            board.lastWordText = "Word is incorrect";
                        }

                        var newCards = board.resetChoices();
                    }
                }

                onEndGame: {
                    endScore.showScore(score);
                    if (isTimerGame) {
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

                function startGame() {
                    Game.initialize();
                    board.initialize();
                    for (var i=0; i<=7; i++) {
                        var nextCard = Game.getNextCard();
                        board.pileModel.append( { cardText: nextCard,
                                               selected: false,
                                               cardValue: Game.score_definition[nextCard]  } );
                    }
                    board.updateCount();
                    intro.visible = false;
                    board.visible = true;
                }

                function startTimerGame() {
                    startGame();
                    board.setTimer();
                }

                function startOnlineGame(online_deck) {
                    Game.initializeOnline(online_deck);
                    board.initialize();
                    for (var i=0; i<=7; i++) {
                        var nextCard = Game.getNextCard();
                        board.pileModel.append( { cardText: nextCard,
                                               selected: false,
                                               cardValue: Game.score_definition[nextCard]  } );
                    }
                    board.updateCount();
                    intro.visible = false;
                    board.visible = true;
                }

            }
        }
    }

    Component.onCompleted: {
        Storage.initialize();
        intro.updateScore();
    }

    EndScore {
        id: endScore
        width: parent.width
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }

}
