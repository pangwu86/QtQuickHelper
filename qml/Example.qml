import QtQuick 1.1
import "plugins"

Rectangle {
    id: idc_main
    width: 800
    height: 600
    color: "#000"
    UpMessage {
        width: 600
        height: 150
        anchors.horizontalCenter: parent.horizontalCenter
        y: (idc_main.height / 2 ) - 100
        um_text_visible: true
        um_texts: [{
                text: "Welcome to QtQuickHepler",
                size: 35,
                bold: true
            }, {
                text: "author: pangwu86@gmail.com",
                size: 18
            }, {
                text: "http://github.com/pangwu86/QtQuickHepler",
                size: 18
            }]
    }
}
