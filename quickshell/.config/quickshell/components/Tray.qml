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
            id: trayIcon
            required property var modelData
            
            width: Config.fontSize
            height: Config.fontSize
            
            // Assume modelData.icon provides a valid image source (URL or icon name handled by Qt/Quickshell)
            source: modelData.icon

            QsMenuAnchor {
                id: menuAnchor
                menu: modelData.menu
                anchor {
                    item: trayIcon
                    gravity: Edges.Bottom | Edges.Right
                    edges: Edges.Bottom | Edges.Left
                }
            }
            
            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onClicked: (mouse) => {
                    if (mouse.button === Qt.LeftButton) {
                        modelData.activate()
                    } else if (mouse.button === Qt.RightButton) {
                        if (modelData.menu) {
                            menuAnchor.toggle()
                        }
                    }
                }
            }
        }
    }
}
