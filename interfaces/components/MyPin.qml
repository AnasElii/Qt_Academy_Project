import QtQuick 6.5
import QtQuick.Controls 6.5

Item {
    id: root

    width: 30
    height: 30

    property string pinId: "0"
    property string comment: ""
    property list<MyPin> pins

    // Declare the custom signal
    signal pinPressAndHeld(string pinId)
    signal pinDoubleClick(string pinId, string comment)

    MouseArea {
        id: mouseArea

        anchors.fill: parent

        onClicked: {
            console.log("Comment: " + comment);
        }

        // onPositionChanged: {
        //     console.log("position changed");
        //     root.x = mouse.x;
        //     root.y = mouse.y;
        // }

        onPressAndHold: {
            console.log("press and hold");
            pinPressAndHeld(root.pinId);
        }

        onDoubleClicked: {
            console.log("double clicked");
            pinDoubleClick(root.pinId, root.comment);
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
