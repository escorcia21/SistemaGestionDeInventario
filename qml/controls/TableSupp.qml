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
    property color header_font_color: "#fff"
    property alias add: tabla.model
    property var headers: ['ID','Nombre', 'NIT', 'Correo', 'Direccion', 'Telefono']
    //property int columss: 6
    property var criterio: headers[1]
    property double headersW: tabla.width/headers.length
    property var selectedRow: tabla.currentRow > -1 ? tabla.currentRow :-1


    QtObject {
            id:functions
            function restart (){
                for (let d = 0; d < add.count; d++) {
                    del.append(add.get(d));
                }
                add.clear();
                for (let x = 0; x < del.count; x++) {
                    add.append(del.get(x));
                }
                sortWithName();
                del.clear();
            }

            function sortWithName() {
                let listTypes = _getOriginalList();
                listTypes.sort(_compareName);

                let count = add.count;

                for (let index = 0; index < count; index++) {
                    add.set(index, listTypes[index]);
                }
            }

            // priv functions
            function _compareName(a, b) {
                if (a.ID < b.ID) {
                    return -1;
                }

                if (a.ID > b.ID) {
                    return 1;
                }

                return 0;
            }

            function _getOriginalList() {
                let types = [];
                let count = add.count;

                for (let index = 0; index < count; index++) {
                    let x = {};
                    for (let j = 0; j < headers.length; j++){
                        x[headers[j]]= add.get(index)[headers[j]]
                    }
                    types.push(x);
                    //console.log(types[index].ID);
                }
                return types;
            }

            function find(PName) {
                functions.restart();
                if (PName !== ""){
                    for (let f = 0; f < add.count; f++){
                        let i= add.get(f);
                        let item;
                        //console.log(i[headers[1]]);
                        item = i[criterio].toLowerCase().indexOf(PName.toLowerCase()) >= 0;

                        if (item === false){
                            del.append(i);
                            add.remove(f);
                            f = -1;
                        }
                    }
                }
            }

        }

    Rectangle {
        id:suppBack
        color: "#00000000"
        anchors.fill: parent

        Component
        {
            id: columnComponent
            TableViewColumn{width: headersW}
        }

        FormField{
            id:search
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 10
            anchors.topMargin: 10
            placeholderText: "Buscar"
            onTextChanged: {
                functions.find(search.text);
            }
        }

        TableView {
            id:tabla
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: search.bottom
            anchors.bottom: parent.bottom
            //width: styleData.horizontal
            anchors.margins: 10
            anchors.topMargin: 10
            //onClicked: {console.log(selectedRow)}
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

            ListModel{
                id: del
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
                        //anchors.rightMargin: -4
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
                        property string headColors: styleData.column > -1 ? ["#30475e", "#203040"][styleData.column % 2] : "transparent"
                        height: 30
                        //color: red"
                        color: headColors
                        border.width: 0
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
}


/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.5;height:480;width:640}
}
##^##*/

