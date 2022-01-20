import 'package:flutter/material.dart';
import 'package:lazy_data_table/lazy_data_table.dart';

class SimpleTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple table"),
      ),
      body: LazyDataTable(
        rows: 31,
        columns: 5,
        tableDimensions: LazyDataTableDimensions(
          cellHeight: 50,
          cellWidth: 100,
          topHeaderHeight: 50,
          leftHeaderWidth: 100,
        ),
        topHeaderBuilder: (i) => Center(child: Scaffold(body:Center(child: Text("Column: ${i + 1}",style: TextStyle(fontWeight: FontWeight.bold))) )),
        leftHeaderBuilder: (i) => Center(child: Text("2022-Jan- ${i + 1}")),
        dataCellBuilder: (i, j) => Center(child: Text("Cell: $i, $j")),
        topLeftCornerWidget: Center(child: Text("DATA SHEET")),
      ),
    );
  }
}
