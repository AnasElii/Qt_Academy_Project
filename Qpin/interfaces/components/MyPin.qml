import QtQuick 6.5
import QtQuick.Controls 6.5

Item {
    id: root

    width: 30
    height: 30

    MouseArea {
        anchors.fill: parent
        onClicked: {
            console.log("clicked");
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
