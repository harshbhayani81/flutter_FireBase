import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Fetch_Screen extends StatefulWidget {
  const Fetch_Screen({super.key});

  @override
  State<Fetch_Screen> createState() => _Fetch_ScreenState();
}

class _Fetch_ScreenState extends State<Fetch_Screen> {
  final FireStoreService fireStoreService = FireStoreService();
   List<User> users = [];



  Future<void> getUserData() async{
    List<User> fetchUsers = await fireStoreService.getUser();

    setState(() {
      users = fetchUsers;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("User List"),
          ),

          body: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context,index){
                User user = users[index];
                return ListTile(
                  title: Text("User Name :- ${user.Fname}"),
                  subtitle: Text("User ID :- ${user.id}"),
                );
              }),
        ));
  }
}

class User{
  final String id;
  final String Fname;

  User({
    required this.id,
    required this.Fname,
  });
}

class FireStoreService{
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('Data_1');

  Future<List<User>> getUser() async {
    try{
      QuerySnapshot snapshot = await userCollection.get();

      return snapshot.docs.map((doc) => User(
        id: doc.id,
        Fname: doc.data().toString(),
      )).toList();
    } catch (e){
      print("Fetching User : $e");
      return [];
    }
  }
}