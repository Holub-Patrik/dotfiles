import QtQuick
import ".."

Text {
    id: clock
    color: Config.textColor
    font.pixelSize: Config.fontSize
    font.family: Config.fontMain
    style: Text.Outline
    styleColor: Config.shadowColor
    
    // Timer to update time
    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: clock.updateTime()
    }
    
    function updateTime() {
        text = Qt.formatDateTime(new Date(), "hh:mm")
    }
    
    Component.onCompleted: updateTime()
}
