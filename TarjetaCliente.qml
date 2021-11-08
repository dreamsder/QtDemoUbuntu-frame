import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

Item {
    id: item1

    width: 300
    height: 186

    property alias nombreSocio: txtNombreSocio
    property alias puntosSocio: txtPuntosSocio


    signal resultadoFinalizado

    function consultarPuntos(consulta){

        workerScriptconsultaPuntos.sendMessage(consulta);

    }





    Flipable {
        id: flipable
        anchors.fill: parent

        property bool flipped: false

        transform: Rotation {
            id: rotation
            origin.x: flipable.width/2
            origin.y: flipable.height/2
            axis.x: 0; axis.y: 1; axis.z: 0     // set axis.y to 1 to rotate around y-axis
            angle: 0    // the default angle
        }

        states: State {
            name: "back"
            PropertyChanges { target: rotation; angle: 360 }
            when: flipable.flipped
            onCompleted:  flipable.flipped=false
        }

        transitions: Transition {
            NumberAnimation { target: rotation; property: "angle"; duration: 700; easing.type: Easing.OutBack }
        }

        back: Image { source: "Imagenes/tarjeta.png";
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            fillMode: Image.PreserveAspectFit
            anchors.bottomMargin: 0
            anchors.topMargin: 0
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            antialiasing: true
            smooth: true
            }


          front: Image {
            id: imgTarjetaCliente
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            fillMode: Image.PreserveAspectFit
            source: "Imagenes/tarjeta.png"
            anchors.bottomMargin: 0
            anchors.topMargin: 0
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            antialiasing: true
            smooth: true

            MouseArea {
                width: 100
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.topMargin: 0
                anchors.bottomMargin: 0
                anchors.rightMargin: 0
                onClicked: {
                    flipable.flipped=true
                }
            }


            Text {
                id: txtNombreSocio
                color: "#d3d3d3"
                text: qsTr("Sin nombre de socio")
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                font.pixelSize: 18
                verticalAlignment: Text.AlignVCenter
                font.family: "Times New Roman"
                font.styleName: "Italic"
                font.bold: true
                anchors.rightMargin: 10
                anchors.topMargin: 10
                anchors.leftMargin: 15
                clip: true

            }
            Text {
                id: txtPuntosSocio
                color: "#d3d3d3"
                text: qsTr("Puntos: 5000")
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: txtNombreSocio.bottom
                font.pixelSize: txtNombreSocio.font.pixelSize
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                font.family: "Times New Roman"
                font.styleName: "Italic"
                font.bold: true
                anchors.rightMargin: 20
                anchors.topMargin: 5
                anchors.leftMargin: 20
            }

        }

        Glow {
            anchors.fill: imgTarjetaCliente
            radius: 3
            color: acentoColor
            source: imgTarjetaCliente
        }

        WorkerScript{
            id:workerScriptconsultaPuntos
            source: "consultaPuntos.mjs"
            onMessage: {
                if(messageObject.result.status==="OK"){

                    txtNombreSocio.text=messageObject.result.nombre
                    txtPuntosSocio.text="Puntos: "+messageObject.result.puntos
                    resultadoFinalizado()
                }else{

                    txtNombreSocio.text="Documento no registrado :("
                    txtPuntosSocio.text="Adquiera su tarjeta ya!"
                    resultadoFinalizado()
                }
            }
        }



    }


}
