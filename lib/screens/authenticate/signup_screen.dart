import 'package:country_picker/country_picker.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessapp/models/UserProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../controllers/auth.dart';
import '../../controllers/countries.dart';
import '../../controllers/user.dart';
import '../splash_screen.dart';

// Declare all global variables
final GlobalKey<FormState> firstStepKey = GlobalKey<FormState>();
final GlobalKey<FormState> secondStepKey = GlobalKey<FormState>();
final GlobalKey<FormState> thirdStepKey = GlobalKey<FormState>();

final TextEditingController _genderEditingController = TextEditingController();
final TextEditingController _ageEditingController = TextEditingController();
Country selectedCountry = Country.parse("LB");

final TextEditingController _heightEditingController = TextEditingController();
final TextEditingController _weightEditingController = TextEditingController();
final TextEditingController _measurementSystemEditingController = TextEditingController();

final TextEditingController _fullNameEditingController = TextEditingController();
final TextEditingController _phoneNumberEditingController = TextEditingController();
final TextEditingController _signUpEmailEditingController = TextEditingController();
final TextEditingController _signUpPasswordEditingController = TextEditingController();

class StepByStepSignUpPage extends StatefulWidget {
  const StepByStepSignUpPage({super.key});

  @override
  _StepByStepPageState createState() => _StepByStepPageState();
}

class _StepByStepPageState extends State<StepByStepSignUpPage>{
  final AuthService _authService = AuthService();
  final UserService _userService = UserService();
  late int currentStep;
  String? error;
  String? appBarTitle;

  final List<Widget> steps = [
    const FirstStep(),
    const SecondStep(),
    const ThirdStep(),
  ];

  @override
  void initState() {
    super.initState();
    currentStep = 0;
    error = "";
    appBarTitle = "Personal Info";
    _genderEditingController.text = "";
    _ageEditingController.text = "";
    selectedCountry = Country.parse("LB");
    _heightEditingController.text = "";
    _weightEditingController.text = "";
    _measurementSystemEditingController.text = "Metric";
    _fullNameEditingController.text = "";
    _phoneNumberEditingController.text = "";
    _signUpEmailEditingController.text = "";
    _signUpPasswordEditingController.text = "";
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _nextStep() {
    if (currentStep < steps.length - 1) {
      if (steps[currentStep].toString() == "FirstStep"){
        if (! firstStepKey.currentState!.validate()) {
          return;
        }
      }
      if (steps[currentStep].toString() == "SecondStep"){
        if (! secondStepKey.currentState!.validate()) {
          return;
        }
      }
      setState(() {
        currentStep++;
      });
      changeAppBarTitleBasedOnCurrentStep();
    } else {
      if (thirdStepKey.currentState!.validate()) {
        _authService.registerWithEmailAndPassword(_signUpEmailEditingController.text, _signUpPasswordEditingController.text).then((result) {
          if (mounted) {
            if (result is User) {
              // Create user profile table
              UserProfile userProfile = UserProfile(
                  name: _fullNameEditingController.text,
                  phoneNumber: _phoneNumberEditingController.text,
                  gender: _genderEditingController.text,
                  age: int.tryParse(_ageEditingController.text),
                  country: selectedCountry.countryCode,
                  height: int.tryParse(_heightEditingController.text),
                  weight: int.tryParse(_weightEditingController.text),
                  measurementSystem: _measurementSystemEditingController.text,
                  darkMode: true
              );
              _userService.createProfile(result.uid, userProfile).then((profileResult) {
                if (mounted) {
                  if (profileResult) {
                    // After successful sign-up, navigate to the splash screen
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SplashScreen(),
                      ),
                    );
                  } else {
                    _authService.removeUser();
                    error = 'An unexpected error occurred while signing up. Please try again later or contact support for assistance';
                    showErrorSigningUp(error!);
                  }
                }
              });
            } else if (result == "in-use") {
              error = 'Email is already in use';
              showErrorSigningUp(error!);
            } else {
              error = 'An unexpected error occurred while signing up. Please try again later or contact support for assistance';
              showErrorSigningUp(error!);
            }
          }
        });
      }
    }
  }

  void _previousStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
      changeAppBarTitleBasedOnCurrentStep();
    }
  }

  void changeAppBarTitleBasedOnCurrentStep() {
    if (steps[currentStep].toString() == "FirstStep"){
      appBarTitle = "Personal Info";
    }
    if (steps[currentStep].toString() == "SecondStep"){
      appBarTitle = "Personal Info";
    }
    if (steps[currentStep].toString() == "ThirdStep"){
      appBarTitle = "Sign Up";
    }
  }

  void showErrorSigningUp(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF323232), // Background color
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                'OK',
                style: TextStyle(
                    fontFamily: "Inter"
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
        title: Text(
          appBarTitle!,
          style: const TextStyle(
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
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: const Color(0xFFFFFFFF),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    LinearProgressIndicator(
                      value: (currentStep + 1) / steps.length,
                      backgroundColor: Colors.grey[300],
                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF323232)),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    Expanded(
                      child: steps[currentStep],
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: <Widget>[
                        if (currentStep > 0)
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF323232), // Background color
                            ),
                            onPressed: _previousStep,
                            child: const Text(
                              'Previous',
                              style: TextStyle(
                                fontFamily: "Inter",
                              ),
                            ),
                          ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF323232), // Background color
                          ),
                          onPressed: _nextStep,
                          child: Text(
                            currentStep == steps.length - 1 ? 'Finish' : 'Next',
                            style: const TextStyle(
                              fontFamily: "Inter"
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
            ),
          ),
        ),
      ),
    );
  }
}







