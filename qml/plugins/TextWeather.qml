import QtQuick 1.1
import "js/util.js" as Util

Item {
    id: id_text_weather
    width: text_width
    height: text_height
    clip: true
    property string log_nm: "weather"
    property int text_width: 200
    property int text_height: 46
    property string text_color: "#FFF"
    property string text_size: text_height / 2
    property int update_interval: 1800 * 1000
    property string weather_url: "http://m.weather.com.cn/data/"
    property string weather_city_code: "101010100"
    property string pic_path: "img/"
    property string pic_weather_path: pic_path + "textweather/"
    Image {
        id: id_text_weather_pic
        smooth: true
        source: pic_weather_path + "0.png"
        width: text_height
        height: text_height
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
    }
    Text {
        id: id_text_weather_txt
        anchors.right: parent.right
        width: parent.width
        height: parent.height
        color: text_color
        font.pixelSize: text_size
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
            update_weather()
        }
    }
    function update_weather() {
        var jsonurl = weather_url + weather_city_code + ".html"
        var xmlhttp = new XMLHttpRequest()
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                var tstr = xmlhttp.responseText
                var re = eval("(" + tstr + ")")
                var winfo = re.weatherinfo
                //显示信息
                id_text_weather_pic.source = pic_weather_path + winfo.img1 + ".png"
                id_text_weather_txt.text = winfo.city + " " + winfo.weather1
                        + " " + winfo.temp1 + " " + winfo.wind1
            }
        }
        xmlhttp.open("GET", jsonurl)
        xmlhttp.send()
        Util.z.log(log_nm, "get weather data : " + jsonurl)
    }
}
