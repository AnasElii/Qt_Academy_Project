import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects

Item{
    id: replyCard

    width: parent.width
    implicitHeight: glContent.height

    property int commentID: 0
    property int replyID: 0
    property alias usernameText: username.text
    property url imageSource: profilePic.source
    property alias timeText: time.text
    property alias commentText: comment.text
    property bool awner : false

    function getAlpha() {
        return root.username.substring(0, 1).toUpperCase();
    }

    GridLayout{
        id: glContent

        width: parent.width
        columns: 2
        columnSpacing: 10

        // Profile Picture
        Rectangle{
            id: profilePicContainer
            color: root.userColor
            width: 50
            height: 50
            radius: 10

            Image {
                id: profilePic

                width: parent.width
                source: "qrc:/resources/images/71z05dWWLHL.jpg"
                fillMode: Image.PreserveAspectFit
                visible: false

                // Profile Image Mask
                layer.enabled: true
                layer.effect: MultiEffect {
                    maskEnabled: true
                    maskSource: Image{
                        width: 50
                        source: "qrc:/resources/images/Pic_Circle.png"
                        fillMode: Image.PreserveAspectFit
                    }
                }
            }

            Text{
                id: profileText

                visible: true
                text: getAlpha()
                font{
                    family: "Texta"
                    styleName: "Bold"
                    pixelSize: 20
                }
                color: "white"
                anchors.centerIn: parent
            }
        }

        ColumnLayout{
            spacing: 5
            Text{
                id: username
                text: "@Ridhwan Nordin"
                font{
                    family: "Roboto"
                    styleName: "Bold"
                    pixelSize: 11
                }
            }

            Text{
                id: time
                text: "36 minutes ago"
            }
        }

        // Spacer
        Rectangle{
            color: "transparent"
        }

        Rectangle{
            id: commentBox
            implicitHeight: clContent.height
            color: "#e7e3e6"
            radius: 10

            Layout.fillWidth: true
            Layout.rightMargin: 10

            ColumnLayout{
                id: clContent

                width: parent.width
                spacing: 2

                RowLayout{
                    Layout.alignment: Qt.AlignRight
                    spacing: 0
                    visible: awner ? true : awner

                    ToolButton {
                        Layout.alignment: Qt.AlignRight
                        display: Qt.ToolButtonIconOnly
                        icon.source: "qrc:/resources/icons/pen.png"
                        visible: true
                        text: "edit"
                        onClicked:{
                            canvasPage.newComment.type = "updateReply";
                            canvasPage.newComment.commentID = replyCard.commentID
                            canvasPage.newComment.replyID = replyCard.replyID
                            canvasPage.newComment.newCommentTextField.text = replyCard.commentText;
                            canvasPage.newComment.open();
                        }
                    }
                    ToolButton {
                        Layout.alignment: Qt.AlignRight
                        display: Qt.ToolButtonIconOnly
                        icon.source: "qrc:/resources/icons/delete.png"
                        visible: true
                        text: "delete"
                        onClicked: root.commentList.get(replyCard.commentID).replyList.remove(replyCard.replyID)
                    }
                }

                Text {
                    id: comment

                    Layout.fillWidth: true
                    Layout.leftMargin: 10
                    Layout.topMargin: awner ? 0 : 10

                    text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
                    wrapMode: Text.WordWrap
                }

                Rectangle{
                    color: "transparent"
                    Layout.fillWidth: true
                    height: 10
                }
            }
        }
    }
}
