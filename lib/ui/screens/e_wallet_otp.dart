import 'package:chiventis/services/wallet_service.dart';
import 'package:flutter/material.dart';
import 'package:chiventis/routes.dart';
import 'package:chiventis/services/auth_service.dart';
import 'package:chiventis/ui/components/custom_text_input.dart';
import 'package:chiventis/ui/components/toast_message.dart';

class EWalletOtpPage extends StatefulWidget {
  final String name;
  final String email;

  const EWalletOtpPage({super.key, required this.name, required this.email});

  @override
  EWalletOtpPageState createState() => EWalletOtpPageState();
}

class EWalletOtpPageState extends State<EWalletOtpPage> {
  final TextEditingController _activationCodeController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Future<void> _sendOtpFuture;

  @override
  void initState() {
    super.initState();
    _sendOtpFuture = _sendOtp();
  }

  Future<void> _sendOtp() async {
    await WalletService.sendWalletOtp(context);
  }

  void _verifyWallet(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      String code = _activationCodeController.text;
      Map<String, dynamic>? res =
          await WalletService.verifyWalletOtp(context, widget.email, code);

      if (res['succes'] == true || res['status'] == true) {
        toastSuccess(context, 'Verification Successful!',
            'Please create your e-Wallet PIN', true);
        Navigator.pushNamed(context, Routes.createEWalletPin,
            arguments: widget.name);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return FutureBuilder<void>(
      future: _sendOtpFuture,
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
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
                      'Hi, ${widget.name}',
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontFamily: 'SourceSansPro',
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF424242),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      'We sent you an SMS with your activation code.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenWidth * 0.03,
                        fontFamily: 'SourceSansPro',
                        color: const Color(0xFF424242),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.1),
                    Padding(
                      padding: EdgeInsets.all(screenWidth * 0.15),
                      child: SizedBox(
                        child: Column(
                          children: [
                            CustomTextInput(
                              labelText: 'Enter Activation Code',
                              controller: _activationCodeController,
                            ),
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _verifyWallet(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text(
                        'Verify',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'SourceSansPro',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.2),
                    Text(
                      "Didn't get your activation code?",
                      style: TextStyle(
                        fontSize: screenWidth * 0.03,
                        fontFamily: 'SourceSansPro',
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF424242),
                      ),
                    ),
                    SizedBox(height: screenWidth * 0.04),
                    SizedBox(
                      width: screenWidth * 0.5,
                      child: Text(
                        'Please check email SPAM folder or try again after 2 minutes.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: screenWidth * 0.03,
                          fontFamily: 'SourceSansPro',
                          color: const Color(0xFF424242),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
