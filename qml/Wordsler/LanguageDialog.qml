import QtQuick 1.1

Rectangle {
    id: page
    width: intro.width
    height: intro.height

    anchors.top: intro.top

    color: "white"
    border.width: 1
    opacity: 0
    visible: opacity > 0
    Behavior on opacity {
        NumberAnimation { duration: 500 }
    }

    function forceClose() {
        if(page.opacity == 0)
            return; //already closed
        //page.closed();
        page.opacity = 0;
    }

    function show() {
        loading.visible = false;
        languageButtons.visible = true;
        page.opacity = 1;
    }

     Rectangle {

         id: languageRectangle
         property Item text: dialogText
         signal languageLoading
         anchors.centerIn: parent

    //     signal english
    //     signal french


         width: dialogText.width + 20; height: dialogText.height + 20

         Rectangle {
             id: loading
             anchors.centerIn: parent
             visible: false
             height: 150
             width: 150
             Text {
                 anchors.centerIn: parent

                 text: qsTr("Loading dictionary\nPlease wait")

             }
         }


         Column {
             id: languageButtons
             anchors.centerIn: parent;
             spacing: 30

             Text { id: dialogText;  text: qsTr("Choose which language to use in-game") }

             Rectangle {
                 id: english
                 width: settings.introButtonWidth;
                 height: settings.introButtonHeight;
                 color: "#bbbbbb"
                 radius: 5
                 border.color: 'black'

                 Text {
                     id: englishtext
                     anchors.centerIn: parent
                     text: qsTr("English")
                     font.pixelSize: 0
                 }

                 MouseArea {
                     id: englishButton
                     anchors.fill: parent
                     onClicked: {
                         languageRectangle.languageLoading()
//                         intro.english()
//                         forceClose()
                         myTimer.newLanguage = "en"
                         myTimer.start()
                     }
                 }
             }

             Rectangle {
                 id: french
                 width: settings.introButtonWidth;
                 height: settings.introButtonHeight;
                 color: "#bbbbbb"
                 radius: 5
                 border.color: 'black'

                 Text {
                     id: frenchtext
                     anchors.centerIn: parent
                     text: qsTr("French")
                     font.pixelSize: 0
                 }

                 MouseArea {
                     id: frenchButton
                     anchors.fill: parent
                     onClicked: {
                         languageRectangle.languageLoading()
//                         intro.french()
//                         forceClose()
                         myTimer.newLanguage = "fr"
                         myTimer.start()
                     }
                 }
             }
         }

         Timer {
           id: myTimer
           interval: 1; running: false; repeat: false
           property string newLanguage
           onTriggered: {
               if (newLanguage === "en") {
                   intro.english()
               } else {
                   intro.french()
               }
               forceClose()
           }
         }

            onLanguageLoading: {
                loading.visible = true
                languageButtons.visible = false
            }

         //MouseArea { anchors.fill: parent; onClicked: forceClose(); }
     }

}
