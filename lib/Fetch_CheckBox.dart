import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CheckBox extends StatefulWidget {
  const CheckBox({super.key});

  @override
  State<CheckBox> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  GlobalKey<FormState> _formKey = GlobalKey();
  List<String> _hobbies = [];

  void _handleHobbySelection(String value) {
    setState(() {
      if (_hobbies.contains(value)) {
        _hobbies.remove(value);
      } else {
        _hobbies.add(value);
      }
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form validation successful, save the data to Firestore
      UserData userData = UserData(
        hobbies: _hobbies,
      );

      FirebaseFirestore.instance.collection('Check_Box').add(userData.toMap());

      // Clear form data after saving
      setState(() {
        _hobbies = [];
      });
    }
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('Check_Box');

  // User data
  Map<dynamic, dynamic> userData = {};

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  // Fetch user data from Firestore
  void fetchUserData() async {
    try {
      DocumentSnapshot docSnapshot = await usersCollection.doc().get();
      if (docSnapshot.exists) {
        setState(() {
          userData = docSnapshot.data() as Map<String, dynamic>;
        });
      } else {
        setState(() {
          userData == null;
        });
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore Data Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Select Hobbies:'),
              CheckboxListTile(
                  title: Text(
                    _hobbies.contains('Reading').toString(),
                  ),
                  value: _hobbies.contains('Reading'),
                  onChanged: (bool? value) {
                    setState(() {
                      _handleHobbySelection('Reading');
                    });
                  }),
              CheckboxListTile(
                  title: Text(
                    _hobbies.contains('Sports').toString(),
                  ),
                  value: _hobbies.contains('Sports'),
                  onChanged: (bool? value) {
                    setState(() {
                      _handleHobbySelection('Sports');
                    });
                  }),
              CheckboxListTile(
                  title: Text(
                    _hobbies.contains('Travelling').toString(),
                  ),
                  value: _hobbies.contains('Travelling'),
                  onChanged: (bool? value) {
                    setState(() {
                      _handleHobbySelection('Travelling');
                    });
                  }),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Select Hobbies:'),
                  CheckboxListTile(
                    title: Text('Reading'),
                    onChanged: (value) {},
                    value: userData['hobbies'],
                  ),
                  CheckboxListTile(
                    title: Text('Sports'),
                    value: userData['hobbies'],
                    onChanged: (value) {},
                  ),
                  CheckboxListTile(
                    title: Text('Traveling'),
                    value: userData['hobbies'],
                    onChanged: (value) {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserData {
  List<String> hobbies;

  UserData({
    required this.hobbies,
  });

  Map<String, dynamic> toMap() {
    return {
      'hobbies': hobbies,
    };
  }
}
