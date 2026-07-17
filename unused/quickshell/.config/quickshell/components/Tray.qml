import QtQuick
import QtQuick.Shapes
import Qt5Compat.GraphicalEffects
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
            rect.x: barWindow ? Math.max(0, Math.min(root.mapToItem(barWindow.contentItem, 0, 0).x - width / 2 + root.width / 2, barWindow.width - width)) : 0
            rect.y: barWindow ? barWindow.height : 0
        }

        property int connectionRadius: 5
        property int cardRadius: 5
        property int cardWidth: 150
        property int cardHeight: mainCol.implicitHeight + 24
        property int fadeLength: 10

        implicitWidth: cardWidth + 2 * connectionRadius + 2 * fadeLength
        implicitHeight: cardHeight + connectionRadius
        color: "transparent"

        // Elegant OLED-first card container with smooth animations
        Item {
            id: container
            width: parent.width
            height: parent.height
            y: 0
            opacity: 0.0

            // Custom shape for the premium connected true black background
            Shape {
                id: bgShape
                anchors.fill: parent

                ShapePath {
                    strokeWidth: 0
                    strokeColor: "transparent"
                    fillColor: "#000000" // True black

                    startX: trayPopup.fadeLength
                    startY: 0

                    PathArc {
                        x: trayPopup.fadeLength + trayPopup.connectionRadius
                        y: trayPopup.connectionRadius
                        radiusX: trayPopup.connectionRadius
                        radiusY: trayPopup.connectionRadius
                        direction: PathArc.Clockwise
                    }

                    PathLine {
                        x: trayPopup.fadeLength + trayPopup.connectionRadius
                        y: bgShape.height - trayPopup.cardRadius
                    }

                    PathArc {
                        x: trayPopup.fadeLength + trayPopup.connectionRadius + trayPopup.cardRadius
                        y: bgShape.height
                        radiusX: trayPopup.cardRadius
                        radiusY: trayPopup.cardRadius
                        direction: PathArc.Counterclockwise
                    }

                    PathLine {
                        x: bgShape.width - trayPopup.fadeLength - trayPopup.connectionRadius - trayPopup.cardRadius
                        y: bgShape.height
                    }

                    PathArc {
                        x: bgShape.width - trayPopup.fadeLength - trayPopup.connectionRadius
                        y: bgShape.height - trayPopup.cardRadius
                        radiusX: trayPopup.cardRadius
                        radiusY: trayPopup.cardRadius
                        direction: PathArc.Counterclockwise
                    }

                    PathLine {
                        x: bgShape.width - trayPopup.fadeLength - trayPopup.connectionRadius
                        y: trayPopup.connectionRadius
                    }

                    PathArc {
                        x: bgShape.width - trayPopup.fadeLength
                        y: 0
                        radiusX: trayPopup.connectionRadius
                        radiusY: trayPopup.connectionRadius
                        direction: PathArc.Clockwise
                    }

                    PathLine {
                        x: trayPopup.fadeLength
                        y: 0
                    }
                }
            }

            // Custom shape for the outline border (solid violet)
            Shape {
                id: borderShape
                anchors.fill: parent

                ShapePath {
                    strokeWidth: 1
                    strokeColor: "#cba6f7" // Matches Hyprland active border color
                    fillColor: "transparent"

                    startX: trayPopup.fadeLength
                    startY: 0

                    PathArc {
                        x: trayPopup.fadeLength + trayPopup.connectionRadius
                        y: trayPopup.connectionRadius
                        radiusX: trayPopup.connectionRadius
                        radiusY: trayPopup.connectionRadius
                        direction: PathArc.Clockwise
                    }

                    PathLine {
                        x: trayPopup.fadeLength + trayPopup.connectionRadius
                        y: borderShape.height - trayPopup.cardRadius
                    }

                    PathArc {
                        x: trayPopup.fadeLength + trayPopup.connectionRadius + trayPopup.cardRadius
                        y: borderShape.height
                        radiusX: trayPopup.cardRadius
                        radiusY: trayPopup.cardRadius
                        direction: PathArc.Counterclockwise
                    }

                    PathLine {
                        x: borderShape.width - trayPopup.fadeLength - trayPopup.connectionRadius - trayPopup.cardRadius
                        y: borderShape.height
                    }

                    PathArc {
                        x: borderShape.width - trayPopup.fadeLength - trayPopup.connectionRadius
                        y: borderShape.height - trayPopup.cardRadius
                        radiusX: trayPopup.cardRadius
                        radiusY: trayPopup.cardRadius
                        direction: PathArc.Counterclockwise
                    }

                    PathLine {
                        x: borderShape.width - trayPopup.fadeLength - trayPopup.connectionRadius
                        y: trayPopup.connectionRadius
                    }

                    PathArc {
                        x: borderShape.width - trayPopup.fadeLength
                        y: 0
                        radiusX: trayPopup.connectionRadius
                        radiusY: trayPopup.connectionRadius
                        direction: PathArc.Clockwise
                    }
                }
            }

            // Left horizontal fading outline extension along the bar
            LinearGradient {
                x: 0
                y: 0
                width: trayPopup.fadeLength
                height: 1
                start: Qt.point(0, 0)
                end: Qt.point(width, 0)
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "transparent" }
                    GradientStop { position: 1.0; color: "#cba6f7" }
                }
            }

            // Right horizontal fading outline extension along the bar
            LinearGradient {
                x: borderShape.width - trayPopup.fadeLength
                y: 0
                width: trayPopup.fadeLength
                height: 1
                start: Qt.point(0, 0)
                end: Qt.point(width, 0)
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#cba6f7" }
                    GradientStop { position: 1.0; color: "transparent" }
                }
            }

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

            Item {
                id: contentArea
                x: trayPopup.fadeLength + trayPopup.connectionRadius
                y: trayPopup.connectionRadius
                width: trayPopup.cardWidth
                height: trayPopup.cardHeight

                Column {
                    id: mainCol
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.margins: 12
                    spacing: 12

                // --- Part 1: System Tray Row (Vesktop, etc.) ---
                Row {
                    id: trayRow
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 8
                    visible: trayRepeater.count > 0
                    
                    Repeater {
                        id: trayRepeater
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
                    visible: trayRepeater.count > 0
                }

                // --- Part 3: Volume Section ---
                Column {
                    width: parent.width
                    spacing: 2

                    Text {
                        text: root.isMuted ? "󰅖 Muted" : ` Vol: ${root.volumeLevel}%`
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
                        text: ` Bri: ${root.brightnessLevel}%`
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
}
