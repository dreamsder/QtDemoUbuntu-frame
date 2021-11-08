import QtQuick.Scene3D 2.0

import Qt3D.Core 2.12
import Qt3D.Render 2.12
import Qt3D.Input 2.12
import Qt3D.Extras 2.12


Scene3D
{

    property alias  sceneLoaderrrrr: sceneLoader
 //   anchors.fill: parent

    aspects : ["input", "logic"]
    cameraAspectRatioMode : Scene3D.AutomaticAspectRatio





    Entity
    {
        id: sceneRoot





        Camera
        {
            id: camera
            projectionType : CameraLens.PerspectiveProjection
            fieldOfView : 60
            aspectRatio : 4 / 3
            nearPlane : 0.1
            farPlane : 1000.0
            position : Qt.vector3d(0.0, 00.0, 10.0)
            upVector : Qt.vector3d(00.0, 0.0, 0.0)
            viewCenter : Qt.vector3d(0.0, 0.0, 0.0)
        }

        OrbitCameraController
        {
            camera: camera



        }

        components: [
            RenderSettings
            {
                activeFrameGraph: ForwardRenderer
                {
                    clearColor: Qt.rgba(0.5, 0.5, 1, 1)
                    camera : camera
                }
            },
            InputSettings
            {
            }
        ]

        Entity
        {
            id: monkeyEntity
            components : [
            SceneLoader
            {
                id: sceneLoader
            }
            ]



        }
    }
}
