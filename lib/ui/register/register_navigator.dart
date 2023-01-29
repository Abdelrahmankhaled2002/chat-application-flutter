import 'package:chat/base.dart';
import 'package:chat/model/my_user.dart';

abstract class RegisterNavigator extends BaseNavigator{
  void goToHome(MyUser myUser);
}