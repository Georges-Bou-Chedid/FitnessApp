import 'package:country_picker/country_picker.dart';
import 'package:fitnessapp/screens/authenticate/signup_screen.dart';
import 'package:fitnessapp/services/auth.dart';
import 'package:flutter/material.dart';
import '../splash_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginSignup createState() => LoginSignup();
}

class LoginSignup extends State<LoginPage> {
  final AuthService _authService = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // text field state
  String email = "";
  String password = "";
  String error = "";

  void signIn() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/loginbackground.jpg'), // Path to your image
                fit: BoxFit.cover, // Adjust as needed (cover, contain, etc.)
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/nutrilebwhite.png', // Replace with your app's logo
                          width: 200.0,
                          height: 200.0,
                          alignment: Alignment.center,
                          frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
                            if (wasSynchronouslyLoaded) {
                              return child;
                            }
                            return AnimatedOpacity(
                              opacity: frame == null ? 0 : 1,
                              duration: const Duration(seconds: 1),
                              curve: Curves.easeOut,
                              child: child,
                            );
                          },
                        ),
                        const Text(
                          'Elevate Your Fitness Journey',
                          style: TextStyle(
                            fontFamily: "ComingSoon",
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          validator: (val) {
                            if (isEmailValid(val!)) {
                              return null;
                            } else {
                              return 'Please enter a valid email address';
                            }
                          },
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                          style: const TextStyle(color: Color(0xFFFFFFFF)),
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              fontFamily: "Inter",
                              color: Color(0xFFFFFFFF)
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          validator: (val) => val!.length < 6 ? "Please enter a password 6+ chars long" : null,
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                          style: const TextStyle(color: Color(0xFFFFFFFF)),
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              fontFamily: "Inter",
                              color: Color(0xFFFFFFFF)
                            ),
                            border: OutlineInputBorder(),
                          ),
                          obscureText: true,
                        ),
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(0),
                            minimumSize: const Size(0, 50), // Set the minimum height you want
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ), // Set the background color to null to remove it
                          ),
                          child: Ink(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              gradient: const LinearGradient(
                                colors: [Color(0xFF3FCC7C), Color(0xFFBCFF5C)], // Gradient colors
                                begin: Alignment.bottomLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  color: Color(0xFF323232),
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            error = "";
                            if (_formKey.currentState!.validate()) {
                              dynamic result = await _authService.signInWithEmailAndPassword(email, password);
                              if (result == null) {
                                  setState(() {
                                    error = "Your email or password are incorrect";
                                  });
                              } else {
                                // After successful sign-in, navigate to the splash screen
                                signIn();
                              }
                            }
                          },
                        ),
                        const SizedBox(height: 8.0,),
                        Text(
                          error,
                          style: const TextStyle(
                            color: Colors.red,
                            fontFamily: "Inter",
                            fontSize: 14.0
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        TextButton(
                          onPressed: () {
                            gender = "";
                            age = 0;
                            selectedCountry = Country.parse("LB");
                            height = 0;
                            weight = 0;
                            signUpEmail = "";
                            signUpPassword = "";
                            appBarTitle = "Personal Info";
                            Navigator.of(context).push(_signUpRoute());
                          },
                          child: const Text(
                            'Don\'t have an account? Sign Up',
                            style: TextStyle(
                              fontFamily: "Inter",
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ),
          ),
        ),
      ),
    );
  }
}

PageRouteBuilder<dynamic> _signUpRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const StepByStepSignUpPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0); // Slide in from the bottom
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(
        CurveTween(curve: curve),
      );

      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}