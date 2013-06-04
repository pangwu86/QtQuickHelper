var _log_nm_ = "qml"

var z = {
    log: function (nm, text) {
        console.debug(z.now() + " " + (z.isBlank(
                                           nm) ? _log_nm_ : nm) + " : " + text)
    },
    now: function (needMs) {
        // 返回yyyy-MM-dd_hh:mm:ss:sss格式化日期时间字符串
        var n = new Date()
        var fnow = n.getFullYear() + "-" + z.numberFormat(
                    n.getMonth() + 1, 2) + "-" + z.numberFormat(n.getDate(), 2)
        var snow = z.numberFormat(n.getHours(), 2) + ":" + z.numberFormat(
                    n.getMinutes(), 2) + ":" + z.numberFormat(n.getSeconds(), 2)
        return fnow + "_" + snow + (needMs ? ":" + n.getMilliseconds() : "")
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
