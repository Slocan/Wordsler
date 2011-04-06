import Qt 4.7
import "Game.js" as Game

Rectangle {
    width: 600
    height: 380

    function getScoreForLetter(letter) {
        return Game.score_definition[letter];
    }

//    WordList {
//        id: wordList;

//        onStatusChanged: {
//            if ((status==XmlListModel.Ready) && (board.verify==true)) {
//                board.verify = false;
//                if (count == 1) {
//                    //score += 1
//                    board.lastWordText = "Word correct";
//                    board.score += board.getCurrentWordScore();
//                    var newCardsCount = board.removeSelected();
//                    for (var i=0; i<newCardsCount; i++) {
//                        var nextCard = Game.getNextCard();
//                        if (nextCard) {
//                            board.pileModel.append( { cardText: nextCard,
//                                               selected: false } );
//                        }
//                    }
//                    board.updateCount();
//                } else {
//                    board.clearSelected();
//                    board.lastWordText = "Word incorrect";
//                }

//                var newCards = board.resetChoices();
//                reset();
//            }
//        }
//    }

    Board {
        id: board


        function updateCount() {
            count= Game.current_deck.length + "cards.";
        }

        onVerifyChanged: {
            if (verify == true) {
                //wordList.checkWord(getWord());
                //console.log(wordList.isWord(getWord()));
                board.verify = false;
                if (wordList.isWord(getWord())) {
                    //score += 1
                    board.lastWordText = "Word correct";
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
                    board.lastWordText = "Word incorrect";
                }

                var newCards = board.resetChoices();
            }
        }
    }

    Component.onCompleted: {
        Game.initialize();
        for (var i=0; i<=7; i++) {
            var nextCard = Game.getNextCard();
            board.pileModel.append( { cardText: nextCard,
                                   selected: false,
                                   cardValue: Game.score_definition[nextCard]  } );
        }
        board.updateCount();
    }

}
