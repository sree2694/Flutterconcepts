/// Data class for the dimensions of a [LazyDataTable].
class LazyDataTableDimensions {
  const LazyDataTableDimensions({
    this.cellHeight = 50,
    this.cellWidth = 50,
    this.topHeaderHeight = 50,
    this.leftHeaderWidth = 50,
    this.rightHeaderWidth = 50,
    this.bottomHeaderHeight = 50,
    this.customCellHeight = const {},
    this.customCellWidth = const {},
  });

  /// Height of a cell and row header.
  final double cellHeight;

  /// Width of a cell and column header.
  final double cellWidth;

  /// Height of a top header.
  final double topHeaderHeight;

  /// Width of a left header.
  final double leftHeaderWidth;

  /// Width of a right header.
  final double rightHeaderWidth;

  /// Height of a bottom header.
  final double bottomHeaderHeight;

  /// Map with the custom height for a certain rows.
  final Map<int, double> customCellHeight;

  /// Map with the custom width for certain columns.
  final Map<int, double> customCellWidth;
}
