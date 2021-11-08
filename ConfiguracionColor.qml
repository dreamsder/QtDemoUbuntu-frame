import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQml 2.12
import QtQuick.Layouts 1.12

Item{
    id: rectangle
    width: slider.implicitWidth
    height: slider.implicitHeight

    property string valorSlider: "1"
    property string valorMaximoSlider: "3"
    property string nombreTema: "Clasico"
    signal valorCambio

    Slider {
        id: slider
        x: 202
        y: 235
        anchors.horizontalCenterOffset: 42
        orientation: Qt.Horizontal
        to: valorMaximoSlider
        from: 1
        stepSize: 1
        anchors.horizontalCenter: parent.horizontalCenter
        value: 1

        ToolTip {
                parent: slider.handle
                visible: slider.pressed
                text: nombreTema
          }


        onValueChanged: {
            valorSlider=value
            valorCambio()
        }
    }







}
