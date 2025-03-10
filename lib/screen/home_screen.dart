import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/provider.dart';
import '../utils/quotes.dart';
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
    final cashFlow = totalIncome + totalExpense; // Perhitungan arus kas

    final randomQuote = Quotes.getRandomQuote();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Beranda'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Arus Kas',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
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
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const IncomeScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 219, 226, 239),
                    backgroundColor: const Color.fromARGB(
                        255, 63, 114, 175), // Warna teks di dalam tombol
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    textStyle:
                        const TextStyle(fontSize: 20, fontFamily: 'Poppins'),
                  ),
                  child: const Text('Pemasukan'),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ExpenseScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 219, 226, 239),
                    backgroundColor: const Color.fromARGB(
                        255, 63, 114, 175), // Warna teks di dalam tombol
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    textStyle:
                        const TextStyle(fontSize: 20, fontFamily: 'Poppins'),
                  ),
                  child: const Text('Pengeluaran'),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FinancialReportScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 219, 226, 239),
                    backgroundColor: const Color.fromARGB(
                        255, 63, 114, 175), // Warna teks di dalam tombol
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    textStyle:
                        const TextStyle(fontSize: 20, fontFamily: 'Poppins'),
                  ),
                  child: const Text('Laporan Keuangan'),
                ),
              ),
              const SizedBox(height: 100),
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
