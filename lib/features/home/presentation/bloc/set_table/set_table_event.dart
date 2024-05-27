abstract class SetTableEvent {}

final class TableSetPressedEvent extends SetTableEvent{
  int? floorTableId;
  TableSetPressedEvent(this.floorTableId);
}