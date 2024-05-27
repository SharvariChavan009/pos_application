abstract class SetSelectedFloorTableEvent {
}


final class setSelectedFloorPressed extends SetSelectedFloorTableEvent{
 final String? floorName;
  setSelectedFloorPressed(this.floorName);
}