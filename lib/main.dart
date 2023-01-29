import 'package:chat/provider/user_provider.dart';
import 'package:chat/ui/add_room/add_room_screen.dart';
import 'package:chat/ui/chat/chat_screen.dart';
import 'package:chat/ui/home/home_screen.dart';
import 'package:chat/ui/login/login_screen.dart';
import 'package:chat/ui/register/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
      MultiProvider(child:  MyApp(),
        providers: [
          ChangeNotifierProvider<UserProvider>(create:(_)=>UserProvider()),

        ],
      )
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var userProvider=Provider?.of<UserProvider>(context);
    return MaterialApp(
      title: 'Chat-App',
      routes: {
        LoginScreen.routeName:(_)=>LoginScreen(),
        RegisterScreen.routeName:(_)=>RegisterScreen(),
        HomeScreen.routeName:(_)=>HomeScreen(),
        AddRoomScreen.routeName:(_)=>AddRoomScreen(),
        ChatScreen.route_name:(_)=>ChatScreen(),
      },
      initialRoute: userProvider.firebaseUser ==null? LoginScreen.routeName: HomeScreen.routeName,
      theme: ThemeData(
        primaryColor: Color(0xff3598DB),
        elevatedButtonTheme: ElevatedButtonThemeData(style:  ElevatedButton.styleFrom(
          primary: Color(0xff3598DB),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),

          ),
        ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xff3598DB),
          splashColor: Color(0xff3598DB)
        ),
      ),
    );
  }
}