import QtQuick 1.1
import "js/util.js" as Util

Item {
    id: id_slider
    property string log_nm: "slider"
    property int current_index: 0
    property int slider_start: 0
    property int slider_count: 0
    property int slider_show_count: 1
    property string slider_type: "jpg"
    property string slider_pic_path: ""
    property int slider_width: 640
    property int slider_height: 480
    property bool slider_auto_change: false
    property int slider_auto_interval: 2000
    property bool slider_horizontal: true
    width: slider_horizontal ? (slider_width * slider_show_count) : slider_width
    height: !slider_horizontal ? (slider_height * slider_show_count) : slider_height
    clip: true
    ListView {
        id: id_slider_list
        anchors.fill: parent
        model: slider_count
        contentX: 0
        contentY: 0
        orientation: slider_horizontal ? ListView.Horizontal : ListView.Vertical
        snapMode: ListView.SnapOneItem
        boundsBehavior: Flickable.DragOverBounds
        flickDeceleration: 1000
        delegate: Component {
            id: id_slider_img
            Image {
                width: slider_width
                height: slider_height
                source: slider_pic_path + "" + (slider_start + index) + "." + slider_type
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        id_slider.func_click_pic(index)
                    }
                }
            }
        }
        Behavior on contentX {
            NumberAnimation {
                easing.type: Easing.OutCirc
                duration: 300
            }
        }
        Behavior on contentY {
            NumberAnimation {
                easing.type: Easing.OutCirc
                duration: 300
            }
        }
        // 初始化
        function list_init_state() {
            Util.z.log(log_nm, "list reset")
            contentX = 0
            contentY = 0
            current_index = 0
        }
        // 改变位置
        function change_position() {
            if (slider_horizontal) {
                contentX = current_index * slider_width
            } else {
                contentY = current_index * slider_height
            }
        }
        // 移动
        function list_next_pic() {
            if (check_next()) {
                current_index++
                Util.z.log(log_nm, "move to next, index is " + current_index)
                change_position()
            } else {
                Util.z.log(log_nm, "the end, can't move")
            }
        }
        function list_prev_pic() {
            if (check_prev()) {
                current_index--
                Util.z.log(log_nm, "move to prev, index is " + current_index)
                change_position()
            } else {
                Util.z.log(log_nm, "the start, can't move")
            }
        }
    }
    function func_click_pic(index) {
        Util.z.log(log_nm, "pic[" + index + "] has been clicked")
    }
    // 是否可以移动
    function check_next() {
        return (current_index + slider_show_count) < slider_count
    }
    function check_prev() {
        return (current_index - 1) >= 0
    }
    // 移动
    function init_state() {
        id_slider_list.list_init_state()
        if (slider_auto_change) {
            id_slider_auto_changer.restart()
        }
    }
    function next_pic() {
        id_slider_list.list_next_pic()
        if (slider_auto_change) {
            id_slider_auto_changer.restart()
        }
    }
    function prev_pic() {
        id_slider_list.list_prev_pic()
        if (slider_auto_change) {
            id_slider_auto_changer.restart()
        }
    }
    Timer {
        id: id_slider_auto_changer
        repeat: true
        interval: slider_auto_interval
        onTriggered: {
            if (check_next()) {
                next_pic()
            } else {
                init_state()
            }
            Util.z.log(log_nm,
                       "change pic in " + slider_auto_interval + "ms later")
        }
    }

    Component.onCompleted: {
        Util.z.log(log_nm,
                   "i'm ready, path is " + slider_pic_path + ", there are "
                   + slider_count + " pics[" + slider_type + "]")
        // 开启启动模式
        if (slider_auto_change) {
            id_slider_auto_changer.start()
        }
        init_state()
    }
}
