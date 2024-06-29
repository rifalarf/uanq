import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'income_provider.dart';

class FinancialReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final incomeProvider = Provider.of<IncomeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Laporan Keuangan'),
        actions: [
          IconButton(
            icon: Icon(Icons.picture_as_pdf),
            onPressed: () async {
              await _exportToPDF(context, incomeProvider);
            },
          ),
          IconButton(
            icon: Icon(Icons.grid_on),
            onPressed: () async {
              await _exportToXLS(context, incomeProvider);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SfDataGrid(
          source: FinancialReportDataSource(incomeProvider),
          columns: <GridColumn>[
            GridColumn(
              columnName: 'type',
              label: Container(
                padding: EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: Text(
                  'Jenis',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            GridColumn(
              columnName: 'description',
              label: Container(
                padding: EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: Text(
                  'Deskripsi',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            GridColumn(
              columnName: 'amount',
              label: Container(
                padding: EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: Text(
                  'Jumlah',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            GridColumn(
              columnName: 'category',
              label: Container(
                padding: EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: Text(
                  'Kategori',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _exportToPDF(
      BuildContext context, IncomeProvider incomeProvider) async {
    final document = PdfDocument();
    final page = document.pages.add();
    final grid = PdfGrid();

    grid.columns.add(count: 4);
    grid.headers.add(1);
    final header = grid.headers[0];
    header.cells[0].value = 'Jenis';
    header.cells[1].value = 'Deskripsi';
    header.cells[2].value = 'Jumlah';
    header.cells[3].value = 'Kategori';

    for (final income in incomeProvider.incomeList) {
      final row = grid.rows.add();
      row.cells[0].value = 'Pemasukan';
      row.cells[1].value = income['description'];
      row.cells[2].value = incomeProvider.formatCurrency(income['amount']);
      row.cells[3].value = income['category'];
    }

    for (final expense in incomeProvider.expenseList) {
      final row = grid.rows.add();
      row.cells[0].value = 'Pengeluaran';
      row.cells[1].value = expense['description'];
      row.cells[2].value = incomeProvider.formatCurrency(expense['amount']);
      row.cells[3].value = expense['category'];
    }

    grid.draw(page: page, bounds: const Rect.fromLTWH(0, 0, 0, 0));

    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/Laporan_Keuangan.pdf';
    final file = File(path);
    await file.writeAsBytes(await document.save());
    document.dispose();

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Laporan keuangan disimpan sebagai PDF di $path')));
  }

  Future<void> _exportToXLS(
      BuildContext context, IncomeProvider incomeProvider) async {
    final excel = Excel.createExcel();
    final sheet = excel['Laporan Keuangan'];

    sheet.appendRow(['Jenis', 'Deskripsi', 'Jumlah', 'Kategori']);

    for (final income in incomeProvider.incomeList) {
      sheet.appendRow([
        'Pemasukan',
        income['description'],
        incomeProvider.formatCurrency(income['amount']),
        income['category']
      ]);
    }

    for (final expense in incomeProvider.expenseList) {
      sheet.appendRow([
        'Pengeluaran',
        expense['description'],
        incomeProvider.formatCurrency(expense['amount']),
        expense['category']
      ]);
    }

    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/Laporan_Keuangan.xlsx';
    final file = File(path);
    await file.writeAsBytes(excel.encode()!);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Laporan keuangan disimpan sebagai XLS di $path')));
  }
}

class FinancialReportDataSource extends DataGridSource {
  FinancialReportDataSource(this.incomeProvider) {
    _financialData = [
      ...incomeProvider.incomeList.map((income) {
        return FinancialData(
          type: 'Pemasukan',
          description: income['description'],
          amount: incomeProvider.formatCurrency(income['amount']),
          category: income['category'],
        );
      }).toList(),
      ...incomeProvider.expenseList.map((expense) {
        return FinancialData(
          type: 'Pengeluaran',
          description: expense['description'],
          amount: incomeProvider.formatCurrency(expense['amount']),
          category: expense['category'],
        );
      }).toList(),
    ];

    buildDataGridRows();
  }

  final IncomeProvider incomeProvider;
  List<FinancialData> _financialData = [];
  List<DataGridRow> _dataGridRows = [];

  void buildDataGridRows() {
    _dataGridRows = _financialData.map<DataGridRow>((data) {
      return DataGridRow(cells: [
        DataGridCell<String>(columnName: 'type', value: data.type),
        DataGridCell<String>(
            columnName: 'description', value: data.description),
        DataGridCell<String>(columnName: 'amount', value: data.amount),
        DataGridCell<String>(columnName: 'category', value: data.category),
      ]);
    }).toList();
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(dataGridCell.value.toString()),
      );
    }).toList());
  }
}

class FinancialData {
  FinancialData({
    required this.type,
    required this.description,
    required this.amount,
    required this.category,
  });

  final String type;
  final String description;
  final String amount;
  final String category;
}
