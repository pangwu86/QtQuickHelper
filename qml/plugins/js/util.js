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
        var tnm = (z.isBlank(nm) ? _log_nm_ : nm)
        var tnm2 = z.stringFill(tnm, 12, " ", false)
        console.debug(z.now() + " " + tnm2 + " : " + text)
    },
    now: function (ms) {
        // 返回yyyy-MM-dd_hh:mm:ss:sss格式化日期时间字符串
        return z.nowDate() + "_" + z.nowTime(ms)
    },
    nowTime: function (ms) {
        var cdate = new Date()
        return z.numberFillZero(cdate.getHours(), 2) + ":" + z.numberFillZero(
                    cdate.getMinutes(), 2) + ":" + z.numberFillZero(
                    cdate.getSeconds(),
                    2) + (ms ? ":" + cdate.getMilliseconds() : "")
    },
    nowDate: function () {
        var cdate = new Date()
        return cdate.getFullYear() + "-" + z.numberFillZero(
                    cdate.getMonth() + 1,
                    2) + "-" + z.numberFillZero(cdate.getDate(), 2)
    },
    nowDateCN: function () {
        var cdate = new Date()
        return cdate.getFullYear() + "年" + z.numberFillZero(
                    cdate.getMonth() + 1, 2) + "月" + z.numberFillZero(
                    cdate.getDate(), 2) + "日 周" + _weekday_[cdate.getDay()]
    },
    numberFillZero: function (num, length) {
        return z.stringFill(num + "", length, "0", false)
    },
    stringFill: function (curstr, tarlength, fillstr, append) {
        if (curstr.length < tarlength) {
            for (var i = curstr.length; i < tarlength; i++) {
                if (append) {
                    curstr = curstr + fillstr
                } else {
                    curstr = fillstr + curstr
                }
            }
        }
        return curstr
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
