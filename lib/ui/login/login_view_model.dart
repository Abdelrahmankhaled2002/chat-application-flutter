import 'package:chat/base.dart';
import 'package:chat/database/database_utils.dart';
import 'package:chat/ui/login/login_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginViewModel extends BaseViewModel<LoginNavigator>{
  FirebaseAuth firebaseAuth=FirebaseAuth.instance;

  void login(String email, String password)async{
    String? message;
    try {
      navigator?.showLoading(isDismissable: false);
      var result =await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      print(result.user?.email);
      //connector.hideLoading();
      var userObj=await DatabaseUtils.readUser(result.user?.uid ?? "");
      if(userObj==null){
        message='Faild to complete sign in ,please try to register again ';
      }
      else{
        navigator?.goToHome(userObj);
      }
    }
    on FirebaseAuthException catch (e) {
      message='wring Email or Password';
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