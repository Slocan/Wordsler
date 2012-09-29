#include <QTranslator>
#include <QLocale>
#include <QtGui/QApplication>
#include "wordlist.h"
#include "utility.h"
#include "qmlapplicationviewer.h"

#include <qplatformdefs.h>  //MEEGO_EDITION_HARMATTAN

//#if defined(MEEGO_EDITION_HARMATTAN)
//  #include <MDeclarativeCache>
//#endif

// This include is to make the "setContextProperty" work
#include <QDeclarativeContext>

#if defined(MEEGO_EDITION_HARMATTAN)
Q_DECL_EXPORT int main(int argc, char *argv[])
#else
int main(int argc, char *argv[])
#endif
{
//#if defined(MEEGO_EDITION_HARMATTAN)
//    QApplication *app = MDeclarativeCache::qApplication(argc, argv);
//#else
    QApplication app(argc, argv);
//#endif
    QString locale = QLocale::system().name();
    //locale = "fr_FR";
    QString language = locale.mid(0,2);
    //language = "fr";
    QTranslator translator;
    if (translator.load("qml-translations." + locale, ":/")) {
        app.installTranslator(&translator);
    }
    else {
        translator.load("qml-translations.en", ":/");
        app.installTranslator(&translator);
    }

    WordList* wordlist = WordList::instance(language);

    QmlApplicationViewer viewer;
    Utility *utility = new Utility(qApp, &viewer);

    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.rootContext()->setContextProperty("wordList", wordlist);
    viewer.rootContext()->setContextProperty("utility", utility);
    viewer.rootContext()->setContextProperty("language", language);
#if defined(MEEGO_EDITION_HARMATTAN)
    viewer.setMainQmlFile(QLatin1String("qml/Wordsler/HarmattanMain.qml"));
#else
    //viewer.setMainQmlFile(QLatin1String("qml/Wordsler/main.qml"));
    viewer.setSource(QUrl("qrc:/main.qml"));
#endif
    viewer.showExpanded();
//#if defined(Q_WS_MAEMO_5) ||
#if defined(MEEGO_EDITION_HARMATTAN) || defined(BLACKBERRY_PLAYBOOK)
        viewer.showFullScreen();
#endif

    return app.exec();
}
