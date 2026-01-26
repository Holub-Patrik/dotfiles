import QtQuick
import Quickshell
import Quickshell.Services.SystemTray
import ".."

Row {
    id: root
    spacing: 5
    
    Repeater {
        model: SystemTray.items
        
        delegate: Image {
            required property var modelData
            
            width: Config.fontSize
            height: Config.fontSize
            
            // Assume modelData.icon provides a valid image source (URL or icon name handled by Qt/Quickshell)
            source: modelData.icon
            
            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onClicked: (mouse) => {
                    if (mouse.button === Qt.LeftButton) {
                        modelData.activate()
                    } else if (mouse.button === Qt.RightButton) {
                        if (modelData.menu) {
                            // Assuming menu has an open method that takes coordinates or a target
                            // or it might be a context menu that needs to be instantiated.
                            // For now, let's try calling open() if it exists.
                            modelData.menu.open()
                        }
                    }
                }
            }
        }
    }
}
