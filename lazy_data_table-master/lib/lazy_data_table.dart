library lazy_data_table;

export 'src/lazy_data_table_dimensions.dart';
export 'src/lazy_data_table_theme.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/scheduler.dart';

import 'src/lazy_data_table_dimensions.dart';
import 'src/lazy_data_table_theme.dart';

/// Create a lazily loaded data table.
///
/// The table is [columns] by [rows] big.
/// The [topHeaderBuilder], [leftHeaderBuilder], [rightHeaderBuiler] and [bottomHeaderBuilder] are optional,
/// and the corner widget should only be given if the two headers next to that corner are given.
class LazyDataTable extends StatefulWidget {
  LazyDataTable({
    Key? key,
    // Number of data columns.
    required this.columns,

    // Number of data rows.
    required this.rows,

    // Dimensions of the table elements.
    this.tableDimensions = const LazyDataTableDimensions(),

    // Theme of the table elements.
    this.tableTheme = const LazyDataTableTheme(),

    // Builder function for the top header.
    this.topHeaderBuilder,

    // Builder function for the left header.
    this.leftHeaderBuilder,

    // Builder function for the right header.
    this.rightHeaderBuilder,

    // Builder function for the bottom header.
    this.bottomHeaderBuilder,

    // Builder function for the data cell.
    required this.dataCellBuilder,

    // Top left corner widget.
    this.topLeftCornerWidget,

    // Top right corner widget.
    this.topRightCornerWidget,

    // Bottom left corner widget.
    this.bottomLeftCornerWidget,

    // Bottom right corner widget.
    this.bottomRightCornerWidget,
  }) : super(key: key) {
    // Check for top left corner
    if (topHeaderBuilder == null || leftHeaderBuilder == null) {
      assert(topLeftCornerWidget == null,
          "The top left corner widget is only allowed when you have both the top header and the left header.");
    }
    // Check for top right corner
    if (topHeaderBuilder == null || rightHeaderBuilder == null) {
      assert(topRightCornerWidget == null,
          "The top right corner widget is only allowed when you have both the top header and the right header.");
    }
    // Check for bottom left corner
    if (bottomHeaderBuilder == null || leftHeaderBuilder == null) {
      assert(bottomLeftCornerWidget == null,
          "The bottom left corner widget is only allowed when you have both the bottom header and the left header.");
    }
    // Check for bottom right corner
    if (bottomHeaderBuilder == null || rightHeaderBuilder == null) {
      assert(bottomRightCornerWidget == null,
          "The bottom right corner widget is only allowed when you have both the bottom header and the right header.");
    }
  }

  /// The state class that contains the table.
  final table = _LazyDataTableState();

  // Amount of cells
  /// The number of columns in the table.
  final int columns;

  /// The number of rows in the table.
  final int rows;

  // Size of cells and headers
  /// The dimensions of the table cells and headers.
  final LazyDataTableDimensions tableDimensions;

  // Theme of the table
  /// The theme of the table cells and headers.
  final LazyDataTableTheme tableTheme;

  // Builder functions
  /// The builder function for a top header.
  final Widget Function(int columnIndex)? topHeaderBuilder;

  /// The builder function for a left header.
  final Widget Function(int rowIndex)? leftHeaderBuilder;

  /// The builder function for a right header.
  final Widget Function(int rowIndex)? rightHeaderBuilder;

  /// The builder function for a bottom header.
  final Widget Function(int columnIndex)? bottomHeaderBuilder;

  /// The builder function for a data cell.
  final Widget Function(int rowIndex, int columnIndex) dataCellBuilder;

  /// The widget for the top left corner.
  final Widget? topLeftCornerWidget;

  /// The widget for the top right corner.
  final Widget? topRightCornerWidget;

  /// The widget for the bottom left corner.
  final Widget? bottomLeftCornerWidget;

  /// The widget for the bottom right corner.
  final Widget? bottomRightCornerWidget;

  @override
  _LazyDataTableState createState() => table;

  /// Jump the table to the given cell.
  void jumpToCell(int column, int row) {
    table.jumpToCell(column, row);
  }

  /// Jump the table to the given location.
  void jumpTo(double x, double y) {
    table.jumpTo(x, y);
  }
}

