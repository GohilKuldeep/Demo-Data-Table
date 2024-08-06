import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:untitled/widget/customDataTable.dart';

class DataTableScreen extends StatefulWidget {
  const DataTableScreen({super.key});

  @override
  State<DataTableScreen> createState() => _DataTableScreenState();
}

class _DataTableScreenState extends State<DataTableScreen> {
  final ScrollController _firstTableScrollController = ScrollController();
  final ScrollController _thirdTableScrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _firstTableScrollController.addListener(() {
      if (_firstTableScrollController.hasClients) {
        _syncScrollController(
          _firstTableScrollController,
          _thirdTableScrollController,
        );
      }
    });

    _thirdTableScrollController.addListener(() {
      if (_thirdTableScrollController.hasClients) {
        _syncScrollController(
          _thirdTableScrollController,
          _firstTableScrollController,
        );
      }
    });
  }

  void _syncScrollController(ScrollController source, ScrollController target) {
    if (source.hasClients && target.hasClients) {
      final sourceOffset = source.offset;
      final targetOffset = target.offset;

      // Sync only if the offsets are different to avoid conflicts
      if ((sourceOffset - targetOffset).abs() > 1) {
        target.jumpTo(sourceOffset);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        color: Colors.white
      ),
      width: MediaQuery.sizeOf(context).width,
      child: SingleChildScrollView(
        child: Row(
          children: [
            // First Table
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: _firstTableScrollController,
                reverse: true,
                child: CustomDataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text(
                        "Name",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Age",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Email",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                  rows: List.generate(
                    20,
                        (int index) => DataRow(cells: <DataCell>[
                      DataCell(Text("Name $index")),
                      DataCell(Text("${20 + index}")),
                      DataCell(Text("test$index@gmail.com")),
                    ]),
                  ),
                ),
              ),
            ),

            // Second Table
            Expanded(
              child: CustomDataTable(
                dataRowColor: MaterialStateColor.resolveWith((states) => Colors.grey.withOpacity(0.3)),
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      "Item",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Price",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                rows: List.generate(
                  20,
                      (int index) => DataRow(cells: <DataCell>[
                    DataCell(Center(child: Text("$index"))),
                    DataCell(Text("\$${(index + 1) * 10}")),
                  ]),
                ),
              ),
            ),

            // Third Table
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: _thirdTableScrollController,
                child: CustomDataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text(
                        "Order ID",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Date",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Amount",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                  rows: List.generate(
                    20,
                        (int index) => DataRow(cells: <DataCell>[
                      DataCell(Text("ORD${1000 + index}")),
                      DataCell(Text("2024-08-${index + 1}")),
                      DataCell(Text("\$${(index + 1) * 25}")),
                    ]),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    _firstTableScrollController.dispose();
    _thirdTableScrollController.dispose();
    super.dispose();
  }
}
