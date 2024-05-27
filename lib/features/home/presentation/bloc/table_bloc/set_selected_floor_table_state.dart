abstract class SetSelectedFloorTableState {}

final class SetSelectedFloorTableInitial extends SetSelectedFloorTableState {}

final class SetSelectedFloorTableSuccess extends SetSelectedFloorTableState {
   String? floorTable;

   SetSelectedFloorTableSuccess(this.floorTable);
}

final class SetSelectedFloorTableFailure extends SetSelectedFloorTableState{}