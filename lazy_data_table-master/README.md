# lazy_data_table

A Flutter widget data table that can be loaded lazily. The table also has a column header row and a row header column that will stay in view.
(This widget is still in development, and may not work 100%)

This widget is based on [table-sticky-headers](https://pub.dev/packages/table_sticky_headers) made by Alex Bacich, so credits to him.

## Features

* Scrollable when items overflow
* Column and row headers stay in view
* Items are loaded lazily
* Custom size for individual columns or rows.
* Themable

![img not loaded](https://gitlab.com/_Naomi/lazy_data_table/-/raw/master/example/lazy_data_table_example.gif "lazy_data_table example")

## Usage

To use this widget, add `lazy_data_table: ^0.3.1` to your dependencies in `pubspec.yaml`

```yaml
dependencies:
  lazy_data_table: ^0.3.1
```

Then the package can be included in a file with:

```dart
import 'package:lazy_data_table/lazy_data_table.dart';
```

And then the LazyDataTable can be used as following:  
(This example is used to create the table in the gif above)

```dart
LazyDataTable(
  rows: 100,
  columns: 100,
  tableDimensions: LazyDataTableDimensions(
    cellHeight: 50,
    cellWidth: 100,
    topHeaderHeight: 50,
    leftHeaderWidth: 75,
  ),
  topHeaderBuilder: (i) => Center(child: Text("Column: ${i + 1}")),
  leftHeaderBuilder: (i) => Center(child: Text("Row: ${i + 1}")),
  dataCellBuilder: (i, j) => Center(child: Text("Cell: $i, $j")),
  topLeftCornerWidget: Center(child: Text("Corner")),
)
```

## Issues
If you have any problems or even suggestions feel free leave them [here](https://gitlab.com/_Naomi/lazy_data_table/-/issues)
