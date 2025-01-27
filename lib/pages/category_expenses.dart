import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:projetfinal/components/add_transaction.dart';
import 'package:projetfinal/pages/homePage.dart';
import 'package:projetfinal/pages/setting.dart';

class Expense {
  final String category;
  final double amount;

  Expense({required this.category, required this.amount});
}

class CategoryExpenses extends StatelessWidget {
  final List<Expense> expenses;

  const CategoryExpenses({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    // Calculer le total de toutes les dépenses
    double totalExpenses = expenses.fold(0, (sum, item) => sum + item.amount);

    // Organiser les dépenses par catégorie
    Map<String, double> categoryTotals = {};
    for (var expense in expenses) {
      categoryTotals[expense.category] =
          (categoryTotals[expense.category] ?? 0) + expense.amount;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Catégories de Dépenses",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Afficher le total de toutes les dépenses
            Text(
              "Total des Dépenses: \$${totalExpenses.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Afficher les catégories et leurs totaux
            Expanded(
              child: ListView.builder(
                itemCount: categoryTotals.length,
                itemBuilder: (context, index) {
                  String category = categoryTotals.keys.elementAt(index);
                  double totalForCategory = categoryTotals[category]!;

                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      title: Text(category),
                      trailing:
                          Text("\$${totalForCategory.toStringAsFixed(2)}"),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.purple,
        backgroundColor: Colors.white,
        animationDuration: const Duration(milliseconds: 400),
        items: const <Widget>[
          Icon(Icons.bar_chart, size: 30, color: Colors.white),
          Icon(Icons.list, size: 30, color: Colors.white),
          Icon(Icons.settings, size: 30, color: Colors.white),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ExpenseList()),
            );
          } else if (index == 2) {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => SettingPage()),
            );
          }
        },
      ),
    );
  }
}
