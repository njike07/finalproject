import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:projetfinal/components/expense_item.dart';

class CategoryExpenses extends StatelessWidget {
  final List<ExpenseItem> expenses;

  CategoryExpenses({required this.expenses}) {
    // Debugging: Print the expenses received
    print('Expenses received: $expenses');
  }

  Map<String, double> _getCategoryData() {
    Map<String, double> categoryData = {};

    for (var expense in expenses) {
      if (categoryData.containsKey(expense.category)) {
        categoryData[expense.category] =
            categoryData[expense.category]! + expense.amount;
      } else {
        categoryData[expense.category] = expense.amount;
      }
    }

    return categoryData;
  }

  @override
  Widget build(BuildContext context) {
    final categoryData = _getCategoryData();
    final total =
        categoryData.values.fold(0.0, (sum, amount) => sum + amount); // Use 0.0

    return Scaffold(
      appBar: AppBar(
        title: Text('Dépenses par Catégorie'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Répartition des Dépenses',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            PieChart(
              PieChartData(
                sections: categoryData.entries.map((entry) {
                  final percentage = (entry.value / total) * 100;
                  return PieChartSectionData(
                    color: Colors.primaries[
                        categoryData.keys.toList().indexOf(entry.key) %
                            Colors.primaries.length],
                    value: entry.value,
                    title: '${entry.key}: ${percentage.toStringAsFixed(1)}%',
                    radius: 60,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
