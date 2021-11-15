import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3

Rectangle {
    id: root
    property var value
    property int type : Class.MetaType.UnknownType
    property bool readOnly : false
    property bool hasDomain : false
    property var domain
    signal clicked()
    implicitWidth: 100
    implicitHeight: 30
    color:"#eee"
    Loader {
        id: loader
        anchors.fill: parent
        anchors.margins: 1
    }
    MouseArea {
        id: editSurface
        anchors.fill: parent
        onClicked: root.clicked()
        enabled: loader.item.objectName !=="!"
    }
    Component {
        id: textDelegate
        Text {
            text: root.value
            clip: true
            horizontalAlignment:  Text.AlignHCenter
            verticalAlignment:    Text.AlignVCenter
            elide: Text.ElideRight
        }
    }
    Component {
        id: boolDelegate
        Switch {
            checked: root.value
            onClicked: root.onAccepted(checked)
            objectName: "!"
            enabled: !root.readOnly
        }
    }
    Component {
        id: numberDelegate
        Text {
            text: root.value
            clip: true
            horizontalAlignment:  Text.AlignRight
            verticalAlignment:    Text.AlignVCenter
            color: "#2E7D32"
            elide: Text.ElideLeft
            rightPadding: 2
        }
    }
    Component {
        id: colorDelegate
        Rectangle {
            color: root.value
        }
    }
    Component {
        id: stringListDelegate
        ComboBox {
            model: root.domain
            currentIndex: model.indexOf(root.value)
            objectName: "!"
            enabled: !root.readOnly
            //onCurrentIndexChanged: root.onAccepted(currentIndex)
            onActivated: root.onAccepted(model[index])
        }
    }
}
