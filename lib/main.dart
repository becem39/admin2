import 'package:admin/const/const.dart';
import 'package:admin/firebase_options.dart';
import 'package:admin/views/auth_screen/login_screen.dart';
import 'package:admin/views/home_screen/home.dart';
import 'package:admin/views/home_screen/home_screen.dart';
import 'package:admin/views/profile_screen/edit_profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import 'controllers/product_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    checkUser();
  }

  var isLoggedIn = false;
  checkUser() async {
    auth.authStateChanges().listen((User? user) {
      if (user == null && mounted) {
        isLoggedIn = false;
      } else {
        isLoggedIn = true;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      home: isLoggedIn ? const Home() : const LoginScreen(),
      initialRoute: '/LoginScreen',
      
      getPages: [
        GetPage(name: '/LoginScreen', page: () => const LoginScreen()),
        GetPage(
            name: '/EditProfileScreen', page: () => const EditProfileScreen()),
        GetPage(name: '/Home', page: () => const Home()),
      ],
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
      ),
    );
  }
}
