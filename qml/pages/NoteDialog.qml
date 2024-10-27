import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    property string note_date
    property string note_name
    property string note_desc
    property bool date_enabled: true

    DialogHeader {
        id: dialogHeader
        acceptText: "Сохранить"
        cancelText: "Отменить"
    }

    SilicaFlickable {
        anchors {
            top: dialogHeader.bottom
            bottom: parent.bottom
            left: parent.left
            right: parent.right
            topMargin: Theme.paddingLarge
        }
        Column {
            id: form
            width: parent.width
            anchors.top: parent.top

            TextField {
                id: dateInput
                validator: RegExpValidator {
                    regExp: /[0-9/,:.]+/
                }
                placeholderText: "Date"
                label: "Date"
                text: note_date
                enabled: date_enabled
            }
            TextField {
                id: nameInput
                placeholderText: "Name node"
                label: "Name node"
                text: note_name
            }
            TextArea {
                id: descInput
                width: parent.width
                placeholderText: qsTr("Description")
                label: qsTr("Description")
                text: note_desc
            }
        }
    }
    onAccepted: if (result == DialogResult.Accepted) {
            note_date = dateInput.text
            note_name = nameInput.text
            note_desc = descInput.text
    }
    onDone: if (result != DialogResult.Accepted) {
                note_date = ""
                note_name = ""
                note_desc = ""
                date_enabled = true
    }
}
