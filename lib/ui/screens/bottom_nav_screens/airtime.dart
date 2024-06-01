import 'package:chiventis/services/wallet_service.dart';
import 'package:flutter/material.dart';
import 'package:chiventis/services/finance_service.dart';
import 'package:chiventis/ui/components/checkmark_button.dart';
import 'package:chiventis/ui/components/custom_text_input.dart';
import 'package:chiventis/ui/components/image_ckeckmark_button.dart';
import 'package:chiventis/ui/components/input_group.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:chiventis/ui/components/payment_dialog.dart';
import 'package:chiventis/ui/components/toast_message.dart';

class AirtimePage extends StatefulWidget {
  const AirtimePage({super.key});

  @override
  State<AirtimePage> createState() => _AirtimePageState();
}

class _AirtimePageState extends State<AirtimePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  double amount = 0.0;
  String provider = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      double screenWidth = MediaQuery.of(context).size.width;
      double screenHeight = MediaQuery.of(context).size.height;
      double parentWidth = constraints.maxWidth;
      double parentHeight = constraints.maxHeight;
      return Scaffold(
          body: SingleChildScrollView(
              child: Padding(
        padding: EdgeInsets.only(
            top: parentHeight * 0.05,
            bottom: parentHeight * 0.02,
            left: parentWidth * 0.05,
            right: parentWidth * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.85,
                    padding: const EdgeInsets.all(18.0),
                    decoration: BoxDecoration(
                      color: Colors.white, // Background color of the box
                      border: Border.all(
                        color: Colors.black, // Border color
                        width: 1.0, // Border width
                      ),
                      borderRadius: BorderRadius.circular(
                          10.0), // Optional: Add rounded corners
                    ),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Mobile number:'),
                            ),
                            SizedBox(height: screenHeight * 0.002),
                            SizedBox(
                              child: CustomTextInput(
                                labelText: 'Mobile number',
                                controller: _phoneController,
                                keyboardType: TextInputType.phone,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () async {
                                  // Request permission for accessing contacts
                                  var status =
                                      await Permission.contacts.request();
                                  if (status.isGranted) {
                                    // Permission granted, open contact selector
                                    openContactSelector(context);
                                  } else {}
                                },
                                child: RichText(
                                  text: const TextSpan(
                                      style: TextStyle(color: Colors.blue),
                                      children: [
                                        TextSpan(text: 'Select from '),
                                        TextSpan(
                                            text: 'CONTACTS',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold))
                                      ]),
                                ),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Select network provider:'),
                            ),
                            Row(
                              children: [
                                ImageCheckmarkButton(
                                  onTap: () {
                                    setState(() {
                                      provider = 'glo';
                                    });
                                  },
                                  buttonValue: 'glo',
                                  stateValue: provider,
                                  buttonImage: 'assets/logos/glo_logo.png',
                                ),
                                ImageCheckmarkButton(
                                  onTap: () {
                                    setState(() {
                                      provider = 'airtel';
                                    });
                                  },
                                  buttonValue: 'airtel',
                                  stateValue: provider,
                                  buttonImage: 'assets/logos/airtel_logo.png',
                                ),
                                ImageCheckmarkButton(
                                  onTap: () {
                                    setState(() {
                                      provider = 'mtn';
                                    });
                                  },
                                  buttonValue: 'mtn',
                                  stateValue: provider,
                                  buttonImage: 'assets/logos/mtn_logo.png',
                                ),
                                ImageCheckmarkButton(
                                  onTap: () {
                                    setState(() {
                                      provider = '9mobile';
                                    });
                                  },
                                  buttonValue: '9mobile',
                                  stateValue: provider,
                                  buttonImage: 'assets/logos/9mobile_logo.png',
                                ),
                              ],
                            ),
                            SizedBox(height: parentHeight * 0.005),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Amount:'),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CheckmarkButton(
                                  onTap: () {
                                    setState(() {
                                      amount = 50.0;
                                    });
                                  },
                                  buttonVal: 50,
                                  stateVal: amount,
                                  buttonValue: '₦50',
                                ),
                                CheckmarkButton(
                                  onTap: () {
                                    setState(() {
                                      amount = 100.0;
                                    });
                                  },
                                  buttonVal: 100,
                                  stateVal: amount,
                                  buttonValue: '₦100',
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CheckmarkButton(
                                  onTap: () {
                                    setState(() {
                                      amount = 200.0;
                                    });
                                  },
                                  buttonVal: 200,
                                  stateVal: amount,
                                  buttonValue: '₦200',
                                ),
                                CheckmarkButton(
                                  onTap: () {
                                    setState(() {
                                      amount = 500.0;
                                    });
                                  },
                                  buttonVal: 500,
                                  stateVal: amount,
                                  buttonValue: '₦500',
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CheckmarkButton(
                                  onTap: () {
                                    setState(() {
                                      amount = 1000.0;
                                    });
                                  },
                                  buttonVal: 1000,
                                  stateVal: amount,
                                  buttonValue: '₦1000',
                                ),
                                CheckmarkButton(
                                  onTap: () {
                                    setState(() {
                                      amount = 2000.0;
                                    });
                                  },
                                  buttonVal: 2000,
                                  stateVal: amount,
                                  buttonValue: '₦2000',
                                ),
                              ],
                            ),
                            SizedBox(height: parentHeight * 0.005),
                            const Align(
                                alignment: Alignment.center, child: Text("OR")),
                            SizedBox(height: parentHeight * 0.005),
                            InputGroup(
                              onChanged: (value) {
                                setState(() {
                                  amount =
                                      value.isEmpty ? 0.0 : double.parse(value);
                                });
                              },
                            ),
                            SizedBox(height: parentHeight * 0.007),
                            SizedBox(
                              width: 180,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                                    (Set<MaterialState> states) {
                                      if (_isLoading) {
                                        return Colors.grey;
                                      }
                                      // Return the default background color here if needed
                                      return null; // Use the default button color
                                    },
                                  ),
                                  shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ))),
                                onPressed: () async {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  if (_phoneController.text.isEmpty) {
                                    toastSuccess(
                                        context,
                                        'Error: Phone number is required.',
                                        'Please enter a phone number',
                                        false);
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    return;
                                  }
                                  if (provider.isEmpty) {
                                    toastSuccess(
                                        context,
                                        'Error: Network provider is required.',
                                        'Please select a network provider',
                                        false);
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    return;
                                  }
                                  if (amount == 0.0) {
                                    toastSuccess(
                                        context,
                                        'Error: Amount is required.',
                                        'Please select an amount',
                                        false);
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    return;
                                  }

                                  final String? url =
                                      await FinanceService.airtimePaystack(
                                          context,
                                          _phoneController.text,
                                          provider,
                                          amount);

                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return PaymentDialog(
                                        amount: amount,
                                        onPay: (pin) {
                                          return WalletService
                                              .topupAirtimeWithWallet(
                                                  context,
                                                  _phoneController.text,
                                                  provider,
                                                  amount,
                                                  pin);
                                        },
                                        payStackUrl: url,
                                        type: 'Airtime',
                                        content: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'Mobile number:',
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(_phoneController.text,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'Provider:',
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(provider,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold))
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'Amount:',
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text('₦$amount',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold))
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                  setState(() {
                                    _isLoading = false;
                                  });
                                },
                                child: const Text('Continue'),
                              ),
                            )
                          ],
                        ))))
          ],
        ),
      )));
    });
  }

  void openContactSelector(BuildContext context) async {
    FullContact contact = await FlutterContactPicker.pickFullContact();
    String? phoneNumber = contact.phones.first.number?.replaceAll(' ', '');
    _phoneController.text = phoneNumber!;
    print('Selected Contact Phone Number: $phoneNumber');
  }
}
