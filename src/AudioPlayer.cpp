#include "AudioPlayer.h"

#include <QFileInfo>
#include <QDebug>

AudioPlayer::AudioPlayer(QObject* parent)
    : QObject(parent)
{
    audioOutput = new QAudioOutput(this);
    player = new QMediaPlayer(this);

    player->setAudioOutput(audioOutput);

    // Default volume: 50%
    // audioOutput->setVolume(0.5f);

    // Update QML whenever playback position changes.
    connect(player, &QMediaPlayer::positionChanged,
        this, &AudioPlayer::positionChanged);

    // Update QML whenever track duration changes.
    connect(player, &QMediaPlayer::durationChanged,
        this, &AudioPlayer::durationChanged);

    connect(audioOutput, &QAudioOutput::volumeChanged,
        this, &AudioPlayer::volumeChanged);

    // Update QML when playback starts or stops.
    connect(player, &QMediaPlayer::playbackStateChanged,
        this, &AudioPlayer::playingChanged);

    // Report playback errors.
    connect(player, &QMediaPlayer::errorOccurred,
        this, [](QMediaPlayer::Error error, const QString& message)
        {
            Q_UNUSED(error);
            qWarning() << "Audio playback error:" << message;
        });
}

bool AudioPlayer::isPlaying() const
{
    return player->playbackState() == QMediaPlayer::PlayingState;
}

qint64 AudioPlayer::position() const
{
    return player->position();
}

qint64 AudioPlayer::duration() const
{
    return player->duration();
}

QString AudioPlayer::songName() const
{
    return m_songName;
}

float AudioPlayer::volume() const
{
	return audioOutput->volume();
}

void AudioPlayer::loadFile(const QUrl& fileUrl)
{
    if (!fileUrl.isValid() || !fileUrl.isLocalFile())
    {
        qWarning() << "Invalid local audio file URL:" << fileUrl;
        return;
    }

    player->stop();
    player->setSource(fileUrl);

    m_songName = QFileInfo(fileUrl.toLocalFile()).fileName();
    emit songNameChanged();
}

void AudioPlayer::play()
{
    player->play();
}

void AudioPlayer::pause()
{
    player->pause();
}

void AudioPlayer::stop()
{
    player->stop();
}

void AudioPlayer::setPosition(qint64 newPosition)
{
    player->setPosition(newPosition);
}

void AudioPlayer::setVolume(float volume)
{
    // Keep volume between 0.0 and 1.0.
    volume = qBound(0.0f, volume, 1.0f);

    if (audioOutput->volume() == volume)
        return;

    audioOutput->setVolume(volume);
}