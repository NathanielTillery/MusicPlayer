# CMakeList.txt : CMake project for MusicPlayer, include source and define
# project specific logic here.
#

# Add source to this project's executable.
qt_add_executable (MusicPlayer "main.cpp"  "AudioPlayer.cpp" "AudioPlayer.h")

if (CMAKE_VERSION VERSION_GREATER 3.12)
  set_property(TARGET MusicPlayer PROPERTY CXX_STANDARD 20)
endif()

set_source_files_properties(
    ../qml/Main.qml
    PROPERTIES QT_RESOURCE_ALIAS Main.qml
)

qt_add_qml_module(MusicPlayer
    URI MusicPlayer
    VERSION 1.0
    QML_FILES
        ../qml/Main.qml
)


target_link_libraries(MusicPlayer PRIVATE
    Qt6::Quick
    Qt6::QuickControls2
    Qt6::Multimedia
)