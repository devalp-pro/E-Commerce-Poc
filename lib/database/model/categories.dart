import 'package:moor/moor.dart';

@DataClassName('Category')
class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().withLength(min: 1, max: 50)();

  IntColumn get parentId => integer().nullable().customConstraint('NULLABLE REFERENCES Category(id)')();
}
