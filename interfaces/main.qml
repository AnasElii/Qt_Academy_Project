import QtQuick
import QtQuick.Controls

ApplicationWindow {
    id: root
    
    width: 420
    height: 650
    visible: true
    title: qsTr("Hello World")

    property alias stackView: stackView
    property alias navBar: navBar
    property alias myTabBar: myTabBar
    property alias commentList: commentList

    ListModel {
        id: commentList
    }

    header: NavBar { id: navBar }

    StackView{
        id: stackView
        width: parent.width
        height: parent.height
        initialItem: "CanvasPage.qml"
    }

    footer: MyTabBar{ id: myTabBar; visible: false }
}
