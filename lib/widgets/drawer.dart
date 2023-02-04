import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gonime/screens/login.dart';
import 'package:image_picker/image_picker.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key, required this.imageurl, required this.name});
  final String imageurl;
  final String name;

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

  final user = FirebaseAuth.instance.currentUser!.uid;
  // late Future data;
  @override
  void initState() {
    // TODO: implement initState
    print(user);
    super.initState();
    // data = Future.wait([
    //   FirebaseStorage.instance.ref('profile_image/$user.jpg').getDownloadURL(),
    //   FirebaseFirestore.instance.collection('users').doc(user).get()
    // ]);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        FutureBuilder(
          // future: data,
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Container()
                  : Container(
                      height: MediaQuery.of(context).size.height * 0.20,
                      alignment: Alignment.center,
                      color: Colors.black,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () =>
                                Navigator.of(context).pushNamed('/profile'),
                            child: CircleAvatar(
                                radius: 30,
                                backgroundImage: widget.imageurl.isNotEmpty
                                    ? NetworkImage(widget.imageurl)
                                    : null),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            widget.name,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
        ),
        Divider(
          height: 0,
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).pop();
            Navigator.pushNamed(context, '/top-anime');
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'See Top Anime!',
                  style: TextStyle(fontSize: 16),
                ),
                Icon(Icons.trending_up_rounded)
              ],
            ),
          ),
        ),
        Divider(
          height: 0,
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
      ]),
    );
  }
}
