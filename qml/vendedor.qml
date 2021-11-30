import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import "controls"
import QtGraphicalEffects 1.15


Window {
    id: window
    width: 1366
    height: 768
    minimumWidth: 1366
    minimumHeight: 768
    visible: true
    color: "#00000000"
    title: ""
    Component.onCompleted: {
        window.x = window.screen.virtualX + window.screen.width / 2 - window.width / 2;
        window.y = window.screen.virtualY + window.screen.height / 2 - window.height / 2;
    }

    //REMOVE TITLE BAR
    flags: Qt.Window | Qt.FramelessWindowHint

    //PROPERTIES
    property int windowsStatus: 0
    property int windowMargin: 10
    property color colorwindow: "#30475e"

    //INTERNAL FUNTIONS
    QtObject{
        id: internal
        function maximizeRestore(){
            if (windowsStatus == 0){
                window.showMaximized()
                windowsStatus = 1
                windowMargin = 0
                maximize.btnIconSource = "../img/svg_img/restore_icon.svg"

            }else {
                window.showNormal()
                windowsStatus = 0
                windowMargin = 10
                //RESIZE VISIVILITY
                maximize.btnIconSource = "../img/svg_img/maximize_icon.svg"
            }
        }
        function ifMaximizeWindowRestore(){
            if(windowsStatus == 1){
                window.showNormal()
                windowsStatus = 0
                windowMargin = 10
                //RESIZE VISIVILITY
                maximize.btnIconSource = "../img/svg_img/maximize_icon.svg"
            }
        }

        function restoreMargins(){
            windowsStatus = 0
            windowMargin = 10
            //RESIZE VISIVILITY
            maximize.btnIconSource = "../img/svg_img/maximize_icon.svg"
        }


        function home() {
            if (btnHome.isActive != true){

                btnHome.isActive = true
                homeView.visible = true

                btnProducts.isActive = false
                productsView.visible = false

                botonFact.isActive = false
                facturaView.visible = false
            }
        }

        function products(){
            if (btnProducts.isActive != true){

                btnHome.isActive = false
                homeView.visible = false

                btnProducts.isActive = true
                productsView.visible = true

                botonFact.isActive = false
                facturaView.visible = false
            }
        }

        function factura(){
            if (botonFact.isActive != true){

                btnHome.isActive = false
                homeView.visible = false

                btnProducts.isActive = false
                productsView.visible = false

                botonFact.isActive = true
                facturaView.visible = true
            }
        }
    }

    Rectangle {
        id: bg
        color: "#e8e8e8"
        border.color: "#e8e8e8"
        anchors.fill: parent
        anchors.rightMargin: windowMargin
        anchors.leftMargin: windowMargin
        anchors.bottomMargin: windowMargin
        anchors.topMargin: windowMargin
        transformOrigin: Item.Center
        z:1
        Rectangle {
            id: container
            color: "#00000000"
            border.color: "#00000000"
            anchors.fill: parent
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.bottomMargin: 0
            anchors.topMargin: 0

            Rectangle {
                id: top_bar
                height: 60
                color: window.colorwindow
                border.color: "#00000000"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.topMargin: 0
                transformOrigin: Item.Center
                anchors.rightMargin: 0
                anchors.leftMargin: 0

                ToggleButton {
                    onClicked: animationMenu.running = true
                    width: 70
                }

                Rectangle {
                    id: titlebar_description
                    y: 29
                    height: 25
                    color: "#e7ded8"
                    border.color: "#00000000"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 0
                    anchors.leftMargin: 70
                    anchors.bottomMargin: 0

                    Label {
                        id: description
                        color: "#353637"
                        text: qsTr("Software de gestion de enventario")
                        anchors.fill: parent
                        font.letterSpacing: 0.4
                        verticalAlignment: Text.AlignVCenter
                        font.weight: Font.Bold
                        anchors.rightMargin: 300
                        anchors.leftMargin: 10
                    }

                    Rectangle {
                        id: description_right
                        color: "transparent"
                        anchors.left: description.right
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 10
                        anchors.leftMargin: 0


                        Image {
                            id: image2
                            width: 20
                            height: 20
                            anchors.right: parent.right
                            anchors.top: parent.top

                            source: "../img/images/github.png"
                            anchors.rightMargin: 10
                            anchors.bottom: parent.bottom
                            sourceSize.height: 24
                            sourceSize.width: 24
                            anchors.bottomMargin: 0
                            anchors.topMargin: 0
                            fillMode: Image.PreserveAspectFit
                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    Qt.openUrlExternally("https://github.com/escorcia21/SistemaGestionDeInventario");
                                }
                            }

                        }
                        ColorOverlay {
                            color: "#353637"
                            anchors.fill: image2
                            source: image2
                            anchors.verticalCenter: parent.verticalCenter
                        }

                    }
                }

                Rectangle {
                    id: titlebar
                    height: 35
                    color: "#00000000"
                    border.color: "#00000000"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.rightMargin: 0
                    anchors.leftMargin: 70
                    anchors.topMargin: 0

                    //drag title bar
                    DragHandler {
                        onActiveChanged: if(active) {
                                             window.startSystemMove()
                                             internal.ifMaximizeWindowRestore()

                                         }
                    }
                    Image {
                        id: image
                        width: 24
                        height: 24
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        source: "../img/images/inventario.png"
                        sourceSize.height: 24
                        sourceSize.width: 24
                        anchors.bottomMargin: 0
                        anchors.leftMargin: 10
                        anchors.topMargin: 0
                        fillMode: Image.PreserveAspectFit

                    }

                    ColorOverlay {
                        color: "#e8e8e8"
                        anchors.fill: image
                        source: image
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Label {
                        id: title
                        color: "#ffffff"
                        text: qsTr("Especialidad Eléctrica")
                        anchors.left: image.right
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        font.letterSpacing: 0.4
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        font.wordSpacing: 0.1
                        font.weight: Font.Bold
                        anchors.leftMargin: 5
                    }

                    Row {
                        id: row
                        x: 1136
                        width: 105
                        height: 35
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 0
                        anchors.topMargin: 0
                        anchors.rightMargin: 0

                        TopBarButton {
                            id: minimize

                            onClicked:{
                                window.showMinimized()
                                internal.restoreMargins()
                            }
                        }

                        TopBarButton {
                            id: maximize
                            btnIconSource: "../img/svg_img/maximize_icon.svg"
                            onClicked: internal.maximizeRestore()
                        }

                        TopBarButton {
                            id: close
                            btnColorMouseOver: "#b83f57"
                            btnIconSource: "../img/svg_img/close_icon.svg"
                            onClicked: {
                                backend.close()
                                window.close()
                            }
                        }
                    }
                }
            }

            Rectangle {
                id: content
                color: "#00000000"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: top_bar.bottom
                anchors.bottom: parent.bottom
                anchors.topMargin: 0

                Rectangle {
                    id: left_menu
                    width: 70
                    color: window.colorwindow
                    border.color: "#00000000"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 0

                    PropertyAnimation {
                        id: animationMenu
                        target: left_menu
                        property: "width"
                        to: if(left_menu.width == 70) return 250; else return 70
                        duration: 500
                        easing.type: Easing.InOutQuint
                    }

                    Column {
                        id: column
                        width: 100
                        height: 400
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 0
                        anchors.leftMargin: 0
                        anchors.bottomMargin: 90
                        anchors.topMargin: 0

                        LeftMenuBtn {
                            id: btnHome
                            width: left_menu.width
                            text: qsTr("Home")
                            iconHeight: 28
                            iconWidth: 28
                            font.pointSize: 12
                            isActive: true

                            onClicked: {

                                internal.home()

                            }
                        }


                        LeftMenuBtn {
                            id: btnProducts
                            width: left_menu.width
                            text: qsTr("Productos")
                            iconHeight: 30
                            iconWidth: 30
                            font.pointSize: 12
                            btnIconSource: "../img/svg_img/247-tag-10.svg"
                            onClicked: {
                                internal.products()
                            }
                        }

                        LeftMenuSHCart {
                            id: botonFact
                            width: left_menu.width
                            text: qsTr("Facturas")
                            iconHeight: 30
                            displayStock: false
                            font.pointSize: 12
                            btnIconSource: "../img/svg_img/invoice-svgrepo-com.svg"
                            font.bold: false
                            iconWidth: 30
                            onClicked: {
                                internal.factura()
                            }
                        }
                    }
                }

                Rectangle {
                    id: content_pages
                    color: "#e8e8e8"
                    anchors.left: left_menu.right
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    clip: false
                    anchors.bottomMargin: 25
                    anchors.leftMargin: 0
                    Loader {
                        id: homeView
                        anchors.fill: parent
                        source: Qt.resolvedUrl("pages/HomePage.qml")
                    }
                    Loader {
                        id: productsView
                        anchors.fill: parent
                        source: Qt.resolvedUrl("pages/ProductsPageSeller.qml")
                        visible: false
                    }
                    Loader {
                        id: facturaView
                        anchors.fill: parent
                        source: Qt.resolvedUrl("pages/Factura.qml")
                        visible: false
                    }
                }

                Rectangle {
                    id: bottom_bar
                    color: "#e7ded8"
                    anchors.left: left_menu.right
                    anchors.right: parent.right
                    anchors.top: content_pages.bottom
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 0

                    MouseArea {
                        id: mouseAreaR
                        x: 1243
                        y: 1
                        width: 20
                        height: 20
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 0
                        anchors.rightMargin: 0
                        cursorShape: Qt.SizeFDiagCursor
                        DragHandler {
                            target: null
                            onActiveChanged: if (active) { window.startSystemResize(Qt.RightEdge|Qt.BottomEdge) }
                        }

                        Image {
                            id: image1
                            x: 0
                            y: 0
                            width: 16
                            height: 16
                            anchors.right: parent.right
                            anchors.bottom: parent.bottom
                            source: "../img/svg_img/resize_icon.svg"
                            anchors.bottomMargin: 0
                            anchors.rightMargin: 0
                            autoTransform: false
                            asynchronous: false
                            cache: true
                            mipmap: false
                            mirror: false
                            sourceSize.height: 16
                            sourceSize.width: 16
                            fillMode: Image.PreserveAspectFit
                            antialiasing: false
                        }
                    }
                }
            }
        }
    }
    //Shadow arround the app

    DropShadow {
        anchors.fill: bg
        horizontalOffset: 0
        verticalOffset: 0
        radius: 10
        samples: 16
        color: "#80000000"
        source: bg
        z:0
    }
    Connections {
        target: backend
    }

}





/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}
}
##^##*/
