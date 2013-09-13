import QtQuick 1.1
import QtQuick 1.1
import "js/util.js" as Util

Item {
    id: idc
    property int cwidth: idc.width
    property int cheight: idc.height
    // 文字信息
    property variant um_texts: []
    // 移动到文字的位置, 默认是到底
    property int um_hold_pos: 99999
    // 自动刷新 or 手动
    property bool um_auto_refresh: true
    // 自动刷新时间(秒)
    property int um_auto_refresh_time: 2
    // 文字间隔
    property int um_text_spacing: 5
    // 全显示(显示过的就不隐藏了) or 仅仅当前显示
    property bool um_text_visible: false

    property real _um_text_heiht: cheight / 3
    property real _um_text_start_y: _um_text_heiht * 2
    Column {
        id: idc_texts
        y: _um_text_start_y
        spacing: um_text_spacing
        Repeater {
            id: idc_texts_rp
            model: um_texts
            delegate: Rectangle {
                width: cwidth
                height: _um_text_heiht
                clip: true
                color: Util.z.cbgcolor(modelData.bgColor)
                opacity: 0.001
                Text {
                    anchors.centerIn: parent
                    text: Util.z.ctext(modelData.text)
                    color: Util.z.ccolor(modelData.color)
                    font.pixelSize: Util.z.csize(modelData.size)
                    font.bold: Util.z.cbold(modelData.bold)
                }
                function show() {
                    opacity = 1.0
                }
                function hide() {
                    opacity = 0.001
                }
                Behavior on opacity {
                    PropertyAnimation {
                        duration: 400
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        }
        Behavior on y {
            PropertyAnimation {
                duration: 250
                easing.type: Easing.InOutBack
            }
        }
    }

    Timer {
        id: idt_um_refresh
        interval: um_auto_refresh_time * 1000
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            idt_um_refresh.repeat = _next_text()
        }
    }

    property int _text_index: 0
    function _next_text() {
        if (_text_index < um_texts.length) {
            // 上一个隐藏
            if (!um_text_visible) {
                if ((_text_index - 1) >= 0) {
                    idc_texts_rp.itemAt(_text_index - 1).hide()
                }
            }
            // 当前的显示
            idc_texts_rp.itemAt(_text_index).show()
            // 修改位置
            if (_text_index <= um_hold_pos) {
                idc_texts.y = idc_texts.y - (_um_text_heiht + um_text_spacing)
            }
            _text_index++
            return true
        }
        return false
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if (!um_auto_refresh) {
                _next_text()
            }
        }
    }

    Component.onCompleted: {
        if (um_auto_refresh) {
            idt_um_refresh.start()
        }
    }
}
