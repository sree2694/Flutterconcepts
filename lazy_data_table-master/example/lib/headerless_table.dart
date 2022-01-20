import 'package:flutter/material.dart';
import 'package:lazy_data_table/lazy_data_table.dart';

class HeaderlessTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Header-less table"),
      ),
      body: LazyDataTable(
        rows: 100,
        columns: 100,
        tableDimensions: LazyDataTableDimensions(
          cellHeight: 50,
          cellWidth: 100,
        ),
        dataCellBuilder: (i, j) => Center(child: Text("Cell: $i, $j")),
      ),
    );
  }
}
