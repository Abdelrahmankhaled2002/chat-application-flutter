
import 'package:flutter/material.dart';

class BaseViewModel<N extends BaseNavigator> extends ChangeNotifier{

  N ? navigator=null;

}

abstract class BaseNavigator{
void showMessage(String message,{String? actionName , VoidCallback? action});
void showLoading({String message,bool isDismissable});
void hideDialog();

}

abstract class BaseState <T extends StatefulWidget ,VM extends BaseViewModel>
    extends State<T>implements BaseNavigator {
  late VM viewModel;

  VM initViewModel();

  @override
  void initState() {
    super.initState();
    viewModel = initViewModel();
  }

  @override
  void hideDialog() {
    //to hide dialog we should pop until we got the current screen
    Navigator.popUntil(context, (route) => route.isCurrent);
  }

  @override
  void showLoading({String message = 'Loading', bool isDismissable = true}) {
    showDialog(context: context, builder: (_) =>
        AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 8),
              Text(message)
            ],
          ),
        ),
        barrierDismissible: isDismissable
    );
  }

  void showMessage(String message,{String? actionName , VoidCallback? action}) {
    List<Widget>actions = [];
    if(actionName!=null){
      actions.add(
          TextButton(onPressed: action, child: Text(actionName)));
    }
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          actions: actions,
          content: Row(
            children: [Expanded(child: Text(message))],
          ),
        ));
  }
}