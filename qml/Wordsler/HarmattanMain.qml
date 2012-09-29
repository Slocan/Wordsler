import QtQuick 1.0
import com.nokia.meego 1.0


PageStackWindow {
    initialPage: mainPage
    showStatusBar: true

    Page{
        id: mainPage
        orientationLock: PageOrientation.Automatic

        Main { }

//        Component.onCompleted: {
//            var main = Qt.createComponent("main.qml");
//            main.createObject(mainPage);
//        }
    }
}
