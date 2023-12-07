import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../controllers/auth.dart';
import '../../../controllers/user.dart';
import '../../../models/UserProfile.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final AuthService _authService = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _changeEmailKey = GlobalKey<FormState>();
  final TextEditingController _fullNameEditingController = TextEditingController();
  final TextEditingController _phoneNumberEditingController = TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _newEmailEditingController = TextEditingController();
  final TextEditingController _oldPasswordEditingController = TextEditingController();
  late UserService userProfileProvider;
  bool showPassword = true;
  String? error;


  @override
  void initState() {
    super.initState();
    error = "";
    userProfileProvider = Provider.of<UserService>(context, listen: false);
    _updateControllerText(userProfileProvider);
  }

  void _updateControllerText(userProfileProvider) {
    _fullNameEditingController.text = userProfileProvider.userProfile.name!;
    _phoneNumberEditingController.text = userProfileProvider.userProfile.phoneNumber!;
    _emailEditingController.text = _authService.getCurrentUser()!.email!;
  }

  String? _validatePassword(String value) {
    if (value.length < 6) {
      return 'Please enter a password 6+ chars long';
    }

    return null;
  }

  void showEmailChangeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Change Your Email Address',
            style: TextStyle(
              fontFamily: "Inter",
              fontSize: 18,
            ),
          ),
          content: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Form(
                key: _changeEmailKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'To change your email, please provide your new email address and your current password.',
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 14.0,
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      validator: (val) {
                        if (isEmailValid(val!) && val != _authService.getCurrentUser()!.email!) {
                          return null;
                        } else {
                          return 'Please enter a valid email address';
                        }
                      },
                      controller: _newEmailEditingController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 3),
                        labelText: "New Email",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 14,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      validator: (val) =>  _validatePassword(val!),
                      controller: _oldPasswordEditingController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                            icon: const Icon(
                              Icons.remove_red_eye_outlined,
                              size: 17,
                            )
                        ),
                        contentPadding: const EdgeInsets.only(bottom: 3),
                        labelText: "Password",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: const TextStyle(
                          fontFamily: "Inter",
                          fontSize: 14,
                        ),
                      ),
                      obscureText: showPassword,
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                    fontFamily: "Inter",
                    color: Color(0xFF5AC8FA)
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                if (_changeEmailKey.currentState!.validate()) {
                  _authService.changeEmail(_newEmailEditingController.text, _oldPasswordEditingController.text).then((result) {
                    if (result is User) {
                      Navigator.of(context).pop();
                      _authService.signOut();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Your email has been updated successfully! Kindly log in again to apply the changes."),
                          duration: Duration(seconds: 3), // Adjust the duration as needed
                        ),
                      );
                    } else if (result == "wrong-password") {
                      error = 'Incorrect password. Please enter the correct password.';
                      showErrorSigningUp(error!);
                    } else if (result == "in-use") {
                      error = 'Email is already in use';
                      showErrorSigningUp(error!);
                    } else {
                      error = 'An unexpected error occurred while signing up. Please try again later or contact support for assistance';
                      showErrorSigningUp(error!);
                    }
                  });
                }

              },
              child: const Text(
                'Save',
                style: TextStyle(
                  fontFamily: "Inter",
                  color: Color(0xFF5AC8FA)
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showErrorSigningUp(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Error',
            style: TextStyle(
              fontFamily: "Inter",
              fontWeight: FontWeight.bold, // Make the title bold
              fontSize: 20.0, // Set the title font size
            ),
          ),
          content: Text(
            errorMessage,
            style: const TextStyle(
              fontSize: 16.0,
              fontFamily: "Inter",
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  fontFamily: "Inter",
                  color: Color(0xFF5AC8FA),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF3FCC7C),
                Color(0xFFBCFF5C)
              ], // Define your gradient colors
              begin: Alignment.bottomLeft, // Adjust the start point as needed
              end: Alignment.bottomRight, // Adjust the end point as needed
            ),
          ),
        ),
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            fontSize: 18.0,
            fontFamily: "BebasNeue",
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            EvaIcons.chevronLeftOutline,
            color: Color(0xFF323232),
          ),
          onPressed: () {
            // Navigate back to the first page when the back button is pressed.
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          Image.asset(
            'assets/images/nutrilebblack.png', // Replace with your app's logo
            width: 100.0,
            height: 100.0,
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black26, // Set the border color here
                            width: 4, // Set the border width here
                          ),
                          boxShadow: [BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(0,10),
                          )],
                          shape: BoxShape.circle,
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/settings/user.png'),
                          )
                        )
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFFFFFFFF), // Set the border color here
                              width: 4, // Set the border width here
                            ),
                            shape: BoxShape.circle,
                            color: const Color(0xFF3FCC7C)
                          ),
                          child: const Icon(Icons.edit, color: Color(0xFFFFFFFF)),
                        )
                      )
                    ]
                )
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        TextFormField(
                          validator: (val) => val!.isEmpty ? "Please enter your full name" : null,
                          controller: _fullNameEditingController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 3),
                            labelText: "Full Name",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelStyle: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          controller: _phoneNumberEditingController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 3),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelText: 'Phone Number',
                            labelStyle: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 14
                            ),
                          ),
                          keyboardType: TextInputType.number, // Use numeric keyboard
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly // Restrict input to digits (integers)
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          controller: _emailEditingController,
                          readOnly: true,
                          decoration: InputDecoration(
                            suffixIcon: TextButton(
                                onPressed: () {
                                  showEmailChangeDialog();
                                },
                                child: const Text(
                                  'Change',
                                  style: TextStyle(
                                    fontFamily: "Inter",
                                    color: Color(0xFF5AC8FA),
                                    fontSize: 13
                                  ),
                                )
                            ),
                            contentPadding: const EdgeInsets.only(bottom: 3),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelText: 'Email',
                            labelStyle: const TextStyle(
                                fontFamily: "Inter",
                                fontSize: 14
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress
                        ),
                      ],
                    )
                  ),
                ),
              ),
              const SizedBox(height: 35),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.resolveWith((states) => const Size(130, 35)), // Adjust the width and height as needed
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 14,
                              letterSpacing: 2,
                              color: Color(0xFFFFFFFF)
                          ),
                        ),

                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith((states) => const Color(0xFF3FCC7C)),
                          minimumSize: MaterialStateProperty.resolveWith((states) => const Size(130, 35)), // Adjust the width and height as needed
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            UserProfile userProfile = UserProfile(
                                name: _fullNameEditingController.text,
                                phoneNumber: _phoneNumberEditingController.text
                            );

                            userProfileProvider.updateProfile(_authService.getCurrentUser()!.uid, userProfile).then((profileResult) {
                              if (mounted) {
                                if (profileResult) {
                                  Fluttertoast.showToast(
                                      msg: "Updated Successfully!",
                                      toastLength: Toast.LENGTH_SHORT,
                                      // Toast duration (Toast.LENGTH_SHORT or Toast.LENGTH_LONG)
                                      gravity: ToastGravity.BOTTOM,
                                      // Toast position (ToastGravity.TOP, ToastGravity.CENTER, or ToastGravity.BOTTOM)
                                      timeInSecForIosWeb: 1,
                                      // Time for iOS and web (in seconds)
                                      fontSize: 16.0
                                  );
                                  Navigator.pushReplacementNamed(context, '/settings');
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "An unexpected error occurred while updating your profile. Please try again later or contact support for assistance",
                                      toastLength: Toast.LENGTH_SHORT,
                                      // Toast duration (Toast.LENGTH_SHORT or Toast.LENGTH_LONG)
                                      gravity: ToastGravity.BOTTOM,
                                      // Toast position (ToastGravity.TOP, ToastGravity.CENTER, or ToastGravity.BOTTOM)
                                      timeInSecForIosWeb: 1,
                                      // Time for iOS and web (in seconds)
                                      fontSize: 16.0
                                  );
                                }
                              }
                            });
                          }
                        },
                        child: const Text(
                          "Save",
                          style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 14,
                              letterSpacing: 2,
                          ),
                        ),
                      ),
                    ],
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

bool isEmailValid(String email) {
  // Define a regular expression pattern for a valid email address
  final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

  // Use the RegExp's `hasMatch` method to check if the email matches the pattern
  return emailRegExp.hasMatch(email);
}