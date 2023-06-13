import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size size = MediaQuery.of(context).size;
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    // ignore: unused_local_variable
    double ffem = fem * 0.97;
    return Material(
      child: Container(
        padding: const EdgeInsets.only(top: 100, bottom: 100),
        decoration: const BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
                image: AssetImage("assets/images/bg.png"),
                fit: BoxFit.cover,
                opacity: 0.6)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Coffee Shop",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                ),
              ),
            ]),
      ),
    );
  }
}
