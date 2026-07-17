import QtQuick
import Quickshell
import Quickshell.Hyprland
import ".."

Row {
    id: root
    spacing: 10

    Repeater {
        model: Hyprland.workspaces.values // Accessing the list of workspaces
        
        delegate: Text {
            required property var modelData
            
            // Check if this workspace is focused
            readonly property bool isFocused: Hyprland.focusedWorkspace && modelData.id === Hyprland.focusedWorkspace.id
            
            // Filter negative workspaces
            visible: modelData.id >= 0
            
            text: {
                const id = modelData.id;
                if (id === 1) return "一";
                if (id === 2) return "二";
                if (id === 3) return "三";
                if (id === 4) return "四";
                if (id === 5) return "五";
                if (id === 6) return "六";
                if (id === 7) return "七";
                if (id === 8) return "八";
                if (id === 9) return "九";
                if (id === 10) return "十";
                return id.toString();
            }
            
            color: isFocused ? Config.textColor : Config.textInactiveColor
            font.pixelSize: Config.fontSize
            font.weight: isFocused ? Font.ExtraBold : Font.Normal
            font.family: Config.fontMain
            
            style: Text.Outline
            styleColor: Config.shadowColor
        }
    }
}
