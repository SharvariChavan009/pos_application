
abstract class MenuNameState {}

 class MenuNameInitial extends MenuNameState {}
class MenuNameLoading extends MenuNameState {}
class MenuNameFetchedSuccess extends MenuNameState {
 final String name;
 MenuNameFetchedSuccess(this.name);
}
class MenuNameFetchedFailure extends MenuNameState {}
