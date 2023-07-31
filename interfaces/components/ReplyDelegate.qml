import QtQuick 6.5
import QtQuick.Controls 2.15

Item {
    id: root

    height: 60

    property string timestamp: ""
    property string username: ""
    property alias text: replay.text

    Rectangle {
        width: parent.width
        height: parent.height

        // color: "lightgrey" // Adjust color for replies

        Row {
            spacing: 8
            Image {
                width: 20
                height: 20
                // Set the profile picture source here
                // source: "path/to/profile_picture.png"
            }
            Column {
                spacing: 4
                Text {
                    text: username
                    font.bold: true
                }
                Text {
                    text: timestamp
                    font.pixelSize: 12
                }
                Text {
                    id: replay

                    text: text
                    wrapMode: Text.WordWrap
                }
            }
        }
    }
}
