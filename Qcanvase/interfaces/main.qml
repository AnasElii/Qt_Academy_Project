import QtQuick 6.5
import QtQuick.Controls.Material 6.5
import QtQuick.Shapes 6.5
import QtQuick.Layouts 6.5
import QtQuick.Dialogs 6.5
import "components"
import mainLib 1.0

ApplicationWindow {
    id: mainWindow

    width: 320
    height: 568

    title: "Canvas"
    visible: true

    property list<MyPin> pinList
    property int pinCount: 0
    property bool isComment: false

    // function checkComment(pinq) {
    //     console.log("Checking comment");
    //     if (pinq.comment != "") {
    //         console.log("Comment found");
    //         return true;
    //     }
    //     return false;
    // }

    function handlePressAndHold(pinId) {
        // Handle the press and hold event here
        if (pinId < 0)
            return;
        var pin = pinList[pinId]; // Get the pin object
        console.log("Destroying pin: ", pin.pinId);
        pin.destroy();
    }

    function handleDoubleClick(pinId, comment) {
        // Handle the double click event here
        if (pinId < 0 && comment == "")
            return;
        var pin = pinList[pinId]; // Get the pin object
        dialog.visible = true;
        dialogInput.text = pin.comment;
        console.log("new Comment ", dialogInput.text);
    }

    // Canvas To Draw On Image And Add Pins On Click Event On Image
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
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            ctx.fillRect(50, 50, 100, 100);
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

    // Mouse Area To Add Pin On Click Event
    MouseArea {
        id: canvasMouseArea

        anchors.fill: parent
        visible: false

        onClicked: {
            // Retrieve the x and y coordinates on mouse click
            console.log("Mouse clicked at x:", mouse.x, "y:", mouse.y);
            var pin = Qt.createComponent('qrc:/mainLib/interfaces/components/MyPin.qml').createObject(mainWindow, {
                    "pinId": pinCount.toString(),
                    "x": mouse.x,
                    "y": mouse.y
                });
            // Connect the pressAndHoldSignal3
            pin.pinPressAndHeld.connect(handlePressAndHold);
            pin.pinDoubleClick.connect(handleDoubleClick);
            pinList.push(pin);
            pinCount++;
            pin.pins = pinList;
            inputs.visible = true;
            console.log(pin.pinId, " | ", pin.x, " | ", pin.y, " | ", pin.visible);
            canvasMouseArea.visible = false;
        }
    }

    // Inputs
    RowLayout {
        id: inputs

        spacing: 10
        anchors {
            left: parent.left
            right: parent.right
            bottom: addPinButton.top
            margins: 10
        }
        height: 30
        visible: false

        TextField {
            id: input

            Layout.fillWidth: true
            height: 20
        }

        Button {
            text: "Send"
            onClicked: {
                console.log("Sending message: ", input.text);
                if (input.text == "") {
                    // inputs.input.focus = true;
                    dialog.visible = true;
                    isComment = false;
                    return;
                }
                pinList[pinList.length - 1].comment = input.text;
                isComment = false;
                input.text = "";
                inputs.visible = false;
            }
        }
    }

    // Add Pin Button
    Rectangle {
        id: addPinButton

        width: 50
        height: 50
        anchors {
            right: parent.right
            bottom: parent.bottom
            margins: 20
        }
        radius: 25
        opacity: 0.6

        MouseArea {
            anchors.fill: parent

            onClicked: {
                if (isComment == false) {
                    console.log("Add pin button clicked");
                    canvasMouseArea.visible = true;
                    isComment = true;
                }
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

    // Dialog To CHeck For Comment
    Dialog {
        id: dialog

        title: "Pin"
        standardButtons: Dialog.Ok | Dialog.Cancel
        visible: false

        ColumnLayout {
            id: dialogLayout
            spacing: 10
            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
                bottom: parent.bottom
                margins: 10
            }

            TextField {
                id: dialogInput

                Layout.fillWidth: true
                height: 20
            }
        }

        onAccepted: {
            console.log("Sending message: ", dialogInput.text);
            pinList[pinList.length - 1].comment = dialogInput.text;
            dialogInput.text = "";
            inputs.visible = false;
        }
    }
}
