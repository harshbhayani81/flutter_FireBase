import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/Login_Screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> Drkey = GlobalKey();

  bool profile = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          key: Drkey,
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: IconButton(
              onPressed: (){
                Drkey.currentState!.openDrawer();
              },
              icon: Icon(
                Icons.list_sharp,
                size: 30,
                color: Colors.white,
              ),
            ),

            centerTitle: true,
            elevation: 10,
            title: Text(
              "Home",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),
            ),

            actions: [
              IconButton(
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 25,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          body: profile ? SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              // height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 30,),
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 50,
                    child: Icon(
                      Icons.person_sharp,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 50,),
                  Row(
                    children: [
                      SizedBox(width: 10,),
                      Text(
                        "ID :- ",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                      ),
                      SizedBox(width: 5,),
                      Text(
                        "1234",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      SizedBox(width: 10,),
                      Text(
                        "User Name :- ",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                      ),
                      SizedBox(width: 5,),
                      Text(
                        "Jaydip",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      SizedBox(width: 10,),
                      Text(
                        "Full Name :- ",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                        ),
                      ),
                      SizedBox(width: 5,),
                      Text(
                        "Parghi Jaydip HimmatBhai",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      SizedBox(width: 10,),
                      Text(
                        "Gender :- ",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                      ),
                      SizedBox(width: 5,),
                      Text(
                        "Male",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      SizedBox(width: 10,),
                      Text(
                        "Date Of Birth :- ",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                      ),
                      SizedBox(width: 5,),
                      Text(
                        "22/5/2003",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      SizedBox(width: 10,),
                      Text(
                        "Mobile No. :- ",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                      ),
                      SizedBox(width: 5,),
                      Text(
                        "9510273895",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      SizedBox(width: 10,),
                      Text(
                        "Gmail :- ",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                      ),
                      SizedBox(width: 5,),
                      Text(
                        "parghijaydip0522@gmail.com",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      SizedBox(width: 10,),
                      Text(
                        "Bio :- ",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                      ),
                      SizedBox(width: 5,),
                      Text(
                        "",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      SizedBox(width: 10,),
                      Text(
                        "Hobby :- ",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                      ),
                      SizedBox(width: 5,),
                      Text(
                        "Coding",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      SizedBox(width: 10,),
                      Text(
                        "City :- ",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                      ),
                      SizedBox(width: 5,),
                      Text(
                        "Ahmedabad",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ) : SingleChildScrollView(
              child: Container(
                height: 732,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CR_Btn(
                        text: "Create",
                        page: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                        },
                      BGcolor: Colors.green
                    ),
                    CR_Btn(
                      text: " Read ",
                      page: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                      },
                      BGcolor: Colors.yellow
                    ),
                    CR_Btn(
                      text: "Update",
                      page: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                      },
                      BGcolor: Colors.orange
                    ),
                    CR_Btn(
                      text: "Delete",
                      page: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                      },
                      BGcolor: Colors.red
                    )
                  ],
                ),
              )
          ),
          drawer: Drawer(
            width: 200,
            surfaceTintColor: Colors.red,
            shadowColor: Colors.yellow,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 10,),
                CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Icon(
                    Icons.person_sharp,
                    color: Colors.white,
                    size: 50,
                  ),
                  maxRadius: 50,
                ),
                SizedBox(height: 10,),
                Container(
                  height: 1.5,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black,
                ),
                TextButton(
                    onPressed: (){
                      setState(() {
                        if(profile == false)
                          {
                            profile = true;
                            Drkey.currentState!.closeDrawer();
                          }
                        else
                          {
                            profile = false;
                            Drkey.currentState!.closeDrawer();
                          }
                      });
                    },
                    child: Text(
                      "View Profile",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue
                      ),
                    ),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white
                  ),
                ),
                Container(
                  height: 1.5,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black,
                ),
                TextButton(
                  onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.logout_sharp,
                        color: Colors.black,
                      ),
                      SizedBox(width: 8,),
                      Text(
                        "LogOut",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue
                        ),
                      ),
                    ],
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white
                  ),
                ),
                Container(
                  height: 1.5,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ));
  }

  Widget CR_Btn({text,page = (),BGcolor = Colors.black}){
    return OutlinedButton(
        // onPressed: (){
        //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page.toString()));
        // },
        onPressed: page,
        style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
            ),
            backgroundColor: BGcolor
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        )
    );
  }
}
