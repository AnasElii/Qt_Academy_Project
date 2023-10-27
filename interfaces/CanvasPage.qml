import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page{
    id: canvasPage

    title: qsTr("Canvas Page")

    property var pin: []
    property alias newComment: newComment

    function deleteComment(){
        var newCommentList;

        if(root.commentList.count > 0){

            for(var i = 0; i < root.commentList.count; i++){
            var commentObject = root.commentList.get(i);

            if(commentObject.visible){
                    newComment.push({
                        commentID: commentObject.commentID,
                        username: commentObject.username,
                        comment: commentObject.comment,
                        time: commentObject.time,
                        awner: commentObject.awner,
                        visible: commentObject.visible,
                        pin: commentObject.pin,
                        replyList: commentObject.replyList
                });        
            } 
            }

            root.commentList.clear();
            root.commentList= newCommentList;
            
        }
    }

    function displayPins(){
        root.pinList.clear();

        for(var k = 0; k < root.commentList.count; k++){
            console.log("Inside The Loop " + k);

            var pinNewObject = root.commentList.get(k).pin.get(0);
            root.pinList.insert(k,
                {
                    pinID: pinNewObject.pinID,
                    x: pinNewObject.x,
                    y: pinNewObject.y,
                    visible: pinNewObject.visible
                }
            );
        }
    }

    Component.onCompleted:{
        root.navBar.visible= true;
        root.navBar.flickable = flickable
        root.navBar.sheet = sheet;
        root.navBar.rcBackground = rcBackground;
        root.navBar.popup= newComment;
        root.navBar.canvasMouseArea = canvasMouseArea;
    }

    Rectangle {
        id: rcImage

        width: parent.width
        height: parent.height
        anchors.centerIn: parent
        color: "transparent"
        clip: true

        Flickable {
            id: flickable

            width: parent.width
            height: parent.height

            contentWidth: image.width
            contentHeight: image.height


            Image {
                id: image

                source: "qrc:/resources/images/Bitmap.png"
                
                fillMode: Image.PreserveAspectFit
            }


            Repeater{
                model: root.pinList

                delegate: MyPin{
                    pinID: model.pinID
                    x: model.x
                    y: model.y
                    visible: model.visible
                }
            }

            // Mouse Area To Add Pin On Click Event
            MouseArea {
                id: canvasMouseArea

                visible: false
                anchors.fill: parent

                onClicked: function(event){                    
                    // Creat Pin
                    canvasPage.pin = {
                        pinID: root.commentList.count,
                        x: (event.x - flickable.contentX),
                        y: (event.y - flickable.contentY),
                        visible: true
                    };

                
                    root.pinList.append(canvasPage.pin);
                    canvasPage.newComment.type = "addComment";
                    canvasPage.newComment.open()
                    visible= false;
                }
            }

        }
    }

    // Sheet Comment
    Rectangle {
        id: sheet

        width: parent.width
        height: parent.height

        color: "#FFF"
        radius: 10

        y: parent.height + 10
        x: 0
        z: 1

        Rectangle{
            width: 40
            height: 5
            radius: 5
            color: "#CCC"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 5
        }

        states: [

            State {
                name: "visible"
                PropertyChanges { target: sheet; y: canvasPage.height / 6 }
            },

            State {
                name: "hidden"
                PropertyChanges { target: sheet; y: canvasPage.height + 10 }
            }
        ]

        transitions: [

            Transition {
                from: "hidden"; to: "visible"
                NumberAnimation { properties: "y"; duration: 300 }
            },

            Transition {
                from: "visible"; to: "hidden"
                NumberAnimation { properties: "y"; duration: 300 }
            }
        ]

        Flickable{
            anchors{
                fill: parent
                topMargin: 20
                leftMargin: 10
                rightMargin: 10
            }
            clip: true
            contentHeight: clAll.implicitHeight

            ColumnLayout{
                id: clAll

                width: parent.width
                Label{
                    id: label
                    text: "Comments"
                    font.pointSize: 34
                    font.styleName: "Bold"
                    leftPadding: 20
                    bottomPadding: 15
                }

                ColumnLayout{
                    id: listInfoContent

                    Layout.fillWidth: true

                    Repeater{
                        model: root.commentList

                        delegate: CommentCumponent {
                            Layout.fillWidth: true
                            
                            commentID: model.commentID
                            commentIndex: model.index
                            usernameText: model.username
                            commentText: model.comment
                            timeText: model.time
                            awner: model.awner
                            visible: model.visible
                            replyList: model.replyList

                            Text{
                                text: model.index + " " + commentID
                            }
                        }

                        onItemRemoved: {
                            console.log("Item Deleted");
                        }
                    }
                }

                Rectangle{
                    opacity: 0
                    height: 100
                    Layout.fillWidth: true
                }
            }
        }
    }

    // Background
    Rectangle{
        id: rcBackground

        anchors.fill: parent
        color: "black"
        opacity: 0
        visible: false

        MouseArea{
            anchors.fill: parent

            onClicked:{
                if (sheet.state === "hidden") {
                    sheet.state = "visible";
                    rcBackground.visible = true;
                } else {
                    sheet.state = "hidden";
                    rcBackground.visible = false;
                }
            }
        }
    }

    // Input Comment
    Popup {
        id: newComment

        anchors.centerIn: parent
        width: parent.width - 40
        height: 200
        modal: true

        property string commentID: ""
        property string replyID: ""
        property string type: ""
        property alias newCommentTextField: newCommentTextField

        ColumnLayout {
            anchors.fill: parent

            Label {
                text: qsTr("New Comment")
                font.styleName: "Semibold"

                Layout.alignment: Qt.AlignHCenter
            }

            TextField {
                id: newCommentTextField

                placeholderText: qsTr("Enter project name")

                Layout.fillWidth: true
                Layout.leftMargin: 10
                Layout.rightMargin: 10

                Keys.onReturnPressed: {
                    if(btnAdd.enabled)
                        btnAdd.clicked()
                }
            }

            RowLayout{
                Layout.alignment: Qt.AlignHCenter
                Button {
                    id: btnAdd
                    text: qsTr("Add Comment")

                    Layout.alignment: Qt.AlignHCenter

                    onClicked: {       
                        if(root.pinList.count > 0)
                                root.pinList.clear();
                                                
                        var commentText = newCommentTextField.text;
                        
                        if(newComment.type === "addComment" && commentText !== ""){
                            root.commentList.append({
                                commentID: root.commentList.count,
                                username: "@user",
                                comment: commentText,
                                time: "Just now",
                                awner: true,
                                visible: true,
                                pin: [{}],
                                replyList: []
                            });

                            root.commentList.get(root.commentList.count - 1).pin.set(0, {
                                pinID: canvasPage.pin.pinID,
                                x: canvasPage.pin.x,
                                y: canvasPage.pin.y,
                                visible: canvasPage.pin.visible
                            });

                            displayPins();
                        }

                        if(newComment.type === "updateComment"){
                            root.commentList.get(newComment.commentID).comment = newCommentTextField.text;
                            displayPins();
                        }

                        if(newComment.type === "addReply")
                            root.commentList.get(newComment.commentID).replyList.append({
                                username: "@user",
                                comment: newCommentTextField.text,
                                time: "Just now",
                                awner: true
                            });

                        if(newComment.type === "updateReply")
                            root.commentList.get(newComment.commentID).replyList.get(newComment.replyID).comment = newCommentTextField.text;

                        newCommentTextField.text = "";
                        newComment.commentID = "";
                        newComment.close();
                    }
                }

                Button {
                    id: btnCancel
                    text: qsTr("Cancel")
                    flat: true

                    Layout.alignment: Qt.AlignHCenter

                    onClicked: {
                        newComment.close()
                    }
                }
            }
        }
    }

}
