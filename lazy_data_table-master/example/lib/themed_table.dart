import 'package:flutter/material.dart';
import 'package:lazy_data_table/lazy_data_table.dart';

class ThemedTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Themed table"),
      ),
      body: LazyDataTable(
        rows: 100,
        columns: 100,
        tableTheme: LazyDataTableTheme(
            columnHeaderBorder: Border.all(color: Colors.blue),
            columnHeaderColor: Colors.lightBlue,
            alternateColumnHeaderBorder: Border.all(color: Colors.orange),
            alternateColumnHeaderColor: Colors.orangeAccent,
            rowHeaderBorder: Border.all(color: Colors.green),
            rowHeaderColor: Colors.lightGreen,
            alternateRowHeaderBorder: Border.all(color: Colors.purple),
            alternateRowHeaderColor: Colors.purpleAccent,
            cornerBorder: Border.all(color: Colors.black),
            cornerColor: Colors.grey,
            cellBorder: Border.all(color: Colors.red),
            cellColor: Colors.pink,
            alternateCellBorder: Border.all(color: Colors.yellow),
            alternateCellColor: Colors.yellowAccent,
            alternateRow: false,
            alternateColumn: true),
        topHeaderBuilder: (i) => SizedBox.shrink(),
        leftHeaderBuilder: (i) => SizedBox.shrink(),
        dataCellBuilder: (i, j) => SizedBox.shrink(),
        topLeftCornerWidget: SizedBox.shrink(),
      ),
    );
  }
}
