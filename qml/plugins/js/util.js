var _log_nm_ = "qml"

var _weekday_ = []
_weekday_[0] = "日"
_weekday_[1] = "一"
_weekday_[2] = "二"
_weekday_[3] = "三"
_weekday_[4] = "四"
_weekday_[5] = "五"
_weekday_[6] = "六"

var z = {
    log: function (nm, text) {
        console.debug(z.now() + " " + (z.isBlank(
                                           nm) ? _log_nm_ : nm) + " : " + text)
    },
    now: function (ms) {
        // 返回yyyy-MM-dd_hh:mm:ss:sss格式化日期时间字符串
        return z.nowDate() + "_" + z.nowTime(ms)
    },
    nowTime: function (ms) {
        var cdate = new Date()
        return z.numberFormat(cdate.getHours(), 2) + ":" + z.numberFormat(
                    cdate.getMinutes(), 2) + ":" + z.numberFormat(
                    cdate.getSeconds(),
                    2) + (ms ? ":" + cdate.getMilliseconds() : "")
    },
    nowDate: function () {
        var cdate = new Date()
        return cdate.getFullYear() + "-" + z.numberFormat(
                    cdate.getMonth() + 1,
                    2) + "-" + z.numberFormat(cdate.getDate(), 2)
    },
    nowDateCN: function () {
        var cdate = new Date()
        return cdate.getFullYear() + "年" + z.numberFormat(
                    cdate.getMonth() + 1, 2) + "月" + z.numberFormat(
                    cdate.getDate(), 2) + "日 周" + _weekday_[cdate.getDay()]
    },
    numberFormat: function (num, length) {
        var nstr = num + ""
        if (nstr.length < length) {
            for (var i = nstr.length; i < length; i++) {
                nstr = "0" + nstr
            }
        }
        return nstr
    },
    isBlank: function (str) {
        if (str == undefined || str == null) {
            return true
        }
        if (str.length == 0) {
            return true
        }
        if (/^\s*$/.test(str)) {
            return true
        }
        return false
    }
}
