import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class IncomeProvider with ChangeNotifier {
  double _totalIncome = 0;
  double _totalExpense = 0;
  List<Map<String, dynamic>> _incomeList = [];
  List<Map<String, dynamic>> _expenseList = [];

  double get totalIncome => _totalIncome;
  double get totalExpense => _totalExpense;
  List<Map<String, dynamic>> get incomeList => _incomeList;
  List<Map<String, dynamic>> get expenseList => _expenseList;

  IncomeProvider() {
    _loadData();
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('incomeList', jsonEncode(_incomeList));
    prefs.setString('expenseList', jsonEncode(_expenseList));
    prefs.setDouble('totalIncome', _totalIncome);
    prefs.setDouble('totalExpense', _totalExpense);
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    _totalIncome = prefs.getDouble('totalIncome') ?? 0;
    _totalExpense = prefs.getDouble('totalExpense') ?? 0;
    _incomeList = jsonDecode(prefs.getString('incomeList') ?? '[]')
        .cast<Map<String, dynamic>>();
    _expenseList = jsonDecode(prefs.getString('expenseList') ?? '[]')
        .cast<Map<String, dynamic>>();
    notifyListeners();
  }

  void addIncome(double amount, String description, String category) {
    _totalIncome += amount;
    _incomeList.add(
        {'amount': amount, 'description': description, 'category': category});
    _saveData();
    notifyListeners();
  }

  void deleteIncome(int index) {
    _totalIncome -= _incomeList[index]['amount'];
    _incomeList.removeAt(index);
    _saveData();
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
    _saveData();
    notifyListeners();
  }

  void addExpense(double amount, String description, String category) {
    _totalExpense += amount;
    _expenseList.add(
        {'amount': amount, 'description': description, 'category': category});
    _saveData();
    notifyListeners();
  }

  void deleteExpense(int index) {
    _totalExpense -= _expenseList[index]['amount'];
    _expenseList.removeAt(index);
    _saveData();
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
    _saveData();
    notifyListeners();
  }

  String formatCurrency(double amount) {
    final formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
    return formatter.format(amount);
  }
}
