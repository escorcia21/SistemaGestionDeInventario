import QtQuick 2.15
import QtQuick.Controls 2.15
import Qt.labs.qmlmodels 1.0
import "../controls"

Item {
    id:suppItem
    property color header_color: "#30475e"
    property color header_font_color: "#fff"
    property alias w: suppBack.width
    property alias add: table_model
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

        TableView {
            id: tableView
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: navBar.bottom
            anchors.bottom: parent.bottom
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            anchors.bottomMargin: 10
            onModelChanged: tableView.resizeColumnToContents()
            boundsBehavior: Flickable.StopAtBounds
            boundsMovement: Flickable.StopAtBounds
            columnWidthProvider: function (column) { return suppItem.width/6 }
            rowHeightProvider: function (column) { return 60; }
            anchors.topMargin: 0
            topMargin: columnsHeader.implicitHeight
            model: TableModel {
                id:table_model
                TableModelColumn { display: "ID" }
                TableModelColumn { display: "Nombre" }
                TableModelColumn { display: "NIT" }
                TableModelColumn { display: "Correo" }
                TableModelColumn { display: "Direccion" }
                TableModelColumn { display: "Telefono" }

                rows: []
            }

            delegate: DelegateChooser {
                DelegateChoice {
                    delegate: Rectangle {
                        color: row===selectedRow ? "#aaa" : "white"
                        Text {
                            text: display
                            anchors.fill: parent
                            anchors.margins: 10
                            color: 'black'
                            font.pixelSize: 15
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            elide: Text.ElideRight
                        }
                    
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                selectedRow = row
                                //parent.color = "#aaa"
                                var r = table_model.getRow(row)
                                // print values from all cells in a row
                                console.log("Clicked row: ",w)
                                for (var i = 0; i < table_model.columnCount; i++)
                                {
                                    console.log(r[headers[i]])
                                }
                            }
                        } 
                    } 
                }
            }
            ScrollBar.vertical: ScrollBar{}
            clip: true



            Row {
                id: columnsHeader
                y: tableView.contentY
                z: 2
                Repeater {
                    model: tableView.columns > 0 ? tableView.columns : 1
                    Label {
                        width: tableView.columnWidthProvider(modelData)
                        height: 35
                        text: headers[modelData]
                        color: header_font_color
                        font.pixelSize: 15
                        padding: 10
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        background: Rectangle { color: header_color }
                        }
                    }

                }

            ScrollIndicator.vertical: ScrollIndicator { }
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
                 add.appendRow({"ID":a.ID,"Nombre":a.Nombre,"NIT":a.NIT,"Correo":a.Correo,"Direccion":a.Direccion,"Telefono":a.Telefono});
             }
        }
    }
}


/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.33;height:480;width:640}D{i:3}
}
##^##*/
