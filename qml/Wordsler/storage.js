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
       var rs = tx.executeSql('SELECT * FROM achievements');
       for(var i = 0; i < rs.rows.length; i++) {
                console.log(rs.rows.item(i).id+ ", " + rs.rows.item(i).value + ", " + rs.rows.item(i).comment + "\n");
       }
//       rs = tx.executeSql('SELECT * FROM scores');
//       for(i = 0; i < rs.rows.length; i++) {
//                console.log(rs.rows.item(i).url+ ", " + rs.rows.item(i).unread + "\n");
//       }
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
                    //tx.executeSql('DROP TABLE scores;');
                    tx.executeSql('DROP TABLE achievements;');
                    //initialize();
                });
}

function getScores() {
    var db = getDatabase();
    var listmodel = Qt.createQmlObject('import Qt 4.7; ListModel {}', intro);
    db.transaction(function(tx) {
    var rs = tx.executeSql('SELECT date, score FROM scores ORDER BY score DESC LIMIT 6;');
    if (rs.rows.length > 0) {
        for(var i = 0; i < rs.rows.length; i++) {
          listmodel.append({date: rs.rows.item(i).date, score: rs.rows.item(i).score});
        }
    }
    })
    return listmodel
}

function getScores_tt() {
    var db = getDatabase();
    var listmodel = Qt.createQmlObject('import Qt 4.7; ListModel {}', intro);
    db.transaction(function(tx) {
    var rs = tx.executeSql('SELECT date, score FROM scores_tt ORDER BY score DESC LIMIT 6;');
    if (rs.rows.length > 0) {
        for(var i = 0; i < rs.rows.length; i++) {
          listmodel.append({date: rs.rows.item(i).date, score: rs.rows.item(i).score});
        }
    }
    })
    return listmodel
}

function getScore(type) {
    var db = getDatabase();
    var res = "";
    db.transaction(function(tx) {
                   var rs;
                   if (type == "timer") {
                               rs = tx.executeSql('SELECT date,score FROM scores_tt ORDER BY score DESC LIMIT 1;');
                   } else {
                               rs = tx.executeSql('SELECT date,score FROM scores ORDER BY score DESC LIMIT 1;');
                   }
                   if (rs.rows.length > 0) {
                        res = rs.rows.item(0).score + " / " + rs.rows.item(0).date;
                   } else {
                        res = "No score";
                   }
                });
   return res;

}

function setScore(score, type) {
    var db = getDatabase();
    var res = "";
    db.transaction(function(tx) {
                   var rs;
                   if (type == "timer") {
                               rs = tx.executeSql('INSERT OR REPLACE INTO scores_tt VALUES (strftime("%Y-%m-%d %H:%M","now"),?);', [score]);
                   } else {
                               rs = tx.executeSql('INSERT OR REPLACE INTO scores VALUES (strftime("%Y-%m-%d %H:%M","now"),?);', [score]);
                   }
                   if (rs.rowsAffected > 0) {
                        res = "OK";
                   } else {
                        res = "Error";
                   }
                });
   return res;
}

function getAchievement(index) {
    var db = getDatabase();
    var res = "";
    db.transaction(function(tx) {
                   var rs;
                       rs = tx.executeSql('SELECT value,comment FROM achievements WHERE id=?;',[index]);
                   if (rs.rows.length > 0) {
                       res = new Array(rs.rows.item(0).value, rs.rows.item(0).comment);
                   } else {
                       res = new Array("-1", "")
                   }
                });
   return res;
}

function setAchievement(index, value, comment) {
    var db = getDatabase();
    var res = "";
    db.transaction(function(tx) {
                   var rs;
                   rs = tx.executeSql('INSERT OR REPLACE INTO achievements VALUES (?,?,?);', [index,value,comment]);
                   if (rs.rowsAffected > 0) {
                        res = "OK";
                   } else {
                        res = "Error";
                   }
                });
   return res;
}

function incrementAchievement(index) {
    var db = getDatabase();
    var res = "";
    db.transaction(function(tx) {
                   var rs;
                   rs = tx.executeSql('UPDATE achievements SET value=value+1 WHERE id=?;', [index]);
                   if (rs.rowsAffected > 0) {
                        res = "OK";
                   } else {
                       rs = tx.executeSql('INSERT OR REPLACE INTO achievements VALUES (?,?,?);', [index,1,""]);
                       res = "OK";
                   }
                });
   return res;
}

function updateAchievement(index, value, comment) {
    var db = getDatabase();
    var res = "";
    if (getAchievement(index)[0]<value) {
        db.transaction(function(tx) {
                       var rs;
                       rs = tx.executeSql('INSERT OR REPLACE INTO achievements VALUES (?,?,?);', [index,value,comment]);
                       if (rs.rowsAffected > 0) {
                            res = "OK";
                       } else {
                           res = "Error";
                       }
                    });
    } else { res="NULL" }
    return res;
}

function initialize() {
    var db = getDatabase();
    //dump()
    //resetAll();

    db.transaction(
        function(tx) {
            // Create the database if it doesn't already exist
            tx.executeSql('CREATE TABLE IF NOT EXISTS settings(setting TEXT UNIQUE, value TEXT)');
            tx.executeSql('CREATE TABLE IF NOT EXISTS scores(date TEXT, score INTEGER)');
            tx.executeSql('CREATE TABLE IF NOT EXISTS scores_tt(date TEXT, score INTEGER)');
            tx.executeSql('CREATE TABLE IF NOT EXISTS achievements(id INTEGER UNIQUE, value INTEGER, comment TEXT);');
        }
    );
}
