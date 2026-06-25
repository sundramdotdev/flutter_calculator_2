import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/calculation_record.dart';

class HistoryRepository {
  static late Isar _isar;

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [CalculationRecordSchema],
      directory: dir.path,
    );
  }

  Future<void> saveCalculation(String expression, String result) async {
    final record = CalculationRecord()
      ..expression = expression
      ..result = result
      ..timestamp = DateTime.now();

    await _isar.writeTxn(() async {
      await _isar.calculationRecords.put(record);
    });
  }

  Future<List<CalculationRecord>> getHistory() async {
    // Return sorted by newest first
    return await _isar.calculationRecords.where().sortByTimestampDesc().findAll();
  }

  Future<void> clearHistory() async {
    await _isar.writeTxn(() async {
      await _isar.calculationRecords.clear();
    });
  }
}
