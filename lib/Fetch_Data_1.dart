import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItem = [
    DropdownMenuItem(
      child: Text("Ahmedabad"),
      value: "Ahmedabad",
    ),
    DropdownMenuItem(
      child: Text("Surendranagar"),
      value: "Surendranagar",
    ),
    DropdownMenuItem(
      child: Text("RajKot"),
      value: "RajKot",
    ),
    DropdownMenuItem(
      child: Text("Vadodra"),
      value: "Vadodra",
    ),
    DropdownMenuItem(
      child: Text("Surat"),
      value: "Surat",
    ),
    DropdownMenuItem(
      child: Text(" "),
      value: " ",
    ),
  ];
  return menuItem;
}

class Fetch_1 extends StatefulWidget {
  const Fetch_1({super.key});

  @override
  State<Fetch_1> createState() => _Fetch_1State();
}

class _Fetch_1State extends State<Fetch_1> {
  String? _SelectedGender;

  void _handleGenderSelection(dynamic value) {
    setState(() {
      _SelectedGender = value;
    });
  }

  String? SelecetedCountry;

  void _handleCountrySelection(String? value) {
    setState(() {
      SelecetedCountry = value;
    });
  }

  List<String> hobbies = [];
  // List<bool> hobbies = [];

  void handleHobbySelection(String value) {
    setState(() {
      if (hobbies.contains(value)) {
        hobbies.remove(value);
      } else {
        hobbies.add(value);
      }
    });
  }

  late DateTime selected_date = DateTime.now();

  void _handleDateSelection(DateTime date) {
    setState(() {
      selected_date = date;
    });
  }

  void PresentDate() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime.now())
        .then((Pickeddate) {
      if (Pickeddate == null) {
        return;
      } else {
        setState(() {
          _handleDateSelection(Pickeddate);
        });
      }
    });
  }
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('Data_1');

  Map<dynamic,dynamic>? userData;
  List<dynamic>? Hobbies;

  void fetchUserDate() async{
    print("Enter");
    try{
      DocumentSnapshot docsnapshot = await userCollection.doc("CcL1W96Wf17mb4rIp1sK").get();
      if(docsnapshot.exists){
        setState(() {
          userData = docsnapshot.data() as Map<dynamic,dynamic>;
          var Hobbies = userData!['Hobbies'];
        });
      }
      else
        {
          setState(() {
            userData = null;
          });
        }
    } catch (e) {
      print("Fetching Error! : $e");
    }
    print("End");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUserDate();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
          ),
          body: userData == null ?
          Center(child: Text("Not Found"),) :
              SingleChildScrollView(
                child: Container(
                  height: 1500,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Id :- ${userData!['id']}"),
                      Text("First_Name :- ${userData!['First_Name']}"),
                      Text("Middle_Name :- ${userData!['Middle_Name']}"),
                      Text("Last_Name :- ${userData!['Last_Name']}"),
                      Text("Email :- ${userData!['Email']}"),
                      Text("Mobile :- ${userData!['Mobile_No']}"),
                      Text("Password :- ${userData!['Password']}"),
                      Text("UserName :- ${userData!['Username']}"),
                      Text("Bio :- ${userData!['Bio']}"),
                      Text("Gender :- ${userData!['Gender']}"),
                      Text("Country :- ${userData!['Country']}"),
                      Text("Hobbies :- ${userData!['Hobbies']}"),
                      Text("Birth Date :- ${userData!['birthDate'].toString()}"),
                      Text("ImageUrl :- ${userData!['prifileImage']}"),
                      TextFormField(
                        initialValue: userData!['Bio'],
                        decoration: InputDecoration(
                          labelText: 'Bio',
                        ),
                        onChanged: (value) {},
                      ),
                      Container(
                        child: CircleAvatar(
                          radius: 55,
                          backgroundImage: NetworkImage('${userData!['prifileImage']}'),
                        ),
                      ),
                      Container(
                        height: 65,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26, width: 2),
                          borderRadius: BorderRadius.circular(4.5),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.person_2_sharp,
                              size: 30,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Gender",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Radio_Btn(
                              Rvalue: "male",
                              Gvalue: userData!['Gender'],
                              change: _handleGenderSelection,
                            ),
                            Text(
                              "Male",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Radio_Btn(
                              Rvalue: "female",
                              Gvalue: userData!['Gender'],
                              change: _handleGenderSelection,
                            ),
                            Text(
                              "Female",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      DropdownButtonFormField(
                        items: dropdownItems,
                        value: '${userData!['Country']}',
                        onChanged: _handleCountrySelection,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.area_chart_sharp,
                            size: 30,
                          ),
                          prefixIconColor: Colors.black,
                          labelText: "City",
                          labelStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2,
                              style: BorderStyle.solid,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2,
                              style: BorderStyle.solid,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 2,
                              style: BorderStyle.solid,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                        ),
                        validator: (value) {
                          if (value == null || value == "") {
                            return "Please Selecte The City";
                          } else {
                            return null;
                          }
                        },
                      ),
                      Container(
                        height: 65,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26, width: 2),
                          borderRadius: BorderRadius.circular(4.5),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.account_tree_sharp,
                              size: 30,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Hobby",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Checkbox(
                              checkColor: Colors.white,
                              activeColor: Colors.black,
                              value: hobbies.contains(userData!['Hobbies']),
                              onChanged: (bool? value) {
                                setState(() {
                                  handleHobbySelection(userData!['Hobbies']);
                                });
                              },
                              // onChanged: (value){},
                            ),
                            Text(
                              "Coding",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Checkbox(
                                checkColor: Colors.white,
                                activeColor: Colors.black,
                                value: hobbies.contains(userData!['Hobbies']),
                                onChanged: (bool? value) {
                                  setState(() {
                                    handleHobbySelection(userData!['Hobbies']);
                                  });
                                },
                                // onChanged: (value){},
                                ),
                            Text(
                              "Games",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      TextFormField(
                        controller: TextEditingController(
                          text: selected_date != null
                              ? "${userData!['birthDate'].toString()}"
                              : "No Date Selected",
                        ),
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.date_range_sharp,
                              size: 30,
                            ),
                            prefixIconColor: Colors.black,
                            labelText: "Date Of Birth",
                            labelStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            hintText: "Enter Your Date-Of-Birth",
                            hintStyle:
                            TextStyle(fontSize: 14, color: Colors.white),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2,
                                style: BorderStyle.solid,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2,
                                style: BorderStyle.solid,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 2,
                                style: BorderStyle.solid,
                              ),
                            ),
                            suffixIcon: IconButton(
                              onPressed: PresentDate,
                              icon: Icon(
                                Icons.calendar_month,
                                size: 25,
                                color: Colors.black,
                              ),
                            )),
                        validator: (value) {
                          if (value == null || value == "") {
                            return "Please Enter The Date Of Birth!";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
                ),
              )
        ));
  }

  Widget Radio_Btn({Rvalue = "", Gvalue, change = ()}) {
    return Radio(
      focusColor: Colors.blue,
      activeColor: Colors.black,
      value: Rvalue,
      groupValue: Gvalue,
      onChanged: change,
    );
  }
}
