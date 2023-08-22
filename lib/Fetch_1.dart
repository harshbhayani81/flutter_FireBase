import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Fetching extends StatefulWidget {
  const Fetching({super.key});

  @override
  State<Fetching> createState() => _FetchingState();
}

class _FetchingState extends State<Fetching> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('Check_Box')
                      .doc('5h8vHJkTAgGB3M5lmDDQ')
                      .get(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done) {
                      var data = snapshot.data.data();
                      var hobbies = data['hobbies'];

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: hobbies.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Text(hobbies[index].toString());
                        },
                      );
                    } else {
                      return Text("Error");
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
