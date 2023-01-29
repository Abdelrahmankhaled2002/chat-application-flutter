import 'package:chat/base.dart';
import 'package:chat/ui/add_room/add_room_screen.dart';
import 'package:chat/ui/home/room_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_navigator.dart';
import 'home_view_model.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen,HomeViewModel> implements
    HomeNavigator{
  @override
  HomeViewModel initViewModel() => HomeViewModel();
  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
    viewModel.getRooms();

  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_)=>viewModel,
        child: Stack(
            children: [
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
                appBar: AppBar(title: Text('Home'),
                  backgroundColor: Colors.transparent,
                  centerTitle: true,
                  elevation: 0,
                ),
                floatingActionButton: FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: (){
                    Navigator.of(context)
                        .pushNamed(AddRoomScreen.routeName);
                  },
                ),
                body: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Expanded(
                          child:Consumer<HomeViewModel>(
                            builder:(buildContext,homeViewModel,child){
                              return GridView.builder(
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 12,
                                  crossAxisSpacing: 12,
                                  childAspectRatio: 1
                                ),
                                itemBuilder: (_,index){
                                return RoomWidget(homeViewModel.rooms[index]);
                              },
                                itemCount: homeViewModel.rooms.length,
                              );
                            } ,
                          ),
                      ),
                    ],
                  ),
                ),
              )
            ]
        )
    );
  }
}