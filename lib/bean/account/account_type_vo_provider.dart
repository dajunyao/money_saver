import 'package:money_saver/database/db_util.dart';
import 'package:sqflite/sqflite.dart';

import 'account_type_vo.dart';

class AccountTypeProvider {
  Future<AccountTypeVO> insert(Database db, AccountTypeVO booking) async {
    booking.id = await db.insert(DBUtil.ACCOUNT_TYPE_TABLE, booking.toJson());
    return booking;
  }

  Future<int> delete(Database db, int id) async {
    return await db
        .delete(DBUtil.ACCOUNT_TYPE_TABLE, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(Database db, AccountTypeVO booking) async {
    return await db.update(DBUtil.ACCOUNT_TYPE_TABLE, booking.toJson(),
        where: 'id = ?', whereArgs: [booking.id]);
  }

  Future<AccountTypeVO> query(Database db, int id) async {
    List<Map> values = await db.query(DBUtil.ACCOUNT_TYPE_TABLE,
        columns: ['id'], where: 'id = ?', whereArgs: [id]);
    if (values.length > 0) {
      return AccountTypeVO.fromJson(values.first);
    }
    return null;
  }

  Future<List<AccountTypeVO>> queryList(Database db) async {
    List<Map> values =
        await db.query(DBUtil.ACCOUNT_TYPE_TABLE, orderBy: 'lastTime DESC');
    if (values.length == 0) {
      return null;
    }
    return (values.map((e) => AccountTypeVO.fromJson(e))).toList();
  }
}
