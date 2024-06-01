import 'package:flutter/material.dart';
import 'package:chiventis/services/auth_service.dart';
import 'package:chiventis/ui/components/custom_text_input.dart';
import 'package:chiventis/routes.dart';
import '../components//toast_message.dart';

class ChangePasswordPage extends StatelessWidget {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ChangePasswordPage({super.key});

  void _createNewPassword(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // Mocked API call
      String password = _passwordController.text;
      String passwordConfirm = _passwordConfirmController.text;
      // Replace this with your actual API call logic
      // For demonstration purposes, I'm just printing the email

      if (password != passwordConfirm) {
        toastSuccess(context, "Passwords do not match", '', false);
        return;
      }

      final res =
          await AuthService.resetPassword(context, password, passwordConfirm);
      // After successful submission, you can navigate to another page or do any other action
      if (res['succes'] == true ||
          res['status'] == true ||
          res['success'] == true) {
        Navigator.pushNamed(context, Routes.login);
        toastSuccess(context, "Succesfully changed password!",
            'You can login now', true);
      } else {
        toastSuccess(context, "Error Occurred", '', false);
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
                  const Image(image: AssetImage('assets/logos/logo_small.png'), height: 100, width: 100),
                  SizedBox(height: screenHeight * 0.1),
                  const Text(
                    'Create new password',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'SourceSansPro',
                      color: Color(0xFF424242),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  SizedBox(
                    width: 275,
                    child: CustomTextInput(
                        labelText: 'Password',
                        controller: _passwordController,
                        isPassword: true),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  SizedBox(
                    width: 275,
                    child: CustomTextInput(
                        labelText: 'Re-enter Password',
                        controller: _passwordConfirmController,
                        isPassword: true),
                  ),
                  SizedBox(height: screenHeight > 750 ? screenHeight * 0.4 : screenHeight * 0.35),
                  ElevatedButton(
                    onPressed: () => _createNewPassword(context),
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
