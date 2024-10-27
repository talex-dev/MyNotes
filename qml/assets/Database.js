function dbInit()
{
    var db = LocalStorage.openDatabaseSync("Notes_DB", "", "My Notes", 1000000)
    try {
        db.transaction(function (tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS note_table (date_note text, name_note text, desc_note text)')
        })
    } catch (err) {
        console.log("Error creating table in database: " + err)
    };
}

function dbGetHandle()
{
    try {
        var db = LocalStorage.openDatabaseSync("Notes_DB", "",
                                               "My Notes", 1000000)
    } catch (err) {
        console.log("Error opening database: " + err)
    }
    return db
}

function dbInsert(Pdate, Pname, Pdesc)
{
    var db = dbGetHandle()
    var rowid = 0;
    db.transaction(function (tx) {
        tx.executeSql('INSERT INTO note_table VALUES(?, ?, ?)',
                      [Pdate, Pname, Pdesc])
        var result = tx.executeSql('SELECT last_insert_rowid()')
        rowid = result.insertId
    })
    dbReadAll()
    return rowid;
}

function dbReadAll()
{
    var db = dbGetHandle()
    listModel.clear()
    db.transaction(function (tx) {
        var results = tx.executeSql(
                    'SELECT rowid,date_note,name_note,desc_note FROM note_table order by rowid desc')
        for (var i = 0; i < results.rows.length; i++) {
            listModel.append({
                                 date_note: results.rows.item(i).date_note,
                                 name_note: results.rows.item(i).name_note,
                                 desc_note: results.rows.item(i).desc_note
                             })
        }
    })
}
function dbUpdate(Pdate, Pname, Pdesc)
{
    var db = dbGetHandle()
    var rowid = 0;
    db.transaction(function (tx) {
        tx.executeSql('UPDATE note_table SET date_note = ?, name_note = ?, desc_note = ? WHERE date_note = ?',
                      [Pdate, Pname, Pdesc, Pdate])
    })
    dbReadAll()
}
function dbRemove(Pdate)
{
    var db = dbGetHandle()
    var rowid = 0;
    db.transaction(function (tx) {
        tx.executeSql('DELETE FROM note_table WHERE date_note = ?',
                      [Pdate])
    })
    dbReadAll()
}
