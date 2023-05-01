import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'routes.dart';
import 'screens/splash/splash_screen.dart';
import 'theme.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
SystemChrome.setPreferredOrientations([
DeviceOrientation.portraitUp,
DeviceOrientation.portraitDown,
]);
runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SolarSaver',
      theme: theme(),
      // home: SplashScreen(),
      // We use routeName so that we don't need to remember the name
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}