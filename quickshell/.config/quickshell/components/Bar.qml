import QtQuick
import Quickshell
import Quickshell.Services.UPower

PanelWindow {
    id: bar
    
    // Position
    anchors {
        top: true
        left: true
        right: true
    }
    implicitHeight: 30

    color: "transparent" // Transparency is king

    // Main layout
    Item {
        anchors.fill: parent
        anchors.margins: 5

        // Left side: Workspaces
        Workspaces {
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
        }

        // Right side: Tray + Clock
        Row {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            spacing: 10

            Tray {
                anchors.verticalCenter: parent.verticalCenter
            }

            Battery {
                anchors.verticalCenter: parent.verticalCenter
                visible: UPower.displayDevice && UPower.displayDevice.isPresent
            }

            Clock {
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
}
