import 'package:flutter/material.dart';
import 'package:chiventis/services/auth_service.dart';
import 'package:chiventis/ui/components/custom_text_input.dart';
import 'package:chiventis/routes.dart';
import 'package:chiventis/ui/components/toast_message.dart';
import 'package:flutter/widgets.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  void _submitForgotPassword(BuildContext context) async {
    setState(() => _isLoading = true);

    if (_formKey.currentState!.validate()) {
      // Mocked API call
      String email = _emailController.text;

      // Replace this with your actual API call logic
      // For demonstration purposes, I'm just printing the email
      final res = await AuthService.forgotPassword(context, email);
      if (res['success'] == true || res['status'] == true) {
        toastSuccess(context, "OTP Sent!", '', true);
        Navigator.pushNamed(context, Routes.resetOTP, arguments: email);
      } else {
        toastSuccess(context, "Error Occurred", '', false);
      }
      // After successful submission, you can navigate to another page or do any other action
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 20.0),
                  Transform.translate(
                    offset: const Offset(-25, 0), // Adjust as needed
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: Image.asset(
                              'assets/icons/arrow-left.png',
                              width: 70,
                              height: 20,
                              color: Colors.black,
                            ),
                          ),
                          Transform.translate(
                    offset: const Offset(-30, 0), // This moves the widget 10 pixels to the left
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        "Go Back",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'SourceSansPro',
                          color: Color(0xFF424242),
                          fontWeight: FontWeight.w400  
                        ),
                      ),
                    ),
                  )],
                ),
              ),
            ),
                  SizedBox(height: screenHeight * 0.01),
                  const Image(image: AssetImage('assets/logos/logo_small.png'), height: 100, width: 100),
                  SizedBox(height: screenHeight * 0.05),
                  const SizedBox(
                      child: Text(
                    'Reset Password',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'SourceSansPro',
                        color: Color(0xFF424242)),
                    textAlign: TextAlign.center,
                  )),
                  SizedBox(
                    width: screenWidth * 0.75,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'enter your email address or mobile number to get an OTP.',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'SourceSansPro',
                          color: Color(0xFF424242),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  SizedBox(
                    width: screenWidth * 0.65,
                    height: screenHeight * 0.05,
                    child: CustomTextInput(
                      labelText: 'Email or Mobile no.',
                      controller: _emailController,
                    ),    
                  ),
                  SizedBox(height: screenHeight > 750 ? screenHeight * 0.4 : screenHeight * 0.25),
                  SizedBox(
                    width: 120,
                    child: ElevatedButton(
                      onPressed: () => _submitForgotPassword(context),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: const Size(128, 40),
                        backgroundColor: _isLoading ? Colors.black26 : null,
                      ),
                      child: const Text(
                        'Send OTP',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'SourceSansPro',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Transform.translate(
                        offset: const Offset(0, 10),  // This moves the widget 10 pixels up
                        child: const Text(
                          'I remember now!',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'SourceSansPro',
                            color: Color(0xFF424242),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'LOGIN',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'SourceSansPro',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
