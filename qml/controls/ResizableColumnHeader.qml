import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
ListView {
    id:roott
    property var len : [200,200,200,200,200,200]
    property var count : roott.model.length
    property int defaultWidth : 100
    signal  columnWidthChanged

    orientation: ListView.Horizontal
    clip: true
    delegate: HeaderDelegate {
        id: thedelegate
        width: roott.len[index]
        height: roott.height
        color:"#eec"
        text: "<b>"+modelData+"</b>"
        Rectangle {
            id: handle
            color: Qt.darker(parent.color, 1.05)
            height: parent.height
            width: 10
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            MouseArea {
                id: mouseHandle
                anchors.fill: parent
                drag{ target: parent; axis: Drag.XAxis }
                hoverEnabled: true
                cursorShape: Qt.SizeHorCursor
                onMouseXChanged: {
                    if (drag.active) {
                        var newWidth = thedelegate.width + mouseX
                        if (newWidth >= 50) {
                            thedelegate.width = newWidth
                            roott.len[index] = newWidth
                            roott.columnWidthChanged()
                        }
                    }
                }
            }
        }
    }
    onCountChanged:        modelCountChanged()
//    Component.onCompleted: resetColumns()

    function columnWidthProvider(column) {
        return len[column]
    }
    function resetColumns() {
        len=[]
        for (var i=0; i<count; i++) len.push(defaultWidth)
    }
    function modelCountChanged() {
        resetColumns()
        roott.columnWidthChanged()
    }
}
