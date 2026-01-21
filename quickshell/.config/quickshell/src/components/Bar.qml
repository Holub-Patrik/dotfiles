import QtQuick
import Quickshell

PanelWindow {
    id: bar
    
    // Position
    anchors {
        top: true
        left: true
        right: true
    }
    implicitHeight: 20

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

        // Right side: Clock
        Clock {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
