#include <QtGui/QApplication>
#include "wordlist.h"
#include "qmlapplicationviewer.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    WordList* wordlist = WordList::instance();
    //wordlist->isWord("egg");

    QmlApplicationViewer viewer;
    //viewer.rootContext()->setContextProperty("wordList", wordlist);
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setMainQmlFile(QLatin1String("qml/Wordsler/main.qml"));
    viewer.showExpanded();

    return app.exec();
}
