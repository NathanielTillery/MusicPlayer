#pragma once

#include <QObject>
#include <QMediaPlayer>
#include <QAudioOutput>
#include <QUrl>
#include <QString>

class AudioPlayer : public QObject
{
    Q_OBJECT

        Q_PROPERTY(bool playing READ isPlaying NOTIFY playingChanged)
        Q_PROPERTY(qint64 position READ position NOTIFY positionChanged)
        Q_PROPERTY(qint64 duration READ duration NOTIFY durationChanged)
        Q_PROPERTY(QString songName READ songName NOTIFY songNameChanged)
        Q_PROPERTY(float volume READ volume WRITE setVolume NOTIFY volumeChanged)

public:
    explicit AudioPlayer(QObject* parent = nullptr);

    bool isPlaying() const;
    qint64 position() const;
    qint64 duration() const;
    QString songName() const;
    float volume() const;

    Q_INVOKABLE void loadFile(const QUrl& fileUrl);
    Q_INVOKABLE void play();
    Q_INVOKABLE void pause();
    Q_INVOKABLE void stop();
    Q_INVOKABLE void setPosition(qint64 position);
    Q_INVOKABLE void setVolume(float volume);

signals:
    void playingChanged();
    void positionChanged();
    void durationChanged();
    void songNameChanged();
    void volumeChanged();

private:
    QMediaPlayer* player;
    QAudioOutput* audioOutput;

    QString m_songName;
};