abstract class SetTableState {}

final class SetTableInitial extends SetTableState {}
final class SetTableSuccessState extends SetTableState {
  String? tableName;
  SetTableSuccessState(this.tableName);
}
final class SetTableFailureState extends SetTableState {}
