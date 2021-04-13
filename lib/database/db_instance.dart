import 'package:money_saver/bean/booking/booking_vo_provider.dart';
import 'package:money_saver/bean/marktype/mark_type_vo_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'db_util.dart';

class DbInstance {
  static final DbInstance _singleton = DbInstance._init();

  factory DbInstance() {
    return _singleton;
  }

  DbInstance._init();

  Database db;

  initDatabase() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'money_saver.db');
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(DBUtil.CREATE_BOOKING_TABLE);
        await db.execute(DBUtil.CREATE_ACCOUNT_TABLE);
        await db.execute(DBUtil.CREATE_MARK_TABLE);
        await MarkTypeProvider().initial(db);
      },
    );
  }
}
