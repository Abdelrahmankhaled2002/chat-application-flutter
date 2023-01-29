import 'package:chat/base.dart';
import 'package:chat/model/category.dart';
import 'package:chat/ui/add_room/add_room_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_room_navigator.dart';

class AddRoomScreen extends StatefulWidget {
  static const String routeName = 'add-room';

  @override
  State<AddRoomScreen> createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends BaseState<AddRoomScreen, AddRoomViewModel>
    implements AddRoomNavigator {
  var categories = Category.getCategories();
  late Category selectedItem;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String title = '', desc = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedItem = categories[0];
    viewModel.navigator = this;
  }

  @override
  AddRoomViewModel initViewModel() => AddRoomViewModel();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Stack(children: [
        Positioned.fill(
            child: Container(
              color: Colors.white,
            )
        ),
        Positioned(
          top: 0,
          right: 0,
          left: 0,
          child: Container(
            width: double.infinity,
            color: Colors.white,
            child: Image.asset(
              'assets/images/background.png',
              width: double.infinity,
              height: 300,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              'Add Room',
            ),
          ),
          body: Container(
            margin: EdgeInsets.all(24),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Create New Room'),
                    Image.asset('assets/images/addroom.png'),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Room Title'),
                      onChanged: (text) {
                        title = text;
                      },
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'please enter room title';
                        }
                        return null;
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButton<Category>(
                              value: selectedItem,
                              items: categories
                                  .map((cat) => DropdownMenuItem<Category>(
                                child: Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Text(cat.title)
                                  ],
                                ),
                                value: cat,
                              ))
                                  .toList(),
                              onChanged: (cat) {
                                if (cat == null) return;
                                setState(() {
                                  selectedItem = cat;
                                });
                              }),
                        )
                      ],
                    ),
                    TextFormField(
                      maxLines: 4,
                      minLines: 4,
                      onChanged: (text) {
                        desc = text;
                      },
                      decoration: InputDecoration(
                        hintText: 'Description',
                      ),
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'please enter room description';
                        }
                        return null;
                      },
                    ),
                    ElevatedButton(
                        onPressed: () {
                          validateForm();
                        },
                        child: Text('Create'))
                  ],
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }

  void validateForm() {
    if (formKey.currentState?.validate() == true) {
      viewModel.createRoom(title, desc, selectedItem.id);
    }
  }

  void roomCreated() {
    showMessage('roome creted successfully',actionName: 'ok',
        action:(){
          hideDialog();
          Navigator.pop(context);
        }
        );
  }
}
