import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/Home_Screen.dart';
import 'package:flutter_firebase/Registration_Form.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  late TextEditingController Email;
  late TextEditingController Pass;
  String errormessage = '';
  GlobalKey<FormState> Frmkey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Email = TextEditingController();
    Pass = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Email.dispose();
    Pass.dispose();
  }

  Future<void> login() async{
    if(Frmkey.currentState!.validate()){
      try {
        final UserCredential userCredential = await _auth
            .signInWithEmailAndPassword(
            email: Email.text,
            password: Pass.text);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
        print("Login Successfully!! UserId ==>> ${userCredential.user?.uid}");
      } on FirebaseAuthException catch(e){
        if(e.code == 'user-not-found'){
          errormessage = "No user Found That Email";
        }
        else if(e.code == 'wrong-password'){
          errormessage = "Wrong Password Provide That Use";
        }
        else
          {
            errormessage = 'Error : ${e.message}';
          }
        setState(() {});
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: IconButton(
              onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Registration()));
              },
              icon: Icon(
                Icons.arrow_back_sharp,
                size: 30,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            elevation: 10,
            title: Text(
              "LogIn",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              // height: MediaQuery.of(context).size.height,
              height: 732,
              width: MediaQuery.of(context).size.width,
              child: Form(
                key: Frmkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text_Field(
                      KeyType: TextInputType.emailAddress,
                      Tcontroller: Email,
                      Iname: Icons.person_sharp,
                      Ltext: "Email",
                    ),
                    SizedBox(height: 10,),
                    Text_Field(
                      Tcontroller: Pass,
                      Iname: Icons.lock,
                      Ltext: "Password",
                      Show: true,
                      Sname: Icons.remove_red_eye,
                    ),
                    SizedBox(height: 10,),
                    Text(errormessage,style: TextStyle(color: Colors.red),),
                    ElevatedButton(
                        onPressed: login,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            )
                        ),
                        child: Text(
                          "Submit",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                    ),
                  ],
                ),
              ),
            )
          ),
        )
    );
  }

  Widget Text_Field({Tcontroller,Iname,Ltext,KeyType = TextInputType.text,Show = false,Sname}){
    return Container(
      width: 350,
      child: TextFormField(
        controller: Tcontroller,
        cursorColor: Colors.black,
        keyboardType: KeyType,
        obscureText: Show,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Iname,
            size: 30,
            color: Colors.black,
          ),
          labelText: Ltext,
          labelStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),
          hintText: "Enter The $Ltext",
          hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold
          ),

          border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.black,
                  width: 2
              )
          ),

          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.black,
                  width: 2
              )
          ),

          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.red,
                  width: 2
              )
          ),

          suffixIcon: IconButton(
            onPressed: (){
              setState(() {});
            },
            icon: Icon(
              Sname,
              size: 30,
              color: Colors.black,
            ),
          )
        ),
        validator: (value){
          if(value == null || value == "")
            {
              return "Please Enter The $Ltext";
            }
          else
            {
              return null;
            }
        },
      ),
    );
  }
}
