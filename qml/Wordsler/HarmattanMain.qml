import QtQuick 1.0
import com.nokia.meego 1.0


PageStackWindow {
    initialPage: mainPage

    Page{
        id: mainPage
        Component.onCompleted: {
            var main = Qt.createComponent("main.qml");
            main.createObject(mainPage);
        }
    }
}
