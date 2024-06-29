import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IncomeProvider with ChangeNotifier {
  double _totalIncome = 0;
  double _totalExpense = 0;
  List<Map<String, dynamic>> _incomeList = [];
  List<Map<String, dynamic>> _expenseList = [];

  double get totalIncome => _totalIncome;
  double get totalExpense => _totalExpense;
  List<Map<String, dynamic>> get incomeList => _incomeList;
  List<Map<String, dynamic>> get expenseList => _expenseList;

  void addIncome(double amount, String description, String category) {
    _totalIncome += amount;
    _incomeList.add(
        {'amount': amount, 'description': description, 'category': category});
    notifyListeners();
  }

  void deleteIncome(int index) {
    _totalIncome -= _incomeList[index]['amount'];
    _incomeList.removeAt(index);
    notifyListeners();
  }

  void editIncome(
      int index, double amount, String description, String category) {
    _totalIncome -= _incomeList[index]['amount'];
    _totalIncome += amount;
    _incomeList[index] = {
      'amount': amount,
      'description': description,
      'category': category
    };
    notifyListeners();
  }

  void addExpense(double amount, String description, String category) {
    _totalExpense += amount;
    _expenseList.add(
        {'amount': amount, 'description': description, 'category': category});
    notifyListeners();
  }

  void deleteExpense(int index) {
    _totalExpense -= _expenseList[index]['amount'];
    _expenseList.removeAt(index);
    notifyListeners();
  }

  void editExpense(
      int index, double amount, String description, String category) {
    _totalExpense -= _expenseList[index]['amount'];
    _totalExpense += amount;
    _expenseList[index] = {
      'amount': amount,
      'description': description,
      'category': category
    };
    notifyListeners();
  }

  String formatCurrency(double amount) {
    final formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
    return formatter.format(amount);
  }
}
