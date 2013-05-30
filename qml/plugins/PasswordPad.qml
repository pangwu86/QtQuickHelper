import QtQuick 1.1
import "js/util.js" as Util
import "js/passwordpad/init.js" as PwPadInit

Rectangle {
    id: id_pwpad
    property string log_nm: "pwpad"
    property string pic_path: "img/"
    property string pic_btns: pic_path + "passwordpad/btns/"
    property bool pwpad_btn_ava: true // 按钮是否可用
    property bool pwpad_input_do: false // 是不是输入过了
    property string pwpad_input_tip_init: "请输入密码"
    property string pwpad_input_tip_err: "密码错误!"
    property string pwpad_input_tip_ok: "密码正确!"
    property string pwpad_input_val: "94518" // 真正的密码
    property string pwpad_input_color: "#7c7c7c"
    property string pwpad_input_color_red: "#AA0000"
    function init_state() {
        pwpad_btn_ava = true
        pwpad_input_do = false
        id_pwpad_input_text.text = pwpad_input_tip_init
        id_pwpad_input_text.color = pwpad_input_color
    }
    function err_state() {
        id_pwpad_input_text.text = pwpad_input_tip_err
        after_input_state()
        if (func_cancel != null) {
            Util.z.log(log_nm, "pwpad_func_cancel is run")
            func_cancel()
        } else {
            Util.z.log(log_nm, "pwpad_func_cancel is empty")
        }
    }
    function ok_state() {
        id_pwpad_input_text.text = pwpad_input_tip_ok
        after_input_state()
        if (func_ok != null) {
            Util.z.log(log_nm, "pwpad_func_ok is run")
            func_ok()
        } else {
            Util.z.log(log_nm, "pwpad_func_ok is empty")
        }
    }
    function after_input_state() {
        id_pwpad_input_text.color = pwpad_input_color_red
        pwpad_btn_ava = false
        timer_pwpad_after_input.start()
    }
    Timer {
        id: timer_pwpad_after_input
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
    Component.onCompleted: {
        init_state()
        Util.z.log(log_nm, "i'm ready")
    }

    // 输入框部分
    Item {
        id: id_pwpad_input
        x: 24
        y: 10
        width: 192
        height: 50
        Text {
            id: id_pwpad_input_text
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
        id: id_pwpad_btns
        width: 212
        height: 286
        anchors.top: id_pwpad_input.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: id_pwpad_input.horizontalCenter

        Grid {
            flow: Flow.LeftToRight
            columns: 3
            spacing: 10
            // columnSpacing: 10
            Repeater {
                model: PwPadInit.btn_pic_list
                Image {
                    width: 64
                    height: 64
                    source: pic_btns + PwPadInit.btn_pic_list[index].init_pic
                    MouseArea {
                        anchors.fill: parent
                        onPressed: {
                            parent.source = pic_btns + PwPadInit.btn_pic_list[index].press_pic
                        }
                        onReleased: {
                            if (pwpad_btn_ava) {
                                Util.z.log(log_nm,
                                           "press : " + PwPadInit.btn_pic_list[index].press_num)
                                PwPadInit.btn_pic_list[index].press_func()
                            }
                            parent.source = pic_btns + PwPadInit.btn_pic_list[index].init_pic
                        }
                    }
                }
            }
        }
    }
}
