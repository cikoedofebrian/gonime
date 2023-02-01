import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gonime/screens/login.dart';
import 'package:image_picker/image_picker.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  File? _image;
  void _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.25,
          alignment: Alignment.center,
          color: Colors.black,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 40,
                  child: Icon(Icons.supervised_user_circle_sharp),
                  backgroundImage: _image != null ? FileImage(_image!) : null,
                ),
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: () => FirebaseAuth.instance.signOut(),
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
