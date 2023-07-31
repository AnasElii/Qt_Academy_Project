import QtQuick 6.5
import QtQuick.Controls.Material 6.5
import mainLib 1.0
import "components"

ApplicationWindow {
    id: mainWindow

    width: 320
    height: 568

    title: "Reviewed"
    visible: true

    ListModel {
        id: commentModel

        ListElement {
            timestamp: "2 hours ago"
            username: "JohnDoe"
            pinID: 1
            text: "This is a comment about the pin."
        }

        ListElement {
            timestamp: "2 hours ago"
            username: "JohnDoe"
            pinID: 1
            text: "This is a comment about the pin."
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent

        initialItem: CanvasPage {
            id: page

            anchors.fill: parent
        }
    }
}
