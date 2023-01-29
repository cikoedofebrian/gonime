import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gonime/screens/login.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.25,
          alignment: Alignment.center,
          color: Colors.black,
          width: double.infinity,
          child: Text(
            'GoNime',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => AuthScreen())),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sign Out',
                  style: TextStyle(fontSize: 16),
                ),
                Icon(Icons.logout)
              ],
            ),
          ),
        ),
        Divider(
          height: 0,
        )
      ]),
    );
  }
}
