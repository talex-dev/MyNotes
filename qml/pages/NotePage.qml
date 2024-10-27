import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    objectName: "notePage"
    allowedOrientations: Orientation.All

    property string date
    property string name
    property string desc

    PageHeader {
        objectName: "pageHeader"
        title: name
        id: pageHeader
    }

    Column {
        id: form
        width: parent.width
        anchors.top: pageHeader.bottom
        Label {
            id: labelDate
            text: date
            font.pixelSize: Theme.fontSizeLarge
            anchors {
                verticalCenter: parent.verticalCenter
                topMargin: Theme.paddingLarge
            }
            color: palette.highlightColor
            x: Theme.paddingLarge
        }
        Label {
            id: descText
            anchors {
                margins: Theme.horizontalPageMargin
                verticalCenter: parent.verticalCenter
                top: labelDate.bottom
            }
            x: Theme.paddingLarge
            font.pixelSize: Theme.fontSizeSmall
            wrapMode: Text.WordWrap
            text: desc
        }
    }
}
