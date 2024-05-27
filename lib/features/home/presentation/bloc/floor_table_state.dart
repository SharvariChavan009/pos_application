import 'package:pos_application/features/home/data/floor_tables.dart';

abstract class FloorTableState{}

class FloorTableStateInitial extends FloorTableState{}
class FloorTableStateSuccess extends FloorTableState{
  final List<FloorTable> floors;

  FloorTableStateSuccess(this.floors);
}
class FloorTableStateFailure extends FloorTableState{}
class AddFloorTableState extends FloorTableState{}


class FloorTableSortInitialState extends FloorTableState{}
class FloorTableSortSuccess extends FloorTableState{
  final List<FloorTable> floors;

  FloorTableSortSuccess(this.floors);
}
class FloorTableSortFailure extends FloorTableState{}

