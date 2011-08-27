function register(username) {

    if (username !== "") {
        var xhr = new XMLHttpRequest;

        var params = "username=" + username + "&platform="+utility.getPlatform();
        var url= "http://feedingit.marcoz.org/wordsler/register.php";
        xhr.open("POST", url);
        xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        xhr.setRequestHeader("Content-length", params.length);
        xhr.setRequestHeader("Connection", "close");

        xhr.onreadystatechange = function() {
            if (xhr.readyState == XMLHttpRequest.DONE) {
                if (xhr.responseText !== "") {
                    //console.log(xhr.responseText);
                    Storage.setSetting("unique_id",xhr.responseText);
                    Storage.setSetting("username",username);
                    challengePane.setUsername();
                } else {
                    //Display error
                    notification.showNotification("Error when registering. Please try again.")
                    registerButton.enabled = true;
                    console.log("Error in registration.")
                }
                textIntro.visible = true

                //challengePane.visible = false
            }
        }
        xhr.send(params);
    } else {
        textIntro.visible = true
        registerButton.enabled = true;
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
            try {
                var tab = eval(xhr.responseText);
                challengePane.challengeId = tab[0];
                challengePane.deck = eval(tab[1]);
                loading.visible = false;
            } catch(e) {
                console.log("Error when connecting to getChallenge.");
                notification.showNotification("Error when connecting. Please verify your internet connection.")
            }
        }
    }
    xhr.send(params);

}

function getIntro() {
    var xhr = new XMLHttpRequest;

    var params = "username="+username+"&pass="+unique_id
    var url= "http://feedingit.marcoz.org/wordsler/introLogin.php";
    xhr.open("POST", url);
    xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xhr.setRequestHeader("Content-length", params.length);
    xhr.setRequestHeader("Connection", "close");

    xhr.onreadystatechange = function() {
        if (xhr.readyState == XMLHttpRequest.DONE) {
            try {
                var tab = eval(xhr.responseText);
                loggedIn.text = tab[1];
                loggedIn.setLogin();
                //loggedIn.setIntro("xxx");
                var tmp = tab[0]; // Placeholder
            } catch(e) {
                console.log("Error when connecting to IntroLogin.");
                loggedIn.text = "Error";
                loggedIn.setLogin();
                notification.showNotification("Error when connecting. Please verify your internet connection.")
            }
        }
    }
    xhr.send(params);

}

function sendScore(challengeId,username,unique_id,score,wordStack) {
    var xhr = new XMLHttpRequest;
    var tmp = "";
    for (var word in wordStack) {
        tmp+="&text[]="+wordStack[word]
    }

    var params = "challengeId=" + challengeId + "&username="+username+"&pass="+unique_id+"&score="+score+tmp;
    var url= "http://feedingit.marcoz.org/wordsler/sendScore-dev.php";
    xhr.open("POST", url);
    xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xhr.setRequestHeader("Content-length", params.length);
    xhr.setRequestHeader("Connection", "close");

    xhr.onreadystatechange = function() {
        if (xhr.readyState == XMLHttpRequest.DONE) {
            textOnline.text = "Your score has been submitted. Current highscores for the day: <BR />"+xhr.responseText
        }
    }
    xhr.send(params);

}
