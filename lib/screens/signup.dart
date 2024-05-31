import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/model/UserClass.dart';
import 'package:ecommerce/model/userProvider.dart';
import 'package:ecommerce/services/userOperations.dart';
import 'package:ecommerce/screens/login.dart';

class Signup extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<Signup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  UserClass user = UserClass(usermail: '', password: '');
  UserOperations operate = UserOperations();
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _phonenoController = TextEditingController();
  final TextEditingController _useremailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                    SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: TextFormField(
                        controller: _fullnameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "This field is required";
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 9, right: 9),
                            child: Icon(
                              Icons.account_circle_outlined,
                              color: Colors.black,
                            ),
                          ),
                          labelText: 'Full Name',
                          labelStyle: TextStyle(
                              fontFamily: 'Lufga', fontWeight: FontWeight.w100),
                          fillColor: Colors.grey[100],
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: _phonenoController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "This field is required";
                          } else if (value.length != 10) {
                            return "Phone number should be exactly 10 characters";
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 9, right: 9),
                            child: Icon(
                              Icons.phone,
                              color: Colors.black,
                            ),
                          ),
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(
                              fontFamily: 'Lufga', fontWeight: FontWeight.w100),
                          fillColor: Colors.grey[100],
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: TextFormField(
                        controller: _useremailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "This field is required";
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 9, right: 9),
                            child: Icon(
                              Icons.person_2,
                              color: Colors.black,
                            ),
                          ),
                          labelText: 'Usermail',
                          labelStyle: TextStyle(
                              fontFamily: 'Lufga', fontWeight: FontWeight.w100),
                          fillColor: Colors.grey[100],
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          } else if (value.length < 8) {
                            return 'Password must be at least 8 characters long';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 9, right: 9),
                            child: Icon(
                              Icons.lock_outline,
                              color: Colors.black,
                            ),
                          ),
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(left: 14, right: 14),
                            child: Icon(
                              Icons.remove_red_eye,
                              color: Colors.black,
                            ),
                          ),
                          labelText: 'Password',
                          labelStyle: TextStyle(
                              fontFamily: 'Lufga', fontWeight: FontWeight.w100),
                          fillColor: Colors.grey[100],
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Center(
                      child: Consumer<userProvider>(
                          builder: (context, provider, child) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            minimumSize: Size(180, 50),
                          ),
                          onPressed: () async {
                            final form = _formKey.currentState;
                            if (form!.validate()) {
                              print("Valid Form");
                              user.usermail = _useremailController.text.trim();
                              user.password = _passwordController.text.trim();
                              user.phone =
                                  int.parse(_phonenoController.text.trim());
                              user.name = _fullnameController.text.trim();
                              provider.setValue(user.usermail, user.name!);
                              int a = await operate.add(user);
                              int b = await operate.create(user);
                              if (a == 1 && b == 1) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Login(),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("Account couldn't be created"),
                                  duration: Duration(milliseconds: 1500),
                                ));
                              }
                            } else {
                              print("error in form");
                            }
                          },
                          child: Text(
                            'SignUp',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.0,
                              fontFamily: 'Lufga',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an Account?',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 63, 63, 63),
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding:
                                EdgeInsets.only(left: 2), // Remove the padding
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          },
                          child: Text(
                            'Login',
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
            ),
          ],
        ),
      ),
    );
  }
}
