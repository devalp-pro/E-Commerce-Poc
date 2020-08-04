import 'package:moor/moor.dart';

@DataClassName('Variant')
class Variants extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get color => text().withLength(min: 1, max: 50)();

  IntColumn get size => integer().nullable()();

  IntColumn get price => integer().nullable()();

  IntColumn get productId => integer().nullable().customConstraint('NULLABLE REFERENCES Product(id)')();
}
