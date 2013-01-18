# Add more folders to ship with the application, here
qnx {
    bb.source = bb/
    #bb.target = bb
    DEPLOYMENTFOLDERS += bb
}

folder_01.source = qml/Wordsler
folder_01.target = qml
DEPLOYMENTFOLDERS += folder_01

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

symbian:TARGET.UID3 = 0xE6B5A1B5

VERSION = 3.2.0

# Allow network access on Symbian
#symbian:TARGET.CAPABILITY += NetworkServices

# Define QMLJSDEBUGGER to allow debugging of QML in debug builds
# (This might significantly increase build time)
# DEFINES += QMLJSDEBUGGER

# If your application uses the Qt Mobility libraries, uncomment
# the following lines and add the respective components to the 
# MOBILITY variable. 
# CONFIG += mobility
# MOBILITY +=


qnx {
    # For bb
    QMAKE_LFLAGS += '-Wl,-rpath,\'./app/native/lib\''
    #LIBS += -lbbsupport
    LIBS +=

    package.target = $${TARGET}.bar
    package.depends = $$TARGET
    package.commands = blackberry-nativepackager \
        -devMode -debugToken ~/.rim/debugtoken.bar \
        -package $${TARGET}.bar -arg -platform -arg blackberry \
        bb/bar-descriptor.xml $$TARGET \
        -e Wordsler.png res/icon.png \
        -e Wordsler-splash.png res/splashscreen.png \
       -e $$[QT_INSTALL_LIBS]/libQtCore.so.4 lib/libQtCore.so.4 \
       -e $$[QT_INSTALL_LIBS]/libQtGui.so.4 lib/libQtGui.so.4 \
       -e $$[QT_INSTALL_LIBS]/libQtOpenGL.so.4 lib/libQtOpenGL.so.4 \
       -e $$[QT_INSTALL_LIBS]/libQtNetwork.so.4 lib/libQtNetwork.so.4 \
       -e $$[QT_INSTALL_LIBS]/libQtDeclarative.so.4 lib/libQtDeclarative.so.4 \
       -e $$[QT_INSTALL_LIBS]/libQtSql.so.4 lib/libQtSql.so.4 \
       -e $$[QT_INSTALL_LIBS]/libQtSvg.so.4 lib/libQtSvg.so.4 \
       -e $$[QT_INSTALL_LIBS]/libQtScript.so.4 lib/libQtScript.so.4 \
       -e $$[QT_INSTALL_LIBS]/libQtXmlPatterns.so.4 lib/libQtXmlPatterns.so.4 \
       -e $$[QT_INSTALL_PLUGINS]/platforms/libblackberry.so lib/platforms/libblackberry.so \
       -e $$[QT_INSTALL_IMPORTS]/ imports/

    QMAKE_EXTRA_TARGETS += package
    #DEFINES += BLACKBERRY_PLAYBOOK
    DEFINES += BLACKBERRY_BB10
}

maemo5 {
    QT += dbus
}
symbian {
    LIBS += -lcone -leikcore -lavkon

    vendorinfo = "%{\"\"}" ":\"Slocan\""
}

exists($$QMAKE_INCDIR_QT"/../qmsystem2/qmkeys.h"):!contains(MEEGO_EDITION,harmattan): {
  MEEGO_VERSION_MAJOR     = 2
  MEEGO_VERSION_MINOR     = 0
  MEEGO_VERSION_PATCH     = 0
  MEEGO_EDITION           = harmattan
  DEFINES += MEEGO_EDITION_HARMATTAN
} # This doesn't seem to work in PR1.2 anymore

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp wordlist.cpp utility.cpp

HEADERS += wordlist.h utility.h

RESOURCES += qml/Wordsler/resource.qrc

# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()

OTHER_FILES += \
    Game.js \
    qml/HarmattanMain.qml \
    qtc_packaging/debian_fremantle/rules \
    qtc_packaging/debian_fremantle/README \
    qtc_packaging/debian_fremantle/copyright \
    qtc_packaging/debian_fremantle/control \
    qtc_packaging/debian_fremantle/compat \
    qtc_packaging/debian_fremantle/changelog \
    android/res/drawable-ldpi/icon.png \
    android/res/drawable-hdpi/icon.png \
    android/res/values/strings.xml \
    android/res/values/libs.xml \
    android/res/drawable-mdpi/icon.png \
    android/AndroidManifest.xml \
    android/src/eu/licentia/necessitas/ministro/IMinistroCallback.aidl \
    android/src/eu/licentia/necessitas/ministro/IMinistro.aidl \
    android/src/eu/licentia/necessitas/mobile/QtFeedback.java \
    android/src/eu/licentia/necessitas/mobile/QtAndroidContacts.java \
    android/src/eu/licentia/necessitas/mobile/QtSystemInfo.java \
    android/src/eu/licentia/necessitas/mobile/QtMediaPlayer.java \
    android/src/eu/licentia/necessitas/mobile/QtCamera.java \
    android/src/eu/licentia/necessitas/mobile/QtLocation.java \
    android/src/eu/licentia/necessitas/mobile/QtSensors.java \
    android/src/eu/licentia/necessitas/industrius/QtApplication.java \
    android/src/eu/licentia/necessitas/industrius/QtActivity.java \
    android/src/eu/licentia/necessitas/industrius/QtSurface.java \
    android/src/eu/licentia/necessitas/industrius/QtLayout.java \
    blackberry-tablet.xml \
    Wordsler.png \
    bb/Wordsler.png \
    bb/Wordsler-splash.png \
    bb/bar-descriptor.xml
#    qtc_packaging/debian_harmattan/rules \
#    qtc_packaging/debian_harmattan/README \
#    qtc_packaging/debian_harmattan/copyright \
#    qtc_packaging/debian_harmattan/control \
#    qtc_packaging/debian_harmattan/compat \
#    qtc_packaging/debian_harmattan/changelog \
#    qtc_packaging/meego.spec
#    qtc_packaging/debian_fremantle/rules \
#    qtc_packaging/debian_fremantle/README \
#    qtc_packaging/debian_fremantle/copyright \
#    qtc_packaging/debian_fremantle/control \
#    qtc_packaging/debian_fremantle/compat \
#    qtc_packaging/debian_fremantle/changelog

contains(MEEGO_EDITION,harmattan) {
    desktopfile.files = Wordsler.desktop
    desktopfile.path = /usr/share/applications
    INSTALLS += desktopfile

    splash.files = Wordsler-splash-harmattan.png
    splash.path = /opt/Wordsler/
    INSTALLS += splash
}

contains(MEEGO_EDITION,harmattan) {
    icon.files = Wordsler.png
    icon.path = /usr/share/icons/hicolor/80x80/apps
    INSTALLS += icon
}
