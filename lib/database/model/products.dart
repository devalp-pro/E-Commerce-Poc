import 'package:moor/moor.dart';

@DataClassName('Product')
class Products extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().withLength(min: 1, max: 50)();

  DateTimeColumn get dateAdded => dateTime().withDefault(currentDateAndTime)();

  IntColumn get catId => integer().nullable().customConstraint('NULLABLE REFERENCES Category(id)')();
}
