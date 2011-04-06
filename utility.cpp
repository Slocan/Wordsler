#include "utility.h"
#include "qmlapplicationviewer.h"

#if defined(Q_WS_MAEMO_5)
#   include <QDBusConnection>
#   include <QDBusMessage>
#endif
#if defined(Q_OS_SYMBIAN)
        #include <eikenv.h>
#endif

#if defined(Q_WS_MAEMO_5) || defined(Q_OS_SYMBIAN)
#include <QOrientationSensor>
#include <QOrientationReading>
QTM_USE_NAMESPACE
#endif

// Orientation code adapted from http://cdumez.blogspot.com/2010/12/screen-orientation-detection-for-qml.html

Utility::Utility(QObject *parent, QmlApplicationViewer *viewerRef) :
    QObject(parent), m_state("Landscape")
{
    viewer = viewerRef;
    #if defined(Q_WS_MAEMO_5) || defined(Q_OS_SYMBIAN)
    m_sensor = new QOrientationSensor(this);
    connect(m_sensor, SIGNAL(readingChanged()), SLOT(onReadingChanged()));
    m_sensor->start();
    #endif
}

Utility::~Utility() {
    #if defined(Q_WS_MAEMO_5) || defined(Q_OS_SYMBIAN)
    delete m_sensor;
    #endif
}

void Utility::taskSwitcher()
{
#if defined(Q_WS_MAEMO_5)
        QDBusConnection c = QDBusConnection::sessionBus();
        QDBusMessage m = QDBusMessage::createSignal("/", "com.nokia.hildon_desktop", "exit_app_view");
        c.send(m);
#elif defined(Q_OS_SYMBIAN)
        CEikonEnv::Static()->DisplayTaskList();
#else
    viewer->showMinimized();
#endif
}

QString Utility::getPlatform()
{
    #if defined(Q_WS_MAEMO_5)
        return "maemo5";
    #elif defined(Q_OS_SYMBIAN)
        return "symbian";
    #else
        return "other";
    #endif
}

void Utility::onReadingChanged()
{
  #if defined(Q_WS_MAEMO_5) || defined(Q_OS_SYMBIAN)
      //qDebug() << "XXX";
      QOrientationReading* reading = m_sensor->reading();
      switch(reading->orientation())
      {
          case QOrientationReading::TopUp:
              #if defined(Q_WS_MAEMO_5)
                m_state = "Landscape";
              #else
                m_state = "Portrait";
              #endif
            emit orientationChanged();
            break;
          case QOrientationReading::TopDown:
            #if defined(Q_WS_MAEMO_5)
              m_state = "LandscapeInverted";
            #else
              m_state = "PortraitInverted";
            #endif
            //m_state = "LandscapeInverted";
            emit orientationChanged();
            break;
          case QOrientationReading::LeftUp:
            #if defined(Q_WS_MAEMO_5)
              m_state = "Portrait";
            #else
              m_state = "LandscapeInverted";
            #endif
            //m_state = "Portrait";
            emit orientationChanged();
            break;
          case QOrientationReading::RightUp:
            #if defined(Q_WS_MAEMO_5)
              m_state = "PortraitInverted";
            #else
              m_state = "Landscape";
            #endif
            //m_state = "PortraitInverted";
            emit orientationChanged();
          default:
            break;
      }
      //qDebug() << "Custom coordinate type:" << m_state;
  #endif
}
