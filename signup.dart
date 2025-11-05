import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ActivityFLUTS/SQLHelper/dbHelper.dart';
import 'package:flutter/material.dart';






class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SignupHome());
  }
}


class SignupHome extends StatefulWidget {
  @override
  State<SignupHome> createState() => _SignupHomeState();
}


class _SignupHomeState extends State<SignupHome> {
  var firstNamecontroller = TextEditingController();


  var middleNamecontroller = TextEditingController();


  var lastNamecontroller = TextEditingController();


  var emailcontroller = TextEditingController();


  var passwordcontroller = TextEditingController();


  var confirmpasswordcontroller = TextEditingController();


  var showpasswordone = true;


  var showpasswordtwo = true;


  DatabaseHelper dbHelper = DatabaseHelper();


  Future<void> validateinputs() async {
    var firstName = firstNamecontroller.text;
    var middleName = middleNamecontroller.text;
    var lastName = lastNamecontroller.text;
    var email = emailcontroller.text;
    var password = passwordcontroller.text;
    var confirmpassword = confirmpasswordcontroller.text;


    if(firstName.isEmpty){
      AwesomeDialog(
          width: 400,
          context: context,
          dialogType: DialogType.error,
          title: "error",
          desc: 'Firstname is Empty',
          btnOkOnPress: () {})
          .show();
    }
    else if (middleName.isEmpty){
      AwesomeDialog(
          width: 400,
          context: context,
          dialogType: DialogType.error,
          title: "error",
          desc: 'Middlename is Empty',
          btnOkOnPress: () {})
          .show();
    }
    else if(lastName.isEmpty){
      AwesomeDialog(
          width: 400,
          context: context,
          dialogType: DialogType.error,
          title: "error",
          desc: 'Lastname is Empty',
          btnOkOnPress: () {})
          .show();
    }
    else if(email.isEmpty){
      AwesomeDialog(
          width: 400,
          context: context,
          dialogType: DialogType.error,
          title: "error",
          desc: 'Email is Empty',
          btnOkOnPress: () {})
          .show();
    }
    else if(password.isEmpty){
      AwesomeDialog(
          width: 400,
          context: context,
          dialogType: DialogType.error,
          title: "error",
          desc: 'Password is Empty',
          btnOkOnPress: () {})
          .show();
    }
    else if(confirmpassword.isEmpty) {
      AwesomeDialog(
          width: 400,
          context: context,
          dialogType: DialogType.error,
          title: "error",
          desc: 'Confirm password is Empty',
          btnOkOnPress: () {})
          .show();
    }
    else{
      if(password!=confirmpassword){
        AwesomeDialog(
            width: 400,
            context: context,
            dialogType: DialogType.error,
            title: "error",
            desc: 'Password dont match',
            btnOkOnPress: () {})
            .show();
      }else{
        final insertResult = await dbHelper.insertUser(firstName, middleName, lastName, email, password);
        if(insertResult <0){
          AwesomeDialog(
            width: 300,
            context: context,
            dialogType: DialogType.success,
            title: "Success",
            desc: "Account created Succesfully",
            btnOkOnPress: () {},
          ).show();
        }else{
          AwesomeDialog(
            width: 300,
            context: context,
            dialogType: DialogType.error,
            title: "",
            desc: "Failed to create an account",
            btnOkOnPress: (){},
          ).show();
        }
      }
    }


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: Colors.deepPurpleAccent,
              height: MediaQuery.of(context).size.height / 4.5,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "SIGNUP",
                    style: TextStyle(fontSize: 24.0, color: Colors.white),
                  ),
                  Text(
                    "Please input your details below",
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: firstNamecontroller,
                      decoration: InputDecoration(
                        label: Text("Firstname"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: middleNamecontroller,
                      decoration: InputDecoration(
                        label: Text("Middlename"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: lastNamecontroller,
                      decoration: InputDecoration(
                        label: Text("Lastname"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: emailcontroller,
                      decoration: InputDecoration(
                        label: Text("Email"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      obscureText: showpasswordone,
                      controller: passwordcontroller,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              if (showpasswordone) {
                                showpasswordone = false;
                              } else {
                                showpasswordone = true;
                              }
                              setState(() {});
                            },
                            icon: Icon(Icons.remove_red_eye)),
                        label: Text("Password"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      obscureText: showpasswordtwo,
                      controller: confirmpasswordcontroller,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              if (showpasswordtwo) {
                                showpasswordtwo = false;
                              } else {
                                showpasswordtwo = true;
                              }
                              setState(() {});
                            },
                            icon: Icon(Icons.remove_red_eye)),
                        label: Text("Confirm password"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurpleAccent,
                          ),
                          onPressed: () {
                            validateinputs();
                          },
                          child: Text(
                            "Signup",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}





