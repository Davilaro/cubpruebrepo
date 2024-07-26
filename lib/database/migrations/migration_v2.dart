class MigrationV2 {
  static const String migrationScript = '''
    ALTER TABLE users ADD COLUMN role TEXT;
  ''';
}