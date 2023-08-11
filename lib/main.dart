import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:ujilevel_bk/auth/signIn.dart';
import 'package:ujilevel_bk/home.dart';
import 'package:ujilevel_bk/providers/auth.dart';
import 'package:ujilevel_bk/splash.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => Auth(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final storage = const FlutterSecureStorage();

  void _attemptAuthentication() async {
    String? key = await storage.read(key: 'auth');

    // ignore: use_build_context_synchronously
    Provider.of<Auth>(context, listen: false).attempt(key);
  }

  @override
  void initState() {
    super.initState();
    _attemptAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: Center(
        child: Consumer<Auth>(
          builder: (context, value, child) {
            if (value.authenticated) {
              return const Home();
            } else {
              return const SignIn();
            }
          },
        ),
      ),
    );
  }
}
