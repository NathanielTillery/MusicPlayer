import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs

ApplicationWindow {
    visible: true
    width: 600
    height: 400
    title: "MusicPlayer"

    color: "#202020"

    FileDialog {
        id: fileDialog
        title: "Select a song"
        fileMode: FileDialog.OpenFile
        nameFilters: [
            "Audio files (*.mp3 *.wav *.ogg *.flac *.m4a)",
            "All files (*)"
        ]

        onAccepted: {
            audioPlayer.loadFile(selectedFile)
        }
    }

    Column {
        anchors.centerIn: parent
        spacing: 20
        width: parent.width * 0.8

        Text {
            text: "Music Player"
            color: "white"
            font.pixelSize: 30
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text: audioPlayer.songName || "No song selected"
            color: "#cccccc"
            font.pixelSize: 18
            anchors.horizontalCenter: parent.horizontalCenter
            elide: Text.ElideMiddle
        }

        Button {
            text: "Choose Song"
            anchors.horizontalCenter: parent.horizontalCenter

            onClicked: fileDialog.open()
        }

        Slider {
            id: progressSlider
            width: parent.width
            from: 0
            to: Math.max(1, audioPlayer.duration)
            value: audioPlayer.position

            onMoved: audioPlayer.setPosition(value)
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 15

            Button {
                text: audioPlayer.playing ? "Pause" : "Play"

                onClicked: {
                    if (audioPlayer.playing)
                        audioPlayer.pause()
                    else
                        audioPlayer.play()
                }
            }

            Button {
                text: "Stop"
                onClicked: audioPlayer.stop()
            }
        }

        Text {
            text: {
                let current = Math.floor(audioPlayer.position / 1000)
                let total = Math.floor(audioPlayer.duration / 1000)

                function formatTime(seconds) {
                    let minutes = Math.floor(seconds / 60)
                    let remaining = seconds % 60
                    return minutes + ":" + String(remaining).padStart(2, "0")
                }

                return formatTime(current) + " / " + formatTime(total)
            }

            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}