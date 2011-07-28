function register(username) {

    if (username !== "") {
        var xhr = new XMLHttpRequest;

        var params = "username=" + username;
        var url= "http://feedingit.marcoz.org/wordsler/register.php";
        xhr.open("POST", url);
        xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        xhr.setRequestHeader("Content-length", params.length);
        xhr.setRequestHeader("Connection", "close");

        xhr.onreadystatechange = function() {
            if (xhr.readyState == XMLHttpRequest.DONE) {
                console.log(xhr.responseText);
                Storage.setSetting("unique_id",xhr.responseText);
                Storage.setSetting("username",username);
                challengePane.setUsername();
                //challengePane.visible = false
            }
        }
        xhr.send(params);
    }
}

function getChallengeDeck() {
    var xhr = new XMLHttpRequest;

    var params = "platform=" + utility.getPlatform();
    var url= "http://feedingit.marcoz.org/wordsler/getChallenge.php";
    xhr.open("POST", url);
    xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xhr.setRequestHeader("Content-length", params.length);
    xhr.setRequestHeader("Connection", "close");

    xhr.onreadystatechange = function() {
        if (xhr.readyState == XMLHttpRequest.DONE) {
            var tab = eval(xhr.responseText);
            challengePane.challengeId = tab[0];
            challengePane.deck = eval(tab[1]);
            console.log(challengePane.challengeId + " " + challengePane.deck[1])
        }
    }
    xhr.send(params);

}

function sendScore(challengeId,username,unique_id,score) {
    var xhr = new XMLHttpRequest;

    var params = "challengeId=" + challengeId + "&username="+username+"&pass="+unique_id+"&score="+score;
    var url= "http://feedingit.marcoz.org/wordsler/sendScore.php";
    xhr.open("POST", url);
    xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xhr.setRequestHeader("Content-length", params.length);
    xhr.setRequestHeader("Connection", "close");

    xhr.onreadystatechange = function() {
        if (xhr.readyState == XMLHttpRequest.DONE) {
            challengePane.state = "idle";
            //console.log(xhr.responseText)
        }
    }
    xhr.send(params);

}
