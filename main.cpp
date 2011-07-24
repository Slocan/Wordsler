#include <QtGui/QApplication>
#include "wordlist.h"
#include "utility.h"
#include "qmlapplicationviewer.h"

//#if defined(MEEGO_EDITION_HARMATTAN)
//  #include <MDeclarativeCache>
//#endif

// This include is to make the "setContextProperty" work
#include <QDeclarativeContext>

int main(int argc, char *argv[])
{
//#if defined(MEEGO_EDITION_HARMATTAN)
//    QApplication *app = MDeclarativeCache::qApplication(argc, argv);
//#else
    QApplication app(argc, argv);
//#endif

    WordList* wordlist = WordList::instance();
    //wordlist->isWord("egg");

    QmlApplicationViewer viewer;
    Utility *utility = new Utility(qApp, &viewer);

    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.rootContext()->setContextProperty("wordList", wordlist);
    viewer.rootContext()->setContextProperty("utility", utility);
#if defined(MEEGO_EDITION_HARMATTAN)
    viewer.setMainQmlFile(QLatin1String("qml/Wordsler/HarmattanMain.qml"));
#else
    viewer.setMainQmlFile(QLatin1String("qml/Wordsler/main.qml"));
#endif
    viewer.showExpanded();
#if defined(Q_WS_MAEMO_5) || defined(MEEGO_EDITION_HARMATTAN)
        viewer.showFullScreen();
#endif

    return app.exec();
}
