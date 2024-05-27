import '../../data/floor_tables.dart';

abstract class FloorTableEvent{}

class FloorTableButtonPressed extends FloorTableEvent{

  FloorTableButtonPressed();
}
class FloorTableAddButtonPressed extends FloorTableEvent{
  final String floorName;
  final int minCapacity;
  final int maxCapacity;
  final int extraCapacity;
  final String floor;

  FloorTableAddButtonPressed({required this.floorName, required this.minCapacity, required this.maxCapacity, required this.extraCapacity, required this.floor});
}


class FloorTableSortEvent extends FloorTableEvent{
  List<FloorTable>? floorTableList;
  String? sortBy;
  FloorTableSortEvent(this.floorTableList,this.sortBy);
}