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

    property string idP: ""

    ListModel {
        id: commentModel
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
