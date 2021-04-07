import 'package:money_saver/bean/booking/booking_vo.dart';
import 'package:money_saver/database/db_util.dart';
import 'package:sqflite/sqflite.dart';

class BookingProvider {
  Future<BookingVO> insert(Database db, BookingVO booking) async {
    booking.id = await db.insert(DBUtil.BOOK_TABLE, booking.toJson());
    return booking;
  }

  Future<int> delete(Database db, int id) async {
    return await db.delete(DBUtil.BOOK_TABLE, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(Database db, BookingVO booking) async {
    return await db.update(DBUtil.BOOK_TABLE, booking.toJson(),
        where: 'id = ?', whereArgs: [booking.id]);
  }

  Future<BookingVO> query(Database db, int id) async {
    List<Map> values = await db.query(DBUtil.BOOK_TABLE,
        columns: ['id'], where: 'id = ?', whereArgs: [id]);
    if (values.length > 0) {
      return BookingVO.fromJson(values.first);
    }
    return null;
  }

  Future<List<BookingVO>> queryList(
      Database db, int endTime, int limit, int accountType) async {
    List<Map> values = await db.query(DBUtil.BOOK_TABLE,
        where: 'bookTime <= ? and accountType = ?',
        whereArgs: [endTime, accountType],
        limit: limit,
        orderBy: 'bookTime DESC');
    if (values.length == 0) {
      return null;
    }
    return (values.map((e) => BookingVO.fromJson(e))).toList();
  }
}
