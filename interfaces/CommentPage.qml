import QtQuick 6.5
import QtQuick.Controls 6.5
import "components" // Import the components folder
import mainLib 1.0

// import "./components/CommentModel.js" as CommentModel // Import the CommentModel.js file

Rectangle {
    id: root

    Rectangle {
        id: openCommentPage
        width: 30
        height: 30
        z: 1
        color: "transparent"
        visible: true
        anchors {
            right: parent.right
            top: parent.top
            margins: 20
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                // var commentList = CommentModel.getCommentData();
                // var index = CommentModel.getCommentData().length - 1;
                stackView.pop();
            }

            Image {
                id: commentIcon

                source: "qrc:/mainLib/resources/icons/back.svg"
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit
                smooth: true
            }
        }
    }

    ScrollView {
        anchors.fill: parent

        ListView {
            width: parent.width
            height: parent.height // Set the height to the height of the ScrollView
            spacing: 10

            model: commentModel

            delegate: CommentDelegate {
                width: parent.width
                height: 150

                timestamp: model.timestamp
                username: model.username
                text: model.text
                commentID: model.commentID
                replies: model.replies
            }
        }
    }
}
