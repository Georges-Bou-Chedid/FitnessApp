import 'package:country_picker/country_picker.dart';
import 'package:fitnessapp/models/UserInformation.dart';
import 'package:fitnessapp/services/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../services/auth.dart';
import '../../services/countries.dart';
import '../splash_screen.dart';

// Declare all global variables
final GlobalKey<FormState> firstStepKey = GlobalKey<FormState>();
final GlobalKey<FormState> secondStepKey = GlobalKey<FormState>();
final GlobalKey<FormState> thirdStepKey = GlobalKey<FormState>();

String gender = "";
int age = 0;
Country selectedCountry = Country.parse("LB");

int height = 0;
int weight = 0;

String signUpEmail = "";
String signUpPassword = "";
String appBarTitle = "Personal Info";

class StepByStepSignUpPage extends StatefulWidget {
  const StepByStepSignUpPage({super.key});

  @override
  _StepByStepPageState createState() => _StepByStepPageState();
}

class _StepByStepPageState extends State<StepByStepSignUpPage>{
  int currentStep = 0;
  String error = "";
  final AuthService _authService = AuthService();
  final UserService _userService = UserService();

  final List<Widget> steps = [
    const FirstStep(),
    const SecondStep(),
    const ThirdStep(),
  ];

  void _nextStep() async{
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
        try {
          dynamic result = await _authService.registerWithEmailAndPassword(signUpEmail, signUpPassword);

          if (result == null) {
            error = 'An unexpected error occurred while signing up. Please try again later or contact support for assistance';
            showErrorSigningUp(error);
          } else if (result == "Email is already in use") {
            error = 'Email is already in use';
            showErrorSigningUp(error);
          } else {
            // Create user info table
            var userId = result.uid;
            UserInformation userInfo = UserInformation(
                gender: gender,
                age: age,
                country: selectedCountry.countryCode,
                height: height,
                heightUnit: "cm",
                weight: weight,
                weightUnit: "kg"
            );
            await _userService.createUserInfo(userId, userInfo);

            // After successful sign-up, navigate to the splash screen
            signUp();
          }
        } catch (e) {
          error = 'An unexpected error occurred while signing up. Please try again later or contact support for assistance';
          showErrorSigningUp(error);
        }
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
          title: const Text(
            'Error',
            style: TextStyle(
              color: Colors.black, // Set the title text color
              fontWeight: FontWeight.bold, // Make the title bold
              fontSize: 20.0, // Set the title font size
            ),
          ),
          content: Text(
            errorMessage,
            style: const TextStyle(
              fontSize: 16.0, // Set the content font size
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.redAccent, // Set the button background color
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Colors.white, // Set the button text color
                ),
              ),
            ),
          ],
        );
      },
    );
  }

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appBarTitle,
          style: const TextStyle(
            fontSize: 17.0,
            fontFamily: "BebasNeue",
            color: Colors.black54,
          ),
        ),
        backgroundColor: Colors.cyan,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black54,
          ),
          onPressed: () {
            // Navigate back to the first page when the back button is pressed.
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          Image.asset(
            'assets/images/b.png', // Replace with your app's logo
            width: 100.0,
            height: 100.0,
          ),
        ],
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black54.withOpacity(0.1)],
              stops: [0.0, 0.3],
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    LinearProgressIndicator(
                      value: (currentStep + 1) / steps.length,
                      backgroundColor: Colors.grey,
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.black54),
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
                              backgroundColor: Colors.black54, // Background color
                            ),
                            onPressed: _previousStep,
                            child: const Text('Previous'),
                          ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black54, // Background color
                          ),
                          onPressed: _nextStep,
                          child: Text(currentStep == steps.length - 1 ? 'Finish' : 'Next'),
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
                labelText: 'Select your sexe',
                border: OutlineInputBorder(),
              ),
              value: gender == "" ? null : gender,
              onChanged: (String? newValue) {
                setState(() {
                  gender = newValue!;
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
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            SizedBox(
              width: 200,
              child: TextFormField(
                validator: (val) => val!.isEmpty || int.tryParse(val)! < 1 || int.tryParse(val)! > 100 ? "Please enter your age between\n1 and 100" : null,
                initialValue: age == 0 ? null : age.toString(),
                onChanged: (val) {
                  setState(() {
                    if (int.tryParse(val) != null) {
                      age = int.tryParse(val)!;
                    }
                  });
                },
                keyboardType: TextInputType.number, // Use numeric keyboard
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly // Restrict input to digits (integers)
                ],
                decoration: const InputDecoration(
                  labelText: 'Age',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            const Text(
              'Please select your country:',
              style: TextStyle(
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
              'Please enter your height in cm:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            SizedBox(
              width: 200,
              child: TextFormField(
                validator: (val) => val!.isEmpty ? "Please enter your height" : null,
                initialValue: height == 0 ? null : height.toString(),
                onChanged: (val) {
                  setState(() {
                    if (int.tryParse(val) != null) {
                      height = int.tryParse(val)!;
                    }
                  });
                },
                keyboardType: TextInputType.number, // Use numeric keyboard
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly // Restrict input to digits (integers)
                ],
                decoration: const InputDecoration(
                  labelText: 'Height',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            const Text(
              'Please enter your weight in kg:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            SizedBox(
              width: 200,
              child: TextFormField(
                validator: (val) => val!.isEmpty ? "Please enter your weight" : null,
                initialValue: weight == 0 ? null : weight.toString(),
                onChanged: (val) {
                  setState(() {
                    if (int.tryParse(val) != null) {
                      weight = int.tryParse(val)!;
                    }
                  });
                },
                keyboardType: TextInputType.number, // Use numeric keyboard
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly // Restrict input to digits (integers)
                ],
                decoration: const InputDecoration(
                  labelText: 'Weight',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
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

  String? _validatePassword(String value) {
    if (value.length < 6) {
      return 'Please enter a password 6+ chars long';
    }

    if (value != signUpPassword) {
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
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 30.0),
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
                    signUpEmail = val;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                validator: (val) =>  _validatePassword(val!),
                onChanged: (val) {
                  setState(() {
                    signUpPassword = val;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                validator: (val) => _validatePassword(val!),
                onChanged: (val) {
                  setState(() {
                    _confirmPassword = val;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
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