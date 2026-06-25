import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../calculator/presentation/providers/calculator_provider.dart';
import '../../data/models/calculation_record.dart';
import '../../data/repositories/history_repository.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  final HistoryRepository _repository = HistoryRepository();
  List<CalculationRecord> _records = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final records = await _repository.getHistory();
    setState(() {
      _records = records;
      _isLoading = false;
    });
  }

  Future<void> _clearHistory() async {
    await _repository.clearHistory();
    _loadHistory();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: _records.isEmpty ? null : _clearHistory,
          )
        ],
      ),
      body: _isLoading 
          ? const Center(child: CircularProgressIndicator())
          : _records.isEmpty
              ? Center(child: Text("No history yet.", style: theme.textTheme.bodyLarge))
              : ListView.builder(
                  itemCount: _records.length,
                  itemBuilder: (context, index) {
                    final record = _records[index];
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      title: Text(
                        record.expression,
                        style: theme.textTheme.bodyLarge,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        DateFormat('MMM dd, hh:mm a').format(record.timestamp),
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.5)
                        ),
                      ),
                      trailing: Text(
                        "= ${record.result}",
                        style: theme.textTheme.displaySmall?.copyWith(
                          fontSize: 24, 
                          color: theme.colorScheme.primary
                        ),
                      ),
                      onTap: () {
                        // Load into calculator and pop
                        ref.read(calculatorProvider.notifier).loadFromHistory(record.expression);
                        context.pop();
                      },
                    );
                  },
                ),
    );
  }
}
