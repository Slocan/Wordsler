import Qt 4.7
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
    property int cardBottomFontSize:1;
    property int cardWidth;
    property int cardHeight;

    property int aboutPageFontSize:1;

    property int medalSize;

    function setValues(platform) {
        if (platform=="maemo5") {
            introButtonHeight = 76;
            introButtonWidth = 200;
            introFontSize = 24;
            statusRowButtonWidth = 150;
            statusRowHeight = 80;
            statusRowFontSize = 26;
            barRowHeight = 45;
            barRowFontSize = 24;
            toolBarHeight = 0;
            scoreFontSize = 30;
            cardFontSize = 26;
            cardBottomFontSize = 18;
            cardWidth = 82;
            cardHeight = 110;
            aboutPageFontSize = 18;
            medalSize = 70;
        } else if (platform=="symbian") {
            introButtonHeight = 50;
            introButtonWidth = 176;
            introFontSize = 25;
            statusRowButtonWidth = 140;
            statusRowHeight = 35;
            statusRowFontSize = 28;
            barRowHeight = 25;
            barRowFontSize = 24;
            toolBarHeight = 46;
            scoreFontSize = 34;
            cardFontSize = 30;
            cardBottomFontSize = 14;
            cardWidth = 62;
            cardHeight = 100;
            aboutPageFontSize = 16;
            medalSize = 30;
        } else if (platform=="harmattan") {
            introButtonHeight = 65;
            introButtonWidth = 200;
            introFontSize = 22;
            statusRowButtonWidth = 150;
            statusRowHeight = 80;
            statusRowFontSize = 22;
            barRowHeight = 33;
            barRowFontSize = 22;
            toolBarHeight = 55;
            scoreFontSize = 26;
            cardFontSize = 24;
            cardBottomFontSize = 16;
            cardWidth = 82;
            cardHeight = 110;
            aboutPageFontSize = 18;
            medalSize = 40;
        } else if (platform=="android") {
            introButtonHeight = 50;
            introButtonWidth = 176;
            introFontSize = 18;
            statusRowButtonWidth = 140;
            statusRowHeight = 35;
            statusRowFontSize = 20;
            barRowHeight = 25;
            barRowFontSize = 18;
            toolBarHeight = 46;
            scoreFontSize = 22;
            cardFontSize = 19;
            cardBottomFontSize = 12;
            cardWidth = 62;
            cardHeight = 100;
            aboutPageFontSize = 12;
            medalSize = 30;
        } else if (platform=="playbook") {
            introButtonHeight = 80;
            introButtonWidth = 250;
            introFontSize = 25;
            statusRowButtonWidth = 200;
            statusRowHeight = 80;
            statusRowFontSize = 28;
            barRowHeight = 45;
            barRowFontSize = 23;
            toolBarHeight = 0;
            scoreFontSize = 26;
            cardFontSize = 23;
            cardBottomFontSize = 14;
            cardWidth = 62;
            cardHeight = 100;
            aboutPageFontSize = 18;
            medalSize = 40;
        } else if (platform=="bb10") {
            introButtonHeight = 100;
            introButtonWidth = 300;
            introFontSize = 35;
            statusRowButtonWidth = 200;
            statusRowHeight = 80;
            statusRowFontSize = 28;
            barRowHeight = 45;
            barRowFontSize = 33;
            toolBarHeight = 0;
            scoreFontSize = 36;
            cardFontSize = 33;
            cardBottomFontSize = 24;
            cardWidth = 82;
            cardHeight = 110;
            aboutPageFontSize = 28;
            medalSize = 40;
        } else {
            introButtonHeight = 50;
            introButtonWidth = 176;
            introFontSize = 18;
            statusRowButtonWidth = 140;
            statusRowHeight = 35;
            statusRowFontSize = 20;
            barRowHeight = 25;
            barRowFontSize = 18;
            toolBarHeight = 46;
            scoreFontSize = 22;
            cardFontSize = 19;
            cardBottomFontSize = 12;
            cardWidth = 62;
            cardHeight = 100;
            aboutPageFontSize = 12;
            medalSize = 30;
        }

    }

}
