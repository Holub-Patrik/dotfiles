import QtQuick
import Quickshell
import Quickshell.Services.SystemTray
import ".."

Item {
    id: root
    width: trayLabel.implicitWidth
    height: trayLabel.implicitHeight

    Text {
        id: trayLabel
        text: "..."
        color: Config.textColor
        font.pixelSize: Config.fontSize
        font.family: Config.fontMain
        style: Text.Outline
        styleColor: Config.shadowColor
        
        MouseArea {
            anchors.fill: parent
            onClicked: trayPopup.visible = !trayPopup.visible
        }
    }

    PopupWindow {
        id: trayPopup
        
        anchor {
            item: root
            // Anchor to the bottom-right of the label
            edges: Edges.Bottom | Edges.Right
            // Expand down and to the left
            gravity: Edges.Bottom | Edges.Left
        }

        width: trayRow.width + 10
        height: trayRow.height + 10
        color: "black" // OLED design first

        Row {
            id: trayRow
            anchors.centerIn: parent
            spacing: 5
            
            Repeater {
                model: SystemTray.items
                
                delegate: Image {
                    id: trayIcon
                    required property var modelData
                    
                    width: Config.fontSize
                    height: Config.fontSize
                    
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
                                    if (menuAnchor.visible) {
                                        menuAnchor.close()
                                    } else {
                                        menuAnchor.open()
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}