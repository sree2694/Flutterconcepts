import 'package:flutter/material.dart';
import 'package:lazy_data_table/lazy_data_table.dart';

class FourHeadersTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Four headers table"),
      ),
      body: LazyDataTable(
        rows: 100,
        columns: 100,
        tableDimensions: LazyDataTableDimensions(
          cellHeight: 50,
          cellWidth: 100,
        ),
        topHeaderBuilder: (i) => Center(child: Text("Column: ${i + 1}")),
        leftHeaderBuilder: (i) => Center(child: Text("Row: ${i + 1}")),
        rightHeaderBuilder: (i) => Center(child: Text("Row: ${i + 1}")),
        bottomHeaderBuilder: (i) => Center(child: Text("Column: ${i + 1}")),
        dataCellBuilder: (i, j) => Center(child: Text("Cell: $i, $j")),
        topLeftCornerWidget: Center(child: Text("Top left Corner")),
        topRightCornerWidget: Center(child: Text("Top right Corner")),
        bottomLeftCornerWidget: Center(child: Text("Bottom left Corner")),
        bottomRightCornerWidget: Center(child: Text("Bottom right Corner")),
      ),
    );
  }
}
