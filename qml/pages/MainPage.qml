import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import "../assets/Database.js" as JS

Page {
    objectName: "mainPage"
    allowedOrientations: Orientation.All

    SilicaListView {
        anchors.fill: parent
        header: PageHeader {
            objectName: "pageHeader"
            title: qsTr("Заметки")
        }
        model: ListModel { id: listModel }
        delegate: ListItem {

            Label {
                id: labelDate
                text: date_note
                color: palette.highlightColor
                x: Theme.horizontalPageMargin
                anchors {
                    verticalCenter: parent.verticalCenter
                }
            }
            Label {
                id: labelName
                text: name_note
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: labelDate.right
                    leftMargin: 15
                }
            }
            menu: ContextMenu {
                MenuItem {
                    text: qsTr("Изменить")
                    onClicked: {
                        var dialog = pageStack.push(Qt.resolvedUrl("NoteDialog.qml"),
                                                    {"note_date": date_note,
                                                     "note_name": name_note,
                                                     "note_desc": desc_note,
                                                     "date_enabled": false});
                        dialog.accepted.connect(function() {
                            console.log("Изменить")
                            JS.dbUpdate(dialog.note_date, dialog.note_name, dialog.note_desc)
                        })
                    }
                }
                MenuItem {
                    text: qsTr("Удалить")
                    onClicked: JS.dbRemove(date_note)
                }
            }
            onClicked: {
                pageStack.push(Qt.resolvedUrl("NotePage.qml"),
                               {"date": date_note,
                                "name": name_note,
                                "desc": desc_note});
            }
        }
        PullDownMenu {
            MenuItem {
                text: "Добавить заметку"
                onClicked: {
                    var dialog = pageStack.push("NoteDialog.qml")
                    dialog.accepted.connect(function() {
                        var rowid = parseInt(JS.dbInsert(dialog.note_date, dialog.note_name, dialog.note_desc), 10)
                        if (!rowid) {
                            console.log("Error Insert")
                        }
                    })
                }
            }
        }
    }
    Component.onCompleted: {
        JS.dbInit()
        JS.dbReadAll()
    }
}
