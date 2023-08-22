import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/Login_Screen.dart';
import 'package:image_picker/image_picker.dart';

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

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  GlobalKey<FormState> FrmKey = GlobalKey();

  FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController Fname = TextEditingController();
  TextEditingController Mname = TextEditingController();
  TextEditingController Lname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController Mob_No = TextEditingController();
  TextEditingController bio = TextEditingController();
  TextEditingController Uname = TextEditingController();
  TextEditingController Pass = TextEditingController();
  TextEditingController CPass = TextEditingController();

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

  List<dynamic> hobbies = [];

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

  File? image;
  String photo = "";
  String? imageUrl;

  Future<void> getImage(ImageSource source) async {
    print("Enter Into GetImage");
    final pickedImage = await ImagePicker().pickImage(source: source);

    setState(() {
      if (pickedImage != null) {
        image = File(pickedImage.path);
        print("${pickedImage.path}");
      } else {
        print("No image Selected");
      }
    });
    print("End GetImage");
  }

  Future uploadImagetoFireBase(File? imageFile) async {
    print("Enter Into uploadImagetoFireBase");
    final fileName = DateTime.now().microsecondsSinceEpoch.toString();
    final Reference storageReference =
    FirebaseStorage.instance.ref().child('image/$fileName');
    final UploadTask uploadTask = storageReference.putFile(imageFile!);
    final TaskSnapshot downloadurl = (await uploadTask.whenComplete(
          () async {
        String downloadURL = await storageReference.getDownloadURL();

        DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref().child('image');

        databaseReference.push().set({
          'path': downloadURL,
        }).then((value) {
          print("Image Path Stored Successfully");
        }).catchError((error) {
          print("Failed to Store Image : $error");
        });
      },
    ));

    String imageUrl = (await downloadurl.ref.getDownloadURL());
    print("End uploadImagetoFireBase");
    return imageUrl;
  }

  submitimage() async {
    print("Enter submitImage");
    if (image != null) {
      imageUrl = await uploadImagetoFireBase(image);
      print(imageUrl);

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Profile Created Succesfully")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Image Not Selected")));
    }
    print("End submitImage");
  }

  bool? _success;
  String? _userEmail;

  void _register() async {
    final User? user = (await _auth.createUserWithEmailAndPassword(
      email: email.text,
      password: Pass.text,
    )).user;

    if (user != null)
    {
      setState(() {
        _success = true;
        _userEmail = user.email!;
      });
    }
    else
    {
      setState(() {
        _success = false;
      });
    }
  }

  Future createUser(
      {
        required String fname,
        required String mname,
        required String lname,
        required String email,
        required String mobile,
        required String password,
        required String username,
        required String Bio,
        required String Gender,
        required String Country,
        required List<dynamic> hobbies,
        // required DateTime birthDate,
        required String birthDate,
        profileImage,
      }
      ) async {
    final docUser = FirebaseFirestore.instance.collection('Data_1').doc();

    final json = {
      'id' : docUser.id,
      'First_Name': fname,
      'Middle_Name': mname,
      'Last_Name': lname,
      'Email': email,
      'Mobile_No': mobile,
      'Password': password,
      'Username': username,
      'Bio': Bio,
      'Gender': Gender,
      'Country': Country,
      'Hobbies': hobbies,
      'birthDate': birthDate,
      'prifileImage': profileImage,
    };
    await docUser.set(json);
  }

  void Change_Page(){
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Login()));
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            centerTitle: true,
            elevation: 10,
            title: Text(
              "Registration",
              style: TextStyle(
                  fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              // height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              // color: Colors.blue,

              child: Form(
                key: FrmKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Stack(
                      children: [
                        Container(
                            child: image == null
                                ? (photo == "" || photo == null)
                                ? CircleAvatar(
                              backgroundImage: AssetImage(
                                  "Assets/Image/profile_2.jpg"),
                              radius: 55,
                            )
                                : CircleAvatar(
                              backgroundImage: NetworkImage(photo.trim()),
                              radius: 55,
                            )
                                : CircleAvatar(
                              backgroundImage: FileImage(image!),
                              radius: 55,
                            )),
                        Positioned(
                            right: 2,
                            bottom: -6,
                            child: IconButton(
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.black,
                              ),
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        height: 100,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            // SizedBox(width: 20,),
                                            Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 40,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius:
                                                    BorderRadius.circular(4),
                                                  ),
                                                  child: IconButton(
                                                      onPressed: () {
                                                        getImage(
                                                            ImageSource.gallery);
                                                        Navigator.of(context).pop();
                                                      },
                                                      icon: Icon(
                                                        Icons.photo_library,
                                                        size: 25,
                                                        color: Colors.white,
                                                      )),
                                                ),
                                                Text(
                                                  "Gallery",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 40,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius:
                                                    BorderRadius.circular(4),
                                                  ),
                                                  child: IconButton(
                                                      onPressed: () {
                                                        getImage(
                                                            ImageSource.camera);
                                                        Navigator.of(context).pop();
                                                      },
                                                      icon: Icon(
                                                        Icons.camera_alt_sharp,
                                                        size: 25,
                                                        color: Colors.white,
                                                      )),
                                                ),
                                                Text(
                                                  "Camera",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              },
                              icon: Icon(
                                Icons.add_a_photo,
                                color: Colors.white,
                                size: 20,
                              ),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      // height: 700,
                      width: 350,
                      child: Column(
                        children: [
                          Text_Field(
                            Tcontroller: Fname,
                            Ltext: "First Name",
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text_Field(
                            Tcontroller: Mname,
                            Ltext: "Middle Name",
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text_Field(
                            Tcontroller: Lname,
                            Ltext: "Last Name",
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text_Field(
                            Tcontroller: email,
                            Ltext: "Gmail",
                            KType: TextInputType.emailAddress,
                            Iname: Icons.email_sharp,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text_Field(
                            Tcontroller: Mob_No,
                            Ltext: "Mobile No.",
                            KType: TextInputType.phone,
                            Iname: Icons.call_sharp,
                          ),
                          SizedBox(
                            height: 10,
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
                                  Gvalue: _SelectedGender,
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
                                  Gvalue: _SelectedGender,
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
                          SizedBox(
                            height: 10,
                          ),
                          DropdownButtonFormField(
                            items: dropdownItems,
                            value: SelecetedCountry,
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
                          SizedBox(
                            height: 10,
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
                                  value: hobbies.contains('coding'),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      handleHobbySelection('coding');
                                    });
                                  },
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
                                    value: hobbies.contains('games'),
                                    onChanged: (bool? value) {
                                      setState(() {
                                        handleHobbySelection('games');
                                      });
                                    }),
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
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: TextEditingController(
                              text: selected_date != null
                                  ? "${selected_date.day.toString()}/${selected_date.month.toString()}/${selected_date.year.toString()}"
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
                          SizedBox(
                            height: 10,
                          ),
                          Text_Field(
                            Tcontroller: bio,
                            Ltext: "Bio",
                            Iname: Icons.line_style_sharp,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text_Field(
                            Tcontroller: Uname,
                            Ltext: "User Name",
                            Iname: Icons.person_2_sharp,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text_Field(
                            Tcontroller: Pass,
                            Ltext: "Password",
                            Iname: Icons.lock_outline,
                            Show: true,
                            Sicon: Icons.remove_red_eye_sharp,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text_Field(
                            Tcontroller: CPass,
                            Ltext: "Confirm Password",
                            Iname: Icons.lock_outline,
                            Show: true,
                            Sicon: Icons.remove_red_eye_sharp,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                // if(FrmKey.currentState!.validate())
                                //   {
                                submitimage();
                                Timer(
                                    Duration(seconds: 10),(){
                                  final FName = Fname.text;
                                  final MName = Mname.text;
                                  final LName = Lname.text;
                                  final EMAIL = email.text;
                                  final Mob = Mob_No.text;
                                  final BIO = bio.text;
                                  final UName = Uname.text;
                                  final PASS = Pass.text;
                                  _register();
                                  createUser(
                                    fname: FName,
                                    mname: MName,
                                    lname: LName,
                                    email: EMAIL,
                                    mobile: Mob,
                                    Bio: BIO,
                                    username: UName,
                                    Gender: _SelectedGender!,
                                    Country: SelecetedCountry!,
                                    hobbies: hobbies,
                                    birthDate: selected_date.toString(),
                                    password: PASS,
                                    profileImage: imageUrl,
                                  );
                                });
                                Change_Page();
                                // }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
  Widget Text_Field(
      {Tcontroller,
        Ltext,
        KType = TextInputType.text,
        Show = false,
        Iname = Icons.abc_sharp,
        Sicon}) {
    return TextFormField(
      controller: Tcontroller,
      keyboardType: KType,
      obscureText: Show,
      cursorColor: Colors.black,
      decoration: InputDecoration(
          prefixIcon: Icon(
            Iname,
            size: 30,
          ),
          prefixIconColor: Colors.black,
          labelText: Ltext,
          labelStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          hintText: "Enter Your $Ltext",
          hintStyle: TextStyle(fontSize: 14, color: Colors.white),
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
            onPressed: () {
              print("Tapped");
              setState(() {
                Show = false;
              });
            },
            icon: Icon(
              Sicon,
              size: 25,
              color: Colors.black,
            ),
          )),
      validator: (value) {
        if (value == null || value == "") {
          return "Please Enter The $Ltext!";
        } else {
          return null;
        }
      },
    );
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
