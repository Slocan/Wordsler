/* Game.js */

// Config variables
var deck_definition = { 'A': 5, 'B': 2, 'C': 3 }
var score = 0;
var initNumberOfCards = 58;
var current_deck = [];


//+ Jonas Raoni Soares Silva
//@ http://jsfromhell.com/array/shuffle [v1.0]
function shuffle(o) { //v1.0
        for(var j, x, i = o.length; i; j = parseInt(Math.random() * i), x = o[--i], o[i] = o[j], o[j] = x);
        return o;
};

function createDeck(numberOfCards) {
    var deck = [];
    for(var key in deck_definition) {
        for (var j=0; j<deck_definition[key]; j++) {
            deck.push(key);
        }
    }
    console.log(deck);
    deck = shuffle(deck);
    return deck.slice(0,numberOfCards);
}

function initialize() {
    current_deck = createDeck(initNumberOfCards);
}

function getNextCard() {
    return current_deck.pop();
}

