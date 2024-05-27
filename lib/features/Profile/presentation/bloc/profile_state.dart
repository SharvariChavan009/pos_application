import 'package:pos_application/features/Profile/data/user_data.dart';

abstract class ProfileState{}

class ProfileStateInitial extends ProfileState{}
class ProfileStateLoading extends ProfileState{}
class ProfileStateSuccess extends ProfileState{
  final UserDataResponse user;
   ProfileStateSuccess({required this.user});
}
class ProfileStateFailure extends ProfileState{}