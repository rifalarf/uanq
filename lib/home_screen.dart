import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'income_provider.dart';
import 'quotes.dart';
import 'income_screen.dart';
import 'expense_screen.dart';
import 'financial_report_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final incomeProvider = Provider.of<IncomeProvider>(context);
    final totalIncome = incomeProvider.totalIncome;
    final totalExpense = incomeProvider.totalExpense;
    final cashFlow = totalIncome + totalExpense; // Perhitungan arus kas

    final randomQuote = Quotes.getRandomQuote();

    return Scaffold(
      appBar: AppBar(
        title: Text('Aplikasiku'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Arus Kas',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                incomeProvider.formatCurrency(cashFlow),
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.arrow_downward, color: Colors.green),
                  SizedBox(width: 8),
                  Text(
                    'Pemasukan: ${incomeProvider.formatCurrency(totalIncome)}',
                    style: TextStyle(fontSize: 16, color: Colors.green),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.arrow_upward, color: Colors.red),
                  SizedBox(width: 8),
                  Text(
                    'Pengeluaran: ${incomeProvider.formatCurrency(totalExpense)}',
                    style: TextStyle(fontSize: 16, color: Colors.red),
                  ),
                ],
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => IncomeScreen()),
                    );
                  },
                  child: Text('Pemasukan'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Color.fromARGB(255, 219, 226, 239),
                    backgroundColor: Color.fromARGB(
                        255, 63, 114, 175), // Warna teks di dalam tombol
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    textStyle: TextStyle(fontSize: 20, fontFamily: 'Poppins'),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ExpenseScreen()),
                    );
                  },
                  child: Text('Pengeluaran'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Color.fromARGB(255, 219, 226, 239),
                    backgroundColor: Color.fromARGB(
                        255, 63, 114, 175), // Warna teks di dalam tombol
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    textStyle: TextStyle(fontSize: 20, fontFamily: 'Poppins'),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FinancialReportScreen()),
                    );
                  },
                  child: Text('Laporan Keuangan'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Color.fromARGB(255, 219, 226, 239),
                    backgroundColor: Color.fromARGB(
                        255, 63, 114, 175), // Warna teks di dalam tombol
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    textStyle: TextStyle(fontSize: 20, fontFamily: 'Poppins'),
                  ),
                ),
              ),
              SizedBox(height: 100),
              Text(
                'Kutipan Hari Ini',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                randomQuote,
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
