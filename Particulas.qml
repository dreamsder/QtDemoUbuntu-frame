import QtQuick 2.12
import QtQuick.Particles 2.12


Item {
    // color: "lightsteelblue"
    //  width: 512
    // height: 64
    id: root


    function pararDispararSimulacion(){

        if(sys.running){           
            sys.stop();

        }else{
            sys.stop();
            sys.start();
        }
    }

    /*SpriteSequence {
        sprites: Sprite {
                name: "bear"
                source: "Imagenes/cotizaciones.png"
                frameCount: 13
                frameDuration: 120
            }
        width: 250
        height: 250
        x: 20
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        z:4
    }*/

    ParticleSystem { id: sys }

    ImageParticle {
        anchors.fill: parent
        id: particles
        system: sys
        sprites: [Sprite {                
                name: "sisteco"
                source: "Imagenes/sisteco.svg"
                frameCount: 1
                frameDuration: 4000
                to: {"sisteco": 1, "correcto": 1}
            },Sprite{
                name: "correcto"
                source: "Imagenes/sisteco.svg"
                frameCount: 1
                frameDuration: 1000
                  to: {"correcto": 1, "sisteco": 1}
            }]
    }

    Emitter {
        system: sys
        emitRate: 1
        lifeSpan: 7000
        velocity: AngleDirection {angle: 76; magnitude: 60; angleVariation: 6}
        acceleration: PointDirection { y: 15 }
        size: 128
        sizeVariation: 40
        width: parent.width
        height: 128
        maximumEmitted: 4

    }

    /*SpriteGoal {
        system: sys
        width: root.width;
        height: root.height/2;
        y: root.height/2;
        goalState:"noticedbear"
    }*/


}
