import QtQuick 1.1
import "plugins"

Rectangle {
    width: 800
    height: 600
    color: "#000"
//    Text {
//        anchors.centerIn: parent
//        text: "Welcome to QtQuickHepler"
//        font.pixelSize: 30
//        color: "#FFF"
//    }
//    MouseArea {
//        anchors.fill: parent
//        onClicked: {
//        }
//    }

    UpMessage {
        width: 600
        height: 300
        anchors.centerIn: parent
        um_texts : [{
                text : "Welcome to QtQuickHepler",
                bgColor : "#888",
                color : "#FFF",
                size : 30,
                bold : true
            }, {
                text : "pangwu86@163.com",
                bgColor : "#888",
                color : "#FFF",
            }, {
                text : "see http://nutzam",
                bgColor : "#888"
            }]
    }
}
