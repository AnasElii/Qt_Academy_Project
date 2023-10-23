import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    id: zoomTest

    title: "Zoom Test"

    Button{
        id: zoomReset

        anchors.left: parent.left
        anchors.bottom: rcImage.top
        anchors.bottomMargin: 10
        anchors.leftMargin: 10
        text: "Reset"

        onClicked: {
            imageScale.xScale = 1;
            imageScale.yScale = 1;
        }
    }

    RowLayout{
        anchors.right: parent.right
        anchors.bottom: rcImage.top
        anchors.bottomMargin: 10
        anchors.rightMargin: 10

        Button{
            id: zoomIn

            text: "+"

            onClicked: {
                imageScale.xScale += 0.1;
                imageScale.yScale += 0.1;
            }
        }

        Button{
            id: zoomOut

            text: "-"

            onClicked: {
                imageScale.xScale -= 0.1;
                imageScale.yScale -= 0.1;
                console.log("Image Width: " + image.implicitWidth);
                console.log("Image Height: " + image.implicitHeight);
            }
        }
    }

    Rectangle {
        id: rcImage

        anchors.centerIn: parent
        anchors.bottom: parent.bottom
        width: parent.width
        height: parent.height / 2
        clip: true

        color: "red"

        Flickable {
            id: flickable

            width: parent.width
            height: parent.height

            contentHeight: image.height * imageScale.yScale
            contentWidth: image.width * imageScale.xScale

            Image {
                id: image

                source: "qrc:/resources/images/Bitmap.png"
                
                fillMode: Image.PreserveAspectFit
                transform: Scale {
                    id: imageScale
                    xScale: 1
                    yScale: 1
                }

                 PinchArea {
                    anchors.fill: parent
                    property real zoomFactor: 0.05 // Adjust this value to control the zoom speed

                    // onPinchUpdated: {
                    //     if (pinch.scale > 1) {
                    //         imageScale.xScale += (pinch.scale - 1) * zoomFactor;
                    //         imageScale.yScale += (pinch.scale - 1)  * zoomFactor;
                    //     } else if (pinch.scale < 1) {
                    //         imageScale.xScale -= (1 - pinch.scale)  * zoomFactor;
                    //         imageScale.yScale -= (1 - pinch.scale)  * zoomFactor;
                    //     }
                    // }
                }
            }
        }
    }
}
