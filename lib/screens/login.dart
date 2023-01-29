import 'package:flutter/material.dart';
import 'package:gonime/screens/home.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colos.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Icon(
                    Icons.supervised_user_circle,
                    size: 100,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Welcome Back',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Sign in to Continue',
                  style: TextStyle(color: Colors.grey),
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
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              suffixIcon: Icon(Icons.key)),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.end,
                  ),
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
                      'LOGIN',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Dont have account?'),
                      GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, '/register'),
                          child: Text(
                            ' Create account',
                            style: TextStyle(color: Colors.grey),
                          ))
                    ],
                  ),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          ),
        ),
      ),
    );
  }
}
