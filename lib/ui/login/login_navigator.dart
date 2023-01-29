import 'package:chat/base.dart';
import 'package:chat/model/my_user.dart';

abstract class LoginNavigator extends BaseNavigator{
  void goToHome(MyUser user);
}