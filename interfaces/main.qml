import QtQuick
import QtQuick.Controls

ApplicationWindow {
    id: root
    
    width: 420
    height: 650
    visible: true
    title: qsTr("Hello World")

    // User Info
    property string username: ""
    property string email: ""

    // Alias
    property alias stackView: stackView
    property alias navBar: navBar
    property alias myTabBar: myTabBar
    property alias commentList: commentList
    property alias pinList: pinList

    ListModel {
        id: commentList
    }

    ListModel{
        id: pinList
    }

    header: NavBar { id: navBar }

    StackView{
        id: stackView
        width: parent.width
        height: parent.height
        initialItem: "LoginPage.qml"
    }

    footer: MyTabBar{ id: myTabBar; visible: false }
}
