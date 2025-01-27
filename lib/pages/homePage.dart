import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projetfinal/components/add_transaction.dart';
import 'package:projetfinal/components/expense_item.dart';
import 'package:intl/intl.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:projetfinal/pages/category_expenses.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projetfinal/services/database_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialiser Firebase
  runApp(Homepage());
}

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Quicksand',
      ),
      home: ExpenseList(),
    );
  }
}

class ExpenseList extends StatefulWidget {
  @override
  _ExpenseListState createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  final DatabaseService _databaseService = DatabaseService();
  List<ExpenseItem> _expenses = [];

  @override
  void initState() {
    super.initState();
    _loadExpenses();
  }

  void _loadExpenses() async {
    List<ExpenseItem> expenses = await _databaseService.getExpenses();
    setState(() {
      _expenses = expenses;
    });
  }

  void _addExpense(String title, double amount, String category, DateTime date) async {
    final newExpense = ExpenseItem(
      title: title,
      amount: amount,
      date: date,
      category: category,
    );

    await _databaseService.addExpense(newExpense);
    _loadExpenses();
  }

  void _deleteExpense(String id) async {
    await _databaseService.deleteExpense(id);
    _loadExpenses();
  }

  void _editExpense(String id, ExpenseItem expense) async {
    await _databaseService.updateExpense(id, expense);
    _loadExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          "Personal Expenses",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _expenses.length,
              itemBuilder: (ctx, index) {
                final expense = _expenses[index];
                return Card(
                  child: ListTile(
                    title: Text(expense.title),
                    subtitle: Text('\$${expense.amount.toStringAsFixed(2)}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _deleteExpense(expense.title);
                      },
                    ),
                    onTap: () {
                      // Navigate to edit page
                    },
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
            // Navigation vers le graphique
          } else if (index == 1) {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => Homepage()),
            );
          } else if (index == 2) {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => CategoryExpenses(
                        expenses: [],
                      )),
            );
          }
        },
      ),
    );
  }
}