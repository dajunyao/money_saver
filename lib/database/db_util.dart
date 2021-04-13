class DBUtil {
  static const String BOOK_TABLE = 'BOOK';
  static const String ACCOUNT_TYPE_TABLE = 'ACCOUNT';
  static const String MARK_TYPE_TABLE = 'MARK';

  static const String CREATE_BOOKING_TABLE =
      'CREATE TABLE $BOOK_TABLE(id INTEGER PRIMARY KEY, '
      'accountType INTEGER, '
      'inOutType INTEGER,'
      'bookTime INTEGER, '
      'money INTEGER, '
      'iconType INTEGER,'
      'type INTEGER,'
      'title TEXT,'
      'custom INTEGER,'
      'remark TEXT)';

  static const String CREATE_ACCOUNT_TABLE =
      'CREATE TABLE $ACCOUNT_TYPE_TABLE(id INTEGER PRIMARY KEY, '
      'accountType INTEGER, '
      'accountName TEXT, '
      'iconType INTEGER, '
      'lastTime INTEGER)';

  static const String CREATE_MARK_TABLE =
      'CREATE TABLE $MARK_TYPE_TABLE(id INTEGER PRIMARY KEY, '
      'markType INTEGER, '
      'markTitle TEXT, '
      'markIcon TEXT, '
      'custom INTEGER)';
}
