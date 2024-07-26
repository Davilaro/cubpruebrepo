class MigrationV1 {
  static const String createTable = '''
    CREATE TABLE users (
      id INTEGER PRYMARY KEY,
      username TEXT,
      password TEXT,
      token TEXT,
      createdAt TEXT,
      updatedAt TEXT
    )
  ''';
}