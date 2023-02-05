import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key, required this.imageurl, required this.name});
  final String imageurl;
  final String name;

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  void initState() {
    super.initState();
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
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pushNamed('/profile');
                            },
                            child: CircleAvatar(
                                radius: 30,
                                child: widget.imageurl.isEmpty
                                    ? Icon(
                                        Icons.account_circle_rounded,
                                        size: 40,
                                      )
                                    : null,
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
