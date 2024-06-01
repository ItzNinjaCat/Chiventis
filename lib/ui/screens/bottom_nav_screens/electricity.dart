import 'package:chiventis/services/wallet_service.dart';
import 'package:flutter/material.dart';
import 'package:chiventis/services/package_service.dart';
import 'package:chiventis/services/finance_service.dart';
import 'package:chiventis/ui/components/checkmark_button.dart';
import 'package:chiventis/ui/components/custom_text_input.dart';
import 'package:chiventis/ui/components/input_group.dart';
import 'package:chiventis/ui/components/payment_dialog.dart';
import 'package:chiventis/ui/components/toast_message.dart';

class ElectricityPage extends StatefulWidget {
  const ElectricityPage({Key? key}) : super(key: key);

  @override
  _ElectricityPageState createState() => _ElectricityPageState();
}

class _ElectricityPageState extends State<ElectricityPage> {
  final _providers = [
    "Abuja Electricity Distribution Company",
    "Access Power",
    "ABA Power",
    "Benin Electricity Distribution Company",
    "Eko Electricity Distribution Company",
    "Enugu Electricity Distribution Company",
    "Ibadan Electricity Distribution Company",
    "Ikeja Electric",
    "Jos Electricity Distribution Plc",
    "Kaduna Electricity Distribution Company",
    "Kano Electricity Distribution Company",
    "Port Harcourt Electricity Distribution Company",
  ];
  String? provider = "Abuja Electricity Distribution Company";
  String category = '';
  bool toggleValue = false; // Initial state for the toggle button
  final TextEditingController _phoneController = TextEditingController();
  List<dynamic>? packages = [
    {"desc": "Select a provider first", "price": 0}
  ];
  double amount = 0;
  String disco = "";
  String meterOwner = "";
  bool error = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchPlans();
  }

  void getActiveDisco(String provider) {
    switch (provider) {
      case "Abuja Electricity Distribution Company":
        disco = "AEDC";
        break;
      case "Access Power":
        disco = "ACCESSPOWER";
        break;
      case "ABA Power":
        disco = "APLE";
        break;
      case "Benin Electricity Distribution Company":
        disco = "BENIN";
        break;
      case "Eko Electricity Distribution Company":
        disco = "EKO";
        break;
      case "Enugu Electricity Distribution Company":
        disco = "ENUGU";
        break;
      case "Ibadan Electricity Distribution Company":
        disco = "IBADAN";
        break;
      case "Ikeja Electric":
        disco = "IKEJA";
        break;
      case "Jos Electricity Distribution Plc":
        disco = "JOS";
        break;
      case "Kaduna Electricity Distribution Company":
        disco = "KADUNA";
        break;
      case "Kano Electricity Distribution Company":
        disco = "KANO";
        break;
      case "Port Harcourt Electricity Distribution Company":
        disco = "PH";
        break;
      default:
        disco = "";
    }
  }

  Future<void> fetchPlans() async {
    if (provider != null && provider!.isNotEmpty) {
      setState(() {
        packages = [
          {"desc": "Loading...", "price": 0}
        ];
      });
      try {
        final fetchedPlans = await PackageService.dataPackages(provider!);
        setState(() {
          packages = fetchedPlans!.isNotEmpty
              ? fetchedPlans
              : [
                  {"desc": "No plans available", "price": 0}
                ];
        });
      } catch (e) {
        setState(() {
          packages = [
            {"desc": "Failed to load plans", "price": 0}
          ];
        });
      }
    }
  }

  void verify() async {
    setState(() {
      _isLoading = true;
    });
    getActiveDisco(provider!);
    String? result = await FinanceService.verifyMeterNumber(
      _phoneController.text,
      disco,
      "ELECTRICITY",
    );
    if (result == null) {
      setState(() {
        error = true;
        _isLoading = false;
      });
    } else {
      setState(() {
        error = false;
        _isLoading = false;
        meterOwner = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final screenWidth = MediaQuery.of(context).size.width;
          final screenHeight = MediaQuery.of(context).size.height;
          double parentWidth = constraints.maxWidth;
          double parentHeight = constraints.maxHeight;

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                top: parentHeight * 0.05,
                bottom: parentHeight * 0.02,
                left: parentWidth * 0.05,
                right: parentWidth * 0.05,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: screenWidth * 0.9,
                      height: screenHeight * 0.85,
                      padding: EdgeInsets.all(screenHeight * 0.02),
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text('Provider:'),
                            const SizedBox(height: 5),
                            SizedBox(
                              width: screenWidth *
                                  0.8, // Set the width to 80% of the screen width
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey, // Set the border color
                                    width: 1.0, // Set the border width
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      5.0), // Optional: set the border radius
                                ),
                                child: DropdownButtonHideUnderline(
                                  // This hides the default underline
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    style: const TextStyle(
                                        fontSize: 14.0,
                                        color: Colors
                                            .black), // Set the text size for the dropdown items
                                    items: _providers
                                        .map((String item) =>
                                            DropdownMenuItem<String>(
                                              value: item,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left:
                                                        10.0), // Add left margin
                                                child: Text(item),
                                              ),
                                            ))
                                        .toList(),
                                    onChanged: (String? value) {
                                      setState(() {
                                        provider = value;
                                        packages = [
                                          {"desc": "Loading...", "price": 0}
                                        ];
                                      });
                                      fetchPlans();
                                    },
                                    value: provider,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.05),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Select Meter Type:'),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Center(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CheckmarkButton(
                                        onTap: () {
                                          setState(() {
                                            category = 'PREPAID';
                                          });
                                          fetchPlans();
                                        },
                                        buttonValue: 'Prepaid',
                                        stateVal: category,
                                        buttonVal: 'PREPAID',
                                      ),
                                      CheckmarkButton(
                                        onTap: () {
                                          setState(() {
                                            category = 'POSTPAID';
                                          });
                                          fetchPlans();
                                        },
                                        buttonValue: 'Postpaid',
                                        stateVal: category,
                                        buttonVal: 'POSTPAID',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.04),
                            const Text('Enter Account/Meter Number:'),
                            const SizedBox(height: 5),
                            SizedBox(
                              width: screenWidth *
                                  0.8, // Set the width to 80% of the screen width
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: screenWidth * 0.55,
                                    child: CustomTextInput(
                                      labelText: 'Account/Meter Number',
                                      controller: _phoneController,
                                      error: error,
                                    ),
                                  ),
                                  SizedBox(width: screenWidth * 0.02),
                                  SizedBox(
                                    width: screenWidth * 0.23,
                                    child: ElevatedButton(
                                      onPressed: verify,
                                      style: ElevatedButton.styleFrom(
                                        shadowColor: Colors.lightBlue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: !_isLoading ? 
                                        const Text(
                                          'Verify',
                                          style: TextStyle(
                                            fontFamily: 'SourceSansPro',
                                          ),
                                        ) : const SizedBox(
                                              width: 25,
                                              height: 25,
                                              child: CircularProgressIndicator(
                                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white)
                                              ),
                                        ) ,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            if (error)
                              const Padding(
                                padding: EdgeInsets.only(top: 2.0, left: 5),
                                child: Text(
                                  'Meter Not Found!',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 197, 13, 0),
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                            if (!error && meterOwner.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 2.0, left: 5),
                                child: Text(
                                  meterOwner,
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                            Transform.scale(
                              scale: 0.8, // Adjust the scale as needed
                              alignment: Alignment.centerLeft,
                              child: Transform.translate(
                                offset: const Offset(
                                    -5, -15), // Add top margin of -10px
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Transform.scale(
                                      scale:
                                          0.7, // Adjust the scale to make the switch smaller
                                      child: Switch(
                                        value: toggleValue,
                                        onChanged: (bool value) {
                                          setState(() {
                                            toggleValue = value;
                                          });
                                        },
                                      ),
                                    ),
                                    const Text(
                                      'Save Number',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Text('Enter Amount:'),
                            SizedBox(
                              width: screenWidth * 0.8,
                              child: InputGroup(
                                onChanged: (value) {
                                  setState(() {
                                    amount = value.isEmpty
                                        ? 0.0
                                        : double.parse(value);
                                  });
                                },
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.03),
                            Center(
                              child: SizedBox(
                                width: 180,
                                child: Center(
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
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                    onPressed: () async {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      if (_phoneController.text.isEmpty) {
                                        toastSuccess(
                                          context,
                                          'Error: Phone number is required.',
                                          'Please enter a phone number',
                                          false,
                                        );
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        return;
                                      }
                                      if (provider!.isEmpty) {
                                        toastSuccess(
                                          context,
                                          'Error: Network provider is required.',
                                          'Please select a network provider',
                                          false,
                                        );
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        return;
                                      }
                                      if (amount == 0.0) {
                                        toastSuccess(
                                          context,
                                          'Error: Amount is required.',
                                          'Please enter an amount',
                                          false,
                                        );
                                        return;
                                      }
                                      final String? url = await FinanceService
                                          .electricityPaystack(
                                        context,
                                        _phoneController.text,
                                        provider!,
                                        amount,
                                        category,
                                      );

                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return PaymentDialog(
                                            amount: amount,
                                            onPay: (pin) {
                                              return WalletService
                                                .topupElectricityWithWallet(
                                                  context,
                                                  _phoneController.text,
                                                  disco,
                                                  amount,
                                                  category,
                                                  pin
                                                );
                                            },
                                            payStackUrl: url,
                                            type: 'Electricity',
                                            content: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                      'Meter Type:',
                                                      style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    Text(
                                                      category,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                      'Meter Number:',
                                                      style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    Text(
                                                      _phoneController.text,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                      'Meter Owner:',
                                                      style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    Text(
                                                      meterOwner,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
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
                                                        fontSize: 16.0,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    Text(
                                                      '₦$amount',
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
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
                                    child: const Text(
                                      'Continue',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
