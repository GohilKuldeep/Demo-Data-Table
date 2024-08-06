import 'package:flutter/material.dart';

// Reusable DataTable Widget
class CustomDataTable extends StatelessWidget {
  final List<DataColumn> columns;
  final List<DataRow> rows;
  final BorderSide borderSide;
  final WidgetStateProperty<Color?>? dataRowColor;

  const CustomDataTable({
    Key? key,
    required this.columns,
    required this.rows,
    this.dataRowColor,
    this.borderSide = const BorderSide(
      color: Colors.blue, // Change this to the desired border color
      width: 1.0, // Change this to the desired border width
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataTable(
      dataRowColor: dataRowColor,
      headingRowColor:
      MaterialStateColor.resolveWith((states) => Colors.blueGrey.withOpacity(0.4)),
      columnSpacing: 22,
      horizontalMargin: 22,
      columns: columns,
      rows: rows,
    );
  }
}