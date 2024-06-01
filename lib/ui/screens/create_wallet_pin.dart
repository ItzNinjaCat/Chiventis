import 'package:chiventis/services/wallet_service.dart';
import 'package:flutter/material.dart';
import 'package:chiventis/routes.dart';
import 'package:chiventis/services/auth_service.dart';
import 'package:chiventis/ui/components/custom_text_input.dart';
import 'package:chiventis/ui/components/toast_message.dart';

class CreateEWalletPinPage extends StatelessWidget {
  final TextEditingController _activationCodeController =
      TextEditingController();
  final TextEditingController _activationCodeConfirmController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String name;
  CreateEWalletPinPage({super.key, required this.name});

  void _createPin(BuildContext context) async {
    if (_activationCodeConfirmController.text !=
        _activationCodeController.text) {
      toastSuccess(context, "PINs do not match", '', false);
      return;
    }
    if (_formKey.currentState!.validate()) {
      // Mocked API call
      String code = _activationCodeController.text;
      // Replace this with your actual API call logic
      // For demonstration purposes, I'm just printing the email and password
      Map<String, dynamic> res =
          await WalletService.createEWalletPin(context, code);

      if (res['succes'] == true || res['status'] == true) {
        Navigator.pushNamed(context, Routes.home);
        toastSuccess(context, '', 'Your e-Wallet is now active', true);
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
                Text(
                  'Hi, $name',
                  style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontFamily: 'SourceSansPro',
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF424242)),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  'please create your e-Wallet PIN',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: screenWidth * 0.03,
                      fontFamily: 'SourceSansPro',
                      color: const Color(0xFF424242)),
                ),
                SizedBox(height: screenHeight * 0.1),
                Text(
                  'Create new  PIN',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: screenWidth * 0.03,
                      fontFamily: 'SourceSansPro',
                      color: const Color(0xFF424242)),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.15,
                        vertical: screenWidth * 0.03),
                    child: SizedBox(
                        child: Column(children: [
                      CustomTextInput(
                        labelText: 'PIN',
                        controller: _activationCodeController,
                      ),
                    ]))),
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.15, vertical: 0.03),
                    child: SizedBox(
                        child: Column(children: [
                      CustomTextInput(
                        labelText: 'Re-enter PIN',
                        controller: _activationCodeConfirmController,
                      ),
                    ]))),
                SizedBox(height: screenHeight * 0.4),
                ElevatedButton(
                  onPressed: () {
                    _createPin(context);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8.0), // Adjust the border radius as needed
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'SourceSansPro',
                        fontWeight: FontWeight.bold),
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
