//storage.js

function getDatabase() {
     return openDatabaseSync("Wordsler", "1.0", "StorageDatabase", 10000);
}

function getSetting(setting) {
   var db = getDatabase();
   var res="";
   db.transaction(function(tx) {
     var rs = tx.executeSql('SELECT value FROM settings WHERE setting=?;', [setting]);
     if (rs.rows.length > 0) {
          res = rs.rows.item(0).value;
     } else {
         res = "Unknown";
     }
  })
  return res
}

function dump() {
    var db = getDatabase();
    db.transaction(function(tx) {
       var rs = tx.executeSql('SELECT * FROM settings');
       for(var i = 0; i < rs.rows.length; i++) {
                console.log(rs.rows.item(i).setting+ ", " + rs.rows.item(i).value + "\n");
       }
       var rs = tx.executeSql('SELECT * FROM scores');
       for(var i = 0; i < rs.rows.length; i++) {
                console.log(rs.rows.item(i).url+ ", " + rs.rows.item(i).unread + "\n");
       }
    });
}

function setSetting(setting, value) {
   var db = getDatabase();
   var res = "";
   db.transaction(function(tx) {
        var rs = tx.executeSql('INSERT OR REPLACE INTO settings VALUES (?,?);', [setting,value]);
              //console.log(rs.rowsAffected)
              if (rs.rowsAffected > 0) {
                res = "OK";
              } else {
                res = "Error";
              }
        }
  );
  return res;
}

function resetAll() {
    var db = getDatabase();
    db.transaction(
        function(tx) {
                    tx.executeSql('DROP TABLE scores;');
                    tx.executeSql('DROP TABLE settings;');
                    initialize();
                });
}

function getScores() {
    var db = getDatabase();
    var listmodel = Qt.createQmlObject('import Qt 4.7; ListModel {}', intro);
    db.transaction(function(tx) {
    var rs = tx.executeSql('SELECT date, score FROM scores ORDER BY score DESC LIMIT 20;');
    if (rs.rows.length > 0) {
        for(var i = 0; i < rs.rows.length; i++) {
          listmodel.append({date: rs.rows.item(i).date, score: rs.rows.item(i).score});
        }
    }
    })
    return listmodel
}

function setScore(score) {
    var db = getDatabase();
    var res = "";
    db.transaction(function(tx) {
          var rs = tx.executeSql('INSERT OR REPLACE INTO scores VALUES (strftime("%Y-%m-%d %H:%M","now"),?);', [score]);
          if (rs.rowsAffected > 0) {
             res = "OK";
          } else {
             res = "Error";
          }
          }
   );
   return res;
}

function initialize() {
    var db = getDatabase();

    db.transaction(
        function(tx) {
            // Create the database if it doesn't already exist
            tx.executeSql('CREATE TABLE IF NOT EXISTS settings(setting TEXT UNIQUE, value TEXT)');
            tx.executeSql('CREATE TABLE IF NOT EXISTS scores(date TEXT, score INTEGER)');
        }
    );
}