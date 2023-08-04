import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts 6.5
import QtQuick.Effects 6.5

Item {
    id: root

    property string timestamp: ""
    property string username: ""
    property list<int> pinIDs: []
    property alias text: comment.text
    property int commentID: 0
    property var replies: []

    function addReplay(userName, timeStamp, replay, commentID) {
        commentModel.set(commentID, {
                "replies": [{
                        "username": userName,
                        "timestamp": timeStamp,
                        "text": replay,
                        "commentID": commentID
                    },]
            });
    }

    width: 100
    height: 150

    Rectangle {

        color: "lightgrey"

        // The user profile
        Image {
            id: profilePic

            width: 60
            source: "qrc:/mainLib/resources/images/Profile.jpg"
            fillMode: Image.PreserveAspectFit

            layer.enabled: true
            layer.effect: MultiEffect {
                maskEnabled: true
                maskSource: Image {
                    width: 60
                    anchors.centerIn: parent
                    source: "qrc:/mainLib/resources/images/cover.png"
                    fillMode: Image.PreserveAspectFit
                }
                maskSpreadAtMax: 1
            }
        }

        // The comment
        ColumnLayout {

            anchors.left: profilePic.right
            anchors.leftMargin: 10
            spacing: 5

            Text {
                text: "@" + username
                font.bold: true
            }
            Text {
                text: timestamp
                font.pixelSize: 12
            }
            Text {
                id: comment
                text: text
                wrapMode: Text.WordWrap
            }

            Repeater {
                id: commentRepeater

                model: replies
                delegate: ReplyDelegate {
                    width: parent.width - 20 // Adjust width to indent the replies
                    x: 20 // Indent the replies

                    timestamp: model.timestamp
                    username: model.username
                    text: model.text
                }

                onItemAdded: {
                    pinIDs.append(model.pinID);
                }

                onModelChanged: {
                    // Reload the repeater when the model changes
                    console.log("Model changed");
                    reload();
                }
            }

            Button {
                id: button

                text: "Reply"
                onClicked: {
                    // Add a new reply to the replies list
                    commentModel.set(commentID, {
                            "replies": [{
                                    "username": "ANAs El",
                                    "timestamp": "Just Now",
                                    "text": "Replay WOrking Fine",
                                    "commentID": 0
                                },]
                        });
                    console.log("User name: " + commentModel.get(commentID).username + " comment: " + commentModel.get(commentID).text);
                    console.log("Replies name: " + commentModel.get(commentID).replies.username + " Replies comment: " + commentModel.get(commentID).replies.text);
                }
            }
        }
    }
}
