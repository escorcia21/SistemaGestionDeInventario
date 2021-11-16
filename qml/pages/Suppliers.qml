import QtQuick 2.15
import Qt.labs.qmlmodels 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 1.4
import QtQuick.Controls 2.15 as C1
import QtQuick.Controls.Private 1.0

import "../controls"

Item {
    id:suppItem
    property color header_color: "#30475e"
    property alias bgv: tabla.backgroundVisible
    property color header_font_color: "#fff"
    property alias w: suppBack.width
    property alias add: tabla.model
    property var headers: ['ID','Nombre', 'NIT', 'Correo', 'Direccion', 'Telefono']
    property int selectedRow: -1
    property double w: suppBack.width
    Rectangle {
        id:suppBack
        color: "#00000000"
        anchors.fill: parent
        Rectangle {
            id:navBar
            height: 70
            color: "#00000000"
            width: 1200
            anchors.top: parent.top
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.topMargin: 0
        }

        Component
        {
            id: columnComponent
            TableViewColumn{width: tabla.width/6 }
        }

        TableView {
            id:tabla
            anchors.fill: parent
            anchors.margins: 10
            resources:
                {
                    var roleList = headers
                    var temp = []
                    for(var i=0; i<roleList.length; i++)
                    {
                        var role  = roleList[i]
                        temp.push(columnComponent.createObject(tabla, { "role": role, "title": role}))
                    }
                    return temp
                }

            model: ListModel {
            }

            style: TableViewStyle {
                handle:Item {
                    property bool sticky: false
                    property bool hovered: __activeControl !== "none"
                    implicitWidth: Math.round(TextSingleton.implicitHeight)
                    implicitHeight: Math.round(TextSingleton.implicitHeight)
                    Rectangle {
                        id: img
                        opacity: styleData.pressed && !transientScrollBars ? 0.5 : styleData.hovered ? 1 : 0.8
                        color: "#e81717"
                        border.color: "#00000000"
                        border.width: 0
                        anchors.top: !styleData.horizontal ? parent.top : undefined
                        anchors.margins: transientScrollBars ? 2 : 0
                        anchors.bottom: parent.bottom
                        anchors.right: parent.right
                        anchors.left: styleData.horizontal ? parent.left : undefined
                        width: !styleData.horizontal && transientScrollBars ? sticky ? 13 : 10 : parent.width
                        height: styleData.horizontal && transientScrollBars ? sticky ? 13 : 10 : parent.height
                        Behavior on width { enabled: !styleData.horizontal && transientScrollBars; NumberAnimation { duration: 100 } }
                        Behavior on height { enabled: styleData.horizontal && transientScrollBars; NumberAnimation { duration: 100 } }
                    }
                    onHoveredChanged: if (hovered) sticky = true
                    onVisibleChanged: if (!visible) sticky = false
                }


                    frame: Rectangle {border{width: 0;}}

                    incrementControl: Rectangle {}

                    decrementControl: Rectangle {}

                    corner : Rectangle {}

                    scrollBarBackground: Item{
                        property bool sticky: false
                        property bool hovered: styleData.hovered
                        implicitWidth: Math.round(TextSingleton.implicitHeight)
                        implicitHeight: Math.round(TextSingleton.implicitHeight)
                        clip: true
                        opacity: transientScrollBars ? 0.5 : 1.0
                        visible: !Settings.hasTouchScreen && (!transientScrollBars || sticky)
                        Rectangle {
                            anchors.fill: parent
                            color: "white"
                            border.width: 0
                            anchors.rightMargin: styleData.horizontal ? -2 : -1
                            anchors.leftMargin: styleData.horizontal ? -2 : 0
                            anchors.topMargin: styleData.horizontal ? 0 : -2
                            anchors.bottomMargin: styleData.horizontal ? -1 : -2
                        }
                        onHoveredChanged: if (hovered) sticky = true
                        onVisibleChanged: if (!visible) sticky = false

                    }

                    itemDelegate: Item {
                        height: Math.max(16, label.implicitHeight)
                        property int implicitWidth: label.implicitWidth + 20
                        Text {
                            id: label
                            objectName: "label"
                            width: parent.width - x - (horizontalAlignment === Text.AlignRight ? 8 : 1)
                            x: (styleData.hasOwnProperty("depth") && styleData.column === 0) ? 0 :
                               horizontalAlignment === Text.AlignRight ? 1 : 8
                            horizontalAlignment: Text.AlignHCenter
                            font.bold: false
                            font.pointSize: 12
                            //minimumPixelSize: 14//styleData.textAlignment
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.verticalCenterOffset: 1
                            elide: styleData.elideMode
                            text: styleData.value !== undefined ? styleData.value.toString() : ""
                            color: styleData.textColor
                            renderType: Settings.isMobile ? Text.QtRendering : Text.NativeRendering
                        }
                    }

                    headerDelegate: Rectangle {
                        height: 30
                        //color: red"
                        color: ["#30475e", "#203040"][styleData.column % 2]
                        Text {
                            text: styleData.value
                            color: "#FFF"
                            width: parent.width
                            height: parent.height
                            font.pointSize: 14
                            //minimumPointSize: 3
                            //fontSizeMode: Text.Fit
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.bold: true
                            elide: Text.ElideRight
                        }
                    }

                    rowDelegate: Rectangle {
                        id: rowDel
                        height: 70
                        property color alternateBackgroundColor: "#f5f5f5"
                        readonly property int modelRow: styleData.row ? styleData.row : 0
                        property color selectedColor: "#999"
                        color: styleData.selected ? selectedColor :
                                                    !styleData.alternate ? alternateBackgroundColor : "white"
                        // MouseArea {
                        //     anchors.fill: parent
                        //     onClicked: {
                        //         console.log("[!] log: " + modelRow);
                        //     }
                        // }

                    }
            }
        }
    }
    Connections {
        target: backend

        function onPageSupplier(object){
            //add.clear()
            var txt = JSON.parse(object);
            //console.log(JSON.stringify(txt,null,2))
             for (var index = 0; index < Object.keys(txt).length; index++) {
                //txt[`'Product{index}`]
                 var a = txt[`Supp${index}`];
                 add.append({"ID":a.ID,"Nombre":a.Nombre,"NIT":a.NIT,"Correo":a.Correo,"Direccion":a.Direccion,"Telefono":a.Telefono});
             }
        }
    }
}


/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.5;height:480;width:640}
}
##^##*/
