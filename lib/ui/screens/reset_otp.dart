import 'package:flutter/material.dart';
import 'package:chiventis/services/auth_service.dart';
import 'package:chiventis/ui/components/custom_text_input.dart';
import 'package:chiventis/routes.dart';
import '../components//toast_message.dart';

class ResetOtpPage extends StatelessWidget {
  final TextEditingController _otpController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String email;

  ResetOtpPage({super.key, required this.email});

  void _submitOTP(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // Mocked API call
      String otp = _otpController.text;
      var res = await AuthService.verifyOTP(context, otp, email);
      if (res.values.first == true) {
        toastSuccess(context, "OTP Verified!", '', true);
        Navigator.pushNamed(context, Routes.changePassword);
      } else {
        toastSuccess(context, "Invalid OTP", '', false);
      }
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
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: screenHeight * 0.05),
                  const Image(image: AssetImage('assets/logos/logo_small.png')),
                  SizedBox(height: screenHeight * 0.05),
                  SizedBox(
                    width: screenWidth * 0.7,
                    child: const Text(
                      'Enter OTP',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'SourceSansPro',
                        color: Color(0xFF424242)
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  SizedBox(
                    width: screenWidth * 0.6,
                    height: screenHeight * 0.05,
                    child: CustomTextInput(
                      labelText: '******',
                      controller: _otpController,
                    ),
                  ),
                  SizedBox(height: screenHeight > 750 ? screenHeight * 0.5 : screenHeight * 0.4),
                  ElevatedButton(
                    onPressed: () => _submitOTP(context),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(128, 40),
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'SourceSansPro',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(''),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
