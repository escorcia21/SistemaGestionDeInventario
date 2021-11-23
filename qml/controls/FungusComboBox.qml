import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Item {
    QtObject {
        id:functions

        function get_id(idd){
            comboValue = idd;
        }

        function restart (){
            for (let d = 0; d < list.count; d++) {
                delTypes.append(list.get(d));
            }
            list.clear();
            for (let x = 0; x < delTypes.count; x++) {
                list.append(delTypes.get(x));
            }
            sortWithName();
            delTypes.clear();
        }

        function sortWithName() {
            let listTypes = _getOriginalList();
            listTypes.sort(_compareName);

            let count = list.count;

            for (let index = 0; index < count; index++) {
                list.set(index, listTypes[index]);
            }
        }

        // priv functions
        function _compareName(a, b) {
            if (a.Nombre < b.Nombre) {
                return -1;
            }

            if (a.Nombre > b.Nombre) {
                return 1;
            }

            return 0;
        }

        function _getOriginalList() {
            let types = [];
            let count = list.count;

            for (let index = 0; index < count; index++) {
                types.push({
                               "ID": list.get(index).ID,
                                "Nombre": list.get(index).Nombre
                            });
            }
            return types;
        }

        function filterTypes(PName) {
            functions.restart();
            if (PName !== ""){
                for (let f = 0; f < list.count; f++){
                    let i= list.get(f);
                    let item;
                    item = i.Nombre.toLowerCase().indexOf(PName.toLowerCase()) >= 0;

                    if (item === false){
                        delTypes.append(i);
                        list.remove(f);
                        f = -1;
                    }else {
                        comboBox.currentIndex = f;
                        comboValue = comboBox.model.get(comboBox.currentIndex).ID;
                    }
                }
            }
        }

    }
    id: item1
    width: 240
    height: 75
    property int comboValue:0
    property alias listm: comboBox.model

    FormField {
        id:funSearch
        height: 35
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        placeholderText: "Buscar"
        anchors.topMargin: 0
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        onTextChanged: {
            functions.filterTypes(funSearch.text);
        }
    }

    ComboBox {
        id: comboBox
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: funSearch.bottom
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        anchors.topMargin: 4
        font.pointSize: 12

        model: ListModel {
            id:list
            ListElement {Nombre:""}
        }

        delegate: ItemDelegate {
                  id:itemDlgt
                  width: comboBox.width


                  contentItem: Text {
                      id:textItem
                      text: Nombre
                      color: "#000"
                      font: comboBox.font
                      elide: Text.ElideRight
                      verticalAlignment: Text.AlignVCenter
                      horizontalAlignment: Text.AlignLeft
                      leftPadding: 0
                  }

                  background: Rectangle {
                    id: rec
                    color:itemDlgt.hovered?"#b5b5b5":"#e8e8e8";
                    anchors.left: itemDlgt.left
                    anchors.right: itemDlgt.right
                    anchors.top: itemDlgt.top
                    anchors.bottom: itemDlgt.bottom
                    border.width: 1
                    anchors.rightMargin: -3
                    anchors.leftMargin: -2
                    anchors.topMargin: -2
                    border.color: "#9f9f9f"
                    width:itemDlgt.width
                  }

        }

        ListModel {
            id: delTypes
        }


        popup: Popup {
                 id:comboPopup
                 y: comboBox.height + 2
                 width: comboBox.width
                 height:contentItem.implicitHeigh
                 padding: 1

                 contentItem: ListView {
                     id:listView
                     clip: true
                     implicitHeight: 85.3
                     model: comboBox.popup.visible ? comboBox.delegateModel : null

                     //ScrollIndicator.vertical: ScrollIndicator {}
                     ScrollBar.vertical: ScrollBar {
                         id: scrollBar
                         width: 10
                         anchors.top: listView.top
                         anchors.right: listView.right
                         anchors.bottom: listView.bottom
                         anchors.rightMargin: 0
                         contentItem: Rectangle {
                             id:contentItem_rect2
                             color: "#30475e"
                             anchors.horizontalCenter: parent.horizontalCenter
                             width: 10 // This will be overridden by the width of the scrollbar
                             height: 10 // This will be overridden based on the size of the scrollbar
                         }
                     }
                 }

                 background: Rectangle {
                     id:comboBackground
                     color: "#e8e8e8"
                     border.width: 0
                     layer.enabled: enabled
                     layer.effect: DropShadow {
                         //anchors.fill: comboBackground
                         width: comboBackground.width
                         height: comboBackground.height
                         color: "#5c242826"
                         horizontalOffset: 1
                         verticalOffset: 1
                         radius: 4
                         samples: 9
                         source: comboBackground
                     }
                 }


            }
        onActivated:{
            functions.get_id(list.get(index).ID);
            //console.log(comboValue)
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.9}
}
##^##*/
