import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kitchen/Menu/AddMealScreen.dart';
import 'package:kitchen/Menu/MenuITemSelectedScreen.dart';
import 'package:kitchen/screen/ForgotPasswordScreen.dart';

import 'package:kitchen/screen/HomeBaseScreen.dart';
import 'package:kitchen/screen/LoginSignUpScreen.dart';
import 'package:kitchen/screen/SplashScreen.dart';
import 'package:kitchen/utils/Log.dart';
import 'package:logging/logging.dart';

void main() {
  _initLog();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) async {
    runApp(App());
  });
}

void _initLog() {
  Log.init();
  Log.setLevel(Level.ALL);
}

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Food App",
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            builder: (BuildContext context) => makeRoute(
                context: context,
                routeName: settings.name,
                arguments: settings.arguments),
            maintainState: true,
            fullscreenDialog: false,
          );
        });
  }

  Widget makeRoute(
      {@required BuildContext context,
      @required String routeName,
      Object arguments}) {
    final Widget child = _buildRoute(
        context: context, routeName: routeName, arguments: arguments);
    return child;
  }

  Widget _buildRoute({
    @required BuildContext context,
    @required String routeName,
    Object arguments,
  }) {
    switch (routeName) {
      case '/':
        return SplashScreen();
      case '/loginSignUp':
        return LoginSignUpScreen();
      case '/homebase':
        return HomeBaseScreen();
      case '/addMeals':
        return AddMealScreen();
      case '/forgot':
        return ForgotPasswordScreen();
      case '/menuItemSelected':
        return MenuITemSelectedScreen();
      default:
        throw 'Route $routeName is not defined';
    }
  }
}