class FirstStep extends StatefulWidget {
  const FirstStep({super.key});

  @override
  _FirstStepState createState() => _FirstStepState();
}

class _FirstStepState extends State<FirstStep>{

  void _onCountryChanged(Country? country) {
    setState(() {
      selectedCountry = country!;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> genders = ['Male', 'Female', 'Other'];

    return SingleChildScrollView(
      child: Form(
        key: firstStepKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 40.0),
            const Text(
              'Please select your gender to calculate your calorie needs:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "Inter",
              ),
            ),
            const SizedBox(height: 8.0),
            DropdownButtonFormField<String>(
              validator: (value) {
                if (value == null) {
                  return 'Please select an option';
                }
                return null; // Return null if the value is valid
              },
              decoration: const InputDecoration(
                labelText: 'Select your gender',
                labelStyle: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 13
                ),
                border: OutlineInputBorder(),
              ),
              value: _genderEditingController.text == "" ? null : _genderEditingController.text,
              onChanged: (String? newValue) {
                setState(() {
                  _genderEditingController.text = newValue!;
                });
              },
              items: genders.map<DropdownMenuItem<String>>((String gender) {
                return DropdownMenuItem<String>(
                  value: gender,
                  child: Text(gender),
                );
              }).toList(),
            ),
            const SizedBox(height: 30.0),
            const Text(
              'Please enter your age:',
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            SizedBox(
              width: 150,
              child: TextFormField(
                validator: (val) => val!.isEmpty || int.tryParse(val)! < 1 || int.tryParse(val)! > 100 ? "Please enter your age\nbetween 1 and 100" : null,
                controller: _ageEditingController,
                keyboardType: TextInputType.number, // Use numeric keyboard
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly // Restrict input to digits (integers)
                ],
                decoration: const InputDecoration(
                  labelText: 'Age',
                  labelStyle: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 13
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            const Text(
              'Please select your country:',
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 18.0),
            CountryDropdown(
              selectedCountry: selectedCountry,
              onCountryChanged: _onCountryChanged,
            ),
          ],
        ),
      ),
    );
  }
}






class SecondStep extends StatefulWidget {
  const SecondStep({super.key});

  @override
  _SecondStepState createState() => _SecondStepState();
}

