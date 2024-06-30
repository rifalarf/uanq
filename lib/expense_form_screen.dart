import 'package:flutter/material.dart';

class ExpenseFormScreen extends StatefulWidget {
  final Function(double, String, String) onSubmit;
  final double? initialAmount;
  final String? initialDescription;
  final String? initialCategory;

  const ExpenseFormScreen({super.key, 
    required this.onSubmit,
    this.initialAmount,
    this.initialDescription,
    this.initialCategory,
  });

  @override
  _ExpenseFormScreenState createState() => _ExpenseFormScreenState();
}

class _ExpenseFormScreenState extends State<ExpenseFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _amountController;
  late TextEditingController _descriptionController;
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(
      text: widget.initialAmount?.toStringAsFixed(0) ?? '',
    );
    _descriptionController =
        TextEditingController(text: widget.initialDescription ?? '');
    _selectedCategory = widget.initialCategory ?? 'Belanja';
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _selectedCategory != null) {
      double amount = double.parse(_amountController.text);
      String description = _descriptionController.text;
      String category = _selectedCategory!;

      widget.onSubmit(amount, description, category);

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.initialAmount == null
            ? 'Tambah Pengeluaran'
            : 'Edit Pengeluaran'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Jumlah'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan jumlah pengeluaran';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Masukkan jumlah yang valid';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Deskripsi'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan deskripsi';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(labelText: 'Kategori'),
                items: [
                  'Belanja',
                  'Cicilan',
                  'Hiburan',
                  'Kesehatan',
                  'Makanan dan Minuman',
                  'Pendidikan',
                  'Top Up',
                  'Transportasi'
                ].map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Pilih kategori';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 219, 226, 239),
                  backgroundColor: const Color.fromARGB(
                      255, 63, 114, 175), // Warna teks di dalam tombol
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle: const TextStyle(fontSize: 20, fontFamily: 'Poppins'),
                ),
                child: Text(widget.initialAmount == null
                    ? 'Catat Pengeluaran'
                    : 'Simpan Perubahan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
