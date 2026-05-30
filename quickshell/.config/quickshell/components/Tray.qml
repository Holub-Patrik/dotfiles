import QtQuick
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Io
import ".."

Item {
    id: root
    width: trayLabel.implicitWidth + 16 // Generous horizontal buffer
    height: 30 // Spans full bar height for an exceptionally comfortable click zone

    property var barWindow: null

    // Volume & Brightness State
    property int volumeLevel: 0
    property int brightnessLevel: 0
    property bool isMuted: false

    // State query methods
    function updateVolume() {
        volProcess.running = false;
        volProcess.running = true;
    }

    // State query methods
    function updateBrightness() {
        briProcess.running = false;
        briProcess.running = true;
    }

    // Process runners for initial load and updates
    Process {
        id: volProcess
        command: ["/home/holubpat/.config/hypr/scripts/volume.sh", "--get"]
        stdout: StdioCollector {
            onStreamFinished: {
                let text = this.text.trim();
                if (text === "muted" || text === "[muted]") {
                    isMuted = true;
                } else {
                    let cleaned = text.replace("%", "").trim();
                    let val = parseInt(cleaned, 10);
                    if (!isNaN(val)) {
                        volumeLevel = val;
                    }
                    isMuted = false;
                }
            }
        }
    }

    Process {
        id: briProcess
        command: ["/home/holubpat/.config/hypr/scripts/brightness.sh", "--get"]
        stdout: StdioCollector {
            onStreamFinished: {
                let cleaned = this.text.trim();
                let val = parseInt(cleaned, 10);
                if (!isNaN(val)) {
                    brightnessLevel = val;
                }
            }
        }
    }

    // Background process managers to apply changes
    Process {
        id: setVolProcess
    }

    Process {
        id: setBriProcess
    }

    Component.onCompleted: {
        updateVolume();
        updateBrightness();
    }

    // Quickshell IPC Handler to listen for external adjustments
    IpcHandler {
        target: "volume_brightness"

        function updateVolume() {
            root.updateVolume();
        }

        function updateBrightness() {
            root.updateBrightness();
        }

        function setVolume(val: int) {
            let v = parseInt(val, 10);
            if (!isNaN(v)) {
                root.volumeLevel = v;
                root.isMuted = false;
            }
        }

        function setBrightness(val: int) {
            let b = parseInt(val, 10);
            if (!isNaN(b)) {
                root.brightnessLevel = b;
            }
        }
    }

    // System Tray indicator on the bar (clicks open the dropdown)
    Text {
        id: trayLabel
        text: "" // Down chevron icon
        color: Config.textColor
        font.pixelSize: Config.fontSize
        font.family: Config.fontMain
        style: Text.Outline
        styleColor: Config.shadowColor
        anchors.centerIn: parent // Center visually inside the large click zone
    }

    // MouseArea covers the full root hitbox (full bar height)
    MouseArea {
        anchors.fill: parent
        onClicked: {
            root.updateVolume();
            root.updateBrightness();
            trayPopup.visible = !trayPopup.visible;
        }
    }

    // Consolidated Dropdown Popup
    PopupWindow {
        id: trayPopup
        visible: false
        
        anchor {
            window: root.barWindow
            rect.x: barWindow ? (barWindow.width - width - 10) : 0
            rect.y: barWindow ? (barWindow.height + 6) : 0
        }

        implicitWidth: 220
        implicitHeight: 164 // Slightly increased height to accommodate slider containers comfortably
        color: "transparent"

        // Elegant OLED-first card container with smooth animations
        Rectangle {
            id: container
            width: parent.width
            height: parent.height
            y: 0
            color: "#000000" // True black background
            border.color: "#ffffff" // Sleek high-contrast white outline border
            border.width: 1
            radius: 4
            opacity: 0.0

            // Smooth opening animation: fade in and slide down
            ParallelAnimation {
                id: openAnimation
                
                NumberAnimation {
                    target: container
                    property: "opacity"
                    to: 1.0
                    duration: 150
                    easing.type: Easing.OutQuad
                }
                
                NumberAnimation {
                    target: container
                    property: "y"
                    to: 0
                    duration: 150
                    easing.type: Easing.OutQuad
                }
            }

            onVisibleChanged: {
                if (visible) {
                    container.y = -8; // Start 8 pixels higher
                    container.opacity = 0.0;
                    openAnimation.start();
                }
            }

            Column {
                id: mainCol
                anchors.fill: parent
                anchors.margins: 12
                spacing: 12

                // --- Part 1: System Tray Row (Vesktop, etc.) ---
                Row {
                    id: trayRow
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 8
                    
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

                // --- Part 2: Separator ---
                Rectangle {
                    width: parent.width
                    height: 1
                    color: "#333333" // Subtle gray separator defining the sections
                }

                // --- Part 3: Volume Section ---
                Column {
                    width: parent.width
                    spacing: 2

                    Text {
                        text: root.isMuted ? "󰅖 Muted" : ` Volume: ${root.volumeLevel}%`
                        color: Config.textColor
                        font.pixelSize: Config.fontSize - 3
                        font.family: Config.fontMain
                    }

                    // Invisible interaction hitbox wrapper for Volume Slider
                    Item {
                        width: parent.width
                        height: 24 // 24px height buffer makes it incredibly easy to click/drag

                        Rectangle {
                            width: parent.width
                            height: 8
                            color: "#222222"
                            radius: 4
                            anchors.verticalCenter: parent.verticalCenter

                            Rectangle {
                                height: parent.height
                                width: parent.width * (root.volumeLevel / 100.0)
                                color: "#ffffff"
                                radius: 4
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            
                            function updateFromMouse(mouse) {
                                let pct = Math.round((mouse.x / width) * 100);
                                pct = Math.max(0, Math.min(100, pct));
                                root.volumeLevel = pct;
                                root.isMuted = false;
                                setVolProcess.command = ["/home/holubpat/.config/hypr/scripts/volume.sh", "--set", pct.toString()];
                                setVolProcess.startDetached();
                            }

                            onClicked: (mouse) => updateFromMouse(mouse)
                            onPositionChanged: (mouse) => updateFromMouse(mouse)
                        }
                    }
                }

                // --- Part 4: Brightness Section ---
                Column {
                    width: parent.width
                    spacing: 2

                    Text {
                        text: ` Brightness: ${root.brightnessLevel}%`
                        color: Config.textColor
                        font.pixelSize: Config.fontSize - 3
                        font.family: Config.fontMain
                    }

                    // Invisible interaction hitbox wrapper for Brightness Slider
                    Item {
                        width: parent.width
                        height: 24 // 24px height buffer makes it incredibly easy to click/drag

                        Rectangle {
                            width: parent.width
                            height: 8
                            color: "#222222"
                            radius: 4
                            anchors.verticalCenter: parent.verticalCenter

                            Rectangle {
                                height: parent.height
                                width: parent.width * (root.brightnessLevel / 100.0)
                                color: "#ffffff"
                                radius: 4
                            }
                        }

                        MouseArea {
                            anchors.fill: parent

                            function updateFromMouse(mouse) {
                                let pct = Math.round((mouse.x / width) * 100);
                                pct = Math.max(0, Math.min(100, pct));
                                root.brightnessLevel = pct;
                                setBriProcess.command = ["/home/holubpat/.config/hypr/scripts/brightness.sh", "--set", pct.toString()];
                                setBriProcess.startDetached();
                            }

                            onClicked: (mouse) => updateFromMouse(mouse)
                            onPositionChanged: (mouse) => updateFromMouse(mouse)
                        }
                    }
                }
            }
        }
    }
}
