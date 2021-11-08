import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQml 2.12
import QtMultimedia 5.12
import QtGraphicalEffects 1.0


Item {
    id: item1

    signal clicCotizacion

    function actualizarCotizacion(moneda){

         myWorker.sendMessage(moneda);

    }

    function procesarMonedas(objetoJson){

        if(objetoJson.tipito==="dolares"){
            lblDolares.text="Dolar:\nCompra "+objetoJson.buy  + " - Venta "+ objetoJson.sell
        }else if(objetoJson.tipito==="euros"){
            lblEuros.text="Euro:\nCompra "+objetoJson.buy  + " - Venta "+ objetoJson.sell
        }
        else if(objetoJson.tipito==="argentinos"){
            lblArgentinos.text="Argentino:\nCompra "+objetoJson.buy  + " - Venta "+ objetoJson.sell
        }
        else if(objetoJson.tipito==="reales"){
            lblReales.text="Real:\nCompra "+objetoJson.buy  + " - Venta "+ objetoJson.sell
        }

    }

    Image {
        id: image
        anchors.fill: parent
        source: "Imagenes/cotizaciones.svg"
        fillMode: Image.PreserveAspectFit
        smooth: true
        antialiasing: true

        MouseArea {
            id: mouseArea
            width: 200
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.topMargin: 0
            anchors.bottomMargin: 0
            anchors.rightMargin: 0


            onClicked: {
                clicCotizacion()
            }
        }
    }

    DropShadow {
           anchors.fill: image
           horizontalOffset: 2
           verticalOffset: 2
           radius: 7.0
           color: acentoColor
           source: image



       }


    Label {
        id: lblDolares
        color: "#ffffff"
        text: qsTr("Dolar: ")
        anchors.left: image.left
        anchors.top: image.top
        font.pointSize: 10
        anchors.topMargin: 70
        anchors.leftMargin: 60
        font.bold: true
    }
    Label {
        id: lblEuros
        color: "#ffffff"
        text: qsTr("Euro: ")
        anchors.left: image.left
        anchors.top: lblDolares.top
        font.pointSize: 10
        anchors.topMargin: 50
        anchors.leftMargin: 60
        font.bold: true
    }
    Label {
        id: lblArgentinos
        color: "#ffffff"
        text: qsTr("Argentino: ")
        anchors.left: image.left
        anchors.top: lblEuros.top
        font.pointSize: 10
        anchors.topMargin: 50
        anchors.leftMargin: 60
        font.bold: true
    }
    Label {
        id: lblReales
        color: "#ffffff"
        text: qsTr("Real: ")
        anchors.left: image.left
        anchors.top: lblArgentinos.top
        font.pointSize: 10
        anchors.topMargin: 50
        anchors.leftMargin: 60
        font.bold: true
    }

    Label {
        id: lblCotizacionTitulo
        color: "#fffdbc"
        text: qsTr("Cotizaciones")
        anchors.top: parent.top
        horizontalAlignment: Text.AlignHCenter
        font.capitalization: Font.Capitalize
        font.pointSize: 15
        font.family: "Tahoma"
        font.bold: true
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
    }



    WorkerScript {
        id: myWorker
        source: "script.mjs"
        // onMessage: myText.text = messageObject.reply
        onMessage: {

            procesarMonedas(messageObject.monedas)



          //  textArea1.append(messageObject.reply.base)
            // console.log(messageObject.reply.base)
            //  lvListaMonedas.model = messageObject.reply

        }
    }




}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
