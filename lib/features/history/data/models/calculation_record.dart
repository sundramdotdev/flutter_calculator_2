import 'package:isar/isar.dart';

part 'calculation_record.g.dart';

@collection
class CalculationRecord {
  Id id = Isar.autoIncrement; // auto increment id

  late String expression;

  late String result;

  late DateTime timestamp;
}
