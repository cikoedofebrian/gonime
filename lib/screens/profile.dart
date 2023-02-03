import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

enum EditStatus { Edit, onEdit, Save }

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    future = FirebaseFirestore.instance.collection('users').doc(user).get();
    // TODO: implement initState
    super.initState();
  }

  final user = FirebaseAuth.instance.currentUser!.uid;
  late Future future;
  EditStatus status = EditStatus.Edit;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) => SafeArea(
              child: Scaffold(
                backgroundColor: Colors.black,
                body: snapshot.connectionState == ConnectionState.waiting
                    ? CircularProgressIndicator(color: Colors.white)
                    : Stack(children: [
                        Container(
                          margin: EdgeInsets.all(50),
                          alignment: Alignment.center,
                          child: Center(
                            child: SingleChildScrollView(
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
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    padding: EdgeInsets.all(50),
                                    child: Form(
                                        child: Column(
                                      children: [
                                        Container(
                                          child: Text('Email'),
                                          width: double.infinity,
                                        ),
                                        TextFormField(
                                          initialValue: snapshot.data!['email'],
                                          enabled: false,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          child: Text('Name'),
                                          width: double.infinity,
                                        ),
                                        TextFormField(
                                          initialValue: snapshot.data!['name'],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          child: Text('Bio'),
                                          width: double.infinity,
                                        ),
                                        TextFormField(
                                          maxLength: 10,
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
                                  color: Colors.green,
                                ),
                              ),
                              GestureDetector(
                                child: Container(
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  color: Colors.green,
                                ),
                              )
                            ],
                          ),
                        ),
                      ]),
              ),
            ));
  }
}
