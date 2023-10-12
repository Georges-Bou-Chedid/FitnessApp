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

  void signUp() {
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
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFFFDE8D), Color(0xFFFFA427)],
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
                      children: <Widget>[
                        Image.asset(
                          'assets/images/b.png', // Replace with your app's logo
                          width: 150.0,
                          height: 150.0,
                        ),
                        const Text(
                          'Elevate Your Fitness Journey',
                          style: TextStyle(
                            fontFamily: "ComingSoon",
                            color: Colors.black54,
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
                          decoration: const InputDecoration(
                            labelText: 'Email',
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
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                          ),
                          obscureText: true,
                        ),
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black54, // Background color
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
                                // After successful sign-up, navigate to the splash screen
                                signUp();
                              }
                            }
                          },
                          child: const Text('Log In'),
                        ),
                        const SizedBox(height: 8.0,),
                        Text(
                          error,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 14.0
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        TextButton(
                          onPressed: () {
                            appBarTitle = "Personal Info";
                            Navigator.of(context).push(_signUpRoute());
                          },
                          child: const Text(
                            'Don\'t have an account? Sign Up',
                            style: TextStyle(
                              color: Colors.black54,
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