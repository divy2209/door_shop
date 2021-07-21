import 'package:door_shop/screens/walkthrough_screen/tutorial_old.dart';
import 'package:door_shop/services/authentication_services/authorization.dart';
import 'package:door_shop/services/authentication_services/user.dart';
import 'package:door_shop/services/authentication_services/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

// TODO: Autocorrect functionality
// TODO: put 'back' button working on every page
// TODO: make the route file and use that for navigation
// TODO: dark theme and system theme
// TODO: Checking internet connectivity using connectivity package
// TODO: firebase authorization in the login and register page
// TODO: put try and catch to avoid system errors and to show user friendly errors
// TODO: After logining in, the back should close the app not take you to login again, using widget binding
// TODO: Action class inside the appBar shows the icon, flatbutton for user profile and cart, basically functionality to be placed at the right of the appBar
// TODO: while navigating to another page, close the  keyboard
// TODO: While landing on a page, closing the keyboard if open
// TODO: getting permission to use location
// TODO: handelling firebase errors

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // TODO: Check the changes by SystemChrome class (Transparent status bar)
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent)
  );
  // TODO: If up and down both required and what's the difference
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<DoorShop>.value(
      value: AuthorizationService().user,
      initialData: null,
      child: MaterialApp(
        title: "Door Shop",
        theme: ThemeData(
          // TODO: Check if this visualDensity code helps/changes or not
          visualDensity: VisualDensity.adaptivePlatformDensity
        ),
        // TODO: Make this tutorial class of walkthrough one timer by using sharedPreference package
        // TODO: Debate on the 3rd screen for earning rewards on walkthrough
        home: Wrapper(),
        //home: Tutorial(),
        // TODO: Changing the overall app font
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

// TODO: Check on tContainerhe screen closings and app closing