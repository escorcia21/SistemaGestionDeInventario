import QtQuick 2.15
import QtQuick.Controls 2.15


ListView {
    id:root
    clip: true
    property int totalPrice

    function totalCount (){
        var t = 0
        for (var d = 0; d < cart.count; d++){
            var f = cart.get(d);
            //console.log(f["totalp"]);
            t += f["totalp"];
        }

        //console.log(t);
        totalPrice = t
    }

    onCountChanged: root.totalCount()

    model: ListModel {
        id: cart
        //ListElement {pname: "acetaminofen"; price: 12; pstock: 0; pseller: "bayern";ptype: "A"; idd: 1; pimg: ""}
    }

    delegate: Item {
        height: 100
        width: root.width
        CartItem {
            id: joa
            anchors.fill: parent
            oprice: price
            title: pname
            pk:idd
            total: totalp
            cspinValue: hmany
        }
    }
    Connections {
        target: backend

        function onRecived (element,quantity){
            var exist = false
            for (var i = 0; i < cart.count; i++){
                var c = cart.get(i);
                if (c["idd"] === element["idd"]){
                    exist = true;
                    break;
                }
            }
            //console.log(quantity)
            if(exist !== true){
                element["hmany"]=quantity
                cart.append(element);
            }
        }

        function onSetTotal(totalp,pk){


            for (var i = 0; i < cart.count; i++){
                var c = cart.get(i);
                if (c.idd === pk){
                    c["totalp"] = totalp;
                    //console.log(totalp)
                    cart.set(i,c);
                }
            }

            root.totalCount()

        }

        function onCartListDelete(itempk){
            //console.log(itempk)
            for (var i = 0; i < cart.count; i++){
                var c = cart.get(i);
                if (c["idd"] === itempk){
                    cart.remove(i)
                    break;
                }
            }
        }

        function onClearList(){
            cart.clear()
        }

    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
