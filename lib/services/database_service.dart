/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projetfinal/components/expense_item.dart';

class DatabaseService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> addExpense(ExpenseItem expense) async {
    await db.collection('expenses').add({
      'title': expense.title,
      'amount': expense.amount,
      'date': expense.date,
      'category': expense.category,
    });
  }

  Future<List<ExpenseItem>> getExpenses() async {
    final snapshot = await db.collection('expenses').get();
    return snapshot.docs.map((doc) {
      return ExpenseItem(
        title: doc['title'],
        amount: doc['amount'],
        date: (doc['date'] as Timestamp).toDate(),
        category: doc['category'],
      );
    }).toList();
  }
}*/
