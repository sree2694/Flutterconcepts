import 'package:flutter/material.dart';
import 'package:lazy_data_table/lazy_data_table.dart';

class CustomSizeTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Custom row and column sizes table"),
      ),
      body: LazyDataTable(
        rows: 100,
        columns: 100,
        tableDimensions: LazyDataTableDimensions(
          customCellHeight: {1: 100, 4: 75},
          customCellWidth: {3: 200},
        ),
        topHeaderBuilder: (i) => SizedBox.shrink(),
        leftHeaderBuilder: (i) => SizedBox.shrink(),
        dataCellBuilder: (i, j) => SizedBox.shrink(),
        topLeftCornerWidget: SizedBox.shrink(),
      ),
    );
  }
}
