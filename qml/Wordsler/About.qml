import QtQuick 1.0

Rectangle {
    width: 600
    height: 480

    Background {}

    Column {
        id: column1
        anchors.fill: parent
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        anchors.topMargin: 20
        anchors.bottomMargin: 20
        height: parent.height
        width: parent.width

        Rectangle {
            border.width: 2;
            radius: 5;
            color: "white";
            opacity: 60;
            height: parent.height
            width: parent.width

            Text {
                id: text1
                anchors.fill: parent
                text: "<p>The goal of this game is to score as many points as possible by <b>making words</b>.</p>
                <p>You are given 8 letters at a time, from which to form words by clicking on them in your choosen order. You can remove a letter by clicking on it again.</p>
                <p>Once your word is complete, click on <b>Validate</b> to check its validity. Bonus points are given based on the length of the word.</p>

                <p>In <b>Standard Game mode</b>, there are 58 cards in total. The game ends when you can't find a word, or you run out of cards.</p>
                <p>At this point, click on <b>End game</b> to complete the game.</p>
                <p>The <b>Time Trial mode</b> has the same rules, but adds a 2 minute timer at the end of which the game ends.</p>
                <p>For feedback, or to report issues, please visit <a href='https://github.com/Slocan/Wordsler/issues'>https://github.com/Slocan/Wordsler/issues</a> or email <a href='mailto:wordsler@marcoz.org'>wordsler@marcoz.org</a></p>"
                wrapMode: Text.WordWrap
                font.pointSize: settings.aboutPageFontSize
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                anchors.topMargin: 10
                anchors.bottomMargin: 10
            }
        }



    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            aboutpage.source="";
        }

    }

}