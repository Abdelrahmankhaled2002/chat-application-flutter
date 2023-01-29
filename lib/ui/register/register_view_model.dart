import 'package:chat/base.dart';
import 'package:chat/database/database_utils.dart';
import 'package:chat/firebase_errors.dart';
import 'package:chat/model/my_user.dart';
import 'package:chat/ui/register/register_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
class RegisterViewModel extends BaseViewModel<RegisterNavigator>{

  FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  void register(String email, String password,String firstName,String lastName,String userName)async{
    String? message;

    try {
      navigator?.showLoading();
      var result =await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      print('firebase user id=${result.user?.uid}');
      var user=MyUser(id: result.user?.uid??"", fName: firstName , lName: lastName, userName: userName, email: email);
      var task = await DatabaseUtils.creatDatabaseUser(user);
      //connector.hideLoading();
      navigator?.goToHome(user);
      return;
    }
    on FirebaseAuthException catch (e) {
      if (e.code == FirebaseErrors.weakPassword) {
        message='The password provided is too weak.';
        print('The password provided is too weak.');
      } else if (e.code == FirebaseErrors.email_in_use) {
        message='The account already exists for that email.';
        print('The account already exists for that email.');
      }
    } catch (e) {
      message='something went wrong.';
      print(e);
    }
    navigator?.hideDialog();
    if (message!=null){
      navigator?.showMessage(message);
    }  
  }
}