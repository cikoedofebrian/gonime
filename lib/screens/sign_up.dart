import 'package:flutter/material.dart';
import 'package:gonime/screens/home.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                              child: TextField(
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
                              child: TextField(
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
                              child: TextField(
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
