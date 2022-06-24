import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:object_detection/services/auth_service.dart';
import 'package:object_detection/ui/pages/detector_page.dart';
import 'package:object_detection/ui/pages/home.dart';
import 'package:object_detection/ui/pages/login_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  var status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
  }
  //initialize firebase
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Map<int, Color> color = {
    50: Color.fromRGBO(255, 255, 255, .1),
    100: Color.fromRGBO(255, 255, 255, .2),
    200: Color.fromRGBO(255, 255, 255, .3),
    300: Color.fromRGBO(255, 255, 255, .4),
    400: Color.fromRGBO(255, 255, 255, .5),
    500: Color.fromRGBO(255, 255, 255, .6),
    600: Color.fromRGBO(255, 255, 255, .7),
    700: Color.fromRGBO(255, 255, 255, .8),
    800: Color.fromRGBO(255, 255, 255, .9),
    900: Color.fromRGBO(255, 255, 255, 1),
  };

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Classificação de Rebit',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFFFFFFF, color),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: LoginPage.route,
      getPages: [
        GetPage(
          name: DetectorPage.route,
          page: () => DetectorPage(),
          transition: Transition.cupertino,
        ),
        GetPage(
          name: HomePage.route,
          page: () => HomePage(),
          transition: Transition.cupertino,
        ),
        GetPage(
          name: LoginPage.route,
          page: () => LoginPage(),
          transition: Transition.cupertino,
        ),
      ],
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

// If you need to test a specific image, you can get a file path where you can put the image.
// Look at getExternalStorageDirectory() from path_provider package;
