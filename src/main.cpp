#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "AudioPlayer.h"

int main(int argc, char* argv[])
{
    QGuiApplication app(argc, argv);

    AudioPlayer audioPlayer;

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty(
        "audioPlayer",
        &audioPlayer
    );


    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("MusicPlayer", "Main");

    return app.exec();
}
