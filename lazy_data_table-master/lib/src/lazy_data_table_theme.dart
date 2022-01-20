import 'package:flutter/material.dart';

/// Data class for the theme of a [LazyDataTable].
class LazyDataTableTheme {
  const LazyDataTableTheme({
    this.columnHeaderBorder =
        const Border.fromBorderSide(BorderSide(color: Colors.black)),
    this.columnHeaderColor = Colors.lightBlue,
    this.alternateColumnHeaderBorder =
        const Border.fromBorderSide(BorderSide(color: Colors.black)),
    this.alternateColumnHeaderColor = Colors.lightBlue,
    this.rowHeaderBorder =
        const Border.fromBorderSide(BorderSide(color: Colors.black)),
    this.rowHeaderColor = Colors.lightBlue,
    this.alternateRowHeaderBorder =
        const Border.fromBorderSide(BorderSide(color: Colors.black)),
    this.alternateRowHeaderColor = Colors.lightBlue,
    this.cellBorder =
        const Border.fromBorderSide(BorderSide(color: Colors.black)),
    this.cellColor = Colors.white,
    this.alternateCellBorder =
        const Border.fromBorderSide(BorderSide(color: Colors.black)),
    this.alternateCellColor = const Color(0xFFF5F5F5),
    this.cornerBorder =
        const Border.fromBorderSide(BorderSide(color: Colors.black)),
    this.cornerColor = Colors.blue,
    this.alternateRow = true,
    this.alternateColumn = false,
  });

  /// [BoxBorder] for the column header.
  final BoxBorder columnHeaderBorder;

  /// [Color] for the column header.
  final Color columnHeaderColor;

  /// A [BoxDecoration] containing the column header border and color.
  BoxDecoration get columnHeader =>
      BoxDecoration(border: columnHeaderBorder, color: columnHeaderColor);

  /// [BoxBorder] for the alternate column header.
  final BoxBorder alternateColumnHeaderBorder;

  /// [Color] for the alternate column header.
  final Color alternateColumnHeaderColor;

  /// A [BoxDecoration] containing the column header border and color.
  BoxDecoration get alternateColumnHeader => BoxDecoration(
      border: alternateColumnHeaderBorder, color: alternateColumnHeaderColor);

  /// [BoxBorder] for the row header.
  final BoxBorder rowHeaderBorder;

  /// [Color] for the row header.
  final Color rowHeaderColor;

  /// A [BoxDecoration] containing the row header border and color.
  BoxDecoration get rowHeader =>
      BoxDecoration(border: rowHeaderBorder, color: rowHeaderColor);

  /// [BoxBorder] for the alternate row header.
  final BoxBorder alternateRowHeaderBorder;

  /// [Color] for the alternate row header.
  final Color alternateRowHeaderColor;

  /// A [BoxDecoration] containing the row header border and color.
  BoxDecoration get alternateRowHeader => BoxDecoration(
      border: alternateRowHeaderBorder, color: alternateRowHeaderColor);

  /// [BoxBorder] for the cell.
  final BoxBorder cellBorder;

  /// [Color] for the cell.
  final Color cellColor;

  /// A [BoxDecoration] containing the cell border and color.
  BoxDecoration get cell => BoxDecoration(border: cellBorder, color: cellColor);

  /// [BoxBorder] for the alternate cell.
  final BoxBorder alternateCellBorder;

  /// [Color] for the alternate cell.
  final Color alternateCellColor;

  /// A [BoxDecoration] containing the alternate cell border and color.
  BoxDecoration get alternateCell =>
      BoxDecoration(border: alternateCellBorder, color: alternateCellColor);

  /// [BoxBorder] for the corner widget.
  final BoxBorder cornerBorder;

  /// [Color] for the corner widget.
  final Color cornerColor;

  /// A [BoxDecoration] containing the corner border and color.
  BoxDecoration get corner =>
      BoxDecoration(border: cornerBorder, color: cornerColor);

  /// Whether or not even rows should have an alternate theme.
  final bool alternateRow;

  /// Whether or not even columns should have an alternate theme.
  final bool alternateColumn;
}
