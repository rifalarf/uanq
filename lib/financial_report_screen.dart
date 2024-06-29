import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'income_provider.dart';

class FinancialReportScreen extends StatelessWidget {
  const FinancialReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final incomeProvider = Provider.of<IncomeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Laporan Keuangan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SfDataGrid(
              source: FinancialReportDataSource(incomeProvider),
              columnWidthMode: ColumnWidthMode.fill,
              rowHeight: 70, // Tinggi baris default
              columns: <GridColumn>[
                GridColumn(
                  columnName: 'type',
                  label: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: const Text(
                      'Jenis',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'description',
                  label: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: const Text(
                      'Deskripsi',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'amount',
                  label: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: const Text(
                      'Jumlah',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'category',
                  label: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: const Text(
                      'Kategori',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
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
      }),
      ...incomeProvider.expenseList.map((expense) {
        return FinancialData(
          type: 'Pengeluaran',
          description: expense['description'],
          amount: incomeProvider.formatCurrency(expense['amount']),
          category: expense['category'],
        );
      }),
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
      if (dataGridCell.columnName == 'type') {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            dataGridCell.value == 'Pemasukan'
                ? Icons.arrow_downward
                : Icons.arrow_upward,
            color:
                dataGridCell.value == 'Pemasukan' ? Colors.green : Colors.red,
          ),
        );
      } else {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: Text(
            dataGridCell.value.toString(),
            style: const TextStyle(fontSize: 14), // Ukuran font kecil
            softWrap: true,
            overflow: TextOverflow.visible, // Membungkus teks
            maxLines: null, // Tidak ada batasan jumlah baris
          ),
        );
      }
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
