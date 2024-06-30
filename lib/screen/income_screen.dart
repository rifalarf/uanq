import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'income_form_screen.dart';
import '../provider/provider.dart';

class IncomeScreen extends StatelessWidget {
  const IncomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final incomeProvider = Provider.of<IncomeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pemasukan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
              'Total Pemasukan: ${incomeProvider.formatCurrency(incomeProvider.totalIncome)}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
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
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 219, 226, 239),
                backgroundColor: const Color.fromARGB(
                    255, 63, 114, 175), // Warna teks di dalam tombol
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: const TextStyle(fontSize: 20, fontFamily: 'Poppins'),
              ),
              child: const Text('Tambah Pemasukan'),
            ),
            const SizedBox(height: 20),
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
                          icon: const Icon(Icons.edit),
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
                          icon: const Icon(Icons.delete),
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
