/* Game.js */

// Config variables
//var deck_definition = { 'A': 5, 'B': 5, 'C': 1, 'G': 8, 'TH': 5, 'CR':3 }
//var score_definition = { 'A': 1, 'B': 3, 'C': 2, 'G': 3, 'TH': 2, 'CR':3 }
var deck_definition_en = {'A': 10, 'B': 2, 'C': 2, 'CL': 2, 'D': 4, 'E': 12, 'ER': 2, 'F': 2, 'G': 4, 'H': 2, 'I': 8, 'IN': 2, 'J': 2,
        'K': 2, 'L': 4, 'M': 2, 'N': 6, 'O': 8, 'P': 2, 'Q': 2, 'QU': 2, 'R': 6, 'S': 4, 'T': 6, 'TH': 2, 'U': 6,
        'V': 2, 'W': 2, 'X': 2, 'Y': 4, 'Z': 2 }
var deck_definition_fr = {'A': 10, 'B': 3, 'C': 4, 'ON': 2, 'D': 4, 'E': 12, 'ER': 2, 'F': 3, 'G': 4, 'H': 2, 'I': 10, 'NT': 2, 'J': 2,
        'K': 2, 'L': 4, 'M': 4, 'N': 6, 'O': 8, 'P': 4, 'Q': 2, 'QU': 2, 'R': 6, 'S': 4, 'T': 6, 'AI': 2, 'U': 6,
        'V': 2, 'W': 1, 'X': 2, 'Y': 2, 'Z': 2 }

var deck_definition = { 'en': deck_definition_en, "fr": deck_definition_fr }

var score_definition_en = {'A': 1, 'B': 2, 'C': 2, 'CL': 2, 'D': 1, 'E': 1, 'ER': 2, 'F': 3, 'G': 2, 'H': 3, 'I': 2, 'IN': 2, 'J': 4,
        'K': 3, 'L': 2, 'M': 1, 'N': 1, 'O': 1, 'P': 4, 'Q': 6, 'QU': 5, 'R': 1, 'S': 1, 'T': 1, 'TH': 1, 'U': 1,
        'V': 3, 'W': 5, 'X': 5, 'Y': 3, 'Z': 5 }
var score_definition_fr = {'A': 1, 'B': 3, 'C': 2, 'ON': 2, 'D': 1, 'E': 1, 'ER': 2, 'F': 3, 'G': 2, 'H': 3, 'I': 2, 'NT': 2, 'J': 4,
        'K': 4, 'L': 2, 'M': 1, 'N': 1, 'O': 1, 'P': 3, 'Q': 4, 'QU': 5, 'R': 1, 'S': 1, 'T': 1, 'AI': 1, 'U': 1,
        'V': 3, 'W': 5, 'X': 5, 'Y': 5, 'Z': 4 }

var score_definition = { 'en': score_definition_en, "fr": score_definition_fr }

var initNumberOfCards = 58;
var current_deck = [];

var wordStack = [];


//+ Jonas Raoni Soares Silva
//@ http://jsfromhell.com/array/shuffle [v1.0]
function shuffle(o) { //v1.0
        for(var j, x, i = o.length; i; j = parseInt(Math.random() * i), x = o[--i], o[i] = o[j], o[j] = x);
        return o;
};

function createDeck(numberOfCards, language) {
    var deck = [];
    for(var key in deck_definition[language]) {
        for (var j=0; j<deck_definition[language][key]; j++) {
            deck.push(key);
        }
    }
    //console.log(deck);
    deck = shuffle(deck);
    return deck.slice(0,numberOfCards);
}

function initializeOnline(online_deck) {
    current_deck = online_deck.slice(0,initNumberOfCards);
    wordStack=[];
}

function initialize(language) {
    current_deck = createDeck(initNumberOfCards, language);
    wordStack=[];
}

function getNextCard() {
    return current_deck.pop();
}
