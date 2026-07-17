import QtQuick
import Quickshell
import Quickshell.Services.UPower
import ".."

Text {
    id: battery
    
    color: Config.textColor
    font.pixelSize: Config.fontSize
    font.family: Config.fontMain
    style: Text.Outline
    styleColor: Config.shadowColor

    readonly property var device: UPower.displayDevice
    readonly property int percentage: device ? Math.round(device.percentage * 100) : 0
    readonly property int state: device ? device.state : UPowerDeviceState.Unknown

    function getStateChar(s) {
        switch (s) {
            case UPowerDeviceState.Charging:
            case UPowerDeviceState.PendingCharge:
                return "+";
            case UPowerDeviceState.Discharging:
            case UPowerDeviceState.PendingDischarge:
                return "-";
            case UPowerDeviceState.FullyCharged:
                return "F";
            case UPowerDeviceState.Empty:
                return "!";
            default:
                return "";
        }
    }

    text: {
        if (!device) return "N/A";
        return `${percentage}%${getStateChar(state)}`;
    }
}
