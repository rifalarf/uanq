import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'income_form_screen.dart';
import 'income_provider.dart';

class IncomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final incomeProvider = Provider.of<IncomeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Pemasukan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
              'Total Pemasukan: ${incomeProvider.formatCurrency(incomeProvider.totalIncome)}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IncomeFormScreen(
                      onSubmit: (amount, description, category) {
                        incomeProvider.addIncome(amount, description, category);
                      },
                    ),
                  ),
                );
              },
              child: Text('Tambah Pemasukan'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: incomeProvider.incomeList.length,
                itemBuilder: (context, index) {
                  final income = incomeProvider.incomeList[index];
                  return ListTile(
                    title: Text(income['description']),
                    subtitle: Text(
                        'Jumlah: ${incomeProvider.formatCurrency(income['amount'])}\nKategori: ${income['category']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => IncomeFormScreen(
                                  initialAmount: income['amount'],
                                  initialDescription: income['description'],
                                  initialCategory: income['category'],
                                  onSubmit: (amount, description, category) {
                                    incomeProvider.editIncome(
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
                            incomeProvider.deleteIncome(index);
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
