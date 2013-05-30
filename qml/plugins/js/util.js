var _log_nm_ = "qml"

var z = {
    log: function (nm, text) {
        console.log((z.isBlank(nm) ? _log_nm_ : nm) + " : " + text)
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
