import QtQuick 6.5
import "components"

Window {
    id: mainWindow

    height: 100
    width: 150

    title: qsTr("Hello World!")
    visible: true

    MyPin {
        id: myPin

        x: 0
        y: 0
    }
}
