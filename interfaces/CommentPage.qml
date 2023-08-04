import QtQuick 6.5
import QtQuick.Controls 6.5
import "components" // Import the components folder
import mainLib 1.0

// import "./components/CommentModel.js" as CommentModel // Import the CommentModel.js file

Rectangle {
    id: root

    Text {
        id: commentPageTitle

        text: "Comments"
        font.family: "Roboto"
        font.pixelSize: 30
        color: "#000000"
        anchors {
            left: parent.left
            top: parent.top
            margins: 20
        }
    }

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
        anchors {
            top: commentPageTitle.bottom
            left: root.left
            right: root.right
            margins: 20
        }

        ListView {
            anchors.fill: parent
            spacing: 10

            model: commentModel

            delegate: MyComment {

                // width: parent.width
                // height: 150

                timestamp: model.timestamp
                username: model.username
                text: model.text
                commentID: model.commentID
                replies: model.replies
            }
        }
    }
}
