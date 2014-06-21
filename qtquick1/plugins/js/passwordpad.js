
// 被按下时候触发的事件
var numberPressed = function () {
    // 已经有了文字
    if (idc_pwpad.pwpad_input_do) {
        idc_pwpad_input_text.text = idc_pwpad_input_text.text + this.press_num
    } else {
        idc_pwpad_input_text.text = this.press_num
        idc_pwpad.pwpad_input_do = true
    }
}

// 被按下时候触发的事件
var okPressed = function () {
    Util.z.log(log_nm, "check input")
    var passcheck = (idc_pwpad_input_text.text == idc_pwpad.pwpad_input_val)
    Util.z.log(log_nm,
               "input is " + idc_pwpad_input_text.text + " ,password is " + idc_pwpad.pwpad_input_val
               + " ,check result is [" + (passcheck ? "success" : "fail") + "]")
    if (passcheck) {
        idc_pwpad.ok_state()
    } else {
        idc_pwpad.err_state()
    }
}

// 被按下时候触发的事件
var cancelPressed = function () {
    Util.z.log(log_nm, "clear input")
    idc_pwpad.init_state()
}

// 数字列表
var _btn_list_ = ["7", "8", "9", "4", "5", "6", "1", "2", "3", "0", "s", "c"]
var _num_list_ = [7, 8, 9, 4, 5, 6, 1, 2, 3, 0, -1, -2]

// func列表
var _func_list_ = []
// 图片列表
var btn_pic_list = []

var init = function () {
    for (var i = 0; i < 10; i++) {
        _func_list_.push(numberPressed)
    }
    _func_list_.push(okPressed)
    _func_list_.push(cancelPressed)

    for (var j = 0; j < 12; j++) {
        btn_pic_list.push({
                              init_pic: _btn_list_[j] + ".png",
                              press_pic: _btn_list_[j] + "p.png",
                              press_func: _func_list_[j],
                              press_num: _num_list_[j]
                          })
    }
}

init()
