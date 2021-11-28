import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import "controls"

Window {
    id: splashScreen
    width: 380
    height: 580
    visible: true
    color: "#00000000"
    title: qsTr("Hello World")

    // Remove Title Bar
    flags: Qt.SplashScreen | Qt.FramelessWindowHint

    // Internal Functions
    QtObject{
        id: internal

        function login(username, password){
            backend.login(username, password)
        }
    }

    //// Properties
    // property int timeInterval: 3000
    //
    // Timer{
    //     id: timer
    //     interval: timeInterval
    //     running: true
    //     repeat: false
    //     onTriggered: {
    //         var component = Qt.createComponent("main.qml")
    //         var win = component.createObject()
    //         win.username = "No name"
    //         win.password = "No password"
    //         win.show()
    //         visible = false
    //     }
    // }

    Rectangle {
        id: bg
        x: 78
        y: 131
        width: 360
        height: 560
        color: "#30475e"
        //radius: 10
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        z: 1

        Image {
            id: logoImage
            x: 85
            width: 233
            height: 233
            opacity: 1
            anchors.top: parent.top
            source: "../img/images/Especialidad Electrica.png"
            anchors.topMargin: 45
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
        }


        FormField {
            id: textUsername
            x: 30
            y: 365
            opacity: 1
            anchors.bottom: textPassword.top
            anchors.bottomMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            placeholderText: "Username or email"
            placeholdColor: "#fff"
            borderColor: "#fff"
        }

        FormField {
            id: textPassword
            x: 30
            y: 418
            opacity: 1
            anchors.bottom: btnLogin.top
            anchors.bottomMargin: 40
            anchors.horizontalCenter: parent.horizontalCenter
            placeholderText: "Password"
            echoMode: TextInput.Password
            placeholdColor: "#fff"
            borderColor: "#fff"
        }

        Btnxd {
            id: btnLogin
            x: 30
            y: 469
            width: 300
            height: 40
            opacity: 1
            text: "Ingresar"
            anchors.bottom: parent.bottom
            font.bold: true
            btnColorClicked: "#ececec"
            textcolor: "#575757"
            btnColorMouseOver: "#f4f4f4"
            btnColorDefault: "#ffffff"
            font.pointSize: 12
            font.family: "Segoe UI"
            //colorPressed: "#558b1f"
            //colorMouseOver: "#7ece2d"
            //colorDefault: "#67aa25"
            anchors.bottomMargin: 40
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: internal.login(textUsername.text, textPassword.text)
        }

        Label {
            id: label1
            x: 55
            y: 330
            opacity: 1
            color: "#ffffff"
            text: qsTr("Ingresar usuario y contraseña")
            anchors.bottom: textUsername.top
            anchors.bottomMargin: 20
            anchors.horizontalCenterOffset: 0
            font.family: "Segoe UI"
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 10
        }

        Label {
            id: label
            x: 100
            y: 294
            opacity: 1
            color: "#ffffff"
            text: qsTr("Iniciar sesión")
            anchors.bottom: label1.top
            anchors.bottomMargin: 10
            font.family: "Segoe UI"
            font.pointSize: 16
            anchors.horizontalCenter: parent.horizontalCenter
        }

        TopBarButton {
            id: btnClose
            x: 20
            width: 30
            height: 30
            opacity: 1
            anchors.right: parent.right
            anchors.top: parent.top
            btnIconSource: "../img/svg_img/close_icon.svg"
            btnColorClicked: "#9b3a4d"
            btnColorDefault: "#b83f57"
            anchors.topMargin: 15
            anchors.rightMargin: 15
            btnColorMouseOver: "#ac3950"
            font.family: "Segoe UI"
            //colorMouseOver: "#7ece2d"
            //colorDefault: "#67aa25"
            font.pointSize: 10
            onClicked: splashScreen.close()
        }

    }

    DropShadow{
        anchors.fill: bg
        source: bg
        verticalOffset: 0
        horizontalOffset: 0
        radius: 10
        color: "#40000000"
        z: 0
    }

    Connections {
        target: backend
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.66}
}
##^##*/
