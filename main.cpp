#include <QtGui/QApplication>
#include "wordlist.h"
#include "qmlapplicationviewer.h"

// This include is to make the "setContextProperty" work
#include <QDeclarativeContext>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    WordList* wordlist = WordList::instance();
    //wordlist->isWord("egg");

    QmlApplicationViewer viewer;
    //Utility *utility = new Utility(qApp, &viewer);

    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.rootContext()->setContextProperty("wordList", wordlist);
    viewer.setMainQmlFile(QLatin1String("qml/Wordsler/main.qml"));
    viewer.showExpanded();
#if defined(Q_WS_MAEMO_5)
        viewer.showFullScreen();
#endif

    return app.exec();
}
