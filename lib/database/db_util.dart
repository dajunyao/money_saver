class DBUtil {
  static const String BOOK_TABLE = 'BOOK';
  static const String ACCOUNT_TYPE_TABLE = 'ACCOUNT';

  static String getCreateBookSql() {
    return 'CREATE TABLE $BOOK_TABLE(id INTEGER PRIMARY KEY, '
        'accountType INTEGER, '
        'bookTime INTEGER, '
        'bookYear INTEGER, '
        'bookMonth INTEGER, '
        'bookDay INTEGER, '
        'money INTEGER, '
        'iconType INTEGER,'
        'type INTEGER,'
        'title TEXT,'
        'custom INTEGER,'
        'remark TEXT)';
  }

  static String getCreateAccountSql() {
    return 'CREATE TABLE $ACCOUNT_TYPE_TABLE(id INTEGER PRIMARY KEY, '
        'accountType INTEGER, '
        'accountName TEXT, '
        'iconType INTEGER, '
        'lastTime INTEGER)';
  }
}
