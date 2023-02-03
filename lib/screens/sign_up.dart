import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gonime/screens/home.dart';
import 'package:provider/provider.dart';
import '../extensions/email_validator.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String name = '';
  String c_password = '';

  @override
  Widget build(BuildContext context) {
    void _submit() async {
      final validate = _formKey.currentState!.validate();
      if (validate) {
        _formKey.currentState!.save();
        if (password != c_password) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Passwords is different')));
          return;
        }
        try {
          String user = '';
          print(email);
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password)
              .then((value) => user = value.user!.uid);
          await FirebaseFirestore.instance.collection('users').doc(user).set(
              {'email': email.trim(), 'name': name, 'bio': '', 'imageUrl': ''});
          print(user);
          Navigator.pop(context);
        } on FirebaseAuthException catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(e.message! + ' (firebase error)')));
        }
      }
    }

    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colos.white,
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Create Account',
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 30),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Create a new account',
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(15),
                              width: double.infinity,
                              child: Text(
                                'EMAIL',
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: TextFormField(
                                validator: (value) {
                                  if (!value!.isValidEmail()) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Please give a valid email address')));
                                  }
                                },
                                onSaved: (newValue) => email = newValue ?? '',
                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  suffixIcon: Icon(Icons.email),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(15),
                              width: double.infinity,
                              child: Text(
                                'NAME',
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                                Text('Please give a name')));
                                  }
                                },
                                onSaved: (newValue) => name = newValue ?? '',
                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  suffixIcon: Icon(Icons.person),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(15),
                              width: double.infinity,
                              child: Text(
                                'PASSWORD',
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.length < 7) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Password needs a minimum length of 7')));
                                    return;
                                  }
                                },
                                onSaved: (newValue) =>
                                    password = newValue ?? '',
                                obscureText: true,
                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    suffixIcon: Icon(Icons.lock)),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(15),
                              width: double.infinity,
                              child: Text(
                                'CONFIRM PASSWORD',
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: TextFormField(
                                onSaved: (newValue) =>
                                    c_password = newValue ?? '',
                                validator: (value) {
                                  if (value!.length < 7) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Password needs a minimum length of 7')));
                                    return;
                                  }
                                },
                                textAlignVertical: TextAlignVertical.center,
                                obscureText: true,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    suffixIcon: Icon(Icons.lock)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        },
                        child: GestureDetector(
                          onTap: () => _submit(),
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Colors.black),
                            padding: EdgeInsets.all(15),
                            child: Text(
                              'SIGN UP',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                alignment: Alignment.topLeft,
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
