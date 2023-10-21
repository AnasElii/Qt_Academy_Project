import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ToolBar {
    id: toolBar

    width: parent.width

    property Flickable flickable
    property StackView stackView: root.stackView
    property Rectangle sheet
    property Popup popup
    property Rectangle rcBackground
    property var previousPage: stackView.get(parent.StackView.index - 1)

    property alias addNewButton : addNewButton
    property alias editingFinishedButton : editingFinishedButton

    background.visible: Qt.platform.os === 'ios' ? !flickable.atYBeginning : true

    // Back Button
    ToolButton{
        anchors.left: parent.left
        display: Qt.ToolButtonTextBesideIcon
        text: Qt.platform.os === 'ios' ? qsTr("Exit") : ""
        icon.source: "qrc:/resources/images/stackview-backarrow-light.png"
        onClicked: toolBar.stackView.pop()
    }

    // Title
    Label{
        anchors.centerIn: parent
        font.styleName: "Semibold"

        text: toolBar.stackView.currentItem.title
        visible: toolBar.background.visible
    }

    // Action Button
    RowLayout{
        anchors.right: parent.right
        spacing: 5
        
        ToolButton{
            id: addNewButton

            display: Qt.ToolButtonIconOnly
            icon.source: "qrc:/resources/images/add.png"
            visible: true
            onClicked: {
                root.stackView.currentItem.newComment.type = "addComment";
                popup.open()
            }
        } 

        ToolButton{
            id: editingFinishedButton

            display: Qt.ToolButtonIconOnly
            icon.source: "qrc:/resources/images/comment.png"
            visible: true

            onClicked: {
                if (toolBar.sheet.state === "hidden") {
                    toolBar.sheet.state = "visible";
                    rcBackground.visible = true;
                } else {
                    toolBar.sheet.state = "hidden";
                    rcBackground.visible = false;
                }
            }
        }
    }

}
