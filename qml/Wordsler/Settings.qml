import QtQuick 1.0

Item {

    property int introButtonHeight;
    property int introButtonWidth;
    property int introFontSize:1;

    property int statusRowHeight;
    property int statusRowButtonWidth;
    property int statusRowFontSize:1;

    property int barRowHeight;
    property int barRowFontSize:1;

    property int toolBarHeight;

    property int scoreFontSize:1;

    property int cardFontSize:1;
    property int cardWidth;
    property int cardHeight;

    function setValues(platform) {
        if (platform=="maemo5") {
            introButtonHeight = 80;
            introButtonWidth = 200;
            introFontSize = 19;
            statusRowButtonWidth = 150;
            statusRowHeight = 80;
            statusRowFontSize = 22;
            barRowHeight = 45;
            barRowFontSize = 19;
            toolBarHeight = 66;
            scoreFontSize = 16;
            cardFontSize = 22;
            cardWidth = 82;
            cardHeight = 110;
        } else if (platform=="symbian") {
            introButtonHeight = 50;
            introButtonWidth = 176;
            introFontSize = 15;
            statusRowButtonWidth = 140;
            statusRowHeight = 35;
            statusRowFontSize = 12;
            barRowHeight = 25;
            barRowFontSize = 10;
            toolBarHeight = 46;
            scoreFontSize = 16;
            cardFontSize = 22;
            cardWidth = 62;
            cardHeight = 100;
        } else {
            introButtonHeight = 50;
            introButtonWidth = 176;
            introFontSize = 15;
            statusRowButtonWidth = 140;
            statusRowHeight = 35;
            statusRowFontSize = 20;
            barRowHeight = 25;
            barRowFontSize = 14;
            toolBarHeight = 46;
            scoreFontSize = 16;
            cardFontSize = 22;
            cardWidth = 62;
            cardHeight = 100;
        }

    }

}
