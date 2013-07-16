import QtQuick 1.1

Item {
    id: id_text_updater
    width: id_text_updater_txt.width
    height: text_height
    property int text_width: 100
    property int text_height: 40
    property string text_color: "#FFF"
    property int text_size: text_height / 2
    property bool text_bold: false
    property int update_interval: 1 * 1000
    clip: true
    Text {
        wrapMode: Text.Wrap
        id: id_text_updater_txt
        height: parent.height
        anchors.centerIn: parent
        color: text_color
        font.pixelSize: text_size
        font.bold: text_bold
        text: "loading..."
        smooth: true
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }
    Timer {
        interval: update_interval
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            id_text_updater_txt.text = func_update_txt()
        }
    }
    function func_update_txt() {
        return "......"
    }
}
