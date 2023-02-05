import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gonime/widgets/custom_progress_indicator.dart';
import 'package:image_picker/image_picker.dart';

enum EditStatus { Edit, Save }

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    future = FirebaseFirestore.instance.collection('users').doc(user).get();
    super.initState();
  }

  void editFunction() {
    setState(() {
      if (status == EditStatus.Edit) {
        status = EditStatus.Save;
      } else {
        status = EditStatus.Edit;
        saveChanges(email, name, bio);
      }
    });
  }

  void saveChanges(email, name, bio) async {
    final _firestore = FirebaseFirestore.instance.collection('users').doc(user);
    if (_image != null) {
      final _reference =
          FirebaseStorage.instance.ref('profile_image/$user.jpg');
      await _reference.putFile(_image!);
      final String imageurl = await _reference.getDownloadURL();
      await _firestore.set(
          {'email': email, 'name': name, 'bio': bio, 'imageurl': imageurl});
      return;
    }
    await _firestore
        .set({'email': email, 'name': name, 'bio': bio, 'imageurl': _imageurl});
  }

  void _pickImage() async {
    final picker = ImagePicker();
    final ImageSource? image = await showDialog<ImageSource>(
        context: context,
        builder: (context) => SimpleDialog(
              title: const Text('Choose source'),
              children: <Widget>[
                SimpleDialogOption(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [Text('Camera'), Icon(Icons.camera)],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                  ),
                  onPressed: () => Navigator.pop(context, ImageSource.camera),
                ),
                SimpleDialogOption(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [Text('Gallery'), Icon(Icons.photo)],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                  ),
                  onPressed: () => Navigator.pop(context, ImageSource.gallery),
                ),
              ],
            ));
    // await picker.pickImage(source: ImageSource.camera);
    if (image == null) {
      return;
    }
    final pickedImage = await picker.pickImage(source: image);
    setState(() {
      _image = File(pickedImage!.path);
    });
  }

  final user = FirebaseAuth.instance.currentUser!.uid;
  File? _image;
  String? _imageurl;
  String email = '';
  String name = '';
  String bio = '';
  late Future future;
  EditStatus status = EditStatus.Edit;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CustomProgressIndicator(color: Colors.white));
              }
              name = snapshot.data!['name'];
              email = snapshot.data!['email'];
              bio = snapshot.data!['bio'];
              _imageurl = snapshot.data!['imageurl'];

              return Stack(children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  alignment: Alignment.center,
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            padding: EdgeInsets.all(35),
                            child: Form(
                                child: Column(
                              children: [
                                if (_imageurl!.isEmpty && _image == null)
                                  TextButton.icon(
                                      onPressed: () {
                                        _pickImage();
                                        setState(() {
                                          status = EditStatus.Save;
                                        });
                                      },
                                      icon: Icon(Icons.camera),
                                      label: Text('Add photo')),
                                if (_imageurl!.isNotEmpty || _image != null)
                                  GestureDetector(
                                    onTap: status == EditStatus.Save
                                        ? _pickImage
                                        : null,
                                    child: CircleAvatar(
                                      backgroundImage: _image != null
                                          ? FileImage(_image!)
                                          : NetworkImage(_imageurl!)
                                              as ImageProvider,
                                      radius: 50,
                                    ),
                                  ),
                                SizedBox(
                                  height: 40,
                                ),
                                Container(
                                  child: Text('Email'),
                                  width: double.infinity,
                                ),
                                TextFormField(
                                  onChanged: (value) => email = value,
                                  initialValue: snapshot.data!['email'],
                                  enabled:
                                      status == EditStatus.Edit ? false : true,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  child: Text('Name'),
                                  width: double.infinity,
                                ),
                                TextFormField(
                                  onChanged: (value) => name = value,
                                  initialValue: snapshot.data!['name'],
                                  enabled:
                                      status == EditStatus.Edit ? false : true,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  child: Text('Bio'),
                                  width: double.infinity,
                                ),
                                TextFormField(
                                  initialValue: bio,
                                  onChanged: (value) => bio = value,
                                  maxLength: 100,
                                  maxLines: 4,
                                  enabled:
                                      status == EditStatus.Edit ? false : true,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 100,
                Container(
                  padding: EdgeInsets.all(20),
                  height: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          // padding: EdgeInsets.all(20),
                          // alignment: Alignment.topLeft,
                          child: Icon(
                            color: Colors.white,
                            Icons.arrow_back_ios_new_rounded,
                            size: 30,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: editFunction,
                        child: Container(
                          child: Icon(
                            status == EditStatus.Edit ? Icons.edit : Icons.save,
                            color: Colors.white,
                            size: 30,
                          ),
                          // color: Colors.green,
                        ),
                      )
                    ],
                  ),
                ),
              ]);
            }),
      ),
    ));
  }
}
