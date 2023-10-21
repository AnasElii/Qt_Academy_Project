import QtQuick
import QtQuick.Controls

TabBar {
    TabButton {
        text: "Home"
        display: Qt.ToolButtonTextUnderIcon
        icon.source: "qrc:/resources/images/home.png"

        onClicked: console.log("Home pressed");
    }

//    TabButton {
//        text: "List"
//        display: Qt.ToolButtonTextUnderIcon
//        icon.source: "qrc:/images/list.png"
//    }

//    TabButton {
//        text: "Add"
//        display: Qt.ToolButtonTextUnderIcon
//        icon.source: "qrc:/images/add-new.png"
//    }

//    TabButton {
//        text: "User"
//        display: Qt.ToolButtonTextUnderIcon
//        icon.source: "qrc:/images/user.png"
//    }

    TabButton {
        text: "Settings"
        display: Qt.ToolButtonTextUnderIcon
        icon.source: "qrc:/resources/images/settings.png"

        onClicked: console.log("Settings pressed")

    }
}
