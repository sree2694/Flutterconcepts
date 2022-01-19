import 'package:datatable_editable_example/data/users.dart';
import 'package:datatable_editable_example/model/user.dart';
import 'package:datatable_editable_example/utils.dart';
import 'package:datatable_editable_example/widget/scrollable_widget.dart';
import 'package:datatable_editable_example/widget/text_dialog_widget.dart';
import 'package:flutter/material.dart';

class EditablePage extends StatefulWidget {
  @override
  _EditablePageState createState() => _EditablePageState();
}

class _EditablePageState extends State<EditablePage> {
  late List<User> users;

  @override
  void initState() {
    super.initState();

    this.users = List.of(allUsers);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: ScrollableWidget(child: buildDataTable()),
      );

  Widget buildDataTable() {
    final columns = ['Invoice Number', 'Frequency', 'Hours'];

    return DataTable(
      columns: getColumns(columns),
      rows: getRows(users),
    );
  }

  List<DataColumn> getColumns(List<String> columns) {
    return columns.map((String column) {
      final isAge = column == columns[2];

      return DataColumn(
        label: Text(column),
        numeric: isAge,
      );
    }).toList();
  }

  List<DataRow> getRows(List<User> users) => users.map((User user) {
        final cells = [user.invoiceNumber, user.frequency, user.hours];

        return DataRow(
          cells: Utils.modelBuilder(cells, (index, cell) {
            final showEditIcon = index == 0 || index == 1;

            return DataCell(
              Text('$cell'),
              showEditIcon: showEditIcon,
              onTap: () {
                switch (index) {
                  case 0:
                    editInvoiceNumber(user);
                    break;
                  case 1:
                    editFrequency(user);
                    break;
                  case 2:
                    editHours(user);
                    break;
                }
              },
            );
          }),
        );
      }).toList();

  Future editInvoiceNumber(User editUser) async {
    final invoiceNumber = await showTextDialog(
      context,
      title: 'Change Invoice Number',
      value: editUser.invoiceNumber,
    );

    setState(() => users = users.map((user) {
          final isEditedUser = user == editUser;

          return isEditedUser ? user.copy(invoiceNumber: invoiceNumber) : user;
        }).toList());
  }

  Future editFrequency(User editUser) async {
    final frequency = await showTextDialog(
      context,
      title: 'Change frequency',
      value: editUser.frequency,
    );

    setState(() => users = users.map((user) {
          final isEditedUser = user == editUser;

          return isEditedUser ? user.copy(frequency: frequency) : user;
        }).toList());
  }
  Future editHours(User editUser) async {
    final hours = await showTextDialog(
      context,
      title: 'Change Hours',
      value: editUser.hours.toString(),
    );

    setState(() => users = users.map((user) {
      final isEditedUser = user == editUser;

      return isEditedUser ? user.copy(hours: hours) : user;
    }).toList());
  }
}
