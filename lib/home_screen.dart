import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'income_provider.dart';
import 'quotes.dart';
import 'income_screen.dart';
import 'expense_screen.dart';
import 'financial_report_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final incomeProvider = Provider.of<IncomeProvider>(context);
    final totalIncome = incomeProvider.totalIncome;
    final totalExpense = incomeProvider.totalExpense;
    final cashFlow = totalIncome - totalExpense;
    final randomQuote = Quotes.getRandomQuote();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplikasiku'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Arus Kas',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                incomeProvider.formatCurrency(cashFlow),
                style:
                    const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Icon(Icons.arrow_downward, color: Colors.green),
                  const SizedBox(width: 8),
                  Text(
                    'Pemasukan: ${incomeProvider.formatCurrency(totalIncome)}',
                    style: const TextStyle(fontSize: 16, color: Colors.green),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Icon(Icons.arrow_upward, color: Colors.red),
                  const SizedBox(width: 8),
                  Text(
                    'Pengeluaran: ${incomeProvider.formatCurrency(totalExpense)}',
                    style: const TextStyle(fontSize: 16, color: Colors.red),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const IncomeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle: const TextStyle(fontSize: 20),
                ),
                child: const Text('Pemasukan'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ExpenseScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle: const TextStyle(fontSize: 20),
                ),
                child: const Text('Pengeluaran'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FinancialReportScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle: const TextStyle(fontSize: 20),
                ),
                child: const Text('Laporan Keuangan'),
              ),
              const SizedBox(height: 20),
              const Text(
                'Kutipan Hari Ini',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                randomQuote,
                style:
                    const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
