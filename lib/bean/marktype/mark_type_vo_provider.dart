import 'package:money_saver/bean/marktype/mark_type_vo.dart';
import 'package:money_saver/database/db_util.dart';
import 'package:sqflite/sqflite.dart';

class MarkTypeProvider {
  Future<bool> initial(Database db) async {
    Batch batch = db.batch();
    MarkTypeVO buy =
        MarkTypeVO(id: 1, markType: MarkTypeVO.BUY, markTitle: '买', custom: 0);
    batch.insert(DBUtil.MARK_TYPE_TABLE, buy.toJson());

    MarkTypeVO car =
        MarkTypeVO(id: 2, markType: MarkTypeVO.CAR, markTitle: '车', custom: 0);
    batch.insert(DBUtil.MARK_TYPE_TABLE, car.toJson());

    MarkTypeVO clothes = MarkTypeVO(
        id: 3, markType: MarkTypeVO.CLOTHES, markTitle: '衣', custom: 0);
    batch.insert(DBUtil.MARK_TYPE_TABLE, clothes.toJson());

    MarkTypeVO eat =
        MarkTypeVO(id: 4, markType: MarkTypeVO.EAT, markTitle: '吃', custom: 0);
    batch.insert(DBUtil.MARK_TYPE_TABLE, eat.toJson());

    MarkTypeVO house = MarkTypeVO(
        id: 5, markType: MarkTypeVO.HOUSE, markTitle: '住', custom: 0);
    batch.insert(DBUtil.MARK_TYPE_TABLE, house.toJson());

    MarkTypeVO pets =
        MarkTypeVO(id: 6, markType: MarkTypeVO.PET, markTitle: '宠物', custom: 0);
    batch.insert(DBUtil.MARK_TYPE_TABLE, pets.toJson());

    MarkTypeVO traffic = MarkTypeVO(
        id: 7, markType: MarkTypeVO.TRAFFIC, markTitle: '公交', custom: 0);
    batch.insert(DBUtil.MARK_TYPE_TABLE, traffic.toJson());
    await batch.commit();
    return true;
  }

  Future<MarkTypeVO> insert(Database db, MarkTypeVO booking) async {
    booking.id = await db.insert(DBUtil.MARK_TYPE_TABLE, booking.toJson());
    return booking;
  }

  Future<int> delete(Database db, int id) async {
    return await db
        .delete(DBUtil.MARK_TYPE_TABLE, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(Database db, MarkTypeVO booking) async {
    return await db.update(DBUtil.MARK_TYPE_TABLE, booking.toJson(),
        where: 'id = ?', whereArgs: [booking.id]);
  }

  // Future<MarkTypeVO> query(Database db, int id) async {
  //   List<Map> values = await db.query(DBUtil.MARK_TYPE_TABLE,
  //       columns: ['id'], where: 'id = ?', whereArgs: [id]);
  //   if (values.length > 0) {
  //     return MarkTypeVO.fromJson(values.first);
  //   }
  //   return null;
  // }

  Future<List<MarkTypeVO>> queryList(Database db) async {
    List<Map> values = await db.query(
      DBUtil.MARK_TYPE_TABLE,
    );
    if (values.length == 0) {
      return null;
    }
    return (values.map((e) => MarkTypeVO.fromJson(e))).toList();
  }
}
