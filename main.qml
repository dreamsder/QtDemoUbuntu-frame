import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQml 2.12
import QtMultimedia 5.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.0
import QtQuick.VirtualKeyboard 2.2
import QtQuick.VirtualKeyboard.Settings 2.2

import QtQuick.Particles 2.12

import "temasColores.js" as Temas



Window {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("")
    color: fondoColor


    property string version: "1.0.7"

    property string acentoColor : "#76a82c"
    property string fondoColor : "#f5ebdf"
    property string colorPrincial : "#11ebdf"


    function setearColores(colorDeseado){

        /*var coloresAcento = {};
        coloresAcento["1"]={'color':'#76a82c','fondo':'#f5ebdf'};
        coloresAcento["2"]={'color':'#FF5C58','fondo':'#FCD2D1'};
        coloresAcento["3"]={'color':'#7027A0','fondo':'#1DB9C3'};
*/
        acentoColor=Temas.coloresAcento[colorDeseado].color;
        fondoColor=Temas.coloresAcento[colorDeseado].fondo;

    }




    Component.onCompleted: {
        tmrFechaHora.triggered();
    }



    Timer{
        id:tmrFechaHora
        interval: 50000
        running: true
        repeat: true
        onTriggered: {
            myWorkerHora.sendMessage("hora")
        }
    }

    WorkerScript {
        id: myWorkerHora
        source: "date.mjs"
        onMessage: lblFecha.text = version + " - " + messageObject.hora
    }





    /*


    Component {
        id: fruitDelegate
        Row {
            spacing: 10
            Text { text: "Moneda: " }
            Text { text: "Compra: "+buy }
            Text { text: "Venta: " +sell  }
        }
    }

    ListView {
        id: lvListaMonedas
        width: 200
        height: 500
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: 50
        anchors.leftMargin: 20
        model: fruitModel
        delegate: fruitDelegate
    }

    ListModel {
        id: fruitModel

    }




    Text {
        id: myText
        x: 20
        y: 385
        text: 'Cargando fecha...'

    }






    Rectangle{
        id:pepe
        x:200
        y:200
        width: 100
        height: 50
        color: "#ff0000"


        MouseArea {
            id: mouseArea
            anchors.fill: parent
            anchors.rightMargin: 34
            anchors.bottomMargin: -176
            anchors.leftMargin: -34
            anchors.topMargin: 176
            onClicked: {


                // myWorker.sendMessage({ 'x': mouse.x, 'y': mouse.y,'dato':"1" })


                var msg = {'model': fruitModel};
                myWorker.sendMessage(msg);

                //  Logic.readConfigFile();


            }




        }
    }


    Button{
        x:345
        y: 350
        text: "mostrar"
        onClicked: {


            if(pepe.color=="#ffffff"){
                pepe.color="#ff0000"
            }else{
                pepe.color="#ffffff"
            }


        }
    }




    Button {
        id: btnSalir
        x: 504
        y: 412
        text: "Cerrar"
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 30
        anchors.bottomMargin: 30
        onClicked: window.close()
    }*/


    /*Rectangle{
        anchors.right: textArea1.left
        anchors.top: pepe.bottom
        anchors.bottom: parent.bottom
        anchors.topMargin: 20
        anchors.rightMargin: 20
        anchors.bottomMargin: 20

        anchors.leftMargin: 20
        radius: 10
        border.color: "blue"
        clip: true

        Image {
            anchors.fill: parent
            id: image
            source: "https://www.lacasadeel.net/wp-content/uploads/2017/05/animaniacs.jpg"
            antialiasing: true
            fillMode: Image.PreserveAspectFit

        }
    }*/




    /*Text {
        id: text1
        text: version
        anchors.right: parent.right
        anchors.top: parent.top
        font.pixelSize: 12
        anchors.topMargin: 5
        anchors.rightMargin: 20
    }*/



    Cotizacion{
        id:cotizaciones
        x: (width*-1)+22
        width: 300
        height: 300
        anchors.verticalCenter: parent.verticalCenter
        z:image.z+1
        Behavior on x {
            NumberAnimation { duration: 400;easing.type: Easing.OutBack}
        }

        onClicCotizacion: {
            x= cotizaciones.x==-50 ? (width*-1)+22 : -50
        }
    }


    Image {
        id: image
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        antialiasing: true

        Particulas{
            id:particulasSistema
            anchors.fill: parent

        }

        Image {
            id: cabezal
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            fillMode: Image.PreserveAspectFit
            source: "Imagenes/cabezal.svg"
            //source: "Imagenes/cabezal2.png"
            anchors.topMargin: 0
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            antialiasing: true
            smooth: true





        }



        Glow {
            anchors.fill: cabezal
            radius: 6
            color: acentoColor
            source: cabezal
            z:cabezal.z-1
        }


        SequentialAnimation {
            id: scalaImagen

            onStarted: {
                cotizaciones.actualizarCotizacion("dolares")
                cotizaciones.actualizarCotizacion("euros")
                cotizaciones.actualizarCotizacion("argentinos")
                cotizaciones.actualizarCotizacion("reales")
            }

            ScaleAnimator {target:glowCirculo ; from:1 ; to: 0.1; duration: 1}



            ScaleAnimator {target:circulo ; from:1 ; to: 0.5; duration: 500; easing.type: Easing.InBack}
            ScaleAnimator { target:circulo ; from: 0.5; to: 1; duration: 150 ;easing.type: Easing.InBack}




            ScaleAnimator { target:glowCirculo ; from: 0.5; to: 1; duration: 1 }

        }




        Image {
            id: imgPie
            anchors.fill: parent
            source: "Imagenes/pie.png"

            Label {
                id: lblFecha
                color: "#ffffff"
                text: qsTr("Fecha")
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                font.capitalization: Font.Capitalize
                layer.samples: 16
                layer.smooth: true
                font.bold: true
                anchors.bottomMargin: 12
                anchors.rightMargin: 12
            }
        }

        Glow {
            anchors.fill: imgPie
            radius: 6
            color: acentoColor
            source: imgPie
        }


        Glow {
            id:glowCirculo
            anchors.fill: circulo
            radius: 6
            color: acentoColor
            source: circulo
            scale: circulo.scale
            //z:circulo.z+10
        }





        Image {
            id: circulo
            fillMode: Image.PreserveAspectFit
            anchors.verticalCenter: cabezal.verticalCenter
            anchors.right: parent.right
            source: "Imagenes/circuloverde.png"
            anchors.rightMargin: 20
            antialiasing: true
            smooth: true
            height: cabezal.height*0.7



           Behavior on rotation {
                SmoothedAnimation{ velocity: 350 }
                //RotationAnimation { duration: 450 ; direction: RotationAnimation.Clockwise}
            }

            MouseArea{
                anchors.fill: parent

                onClicked: {

                    circulo.rotation+=360
                    scalaImagen.start()
                    particulasSistema.pararDispararSimulacion()


                    //  circulo.scale=0.5
                    // circulo.scale=1


                }



            }



        }












        BusyIndicator {
            id: busyIndicator
            anchors.verticalCenter: tarjetaDeCliente.verticalCenter
            layer.smooth: true
            running: false
            antialiasing: true
            anchors.horizontalCenter: tarjetaDeCliente.horizontalCenter

            contentItem: Item {
                   implicitWidth: 64
                   implicitHeight: 64

                   Item {
                       id: item
                       x: parent.width / 2 - 32
                       y: parent.height / 2 - 32
                       width: 64
                       height: 64
                       opacity: busyIndicator.running ? 1 : 0

                       Behavior on opacity {
                           OpacityAnimator {
                               duration: 250
                           }
                       }

                       RotationAnimator {
                           target: item
                           running: busyIndicator.visible && busyIndicator.running
                           from: 0
                           to: 360
                           loops: Animation.Infinite
                           duration: 1250
                       }

                       Repeater {
                           id: repeater
                           model: 6

                           Rectangle {
                               x: item.width / 2 - width / 2
                               y: item.height / 2 - height / 2
                               implicitWidth: 10
                               implicitHeight: 10
                               radius: 5
                               color: acentoColor
                               transform: [
                                   Translate {
                                       y: -Math.min(item.width, item.height) * 0.5 + 5
                                   },
                                   Rotation {
                                       angle: index / repeater.count * 360
                                       origin.x: 5
                                       origin.y: 5
                                   }
                               ]
                           }
                       }
                   }
               }
        }
        TarjetaCliente{
            id:tarjetaDeCliente
            x: 42
            y: 24
            opacity: 0
            rotation: -15
            smooth: true
            antialiasing: true
            scale:0.5

            Behavior on opacity {
                OpacityAnimator {
                    target: tarjetaDeCliente;
                    from: 0;
                    to: 1;
                    duration: 300
                }
            }
            Behavior on scale {
                ScaleAnimator{
                    target: tarjetaDeCliente;
                    from: 0.5;
                    to: 1;
                    duration: 300
                }

            }


            onResultadoFinalizado: {
                scale=1.0
                opacity=1.0
                busyIndicator.running=false

            }

        }



        Row{
            anchors.left: parent.left
            anchors.bottom: inputPanel.top
            anchors.bottomMargin: 40
            // anchors.bottom: parent.bottom
            anchors.leftMargin: 20
            //  anchors.bottomMargin: 40
            spacing: 10
            ComboBox {

                id:comboListaTipoDocumentos
                model: ListModel {
                    id: model
                    ListElement { text: "Cedula" }
                    ListElement { text: "Otro" }
                }

                onCurrentIndexChanged: {
                    //textField.forceActiveFocus()
                    console.log(currentIndex)
                }

            }

            TextField {
                id: textField
                layer.smooth: true
                antialiasing: true
                maximumLength: 20
                placeholderText: "introduzca su documento"
                //focus: true
                inputMethodHints: Qt.ImhDigitsOnly
                //enterKeyAction: EnterKeyAction.Next

            }

            RoundButton {
                id: roundButton
                text: "X"
                hoverEnabled: false
                focus: false
                onClicked: {
                    if(textField.text.trim()!=""){
                        textField.forceActiveFocus()
                        textField.clear()
                    }
                }
            }
            RoundButton {
                id: roundButtonOk
                text: "OK"
                hoverEnabled: false
                focus: false
                onClicked: {
                    //  textField.forceActiveFocus()
                    playMusic.play()

                    if(textField.text.trim()!=""){

                        var tipoDoc=comboListaTipoDocumentos.currentIndex==0?"C":"O"
                        var doc=textField.text.trim()

                        busyIndicator.running=true
                        tarjetaDeCliente.consultarPuntos({ 'tipoDoc': tipoDoc, 'doc': doc })

                    }




                }
            }




        }

        InputPanel {
            id: inputPanel
            z: 999
            y: parent.height
            anchors.left: parent.left
            anchors.right: parent.right
            states: State {
                name: "visible"
                /*  The visibility of the InputPanel can be bound to the Qt.inputMethod.visible property,
                    but then the handwriting input panel and the keyboard input panel can be visible
                    at the same time. Here the visibility is bound to InputPanel.active property instead,
                    which allows the handwriting panel to control the visibility when necessary.
                */
                when: inputPanel.active
                PropertyChanges {
                    target: inputPanel
                    y: parent.height - inputPanel.height
                }
            }
            transitions: Transition {
                id: inputPanelTransition
                from: ""
                to: "visible"
                reversible: true
                enabled: !VirtualKeyboardSettings.fullScreenMode
                ParallelAnimation {
                    NumberAnimation {
                        properties: "y"
                        duration: 250
                        easing.type: Easing.InOutSine
                    }
                }
            }
            Binding {
                target: InputContext
                property: "animating"
                value: inputPanelTransition.running
            }
        }



    }

     Video {
        id: video
        width : 300
        height : 200
        source: "https://file-examples-com.github.io/uploads/2018/04/file_example_AVI_1920_2_3MG.avi"

        MouseArea {
            anchors.fill: parent
            onClicked: {
                video.play()
                playMusic.play()

                console.log(playMusic.source)
                console.log(playMusic.status)
                console.log(playMusic.errorString)
            }
        }

        focus: true
        Keys.onSpacePressed: video.playbackState == MediaPlayer.PlayingState ? video.pause() : video.play()
        Keys.onLeftPressed: video.seek(video.position - 5000)
        Keys.onRightPressed: video.seek(video.position + 5000)


        Audio {

               id: playMusic
               source: "https://file-examples-com.github.io/uploads/2017/11/file_example_WAV_10MG.wav"
        }

    }





    Drawer {
        id: drawer
        width: 0.66 * window.width
        height: window.height

        Rectangle{
            id:rect
            anchors.fill: parent
            color: fondoColor
            border.width: 0


            ConfiguracionColor{
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: 100
                anchors.topMargin: 100
                valorMaximoSlider: Temas.cantidadTemasDisponibles()
                nombreTema: Temas.retornaNombreTema(valorSlider)
                onValorCambio: {
                    setearColores(valorSlider)
                }

            }










        }



    }





}



