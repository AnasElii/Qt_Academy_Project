import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Shapes 6.5
import QtQuick.Layouts 6.5
import "components"

ApplicationWindow {
    id: mainWindow

    width: 320
    height: 568

    title: "Canvas"
    visible: true

    Canvas {
        id: mycanvas
        anchors.fill: parent

        onPaint: {
            // Get the x and y coordinates of the mouse cursor
            var x = mouse.x;
            var y = mouse.y;

            // Draw a line at the mouse cursor position
            var painter = mycanvas.getContext('2d');
            ctx.fillStyle = Qt.rgba(1, 1, 1, 1);
            painter.strokeStyle = "black";
            painter.lineWidth = 2;
            painter.beginPath();
            painter.moveTo(x, y);
            painter.lineTo(x + 1, y + 1);
            painter.stroke();
            console.log("Painted at " + x + ", " + y);
        }

        Image {
            id: image
            source: "https://images.pexels.com/photos/1570264/pexels-photo-1570264.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
            anchors.centerIn: parent
            fillMode: Image.PreserveAspectFit
            width: parent.width
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            // Retrieve the x and y coordinates on mouse click
            console.log("Mouse clicked at x:", mouse.x, "y:", mouse.y);
            pin.x = mouse.x;
            pin.y = (mouse.y - pin.height);
            pin.visible = true;
            inputs.visible = true;
        }
    }

    MyPin {
        id: pin
        visible: false
    }

    RowLayout {
        id: inputs

        spacing: 10
        anchors {
            top: pin.bottom
            left: parent.left
            right: parent.right
            margins: 10
        }
        visible: false

        TextField {
            id: input

            Layout.fillWidth: true
            height: 20
        }

        Button {
            text: "Send"
            onClicked: {
                console.log("Sending message:", input.text);
                parent.visible = false;
            }
        }
    }

    Rectangle {
        id: addPinButton

        width: 50
        height: 50
        radius: 25
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 20

        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log("Add pin button clicked");
                // pin.x = (parent.x + (parent.width / 2) - (pin.width / 2));
                // pin.y = (parent.y + (parent.height / 2) - (pin.height / 2));
                // pin.visible = true;
                // inputs.visible = true;
            }

            Image {
                id: addPinIcon

                source: "qrc:/mainLib/resources/icons/pin-circle.svg"
                anchors.centerIn: parent
                fillMode: Image.PreserveAspectFit
                width: parent.width * 0.8
                smooth: true
            }
        }
    }
}