class _LazyDataTableState extends State<LazyDataTable>
    with TickerProviderStateMixin {
  _CustomScrollController? _horizontalControllers;
  _CustomScrollController? _verticalControllers;

  @override
  void initState() {
    super.initState();

    _horizontalControllers = _CustomScrollController(this);
    _verticalControllers = _CustomScrollController(this);
  }

  @override
  void dispose() {
    _horizontalControllers!.dispose();
    _verticalControllers!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: (pointerSignal) {
        if (pointerSignal is PointerScrollEvent) {
          jump(pointerSignal.scrollDelta.dx, pointerSignal.scrollDelta.dy);
        }
      },
      child: GestureDetector(
        onPanUpdate: (DragUpdateDetails details) {
          jump(-details.delta.dx, -details.delta.dy);
        },
        onPanEnd: (DragEndDetails details) {
          _verticalControllers!
              .setVelocity(-details.velocity.pixelsPerSecond.dy / 100);
          _horizontalControllers!
              .setVelocity(-details.velocity.pixelsPerSecond.dx / 100);
        },

        /// main container
        child: Row(
          children: <Widget>[
            // Left header
            widget.leftHeaderBuilder != null
                ? SizedBox(
                    width: widget.tableDimensions.leftHeaderWidth,
                    child: Column(
                      children: <Widget>[
                        // Top left corner widget
                        widget.topLeftCornerWidget != null
                            ? SizedBox(
                                height: widget.tableDimensions.topHeaderHeight,
                                width: widget.tableDimensions.leftHeaderWidth,
                                child: Container(
                                  decoration: widget.tableTheme.corner,
                                  child: widget.topLeftCornerWidget,
                                ),
                              )
                            : Container(),
                        // Row headers
                        Expanded(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              controller: _verticalControllers,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: widget.rows,
                              itemBuilder: (__, i) {
                                return Container(
                                  height: widget
                                          .tableDimensions.customCellHeight
                                          .containsKey(i)
                                      ? widget
                                          .tableDimensions.customCellHeight[i]
                                      : widget.tableDimensions.cellHeight,
                                  width: widget.tableDimensions.leftHeaderWidth,
                                  decoration: (widget.tableTheme.alternateRow &&
                                          i % 2 != 0)
                                      ? widget.tableTheme.alternateRowHeader
                                      : widget.tableTheme.rowHeader,
                                  child: widget.leftHeaderBuilder!(i),
                                );
                              }),
                        ),
                        // Bottom left corner widget
                        widget.bottomLeftCornerWidget != null
                            ? SizedBox(
                                height:
                                    widget.tableDimensions.bottomHeaderHeight,
                                width: widget.tableDimensions.leftHeaderWidth,
                                child: Container(
                                  decoration: widget.tableTheme.corner,
                                  child: widget.bottomLeftCornerWidget,
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  )
                : Container(),
            Expanded(
              child: Column(
                children: <Widget>[
                  // Top headers
                  widget.topHeaderBuilder != null
                      ? SizedBox(
                          height: widget.tableDimensions.topHeaderHeight,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              controller: _horizontalControllers,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: widget.columns,
                              itemBuilder: (__, i) {
                                return Container(
                                  height:
                                      widget.tableDimensions.topHeaderHeight,
                                  width: widget.tableDimensions.customCellWidth
                                          .containsKey(i)
                                      ? widget
                                          .tableDimensions.customCellWidth[i]
                                      : widget.tableDimensions.cellWidth,
                                  decoration: (widget
                                              .tableTheme.alternateColumn &&
                                          i % 2 != 0)
                                      ? widget.tableTheme.alternateColumnHeader
                                      : widget.tableTheme.columnHeader,
                                  child: widget.topHeaderBuilder!(i),
                                );
                              }),
                        )
                      : Container(),
                  // Main data
                  Expanded(
                    // List of rows
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        controller: _verticalControllers,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: widget.rows,
                        itemBuilder: (_, i) {
                          // Single row
                          return SizedBox(
                            height: widget.tableDimensions.customCellHeight
                                    .containsKey(i)
                                ? widget.tableDimensions.customCellHeight[i]
                                : widget.tableDimensions.cellHeight,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                controller: _horizontalControllers,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: widget.columns,
                                itemBuilder: (__, j) {
                                  return Container(
                                    height: widget
                                            .tableDimensions.customCellHeight
                                            .containsKey(i)
                                        ? widget
                                            .tableDimensions.customCellHeight[i]
                                        : widget.tableDimensions.cellHeight,
                                    width: widget
                                            .tableDimensions.customCellWidth
                                            .containsKey(j)
                                        ? widget
                                            .tableDimensions.customCellWidth[j]
                                        : widget.tableDimensions.cellWidth,
                                    decoration:
                                        (widget.tableTheme.alternateRow &&
                                                    i % 2 != 0) ||
                                                (widget.tableTheme
                                                        .alternateColumn &&
                                                    j % 2 != 0)
                                            ? widget.tableTheme.alternateCell
                                            : widget.tableTheme.cell,
                                    child: widget.dataCellBuilder(i, j),
                                  );
                                }),
                          );
                        }),
                  ),
                  // Bottom header
                  widget.bottomHeaderBuilder != null
                      ? SizedBox(
                          height: widget.tableDimensions.bottomHeaderHeight,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              controller: _horizontalControllers,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: widget.columns,
                              itemBuilder: (__, i) {
                                return Container(
                                  height:
                                      widget.tableDimensions.bottomHeaderHeight,
                                  width: widget.tableDimensions.customCellWidth
                                          .containsKey(i)
                                      ? widget
                                          .tableDimensions.customCellWidth[i]
                                      : widget.tableDimensions.cellWidth,
                                  decoration: (widget
                                              .tableTheme.alternateColumn &&
                                          i % 2 != 0)
                                      ? widget.tableTheme.alternateColumnHeader
                                      : widget.tableTheme.columnHeader,
                                  child: widget.bottomHeaderBuilder!(i),
                                );
                              }),
                        )
                      : Container(),
                ],
              ),
            ),
            // Right header
            widget.rightHeaderBuilder != null
                ? SizedBox(
                    width: widget.tableDimensions.rightHeaderWidth,
                    child: Column(
                      children: [
                        // Top left corner
                        widget.topRightCornerWidget != null
                            ? SizedBox(
                                height: widget.tableDimensions.topHeaderHeight,
                                width: widget.tableDimensions.rightHeaderWidth,
                                child: Container(
                                  decoration: widget.tableTheme.corner,
                                  child: widget.topRightCornerWidget,
                                ),
                              )
                            : Container(),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            controller: _verticalControllers,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: widget.rows,
                            itemBuilder: (__, i) {
                              return Container(
                                height: widget.tableDimensions.customCellHeight
                                        .containsKey(i)
                                    ? widget.tableDimensions.customCellHeight[i]
                                    : widget.tableDimensions.cellHeight,
                                width: widget.tableDimensions.rightHeaderWidth,
                                decoration: (widget.tableTheme.alternateRow &&
                                        i % 2 != 0)
                                    ? widget.tableTheme.alternateRowHeader
                                    : widget.tableTheme.rowHeader,
                                child: widget.rightHeaderBuilder!(i),
                              );
                            },
                          ),
                        ),
                        // Bottom right corner widget
                        widget.bottomRightCornerWidget != null
                            ? SizedBox(
                                height:
                                    widget.tableDimensions.bottomHeaderHeight,
                                width: widget.tableDimensions.rightHeaderWidth,
                                child: Container(
                                  decoration: widget.tableTheme.corner,
                                  child: widget.bottomRightCornerWidget,
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  /// Jump the table to the given cell.
  void jumpToCell(int column, int row) {
    double customWidth = 0;
    int customWidthCells = 0;
    for (int i = 0; i < column; i++) {
      if (widget.tableDimensions.customCellWidth.containsKey(i)) {
        customWidth += widget.tableDimensions.customCellWidth[i]!;
        customWidthCells++;
      }
    }
    _horizontalControllers!.jumpTo(
        (column - customWidthCells) * widget.tableDimensions.cellWidth +
            customWidth);

    double customHeight = 0;
    int customHeightCells = 0;
    for (int i = 0; i < column; i++) {
      if (widget.tableDimensions.customCellHeight.containsKey(i)) {
        customHeight += widget.tableDimensions.customCellHeight[i]!;
        customHeightCells++;
      }
    }
    _verticalControllers!.jumpTo(
        (row - customHeightCells) * widget.tableDimensions.cellHeight +
            customHeight);
  }

  /// Jump the table to the given location.
  void jumpTo(double x, double y) {
    _horizontalControllers!.jumpTo(x);
    _verticalControllers!.jumpTo(y);
  }

  /// Jump to a relative location from the current location.
  void jump(double x, double y) {
    _horizontalControllers!.jump(x);
    _verticalControllers!.jump(y);
  }
}

/// A custom synchronized scroll controller.
///
/// This controller stores all their attached [ScrollPosition] in a list,
/// and when given a notification via [processNotification], it will scroll
/// every ScrollPosition in that list to the same [offset].
class _CustomScrollController extends ScrollController {
  _CustomScrollController(TickerProvider provider) : super() {
    _ticker = provider.createTicker((_) {
      jumpTo(offset + _velocity);
      _velocity *= 0.9;
      if (_velocity < 0.1 && _velocity > -0.1) {
        _ticker.stop();
      }
    });
  }

  /// List of [ScrollPosition].
  List<ScrollPosition> _positions = [];

  /// The offset of the ScrollPositions.
  double offset = 0;

  /// Ticker to calculate the [_velocity].
  late Ticker _ticker;

  /// The velocity of the controller.
  /// The [_ticker] will tick while the velocity
  /// is not between -0.1 and 0.1.
  late double _velocity;

  /// Stores given [ScrollPosition] in the list and
  /// set the initial offset of that ScrollPosition.
  @override
  void attach(ScrollPosition position) {
    position.correctPixels(offset);
    _positions.add(position);
  }

  /// Removes given [ScrollPostion] from the list.
  @override
  void detach(ScrollPosition position) {
    _positions.remove(position);
  }

  /// Processes notification from one of the [ScrollPositions] in the list.
  void processNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      jumpTo(notification.metrics.pixels);
    }
  }

  /// Jumps every item in the list to the given [value],
  /// except the ones that are already at the correct offset.
  @override
  void jumpTo(double value) {
    if (value > _positions[0].maxScrollExtent) {
      offset = _positions[0].maxScrollExtent;
    } else if (value < 0) {
      offset = 0;
    } else {
      offset = value;
    }
    for (ScrollPosition position in _positions) {
      if (position.pixels != offset) {
        position.jumpTo(offset);
      }
    }
  }

  /// Jump to [offset] + [value].
  void jump(double value) {
    jumpTo(offset + value);
  }

  /// Set [_velocity] to new value.
  void setVelocity(double velocity) {
    if (_ticker.isActive) _ticker.stop();
    _velocity = velocity;
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }
}
