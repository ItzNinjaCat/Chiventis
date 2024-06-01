import 'package:flutter/material.dart';
import 'package:chiventis/routes.dart';
import 'package:chiventis/services/auth_service.dart';
import 'package:chiventis/ui/components/custom_text_input.dart';
import 'package:chiventis/ui/components/toast_message.dart';

class SignUpSuccessPage extends StatelessWidget {
  final TextEditingController _activationCodeController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String email;
  SignUpSuccessPage({super.key, required this.email});

  void _verifyAccount(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // Mocked API call
      String code = _activationCodeController.text;
      // Replace this with your actual API call logic
      // For demonstration purposes, I'm just printing the email and password
      Map<String, dynamic> res =
          await AuthService.verifyAccount(context, code, email);

      if (res['succes'] == true || res['status'] == true) {
        toastSuccess(
            context, 'Successful!', 'Your account is activated.', true);
        Navigator.pushNamed(context, Routes.home);
      }
      // After successful creation, you can navigate to another page or do any other action
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: screenHeight * 0.1),
                const Text(
                  'Sign up Successful!',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'SourceSansPro',
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF424242)),
                ),
                SizedBox(height: screenHeight * 0.01),
                const Text(
                  'We sent you an email and SMS with your activation code.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 10,
                      fontFamily: 'SourceSansPro',
                      color: Color(0xFF424242)),
                ),
                SizedBox(height: screenHeight * 0.15),
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.15),
                  child: SizedBox(
                      child: Column(children: [
                    CustomTextInput(
                      labelText: 'Enter Activation Code',
                      controller: _activationCodeController,
                    ),
                  ]))
                ),
                Transform.translate(
                  offset: const Offset(0, -30),  // This moves the widget 10 pixels up
                  child: ElevatedButton(
                    onPressed: () => _verifyAccount(context),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0), // Adjust the border radius as needed
                      ),
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'SourceSansPro',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.23),
                Text(
                  "Didn't get your activation code?",
                  style: TextStyle(
                      fontSize: screenWidth * 0.03,
                      fontFamily: 'SourceSansPro',
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF424242)),
                ),
                SizedBox(height: screenWidth * 0.04),
                SizedBox(
                  width: screenWidth * 0.5,
                  child: Column(
                    children: [
                      Text(
                        'Please check email SPAM folder.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: screenWidth * 0.03,
                          fontFamily: 'SourceSansPro',
                          color: const Color(0xFF424242)),
                        ),
                      Text(
                        'or try again after 2 minutes.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: screenWidth * 0.03,
                          fontFamily: 'SourceSansPro',
                          color: const Color(0xFF424242)),
                        )
                    ]
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
