abstract class MenuSettingEvent {}

final class MenuSettingPressed extends MenuSettingEvent{
  int? menuId;
  MenuSettingPressed(this.menuId);
}
