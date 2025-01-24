import 'package:flutter/material.dart';
import 'package:projetfinal/components/add_transaction.dart';
import 'package:projetfinal/components/expense_item.dart';
import 'package:intl/intl.dart';

void main() => runApp(Homepage());

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Quicksand',
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text(
            "Personal Expenses",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ExpenseList(),
      ),
    );
  }
}

class ExpenseList extends StatefulWidget {
  @override
  _ExpenseListState createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  final List<ExpenseItem> _expenses = [];

  void _addExpense(
      String title, double amount, String category, DateTime date) {
    final newExpense = ExpenseItem(
      title: title,
      amount: amount,
      date: date,
      category: category,
    );

    setState(() {
      _expenses.add(newExpense);
    });
  }

  void _deleteExpense(String title) {
    setState(() {
      _expenses.removeWhere((expense) => expense.title == title);
    });
  }

  void _editExpense(ExpenseItem expense, String title, double amount,
      String category, DateTime date) {
    setState(() {
      expense.title = title;
      expense.amount = amount;
      expense.category = category;
      expense.date = date;
    });
  }

  List<double> _getWeeklyExpenses() {
    List<double> weeklyExpenses = List.filled(7, 0.0);
    DateTime now = DateTime.now();

    for (var expense in _expenses) {
      if (expense.date.isAfter(now.subtract(Duration(days: now.weekday - 1))) &&
          expense.date.isBefore(now.add(Duration(days: 8 - now.weekday)))) {
        int weekdayIndex = expense.date.weekday - 1;
        weeklyExpenses[weekdayIndex] += expense.amount;
      }
    }
    return weeklyExpenses;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Column(
          children: [
            Text(
              'Dépenses Hebdomadaires',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildWeeklyExpensesChart(),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _expenses.length,
            itemBuilder: (ctx, index) {
              final expense = _expenses[index];
              return Card(
                child: ListTile(
                  title: Text(expense.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '\$${expense.amount.toStringAsFixed(2)}',
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                      Text(
                        expense.category,
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                      Text(
                        DateFormat.yMd().format(expense.date),
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (ctx) => AddTransaction(
                              (newTitle, newAmount, newCategory, newDate) {
                                _editExpense(expense, newTitle, newAmount,
                                    newCategory, newDate);
                                Navigator.of(ctx).pop();
                              },
                              existingExpense: expense,
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _deleteExpense(expense.title);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 233, 213, 33),
          shape: CircleBorder(),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (ctx) => AddTransaction(_addExpense),
            );
          },
          child: Icon(Icons.add),
        ),
      ],
    );
  }

  Widget _buildWeeklyExpensesChart() {
    List<double> expenses = _getWeeklyExpenses();
    double maxExpense = expenses.reduce((a, b) => a > b ? a : b);
    double maxBarHeight = 100.0;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(7, (index) {
          double heightFactor =
              maxExpense > 0 ? (expenses[index] / maxExpense) : 0;

          return Column(
            children: [
              Container(
                height: maxBarHeight,
                width: 20,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: FractionallySizedBox(
                  heightFactor: heightFactor,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Text(_getWeekdayLabel(index)),
            ],
          );
        }),
      ),
    );
  }

  String _getWeekdayLabel(int index) {
    const weekdays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    return weekdays[index];
  }
}
