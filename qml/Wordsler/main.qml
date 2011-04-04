import Qt 4.7
import "Game.js" as Game

Rectangle {
    width: 600
    height: 380
//    Text {
//        id: debugText
//        text: "Hello World"
//        anchors.centerIn: parent
//    }
//    MouseArea {
//        anchors.fill: parent
//        onClicked: {
//            //debugText.text = Game.createDeck(30).toString();



//            console.log(wordList.checkWord("help"));
//            console.log(wordList.checkWord("shelf"));
//            console.log(wordList.checkWord("shelves"));
//            console.log(wordList.checkWord("hello"));
//            //console.log(wordList.checkWord("helicopter"));
//        }
//    }

    WordList {
        id: wordList;
    }

    Board {
        id: board
        count: Game.current_deck.length + "cards.";
    }

    Component.onCompleted: {
        Game.initialize();
        for (var i=0; i<=7; i++) {
            board.pileModel.append( { card: Game.getNextCard() } );
        }
    }

}
