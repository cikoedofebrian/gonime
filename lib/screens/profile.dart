import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!.email;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        margin: EdgeInsets.all(50),
        alignment: Alignment.center,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              child: Icon(Icons.account_circle_rounded),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.all(50),
              child: Form(
                  child: Column(
                children: [
                  Container(
                    child: Text('Email'),
                    width: double.infinity,
                  ),
                  TextFormField(
                    initialValue: user,
                    enabled: false,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Text('Bio'),
                    width: double.infinity,
                  ),
                  TextFormField()
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}
