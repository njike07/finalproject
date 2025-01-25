import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'expense_item.dart';

class AddTransaction extends StatefulWidget {
  final Function(String, double, String, DateTime) addExpense;
  final ExpenseItem? existingExpense;

  AddTransaction(this.addExpense, {this.existingExpense});

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  String selectedCategory = 'Miscellaneous';
  DateTime selectedDate = DateTime.now();

  final List<String> categories = [
    'Food',
    'Transport',
    'Entertainment',
    'Utilities',
    'Miscellaneous'
  ];

  @override
  void initState() {
    super.initState();
    if (widget.existingExpense != null) {
      titleController.text = widget.existingExpense!.title;
      amountController.text = widget.existingExpense!.amount.toString();
      selectedCategory = widget.existingExpense!.category;
      selectedDate = widget.existingExpense!.date;
    }
  }

  void _submitData() {
    final title = titleController.text;
    final amount = double.tryParse(amountController.text) ?? 0.0;

    if (title.isEmpty || amount <= 0) {
      return; // Gérer les erreurs ici
    }

    // Appeler la fonction pour ajouter ou modifier une dépense
    if (widget.existingExpense != null) {
      widget.addExpense(title, amount, selectedCategory, selectedDate);
    } else {
      widget.addExpense(title, amount, selectedCategory, selectedDate);
    }

    Navigator.of(context).pop();
  }

  void _selectDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
            ),
            Row(
              children: [
                Expanded(
                  child: Text('Date: ${DateFormat.yMd().format(selectedDate)}'),
                ),
                TextButton(
                  onPressed: () => _selectDate(context),
                  child: Text('Choose Date'),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(5),
              ),
              margin: EdgeInsets.only(
                  top: 10, bottom: 10), // Espace autour du dropdown
              child: DropdownButton<String>(
                value: selectedCategory,
                items: categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        category,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCategory = newValue!;
                  });
                },
                icon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(Icons.arrow_drop_down, color: Colors.purple),
                ),
                isExpanded: true, // Prendre tout l'espace disponible
                underline: SizedBox(), // Supprimer la ligne par défaut
              ),
            ),
            ElevatedButton(
              onPressed: _submitData,
              child: Text(widget.existingExpense != null
                  ? 'Edit Expense'
                  : 'Add Expense'),
            ),
          ],
        ),
      ),
    );
  }
}
