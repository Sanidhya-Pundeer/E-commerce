import 'package:flutter/material.dart';
import 'package:ecommerce/model/UserClass.dart';
import 'package:ecommerce/screens/homepage.dart';
import 'package:ecommerce/screens/signup.dart';
import 'package:ecommerce/services/userOperations.dart';

class Login extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  UserOperations operate = UserOperations();
  UserClass u = UserClass(usermail: '', password: '');
  final TextEditingController _usermailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true; // Add this line for password visibility toggle

  @override
  Widget build(BuildContext context) {
    String? _usernameError;
    String? _passwordError;

    void _validateUsername(String value) {
      setState(() {
        if (value.isEmpty) {
          _usernameError = 'This field is required';
        } else {
          _usernameError = null;
        }
      });
    }

    void _validatePassword(String value) {
      setState(() {
        if (value.isEmpty) {
          _passwordError = 'This field is required';
        } else if (value.length < 8) {
          _passwordError = 'Password must be at least 8 characters long';
        } else {
          _passwordError = null;
        }
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 120.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Image(
                      image: AssetImage("assets/images/SwiftCart.png"),
                      height: 200,
                      width: 270,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 2.0, horizontal: 7.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.grey[100],
                            ),
                            child: TextFormField(
                              controller: _usermailController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              onChanged: _validateUsername,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.account_circle_rounded),
                                labelText: 'Username',
                                fillColor: Colors.grey[100],
                                filled: true,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 0),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide.none,
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide.none,
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          if (_usernameError != null)
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, left: 8.0, right: 8.0),
                              child: Text(
                                _usernameError!,
                                style: TextStyle(
                                  fontFamily: 'Lufga',
                                  fontWeight: FontWeight.normal,
                                  fontSize:
                                      12.0, // Adjust the font size as needed
                                  color: Color.fromARGB(255, 206, 46,
                                      46), // Customize the error text color
                                ),
                              ),
                            ),
                          SizedBox(height: 10.0),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 2.0, horizontal: 7.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.grey[100],
                            ),
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              onChanged: _validatePassword,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock_rounded),
                                suffixIcon: IconButton(
                                  icon: Icon(_obscurePassword
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                                labelText: 'Password',
                                fillColor: Colors.grey[100],
                                filled: true,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 0),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide.none,
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide.none,
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          if (_passwordError != null)
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, left: 8.0, right: 8.0),
                              child: Text(
                                _passwordError!,
                                style: TextStyle(
                                  fontFamily: 'Lufga',
                                  fontWeight: FontWeight.normal,
                                  fontSize:
                                      12.0, // Adjust the font size as needed
                                  color: Color.fromARGB(255, 206, 46,
                                      46), // Customize the error text color
                                ),
                              ),
                            ),
                          SizedBox(height: 20.0),
                          Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                minimumSize: Size(290, 45),
                              ),
                              onPressed: () async {
                                u.usermail = _usermailController.text.trim();
                                u.password = _passwordController.text.trim();
                                final form = _formKey.currentState;
                                if (form!.validate()) {
                                  print("Valid Form");
                                  int a = await operate.login(u);
                                  if (a == 1) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomePage(),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("Incorrect credentials"),
                                        duration: Duration(milliseconds: 1500),
                                      ),
                                    );
                                  }
                                } else {
                                  print("error in form");
                                }
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17.0,
                                    fontFamily: 'Lufga',
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an Account?',
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 63, 63, 63),
                                ),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.only(
                                      left: 2), // Remove the padding
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Signup(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: Colors.black,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
