# Add more folders to ship with the application, here
folder_01.source = qml/Wordsler
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

symbian:TARGET.UID3 = 0xE6B5A1B5

VERSION = 1.0.0

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
maemo5 {
    QT += dbus
}
symbian {
    LIBS += -lcone -leikcore -lavkon
}

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp wordlist.cpp utility.cpp

HEADERS += wordlist.h utility.h

RESOURCES += qml/Wordsler/resource.qrc

# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()

OTHER_FILES += \
    Game.js \
#    qtc_packaging/debian_harmattan/rules \
#    qtc_packaging/debian_harmattan/README \
#    qtc_packaging/debian_harmattan/copyright \
#    qtc_packaging/debian_harmattan/control \
#    qtc_packaging/debian_harmattan/compat \
#    qtc_packaging/debian_harmattan/changelog \
#    qtc_packaging/meego.spec
