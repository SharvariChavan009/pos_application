import 'package:flutter/material.dart';
import 'package:pos_application/features/home/presentation/home_components/tables_list/tables_list.dart';

class TablesList extends StatefulWidget {
  final TabController tabController;
  const TablesList({required this.tabController, super.key});

  @override
  State<TablesList> createState() => _TablesListState();
}

class _TablesListState extends State<TablesList> {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: widget.tabController,
      children: const [
        MainBodyTable(),
      ],
    );
  }
}
