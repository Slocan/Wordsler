import QtQuick 1.0

Item {

    property int introButtonHeight;
    property int introButtonWidth;
    property int introFontSize;

    property int statusRowHeight;
    property int statusRowButtonWidth;
    property int statusRowFontSize;

    property int barRowHeight;
    property int barRowFontSize;

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
        } else if (platform=="symbian") {
            introButtonHeight = 50;
            introButtonWidth = 176;
            introFontSize = 15;
            statusRowButtonWidth = 120;
            statusRowHeight = 35;
            statusRowFontSize = 20;
            barRowHeight = 45;
            barRowFontSize = 10;
        } else {
            introButtonHeight = 50;
            introButtonWidth = 176;
            introFontSize = 15;
            statusRowButtonWidth = 120;
            statusRowHeight = 35;
            statusRowFontSize = 20;
            barRowHeight = 45;
            barRowFontSize = 10;
        }

    }

}
