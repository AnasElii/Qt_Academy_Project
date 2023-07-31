import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: numBtn

    property var myText: "0"

    width: 80
    height: 80
    anchors.top: inputRec.bottom
    anchors.left: inputRec.left
    anchors.topMargin: 20
    radius: 10
    color: "#888c90"

    Text {
        anchors.centerIn: parent
        text: myText
        font.pixelSize: 25
        font.bold: true
    }
}
