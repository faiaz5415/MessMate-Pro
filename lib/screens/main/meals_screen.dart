import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MealsScreen extends StatefulWidget {
  const MealsScreen({super.key});

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  final DateTime selectedMonth = DateTime.now();

  // 🔴 later Provider/Firebase থেকে আসবে
  final bool isManager = true; // false হলে member

  bool _isLocked(DateTime date) {
    final today = DateTime.now();
    return date.isBefore(DateTime(today.year, today.month, today.day));
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth = DateUtils.getDaysInMonth(
      selectedMonth.year,
      selectedMonth.month,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(DateFormat('MMMM yyyy').format(selectedMonth)),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: daysInMonth,
        itemBuilder: (context, index) {
          final date = DateTime(
            selectedMonth.year,
            selectedMonth.month,
            index + 1,
          );

          return MealDayCard(
            date: date,
            locked: _isLocked(date),
            isManager: isManager,
          );
        },
      ),
    );
  }
}

/// ----------------------------------------------------------------
/// MEAL DAY CARD
/// ----------------------------------------------------------------
class MealDayCard extends StatefulWidget {
  final DateTime date;
  final bool locked;
  final bool isManager;

  const MealDayCard({
    super.key,
    required this.date,
    required this.locked,
    required this.isManager,
  });

  @override
  State<MealDayCard> createState() => _MealDayCardState();
}

class _MealDayCardState extends State<MealDayCard> {
  bool dayOn = true;
  bool nightOn = true;

  double dayQty = 1;
  double nightQty = 1;

  bool get canEdit {
    if (!widget.locked) return true;
    return widget.isManager;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Date Header + Lock/Admin Icon
            Row(
              children: [
                Text(
                  DateFormat('dd MMMM, EEEE').format(widget.date),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                if (widget.locked && !widget.isManager)
                  const Icon(Icons.lock, color: Colors.red),
                if (widget.locked && widget.isManager)
                  const Icon(Icons.admin_panel_settings,
                      color: Colors.orange),
              ],
            ),

            const SizedBox(height: 16),

            /// DAY MEAL
            _mealRow(
              title: 'Day Meal',
              isOn: dayOn,
              quantity: dayQty,
              enabled: canEdit,
              onToggle: (v) => setState(() => dayOn = v),
              onQtyChanged: (v) => setState(() => dayQty = v!),
            ),

            const SizedBox(height: 12),

            /// NIGHT MEAL
            _mealRow(
              title: 'Night Meal',
              isOn: nightOn,
              quantity: nightQty,
              enabled: canEdit,
              onToggle: (v) => setState(() => nightOn = v),
              onQtyChanged: (v) => setState(() => nightQty = v!),
            ),

            /// Manager Override Indicator
            if (widget.locked && widget.isManager) ...[
              const SizedBox(height: 12),
              const Text(
                'Manager Override Enabled',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 12,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// ----------------------------------------------------------------
  /// SINGLE MEAL ROW (Day / Night)
  /// ----------------------------------------------------------------
  Widget _mealRow({
    required String title,
    required bool isOn,
    required double quantity,
    required bool enabled,
    required Function(bool) onToggle,
    required ValueChanged<double?> onQtyChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(title),
            const Spacer(),
            Switch(
              value: isOn,
              onChanged: enabled ? onToggle : null,
            ),
          ],
        ),
        if (isOn)
          Row(
            children: [
              const Text('Qty'),
              const SizedBox(width: 12),
              DropdownButton<double>(
                value: quantity,
                items: const [
                  DropdownMenuItem(value: 0.5, child: Text('0.5')),
                  DropdownMenuItem(value: 1, child: Text('1')),
                  DropdownMenuItem(value: 2, child: Text('2')),
                  DropdownMenuItem(value: 3, child: Text('3')),
                  DropdownMenuItem(value: 4, child: Text('4')),
                ],
                onChanged: enabled
                    ? (value) {
                  if (value != null) {
                    onQtyChanged(value);
                  }
                }
                    : null,
              ),
            ],
          ),
      ],
    );
  }
}
