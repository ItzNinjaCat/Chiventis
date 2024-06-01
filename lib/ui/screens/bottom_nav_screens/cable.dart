import 'package:chiventis/services/finance_service.dart';
import 'package:chiventis/services/wallet_service.dart';
import 'package:chiventis/ui/components/payment_dialog.dart';
import 'package:chiventis/ui/components/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:chiventis/services/package_service.dart';
import 'package:chiventis/ui/components/custom_text_input.dart';

class CablePage extends StatefulWidget {
  const CablePage({Key? key}) : super(key: key);

  @override
  _CablePageState createState() => _CablePageState();
}

class _CablePageState extends State<CablePage> {
  final _providers = ["DSTV", "GOTV", "STARTIMES"];
  dynamic provider;
  dynamic selectedPackage;
  bool toggleValue = false; // Initial state for the toggle button
  final TextEditingController _phoneController = TextEditingController();
  List<dynamic>? packages = [];
  String bouquet = '';
  int amount = 0;
  String code = '';
  bool error = false;
  String meterOwner = "";
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchPlans();
  }

  Future<void> fetchPlans() async {
    if (provider.isNotEmpty) {
      setState(() {
        packages = [];
        selectedPackage = null;
      });
      final fetchedPlans = await PackageService.dataPackages(provider);

      setState(() {
        packages = fetchedPlans;
      });
    }
  }

  void verify() async {
    setState(() {
      _isLoading = true;
    });
    String? result = await FinanceService.verifyMeterNumber(
      _phoneController.text,
      provider as String,
      "TV",
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;
        double parentWidth = constraints.maxWidth;
        double parentHeight = constraints.maxHeight;

        return Scaffold(
          body: SingleChildScrollView(
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
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
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
                                  child: DropdownButton(
                                    // Set the hint text
                                    isExpanded: true,
                                    hint: const Padding(
                                      padding: EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        "Select Provider",
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    style: const TextStyle(
                                        fontSize: 12.0,
                                        color: Colors
                                            .black), // Set the text size for the dropdown items
                                    items: _providers.map((e) {
                                      return DropdownMenuItem<String>(
                                        value: e,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0), // Add left margin
                                          child: Text(
                                            e,
                                            style: const TextStyle(
                                                fontSize: 14.0,
                                                color: Colors
                                                    .black), // Set the text size
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        provider = value;
                                      });
                                      fetchPlans();
                                    },
                                    value: provider,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.05),
                            const Text('Smartcard Number:'),
                            SizedBox(
                              width: screenWidth * 0.8,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: screenWidth * 0.55,
                                    child: CustomTextInput(
                                      labelText: 'Enter Smartcard Number',
                                      controller: _phoneController,
                                      keyboardType: TextInputType.phone,
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
                                        ) 
                                    ),
                                  )
                                ],
                              ),
                            ),
                            if (error)
                              const Padding(
                                padding: EdgeInsets.only(top: 2.0, left: 5),
                                child: Text(
                                  'Smartcard Number Not Found!',
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
                            SizedBox(height: screenHeight * 0.02),
                            const Text('Select Bouquet/Package:'),
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
                                  child: DropdownButton(
                                    // Set the hint text
                                    isExpanded: true,
                                    hint: const Padding(
                                      padding: EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        "Select plan category to see plans",
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    style: const TextStyle(
                                        fontSize: 12.0,
                                        color: Colors
                                            .black), // Set the text size for the dropdown items
                                    items: packages?.map((e) {
                                      return DropdownMenuItem<Object>(
                                        value: e,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0), // Add left margin
                                          child: Text(
                                            e["desc"] +
                                                " - ₦" +
                                                e["price"].toString(),
                                            style: const TextStyle(
                                                fontSize: 14.0,
                                                color: Colors
                                                    .black), // Set the text size
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        selectedPackage = val;
                                      });
                                      if (val != null) {
                                        amount = (val
                                            as Map<String, dynamic>)['price'];
                                        code = (val)['code'];
                                        bouquet = (val)['desc'];
                                      }
                                    },
                                    value: selectedPackage,
                                  ),
                                ),
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
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
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
    
                                    final String? url = await FinanceService.cablePaystack(
                                      context,
                                      _phoneController.text,
                                      code,
                                      provider as String,
                                      amount.toDouble()
                                    );

                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return PaymentDialog(
                                          amount: amount.toDouble(),
                                          onPay: (pin) {
                                            return WalletService
                                              .topupCableTvWithWallet(
                                                context,
                                                _phoneController.text,
                                                provider as String,
                                                bouquet,
                                                amount.toDouble(),
                                                pin
                                              );
                                            },
                                          payStackUrl: url,
                                          type: 'Cable TV',
                                          content: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                    'Provider:',
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Color(0xFF424242),
                                                    ),
                                                  ),
                                                  Text(
                                                    provider as String,
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
                                                    'Smartcard No.:',
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Color(0xFF424242),
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
                                                    'Smartcard Owner:',
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Color(0xFF424242),
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
                                                    'Bouquet:',
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Color(0xFF424242),
                                                    ),
                                                  ),
                                                  Container(
                                                     constraints:
                                                      const BoxConstraints(
                                                        maxWidth: 150,
                                                      ),
                                                    child: Text(
                                                    // '₦$amount',
                                                    bouquet,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.right,
                                                  ),
                                                )
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  const Text(
                                                    'Bouquet:',
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Color(0xFF424242),
                                                    ),
                                                  ),
                                                  Container(
                                                     constraints:
                                                      const BoxConstraints(
                                                        maxWidth: 150,
                                                      ),
                                                    child: Text(
                                                    // '₦$amount',
                                                    bouquet,
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.right,
                                                  ),
                                                )
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  const Text(
                                                    'Bouquet:',
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Color(0xFF424242),
                                                    ),
                                                  ),
                                                  Text(
                                                    '₦$amount',
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
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
                            ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