class _SecondStepState extends State<SecondStep> {
  List<String> measurementSystems = ['Imperial', 'Metric'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
      key: secondStepKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 40.0),
            const Text(
              'Please enter your height',
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            SizedBox(
              width: 170,
              child: TextFormField(
                validator: (val) => val!.isEmpty ? "Please enter your height" : null,
                controller: _heightEditingController,
                keyboardType: TextInputType.number, // Use numeric keyboard
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly // Restrict input to digits (integers)
                ],
                decoration: const InputDecoration(
                  labelText: 'Height',
                  labelStyle: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 13
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            const Text(
              'Please enter your weight',
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            SizedBox(
              width: 170,
              child: TextFormField(
                validator: (val) => val!.isEmpty ? "Please enter your weight" : null,
                controller: _weightEditingController,
                keyboardType: TextInputType.number, // Use numeric keyboard
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly // Restrict input to digits (integers)
                ],
                decoration: const InputDecoration(
                  labelText: 'Weight',
                  labelStyle: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 13
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            const Text(
              'Measurement System',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "Inter",
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                SizedBox(
                  width: 200,
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Select your measurement system',
                      labelStyle: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 13
                      ),
                      border: OutlineInputBorder(),
                    ),
                    value: _measurementSystemEditingController.text,
                    onChanged: (String? newValue) {
                      setState(() {
                        _measurementSystemEditingController.text = newValue!;
                      });
                    },
                    items: measurementSystems.map<DropdownMenuItem<String>>((String measurementSystem) {
                      return DropdownMenuItem<String>(
                        value: measurementSystem,
                        child: Text(measurementSystem),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(width: 8.0),
                HintButton(
                  hint: 'Imperial System:\n'
                      '  - Height: feet/inches\n'
                      '  - Weight: pounds\n'
                      '  - Energy: calories\n'
                      '  - Water: liters\n'
                      'Metric System:\n'
                      '  - Height: centimeters\n'
                      '  - Weight: kilograms\n'
                      '  - Energy: calories\n'
                      '  - Water: fluid ounces',
                  child: IconButton(
                    onPressed: () {
                      // Your button's onPressed logic here
                    },
                    icon: Image.asset('assets/images/icons/info.png', width: 24, height: 24),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}


class ThirdStep extends StatefulWidget {
  const ThirdStep({super.key});

  @override
  _ThirdStepState createState() => _ThirdStepState();
}

class _ThirdStepState extends State<ThirdStep> {
  String _confirmPassword = '';
  bool showPassword = true;
  bool showConfirmPassword = true;

  String? _validatePassword(String value) {
    if (value.length < 6) {
      return 'Please enter a password 6+ chars long';
    }

    if (value != _signUpPasswordEditingController.text) {
      return 'Passwords do not match';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
      return SingleChildScrollView(
        child: Form(
          key: thirdStepKey,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 50.0),
              const Text(
                'Almost done! Create your account.',
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: "BebasNeue",
                  color: Color(0xFF323232),
                ),
              ),
              const SizedBox(height: 30.0),
              TextFormField(
                validator: (val) => val!.isEmpty ? "Please enter your full name" : null,
                controller: _fullNameEditingController,
                decoration: const InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 14
                    ),
                    border: OutlineInputBorder()
                ),
              ),

              const SizedBox(height: 20.0),
              TextFormField(
                controller: _phoneNumberEditingController,
                decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    labelStyle: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 14
                    ),
                    border: OutlineInputBorder()
                ),
                keyboardType: TextInputType.number, // Use numeric keyboard
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly // Restrict input to digits (integers)
                ],
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
                controller: _signUpEmailEditingController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 14
                  ),
                  border: OutlineInputBorder()
                ),
                keyboardType: TextInputType.emailAddress
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                validator: (val) =>  _validatePassword(val!),
                controller: _signUpPasswordEditingController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      icon: const Icon(
                          Icons.remove_red_eye_outlined
                      )
                  ),
                  labelText: 'Password',
                  labelStyle: const TextStyle(
                      fontFamily: "Inter",
                      fontSize: 14
                  ),
                  border: const OutlineInputBorder(),
                ),
                obscureText: showPassword,
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                validator: (val) => _validatePassword(val!),
                onChanged: (val) {
                  setState(() {
                    _confirmPassword = val;
                  });
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        showConfirmPassword = !showConfirmPassword;
                      });
                    },
                    icon: const Icon(
                      Icons.remove_red_eye_outlined
                    )
                  ),
                  labelText: 'Confirm Password',
                  labelStyle: const TextStyle(
                      fontFamily: "Inter",
                      fontSize: 14
                  ),
                  border: const OutlineInputBorder(),
                ),
                obscureText: showConfirmPassword,
              ),
            ],
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

class HintButton extends StatelessWidget {
  final String hint;
  final Widget child;

  const HintButton({super.key, required this.hint, required this.child});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: hint,
      child: child,
    );
  }
}

