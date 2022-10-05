import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  intialDb() async {
    String databasepath = await getDatabasesPath(); // موقع افتراضي
    String path = join(databasepath, 'motee.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 10, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) async {
    print("onUpgrade =====================================");
    await db.execute('ALTER TABLE notes ADD COLUMN color TEXT');
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
  CREATE TABLE "notes" (
    "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT, 
    "color" TWXT NOT NULL ,
    "title" TWXT NOT NULL ,
    "note" TEXT NOT NULL
  )
 ''');
    print(" onCreate =====================================");
  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  mydeleteDatabase() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'motee.db');
    await deleteDatabase(path);
  }

// SELECT
// DELETE
// UPDATE
// INSERT

}

// class SqlDb {
//   static Database? _db;

//   Future<Database?> get db async {
//     if (_db == null) {
//       _db = await intialdb();
//       return _db;
//     } else {
//       return _db;
//     }
//   }

//   intialdb() async {
//     String databasepath = await getDatabasesPath(); 
//     String path =
//         join(databasepath, 'ahmed.db'); // استدعبنا الموقع ثم اعطيناه اسم
//     Database mydb = await openDatabase(path,
//         onCreate: _onCreate,
//         onUpgrade: _onUpgrade); //  انشأنا الداتا بيس وأعطيناها اسم
//     // _onCreate هذه الفنقشن اللتي من خلالها ننشئ الداتا بيس
//     // onCreate تنشئ الجداول
//     return mydb;
//   }

//   _onUpgrade(Database db, int oldversion, int newversion) {
//     print('onUpgrade =========================');
//   }

//   _onCreate(Database db, int version) async {
//     await db.execute(
//         'CREATE TABLE "Notes"( id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, "note" TEXT NOT NULL)'
//         ''
//         '');
//     print('onCreate  ==========================');
//   }

//   readData(String sql) async {
//     // وظيفتها جلب البيانات من قادعة البيانانت )(Select)

//     Database? mydb = await db;
//     List<Map> response = await mydb!.rawQuery(sql);
//     // rawQuery >>> select
//     return response;
//   }

//   insertData(String sql) async {
//     Database? mydb = await db;
//     int response = await mydb!.rawInsert(sql);
//     return response;
//   }

//   updatetData(String sql) async {
//     Database? mydb = await db;
//     int response = await mydb!.rawUpdate(sql);
//     return response;
//   }

//   deleteData(String sql) async {
//     Database? mydb = await db;
//     int response = await mydb!.rawDelete(sql);
//     return response;
//   }
// }

// class SqlDb {
//   static Database? _db;
//   Future<Database?> get db async {
//     if (_db == null) {
//       _db = await intialDb();
//       return _db;
//     }
//     return _db;
//   }

//   intialDb() async {
//     String databasepath =
//         await getDatabasesPath(); // Get the default databases location.
//     // لازم تضيف المسار مع أسم الداتا بيس
//     String path = join(databasepath, 'note.db');
//     Database mydb = await openDatabase(path,
//         onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
//     return mydb;
//   }

//   _onUpgrade(Database db, int oldversion, int newversion) {
//     print('onUpgrade===========================');
//   }

//   _onCreate(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE "motes"(
//         "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
//         "note" TEXT NOT NULL
//       )
// ''');
//     print('Create DATABASE AND TABLE ============================');
//   }

//   readData(String sql) async {
//     Database? mydb = await db;
//     Future<List<Map>> response = mydb!.rawQuery(sql);
//     return response;
//   }

//   insertData(String sql) async {
//     Database? mydb = await db;
//     int response = await mydb!.rawInsert(sql);
//     return response;
//   }

//   updatetData(String sql) async {
//     Database? mydb = await db;
//     int response = await mydb!.rawUpdate(sql);
//     return response;
//   }

//   deleteData(String sql) async {
//     Database? mydb = await db;
//     int response = await mydb!.rawDelete(sql);
//     return response;
//   }
// }
