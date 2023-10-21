import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page{
    id: loginPage

    title: qsTr("Login Page")

   Component.onCompleted:{
       root.navBar.visible= false
       root.myTabBar.visible = false
   }

    ColumnLayout{
        id: clInputs

        width: parent.width
        anchors.centerIn: parent
        spacing: 20


        Text{
            text: "Login"
            font.pixelSize: 32
            font.family: "Mulish"
            font.styleName: "Bold"

            Layout.alignment: Qt.AlignHCenter
        }

        TextField{
            id: tfRoomID

            placeholderText: qsTr("Root ID")
            focus: true

            Layout.fillWidth: true
            Layout.leftMargin: 10
            Layout.rightMargin: 10

            Keys.onReturnPressed: {
                if(createProjectButton.enabled)
                    focus: true
            }
        }

        TextField{
            id: tfEmail

            placeholderText: qsTr("Email")

            Layout.fillWidth: true
            Layout.leftMargin: 10
            Layout.rightMargin: 10

            Keys.onReturnPressed: {
                console.log("Login");
            }
        }

        Button{
            id: btnLogin

            text: qsTr("Login")

            Layout.fillWidth: true
            Layout.leftMargin: 10
            Layout.rightMargin: 10

            onClicked: root.stackView.replace("CanvasPage.qml")
        }
    }
}
