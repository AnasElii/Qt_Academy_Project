

/*
This is a qml filethat is intended to be edited in Qt Design Studio only.
*/
import QtQuick 6.2
import QtQuick.Controls 6.2
import QtQuick.Layouts 1.0

Rectangle {
    id: rectangle
    width: 400 //parent.width
    height: 800 //parent.height

    color: Constants.backgroundColor
    property string comment: "slackuj commented on your project ASSIGNMENT"
    property string commentDate: "30 July on 16:12"

    Text {
        id: header
        color: "#0c149d"
        text: qsTr("NOTIFICATIONS")
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        font.pixelSize: 22
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.weight: Font.ExtraBold
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.topMargin: 10
    }

    Column {
        id: column
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        spacing: 20
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.bottomMargin: 100
        anchors.topMargin: 50

        Repeater {
            id: repeater
            anchors.fill: parent

            model: ListModel {
                id: myListModel
                ListElement {}
            }

            Rectangle {
                id: notificationBox
                x: 0
                y: 0
                height: 70
                width: parent.width
                color: "#d6d7d7"
                radius: 10

                Text {
                    id: notification
                    text: comment
                    anchors.fill: parent
                    font.pixelSize: 24
                    wrapMode: Text.Wrap
                }

                Text {
                    id: nDate
                    x: 250
                    width: 105
                    height: 17
                    text: commentDate
                    anchors.bottom: parent.bottom
                    font.pixelSize: 12
                    horizontalAlignment: Text.AlignRight
                    anchors.bottomMargin: -18
                }

                MouseArea {
                    id: mouseArea
                    anchors.fill: parent

                    Connections {
                        target: mouseArea
                        onClicked: console.log("notification clicked\n You need to redirect to project here.")
                    }
                }
            }
        }
    }

    Button {
        id: button
        x: 137
        y: 760
        text: qsTr("Trigger-Comment")

        Connections {
            target: button
            onClicked:{

                myListModel.append(myListModel)
                // comment = getCommet();----function to get commentator name from comment-CheckBox
                // commentDate = getCommentDate();---function to get comment time from comment-CheckBox
            }
        }
    }

    states: [
        State {
        }
    ]
}

