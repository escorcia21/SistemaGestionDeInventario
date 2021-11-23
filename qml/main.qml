import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import "controls"
import QtGraphicalEffects 1.15


Window {
    id: window
    width: 1366
    height: 768
    minimumWidth: 800
    minimumHeight: 600
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
        function resetBorders (){
            resizeLeft.visible = true
            resizeRight.visible = true
            resizeTop.visible = true
            resizeBottom.visible = true
        }

        function hideBorders(){
            resizeLeft.visible = false
            resizeRight.visible = false
            resizeTop.visible = false
            resizeBottom.visible = false
        }
        function maximizeRestore(){
            if (windowsStatus == 0){
                window.showMaximized()
                windowsStatus = 1
                windowMargin = 0
                internal.hideBorders()
                maximize.btnIconSource = "../img/svg_img/restore_icon.svg"

            }else {
                window.showNormal()
                windowsStatus = 0
                windowMargin = 10
                //RESIZE VISIVILITY
                internal.resetBorders()
                maximize.btnIconSource = "../img/svg_img/maximize_icon.svg"
            }
        }
        function ifMaximizeWindowRestore(){
            if(windowsStatus == 1){
                window.showNormal()
                windowsStatus = 0
                windowMargin = 10
                //RESIZE VISIVILITY
                internal.resetBorders()
                maximize.btnIconSource = "../img/svg_img/maximize_icon.svg"
            }
        }

        function restoreMargins(){
            windowsStatus = 0
            windowMargin = 10
            //RESIZE VISIVILITY
            internal.resetBorders()
            maximize.btnIconSource = "../img/svg_img/maximize_icon.svg"
        }

       
        function home() {
            if (btnHome.isActive != true){

                btnHome.isActive = true
                btnSettings.isActive = false

                settingsView.visible = false
                homeView.visible = true

                btnProv.isActive= false
                suppliersView.visible = false

                btnProducts.isActive = false
                productsView.visible = false

                btnCart.isActive = false
                cartView.visible = false

                botonFact.isActive = false
                facturaView.visible = false

                clienteUsView.visible = false
                botonCliente.isActive = false

            }
        }

        function settings() {
            if (btnSettings.isActive != true){

                btnHome.isActive = false
                btnSettings.isActive = true

                settingsView.visible = true
                homeView.visible = false

                btnProv.isActive= false
                suppliersView.visible = false

                btnProducts.isActive = false
                productsView.visible = false

                btnCart.isActive = false
                cartView.visible = false

                botonFact.isActive = false
                facturaView.visible = false

                clienteUsView.visible = false
                botonCliente.isActive = false

            }
        }

        function suppliers() {
            if (btnProv.isActive != true){

                btnHome.isActive = false
                btnSettings.isActive = false

                settingsView.visible = false
                homeView.visible = false

                btnProv.isActive= true
                suppliersView.visible = true

                btnProducts.isActive = false
                productsView.visible = false

                btnCart.isActive = false
                cartView.visible = false

                botonFact.isActive = false
                facturaView.visible = false

                clienteUsView.visible = false
                botonCliente.isActive = false

            }
        }

        function products(){
            if (btnProducts.isActive != true){

                btnHome.isActive = false
                btnSettings.isActive = false

                settingsView.visible = false
                homeView.visible = false

                btnProv.isActive= false
                suppliersView.visible = false

                btnProducts.isActive = true
                productsView.visible = true

                btnCart.isActive = false
                cartView.visible = false

                botonFact.isActive = false
                facturaView.visible = false

                clienteUsView.visible = false
                botonCliente.isActive = false

            }
        }

        function cart(){
            if (btnCart.isActive != true){

                btnHome.isActive = false
                btnSettings.isActive = false

                settingsView.visible = false
                homeView.visible = false

                btnProv.isActive= false
                suppliersView.visible = false

                btnProducts.isActive = false
                productsView.visible = false

                btnCart.isActive = true
                cartView.visible = true

                botonFact.isActive = false
                facturaView.visible = false

                clienteUsView.visible = false
                botonCliente.isActive = false

            }
        }
        function factura(){
            if (botonFact.isActive != true){

                btnHome.isActive = false
                btnSettings.isActive = false

                settingsView.visible = false
                homeView.visible = false

                btnProv.isActive= false
                suppliersView.visible = false

                btnProducts.isActive = false
                productsView.visible = false

                btnCart.isActive = false
                cartView.visible = false

                botonFact.isActive = true
                facturaView.visible = true

                clienteUsView.visible = false
                botonCliente.isActive = false
            }
        }
        function clienteUsuario(){
            if (botonCliente.isActive != true){

                btnProducts.isActive = false
                btnHome.isActive = false
                btnSettings.isActive = false

                settingsView.visible = false
                homeView.visible = false
                productsView.visible = false

                btnProv.isActive= false
                suppliersView.visible = false

                btnCart.isActive = false
                cartView.visible = false

                botonFact.isActive = false
                facturaView.visible = false

                clienteUsView.visible = true
                botonCliente.isActive = true

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
                        color: "#a4aaac"
                        text: qsTr("aplication description")
                        anchors.fill: parent
                        font.letterSpacing: 0.4
                        verticalAlignment: Text.AlignVCenter
                        font.weight: Font.Bold
                        anchors.rightMargin: 300
                        anchors.leftMargin: 10
                    }

                    Label {
                        id: description_right
                        color: "#a4aaac"
                        text: qsTr("| HOME")
                        anchors.left: description.right
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        font.letterSpacing: 0.4
                        horizontalAlignment: Text.AlignRight
                        verticalAlignment: Text.AlignVCenter
                        font.bold: true
                        anchors.rightMargin: 10
                        anchors.leftMargin: 0
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
                        source: "../img/svg_img/cross.svg"
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
                        text: qsTr("MediCare")
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
                            text: qsTr("Products")
                            iconHeight: 30
                            iconWidth: 30
                            font.pointSize: 12
                            btnIconSource: "../img/svg_img/247-tag-10.svg"
                            onClicked: {
                                internal.products()
                            }
                        }

                        LeftMenuBtn {
                            id: btnProv
                            width: left_menu.width
                            text: qsTr("Suppliers")
                            iconHeight: 30
                            iconWidth: 30
                            isActive: false
                            font.pointSize: 12
                            btnIconSource: "../img/svg_img/065-delivery-truck-1.svg"
                            onClicked: {
                                internal.suppliers()
                            }
                        }
                        LeftMenuSHCart {
                            id: btnCart
                            width: left_menu.width
                            text: qsTr("Cart")
                            btnIconSource: "../img/svg_img/034-shopping-cart-12.svg"
                            iconHeight: 30
                            iconWidth: 30
                            displayStock: false
                            font.bold: false
                            font.pointSize: 12
                            onClicked: {
                                internal.cart()
                            }
                        }

                        LeftMenuSHCart {
                            id: botonFact
                            width: left_menu.width
                            text: qsTr("Cart")
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

                        LeftMenuSHCart {
                            id: botonCliente
                            width: left_menu.width
                            text: qsTr("Cart")
                            iconHeight: 30
                            font.pointSize: 12
                            displayStock: false
                            btnIconSource: "../img/svg_img/users-svgrepo-com.svg"
                            font.bold: false
                            iconWidth: 30
                            onClicked: {
                                internal.clienteUsuario()
                            }
                        }
                    }

                    LeftMenuBtn {
                        id: btnSettings
                        width: left_menu.width
                        text: "Settings"
                        anchors.bottom: parent.bottom
                        isActive: false
                        font.pointSize: 12
                        clip: true
                        anchors.bottomMargin: 25
                        btnIconSource: "../img/svg_img/settings_icon.svg"
                        onClicked: {
                            internal.settings()
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

//                    StackView {
//                        id: stackView
//                        anchors.fill: parent
//                        initialItem: Qt.resolvedUrl("pages/HomePage.qml")
//                    }
                    Loader {
                        id: homeView
                        anchors.fill: parent
                        source: Qt.resolvedUrl("pages/HomePage.qml")
                    }
                    Loader {
                        id: settingsView
                        anchors.fill: parent
                        source: Qt.resolvedUrl("pages/SettingsPage.qml")
                        visible: false
                    }
                    Loader {
                        id: productsView
                        anchors.fill: parent
                        source: Qt.resolvedUrl("pages/ProductsPage.qml")
                        visible: false
                    }
                    Loader {
                        id: cartView
                        anchors.fill: parent
                        source: Qt.resolvedUrl("pages/CartPage.qml")
                        visible: false

                    }

                    Loader {
                        id: suppliersView
                        anchors.fill: parent
                        source: Qt.resolvedUrl("pages/Suppliers.qml")
                        visible: false

                    }

                    Loader {
                        id: facturaView
                        anchors.fill: parent
                        source: Qt.resolvedUrl("pages/Factura.qml")
                        visible: false
                    }

                    Loader {
                        id: clienteUsView
                        anchors.fill: parent
                        source: Qt.resolvedUrl("pages/ClienteUsuario.qml")
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

                    Label {
                        id: bottom_description
                        color: "#a4aaac"
                        text: qsTr("aplication description1")
                        anchors.fill: parent
                        font.letterSpacing: 0.4
                        verticalAlignment: Text.AlignVCenter
                        font.weight: Font.Bold
                        anchors.rightMargin: 30
                        anchors.leftMargin: 10
                    }

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

    MouseArea {
        id: resizeLeft
        width: 10
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 0
        anchors.bottomMargin: 10
        anchors.topMargin: 10
        cursorShape: Qt.SizeHorCursor

        DragHandler {
            target: null
            onActiveChanged: if (active){window.startSystemResize(Qt.LeftEdge)}
        }
    }

    MouseArea {
        id: resizeRight
        width: 10
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        anchors.bottomMargin: 10
        anchors.topMargin: 10
        cursorShape: Qt.SizeHorCursor

        DragHandler {
            target: null
            onActiveChanged: if (active){window.startSystemResize(Qt.RightEdge)}
        }
    }

    MouseArea {
        id: resizeBottom
        height: 10
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        anchors.bottomMargin: 0
        cursorShape: Qt.SizeVerCursor

        DragHandler {
            target: null
            onActiveChanged: if (active){window.startSystemResize(Qt.BottomEdge)}
        }
    }

    MouseArea {
        id: resizeTop
        height: 10
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        cursorShape: Qt.SizeVerCursor

        DragHandler {
            target: null
            onActiveChanged: if (active){window.startSystemResize(Qt.TopEdge)}
        }
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
