import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'expense_form_screen.dart';
import 'income_provider.dart';

class ExpenseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final incomeProvider = Provider.of<IncomeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Pengeluaran'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
              'Total Pengeluaran: ${incomeProvider.formatCurrency(incomeProvider.totalExpense)}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExpenseFormScreen(
                      onSubmit: (amount, description, category) {
                        incomeProvider.addExpense(
                            amount, description, category);
                      },
                    ),
                  ),
                );
              },
              child: Text('Tambah Pengeluaran'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: incomeProvider.expenseList.length,
                itemBuilder: (context, index) {
                  final expense = incomeProvider.expenseList[index];
                  return ListTile(
                    title: Text(expense['description']),
                    subtitle: Text(
                        'Jumlah: ${incomeProvider.formatCurrency(expense['amount'])}\nKategori: ${expense['category']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ExpenseFormScreen(
                                  initialAmount: expense['amount'],
                                  initialDescription: expense['description'],
                                  initialCategory: expense['category'],
                                  onSubmit: (amount, description, category) {
                                    incomeProvider.editExpense(
                                        index, amount, description, category);
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            incomeProvider.deleteExpense(index);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
