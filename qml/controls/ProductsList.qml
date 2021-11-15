import QtQuick 2.15
import QtQuick.Controls 2.15
import "../controls"

Rectangle{
    id: bg
    anchors.fill: parent
    color: "#00000000"

    function applyFilter(pname,target){
        root.model.filter(pname,target);
    }

    function restart (){
        for (var d = 0; d < products.count; d++) {
            del.append(products.get(d));
            //console.log(products.get(d).ptype);
        }
        products.clear();
        for (var x = 0; x < del.count; x++) {
            products.append(del.get(x));
        }
        sortWithName();
        del.clear();
    }

    GridView {
        id: root
        anchors.fill: parent
        snapMode: GridView.SnapToRow
        anchors.rightMargin: 1
        boundsMovement: Flickable.StopAtBounds
        //Layout.alignment: Qt.AlignLeft | Qt.AlignTop
        //rowSpacing: 20
        //columnSpacing: 20
        //flow:  width > height ? GridView.LeftToRight : GridView.TopToBottom
        //Keys.onUpPressed: scrollBar.decrease()
        //Keys.onDownPressed: scrollBar.increase()
        //crollbar
        ScrollBar.vertical: ScrollBar {
            id: scrollBar
            width: 12
            // anchors.top: root.top
            // anchors.right: root.right
            // anchors.bottom: root.bottom
            // anchors.rightMargin: 0
            contentItem: Rectangle {
                id:contentItem_rect2
                color: "#30475e"
                //anchors.horizontalCenter: parent.horizontalCenter
                //width: 10 // This will be overridden by the width of the scrollbar
                //height: 10 // This will be overridden based on the size of the scrollbar
            }
        }

        // The standard size
        property var idealCellHeight: 250
        property var idealCellWidth: 200
        //cellWidth: 255
        //cellHeight: 205

        // The actual cell height is always as desired, but the cell width
        // is calculated from the current width of the view and how many cells fit
        cellHeight: idealCellHeight
        cellWidth: width / Math.floor(width / idealCellWidth)
        //cellWidth: idealCellWidth



        model: ListModel {
            id: products
            ListElement {pname: "acetaminifen"; price: "34000"; pstock: 12;ptype: "Tubo"; idd: 2; pimg: ""; totalp:0; hmany:0}
            ListElement {pname: "acetaminifen"; price: "34000"; pstock: 12;ptype: "Tubo"; idd: 2; pimg: ""; totalp:0; hmany:0}
            ListElement {pname: "acetaminifen"; price: "34000"; pstock: 12;ptype: "Tubo"; idd: 2; pimg: ""; totalp:0; hmany:0}
            ListElement {pname: "acetaminifen"; price: "34000"; pstock: 12;ptype: "Tubo"; idd: 2; pimg: ""; totalp:0; hmany:0}
            ListElement {pname: "acetaminifen"; price: "34000"; pstock: 12;ptype: "Tubo"; idd: 2; pimg: ""; totalp:0; hmany:0}
            ListElement {pname: "acetaminifen"; price: "34000"; pstock: 12;ptype: "Tubo"; idd: 2; pimg: ""; totalp:0; hmany:0}
            ListElement {pname: "acetaminifen"; price: "34000"; pstock: 12;ptype: "Tubo"; idd: 2; pimg: ""; totalp:0; hmany:0}
            ListElement {pname: "acetaminifen"; price: "34000"; pstock: 12;ptype: "Tubo"; idd: 2; pimg: ""; totalp:0; hmany:0}
            ListElement {pname: "acetaminifen"; price: "34000"; pstock: 12;ptype: "Tubo"; idd: 2; pimg: ""; totalp:0; hmany:0}


            function filter(PName,target) {
                //console.log("aaa");
                bg.restart();
                if (PName !== "ALL"){
                    for (var f = 0; f < products.count; f++){
                        var i= products.get(f);
                        var item;
                        if(target === 1){
                            item = i.pname.toLowerCase().indexOf(PName.toLowerCase()) >= 0;
                        }else{
                            item = i.ptype.toLowerCase().indexOf(PName.toLowerCase()) >= 0;
                        }
                        if (item === false){
                            del.append(i);
                            //bg.restart();
                            products.remove(f);
                            f = -1;
                        }
                    }
                }
            }
        }

        delegate: Item {
            // The delegate size is equal to the cell size...
            height: GridView.view.cellHeight
            //anchors.horizontalCenter: parent.horizontalCenter
            width: GridView.view.cellWidth

            ProductCard {
                identification: idd
                name: pname
                productImg: pimg == "" ? "../../img/images/NoImage.png" :pimg
                cost: price
                stock: pstock
                visible: show
                type: ptype
                // ... but visible part is not. Here the width is set to the ideal size.
                // The visible part of the delegate is centered in the delegate, which means
                // the grid appears centered
                anchors.centerIn: parent
                width: parent.GridView.view.idealCellWidth - 5  // - 20 (suggestion)
                height: parent.height - 20 // - 20 (suggestion)
                maximumValue:pstock
            }


        }
    }

    ListModel {
        id:del
    }

    //functions
    function sortWithName() {
        var product = _getOriginalList();
        product.sort(_compareName);

        var count = products.count;

        for (var index = 0; index < count; index++) {
            products.set(index, product[index]);
        }
    }

    // priv functions
    function _compareName(a, b) {
        if (a.ptype < b.ptype) {
            return -1;
        }

        if (a.ptype > b.ptype) {
            return 1;
        }

        return 0;
    }

    function _getOriginalList() {
        var product = [];
        var count = products.count;

        for (var index = 0; index < count; index++) {
            product.push({
                            "idd": products.get(index).idd,
                            "pname": products.get(index).pname,
                            "price": products.get(index).price,
                            "pstock": products.get(index).pstock,
                            "pseller": products.get(index).pseller,
                            "ptype": products.get(index).ptype
                        });
        }
        return product;

    }

    Connections {
        target: backend

        function onChange(img,id){

            for (var index = 0; index < products.count; index++) {
                var p = products.get(index);
                if (p["idd"] === id){
                    p["pimg"] = img;
                    products.set(index,p);
                }
            }
            //console.log(img,id);
        }

        function onAdd(id,q){
            //console.log(id,q)
            for (var index = 0; index < products.count; index++) {
                var p = products.get(index);
                if (p["idd"] === id){
                    break
                }
            }
            backend.send(p,q)
        }

        function onInitialize(object){
            //products.clear()
            var txt = JSON.parse(object);
            //console.log(JSON.stringify(txt,null,2))
             for (var index = 0; index < Object.keys(txt).length; index++) {
                //txt[`'Product{index}`]
                 var a = txt[`Product${index}`];
                 products.append({'pname': a.article, 'price': a.price, 'pstock': a.stock,'ptype': a.category, 'idd': a.idd, 'pimg': "", 'totalp':0, 'hmany':0});
             }
        }
    }
}
/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.75;height:480;width:640}
}
##^##*/
