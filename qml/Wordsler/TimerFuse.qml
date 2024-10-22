import Qt 4.7

Rectangle {
    width: 100
    height: settings.barRowHeight

    id: timerContainer

    border.width: 3
    border.color: "black"
    color: "white"

    property real percent: 100
    property variant startTime;
    property variant totalTime;
    property variant callback;
    property bool timerdone: false;
    signal timerEnd;

    function startTimer(duration) {
        var date = new Date();
        startTime = date.getTime();
        percent = 100;
        totalTime = duration*1000;
        timer.start();
    }

    function stopTimer() {
        if ( timer.running) {
            timer.stop();
        }
    }

    Rectangle {
        color: "red"
        x:3
        y:3
        height: parent.height - 6
        width: (parent.width-6) * parent.percent/100
    }

    Timer {
        id: timer
        interval: 300; repeat: true
        onTriggered: {
            var date = new Date();
            var current = date.getTime();
            percent = 100-100*(current-startTime)/totalTime;
            if (percent <= 0) {
                timer.stop();
                timerContainer.timerEnd();
            }
        }
    }

}
