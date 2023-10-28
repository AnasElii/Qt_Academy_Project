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

        ColumnLayout{

            Layout.fillWidth: true
            Layout.leftMargin: 10
            Layout.rightMargin: 10
            
            Label{
                visible: Qt.platform.os === "ios" ? true : false
                text: qsTr("Username")
                
            }
            TextField{
                id: tfRoomID

                placeholderText: qsTr("Username")
                focus: true

                Layout.fillWidth: true

                Keys.onReturnPressed: {
                    btnLogin.clicked()

                }
            }

        }

        TextField{
            id: tfEmail

            placeholderText: qsTr("Email")
            visible: false

            Layout.fillWidth: true
            Layout.leftMargin: 10
            Layout.rightMargin: 10

            Keys.onReturnPressed: {
                // btnLogin.clicked()
            }
        }

        Button{
            id: btnLogin

            text: qsTr("Login")

            Layout.fillWidth: true
            Layout.leftMargin: 10
            Layout.rightMargin: 10

            onClicked: {
                if(tfRoomID.text === "")
                    return;

                root.username = tfRoomID.text;
                root.userColor = root.randomColor();
                root.stackView.push("CanvasPage.qml");
            }
        }
    }
}
