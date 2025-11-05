import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'home_screen.dart';
import 'SQLHelper/dbHelper.dart';
import 'signup.dart';


class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreenHome(),
    );
  }
}


class LoginScreenHome extends StatefulWidget {
  @override
  State<LoginScreenHome> createState() => _LoginScreenHomeState();
}


class _LoginScreenHomeState extends State<LoginScreenHome> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();


  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  Future<void> _checkInput() async {
    if (_usernameController.text.isEmpty) {
      _showErrorDialog('Error', 'Username is empty');
    } else if (_passwordController.text.isEmpty) {
      _showErrorDialog('Error', 'Password is empty');
    } else {
      final loginResult = await _dbHelper.loginUser(
        _usernameController.text,
        _passwordController.text,
      );
      if (loginResult.isNotEmpty) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        _showErrorDialog('Error', 'Username or Password is invalid');
      }
    }
  }


  void _showErrorDialog(String title, String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      title: title,
      desc: message,
      btnOkOnPress: () {},
      width: 300,
    ).show();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SizedBox(
            width: 400,
            child: Card(
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Welcome!",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Username",
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Password",
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      height: 50.0,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: _checkInput,
                        child: Text('Login', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("No account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      SignupScreen()),
                            );
                          },
                          child: Text("Click Here"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

