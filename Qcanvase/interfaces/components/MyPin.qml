import QtQuick 6.5
import QtQuick.Controls 6.5

Item {
    id: root

    width: 30
    height: 30

    MouseArea {
        id: mouseArea

        anchors.fill: parent

        onClicked: {
            console.log("clicked");
        }

        onPositionChanged: {
            console.log("position changed");
        }

        onPressAndHold: {
            console.log("press and hold");
        }

        Image {
            id: image

            sourceSize: Qt.size(parent.width, parent.height)
            source: "qrc:/mainLib/resources/icons/pin.svg"
            smooth: true
            clip: true
        }
    }
}
