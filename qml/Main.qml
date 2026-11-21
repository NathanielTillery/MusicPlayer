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
            "Audio files (*.mp3 *.mp4 *.wav *.ogg *.flac *.m4a)",
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

        Row {
            width: implicitWidth
            spacing: 15
            anchors.horizontalCenter: parent.horizontalCenter

            Column {
                width: parent.width * .2
                spacing: 0

                Slider {
                    id: volumeSlider
                    width: parent.width
                    from: 0
                    to: Math.max(0, 1)
                    value: audioPlayer.volume

                    onMoved: audioPlayer.setVolume(value)
                }

                Text {
                    text: "Volume"
                    color: "white"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

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

            Button {
                text: "Choose Song"

                onClicked: fileDialog.open()
            } 
        }
        Row {
            width: parent.width * 0.8
            spacing: 15
            anchors.horizontalCenter: parent.horizontalCenter

            Column {
                width: parent.width

                Slider {
                    id: progressSlider
                    width: parent.width
                    from: 0
                    to: Math.max(1, audioPlayer.duration)
                    value: audioPlayer.position

                    onMoved: audioPlayer.setPosition(value)
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
                }
            }
            

            

            
        }
    }
}