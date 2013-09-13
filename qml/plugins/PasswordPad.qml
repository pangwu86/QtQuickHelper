import QtQuick 1.1
import "js/util.js" as Util
import "js/passwordpad.js" as PwPad

Rectangle {
    id: idc_pwpad
    property string log_nm: "pwpad"
    property string pwpad_pic: "img/passwordpad/"
    property bool pwpad_btn_ava: true // 按钮是否可用
    property bool pwpad_input_do: false // 是不是输入过了
    property string pwpad_input_tip_init: "请输入密码"
    property string pwpad_input_tip_err: "密码错误!"
    property string pwpad_input_tip_ok: "密码正确!"
    property string pwpad_input_val: "12345" // 真正的密码
    property string pwpad_input_color: "#7c7c7c"
    property string pwpad_input_color_error: "#AA0000"

    function init_state() {
        pwpad_btn_ava = true
        pwpad_input_do = false
        idc_pwpad_input_text.text = pwpad_input_tip_init
        idc_pwpad_input_text.color = pwpad_input_color
    }
    function err_state() {
        idc_pwpad_input_text.text = pwpad_input_tip_err
        after_input_state()
        Util.z.log(log_nm, "func_cancel is called")
        func_cancel()
    }
    function ok_state() {
        idc_pwpad_input_text.text = pwpad_input_tip_ok
        after_input_state()
        Util.z.log(log_nm, "func_ok is called")
        func_ok()
    }
    function after_input_state() {
        idc_pwpad_input_text.color = pwpad_input_color_error
        pwpad_btn_ava = false
        idt_pwpad_after_input.start()
    }

    // 提供两个模式的实现
    function func_ok() {
        Util.z.log(log_nm, "default func_ok")
    }
    function func_cancel() {
        Util.z.log(log_nm, "default func_cancel")
    }

    Timer {
        id: idt_pwpad_after_input
        interval: 2000
        repeat: false
        onTriggered: {
            init_state()
        }
    }

    width: 240
    height: 370
    radius: 15
    color: "#c4c3c3"
    visible: true
    onVisibleChanged: {
        Util.z.log(log_nm, "visible is change, value is " + visible)
        if (visible) {
            init_state()
        }
    }

    // 输入框部分
    Item {
        id: idc_pwpad_input
        x: 24
        y: 10
        width: 192
        height: 50
        Text {
            id: idc_pwpad_input_text
            x: 10
            width: parent.width - 20
            height: parent.height
            style: Text.Normal
            font.pointSize: 24
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.NoWrap
            clip: true
        }
        Rectangle {
            width: parent.width
            height: parent.height
            opacity: 0.3
            radius: 10
        }
    }

    // 按钮部分
    Item {
        id: idc_pwpad_btns
        width: 212
        height: 286
        anchors.top: idc_pwpad_input.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: idc_pwpad_input.horizontalCenter

        Grid {
            flow: Flow.LeftToRight
            columns: 3
            spacing: 10
            // columnSpacing: 10
            Repeater {
                model: PwPad.btn_pic_list
                Image {
                    width: 64
                    height: 64
                    source: pwpad_pic + PwPad.btn_pic_list[index].init_pic
                    MouseArea {
                        anchors.fill: parent
                        onPressed: {
                            parent.source = pwpad_pic + PwPad.btn_pic_list[index].press_pic
                        }
                        onReleased: {
                            if (pwpad_btn_ava) {
                                Util.z.log(log_nm,
                                           "press : " + PwPad.btn_pic_list[index].press_num)
                                PwPad.btn_pic_list[index].press_func()
                            }
                            parent.source = pwpad_pic + PwPad.btn_pic_list[index].init_pic
                        }
                    }
                }
            }
        }
    }


    Component.onCompleted: {
        init_state()
        Util.z.log(log_nm, "i'm ready")
    }
}
