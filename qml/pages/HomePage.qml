import QtQuick 2.15
import QtQuick.Controls 2.15
import "../controls"

Item {
    id: root
    property string calctext: ""
    property int f: 0

    function onclick (txt) {
        if (f == 1){
            calctext = "";
            f=0
        }
        if (calctext.length == 0){
            calctext = txt;
        }
        else{
            calctext += txt;
        }
    }

    function resut (){
        console.log(calctext)
        if (calctext != ""){
            try {
                var r = eval(calctext);
                calctext = r;
            } catch (error) {
                calctext = "Error";
            }
        }
    }

    function deletelast(){
        calctext = calctext.substring(0, calctext.length - 1);

    }
    Rectangle {
        id: container
        color: "#00000000"
        border.color: "#00000000"
        anchors.fill: parent

        Rectangle {
            id: rectangle
            color: "#00000000"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: textInput.bottom
            anchors.bottom: parent.bottom
            anchors.topMargin: 0
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.bottomMargin: 0

            Grid {
                QtObject{
                    id: gridInternal
                    property var w: (calculator.width/calculator.columns)-1
                    property var h: (calculator.height/calculator.rows)-1


                }


                id: calculator
                anchors.fill: parent
                anchors.leftMargin: 1
                anchors.rightMargin: 0
                anchors.bottomMargin: 0
                columns: 4
                rows: 5
                spacing: 1
                Btnxd {onDoubleClicked: {onclick(text)} onClicked: {onclick(text)} width: gridInternal.w; height: gridInternal.h ; text: "("; font.bold: true; textcolor: "#e8e8e8"; font.pointSize: 19; btnColorClicked: "#cd3737"; btnColorMouseOver: "#ec3c3c";btnColorDefault: "#f05454" }
                Btnxd {onDoubleClicked: {onclick(text)} onClicked: {onclick(text)}width: gridInternal.w; height: gridInternal.h ; text: ")"; font.bold: true; font.pointSize: 19; textcolor: "#e8e8e8"; btnColorClicked: "#cd3737"; btnColorMouseOver: "#ec3c3c";btnColorDefault: "#f05454" }
                CalcDelete {onDoubleClicked: {deletelast()} onClicked: {deletelast()}width: gridInternal.w; height: gridInternal.h ; btnColorClicked: "#cd3737"; btnColorMouseOver: "#ec3c3c";btnColorDefault: "#f05454" }
                Btnxd {onDoubleClicked: {onclick(text)} onClicked: {onclick(text)}width: gridInternal.w; height: gridInternal.h ; text: "\u00f7"; font.bold: true; font.pointSize: 19; btnColorClicked: "#cd3737"; btnColorMouseOver: "#ec3c3c";btnColorDefault: "#f05454" }
                Btnxd {onDoubleClicked: {onclick(text)} onClicked: {onclick(text)}width: gridInternal.w; height: gridInternal.h ; text: "7"; font.bold: true; font.pointSize: 19; textcolor: "#26282a"; btnColorClicked: "#bcbec3"; btnColorDefault: "#d7d8db"; btnColorMouseOver: "#cfcfcf"}
                Btnxd {onDoubleClicked: {onclick(text)} onClicked: {onclick(text)}width: gridInternal.w; height: gridInternal.h ; text: "8"; font.bold: true; font.pointSize: 19; textcolor: "#26282a";btnColorDefault: "#d7d8db" ; btnColorClicked: "#bcbec3"; btnColorMouseOver: "#cfcfcf"}
                Btnxd {onDoubleClicked: {onclick(text)} onClicked: {onclick(text)}width: gridInternal.w; height: gridInternal.h ; text: "9"; font.bold: true; font.pointSize: 19; textcolor: "#26282a";btnColorDefault: "#d7d8db"; btnColorClicked: "#bcbec3"; btnColorMouseOver: "#cfcfcf" }
                Btnxd {onDoubleClicked: {onclick("*")} onClicked: {onclick("*")}width: gridInternal.w; height: gridInternal.h ; text: "X"; font.bold: true; font.pointSize: 16; btnColorClicked: "#cd3737"; btnColorMouseOver: "#ec3c3c";btnColorDefault: "#f05454" }
                Btnxd {onDoubleClicked: {onclick(text)} onClicked: {onclick(text)}width: gridInternal.w; height: gridInternal.h ; text: "4"; font.bold: true; font.pointSize: 19; textcolor: "#26282a";btnColorDefault: "#d7d8db"; btnColorClicked: "#bcbec3"; btnColorMouseOver: "#cfcfcf" }
                Btnxd {onDoubleClicked: {onclick(text)} onClicked: {onclick(text)}width: gridInternal.w; height: gridInternal.h ; text: "5"; font.bold: true; font.pointSize: 19; textcolor: "#26282a";btnColorDefault: "#d7d8db"; btnColorClicked: "#bcbec3"; btnColorMouseOver: "#cfcfcf" }
                Btnxd {onDoubleClicked: {onclick(text)} onClicked: {onclick(text)}width: gridInternal.w; height: gridInternal.h ; text: "6"; font.bold: true; font.pointSize: 19; textcolor: "#26282a";btnColorDefault: "#d7d8db"; btnColorClicked: "#bcbec3"; btnColorMouseOver: "#cfcfcf" }
                Btnxd {onDoubleClicked: {onclick(text)} onClicked: {onclick(text)}width: gridInternal.w; height: gridInternal.h ; text: "-"; font.bold: true; font.pointSize: 19; btnColorClicked: "#cd3737"; btnColorMouseOver: "#ec3c3c";btnColorDefault: "#f05454" }
                Btnxd {onDoubleClicked: {onclick(text)} onClicked: {onclick(text)}width: gridInternal.w; height: gridInternal.h ; text: "1"; font.bold: true; font.pointSize: 19; textcolor: "#26282a";btnColorDefault: "#d7d8db"; btnColorClicked: "#bcbec3"; btnColorMouseOver: "#cfcfcf" }
                Btnxd {onDoubleClicked: {onclick(text)} onClicked: {onclick(text)}width: gridInternal.w; height: gridInternal.h ; text: "2"; font.bold: true; font.pointSize: 19; textcolor: "#26282a";btnColorDefault: "#d7d8db"; btnColorClicked: "#bcbec3"; btnColorMouseOver: "#cfcfcf" }
                Btnxd {onDoubleClicked: {onclick(text)} onClicked: {onclick(text)}width: gridInternal.w; height: gridInternal.h ; text: "3"; font.bold: true; font.pointSize: 19; textcolor: "#26282a";btnColorDefault: "#d7d8db"; btnColorClicked: "#bcbec3"; btnColorMouseOver: "#cfcfcf" }
                Btnxd {onDoubleClicked: {onclick(text)} onClicked: {onclick(text)}width: gridInternal.w; height: gridInternal.h ; text: "+"; font.bold: true; font.pointSize: 19; btnColorClicked: "#cd3737"; btnColorMouseOver: "#ec3c3c";btnColorDefault: "#f05454" }
                Btnxd {onDoubleClicked: {onclick(text)} onClicked: {calctext = ""}width: gridInternal.w; height: gridInternal.h ; text: "C"; font.bold: true; font.pointSize: 19; btnColorClicked: "#cd3737"; btnColorMouseOver: "#ec3c3c";btnColorDefault: "#f05454" }
                Btnxd {onDoubleClicked: {onclick(text)} onClicked: {onclick(text)}width: gridInternal.w; height: gridInternal.h ; text: "0"; font.bold: true; font.pointSize: 19; textcolor: "#26282a";btnColorDefault: "#d7d8db"; btnColorClicked: "#bcbec3"; btnColorMouseOver: "#cfcfcf" }
                Btnxd {onDoubleClicked: {onclick(text)} onClicked: {onclick(text)}width: gridInternal.w; height: gridInternal.h ; text: "."; font.bold: true; font.pointSize: 19; btnColorClicked: "#cd3737"; btnColorMouseOver: "#ec3c3c";btnColorDefault: "#f05454" }
                Btnxd {onClicked: {resut(); f = 1}width: gridInternal.w; height: gridInternal.h ; text: "="; font.bold: true; font.pointSize: 19; btnColorClicked: "#cd3737"; btnColorMouseOver: "#ec3c3c";btnColorDefault: "#f05454" }
            }
        }



        TextInput {
            id: textInput
            text: root.calctext
            height: 170
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            font.pixelSize: 50
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
            maximumLength: 50
            readOnly: true
            font.bold: true
            selectedTextColor: "#e8e8e8"
            selectionColor: "#cd3737"
            anchors.leftMargin: 0
            anchors.topMargin: 0
            anchors.rightMargin: 0
        }


    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:1.100000023841858;height:480;width:640}
}
##^##*/
