import 'package:chiventis/services/wallet_service.dart';
import 'package:flutter/material.dart';
import 'package:chiventis/services/finance_service.dart';
import 'package:chiventis/services/product_service.dart';
import 'package:chiventis/ui/components/checkmark_button.dart';
import 'package:chiventis/ui/components/custom_text_input.dart';
import 'package:chiventis/ui/components/image_ckeckmark_button.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:chiventis/ui/components/payment_dialog.dart';
import 'package:chiventis/ui/components/toast_message.dart';

class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  State<DataPage> createState() => _DataPagePageState();
}

class _DataPagePageState extends State<DataPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  String category = '';
  String provider = '';
  int productId = 0;
  int amount = 0;
  dynamic selectedPlan;
  List<dynamic>? plans = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchPlans();
  }

  Future<void> fetchPlans() async {
    if (category.isNotEmpty && provider.isNotEmpty) {
      setState(() {
        plans = [];
        selectedPlan = null;
      });
      final fetchedPlans =
          await ProductService.dataProducsts(provider, category);

      setState(() {
        plans = fetchedPlans;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    Widget selectedPlans =
        const Text('Select Network Provider to view Plan Categories');
    switch (provider) {
      case 'mtn':
        selectedPlans = Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CheckmarkButton(
                onTap: () {
                  setState(() {
                    category = 'Daily';
                  });
                  fetchPlans();
                },
                buttonValue: 'Daily',
                stateVal: category,
                buttonVal: 'Daily',
              ),
              CheckmarkButton(
                onTap: () {
                  setState(() {
                    category = 'Weekly';
                  });
                  fetchPlans();
                },
                buttonValue: 'Weekly',
                stateVal: category,
                buttonVal: 'Weekly',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CheckmarkButton(
                onTap: () {
                  setState(() {
                    category = 'Monthly';
                  });
                  fetchPlans();
                },
                buttonValue: 'Monthly',
                stateVal: category,
                buttonVal: 'Monthly',
              ),
              CheckmarkButton(
                onTap: () {
                  setState(() {
                    category = 'Yearly';
                  });
                  fetchPlans();
                },
                buttonValue: 'Yearly',
                stateVal: category,
                buttonVal: 'Yearly',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CheckmarkButton(
                onTap: () {
                  setState(() {
                    category = 'Others';
                  });
                  fetchPlans();
                },
                buttonValue: 'Others',
                stateVal: category,
                buttonVal: 'Others',
              ),
              CheckmarkButton(
                  onTap: () {
                    setState(() {
                      category = 'SME';
                    });
                    fetchPlans();
                  },
                  buttonValue: 'SME',
                  icon: Icons.savings_outlined,
                  stateVal: category,
                  buttonVal: 'SME',
                  color: Colors.yellow[400]),
            ],
          ),
        ]);
        break;
      case 'glo':
        selectedPlans = Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CheckmarkButton(
                onTap: () {
                  setState(() {
                    category = 'Mini';
                  });
                  fetchPlans();
                },
                buttonValue: 'Mini',
                stateVal: category,
                buttonVal: 'Mini',
              ),
              CheckmarkButton(
                onTap: () {
                  setState(() {
                    category = 'Monthly';
                  });
                  fetchPlans();
                },
                buttonValue: 'Monthly',
                stateVal: category,
                buttonVal: 'Monthly',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CheckmarkButton(
                onTap: () {
                  setState(() {
                    category = 'Social';
                  });
                  fetchPlans();
                },
                buttonValue: 'Social',
                stateVal: category,
                buttonVal: 'Social',
              ),
              CheckmarkButton(
                onTap: () {
                  setState(() {
                    category = 'Night & Weekend';
                  });
                  fetchPlans();
                },
                buttonValue: 'Night & Weekend',
                stateVal: category,
                buttonVal: 'Night & Weekend',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CheckmarkButton(
                onTap: () {
                  setState(() {
                    category = 'Special';
                  });
                  fetchPlans();
                },
                buttonValue: 'Special',
                stateVal: category,
                buttonVal: 'Special',
              ),
              CheckmarkButton(
                onTap: () {
                  setState(() {
                    category = 'Mega';
                  });
                  fetchPlans();
                },
                buttonValue: 'Mega',
                stateVal: category,
                buttonVal: 'Mega',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CheckmarkButton(
                onTap: () {
                  setState(() {
                    category = 'Popular';
                  });
                  fetchPlans();
                },
                buttonValue: 'Popular',
                stateVal: category,
                buttonVal: 'Popular',
              ),
              CheckmarkButton(
                onTap: () {
                  setState(() {
                    category = 'SME';
                  });
                  fetchPlans();
                },
                buttonValue: 'SME',
                stateVal: category,
                buttonVal: 'SME',
                icon: Icons.savings_outlined,
                color: Colors.green,
              ),
            ],
          ),
        ]);
        break;
      case 'airtel':
        selectedPlans = Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CheckmarkButton(
                onTap: () {
                  setState(() {
                    category = 'Daily';
                  });
                  fetchPlans();
                },
                buttonValue: 'Daily',
                stateVal: category,
                buttonVal: 'Daily',
              ),
              CheckmarkButton(
                onTap: () {
                  setState(() {
                    category = 'Weekly';
                  });
                  fetchPlans();
                },
                buttonValue: 'Weekly',
                stateVal: category,
                buttonVal: 'Weekly',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CheckmarkButton(
                onTap: () {
                  setState(() {
                    category = 'Monthly';
                  });
                  fetchPlans();
                },
                buttonValue: 'Monthly',
                stateVal: category,
                buttonVal: 'Monthly',
              ),
              CheckmarkButton(
                onTap: () {
                  setState(() {
                    category = 'Yearly';
                  });
                  fetchPlans();
                },
                buttonValue: 'Yearly',
                stateVal: category,
                buttonVal: 'Yearly',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CheckmarkButton(
                  onTap: () {
                    setState(() {
                      category = 'SME';
                    });
                    fetchPlans();
                  },
                  buttonValue: 'SME',
                  icon: Icons.savings_outlined,
                  stateVal: category,
                  buttonVal: 'SME',
                  color: Colors.red[300]),
            ],
          ),
        ]);
        break;
      case '9mobile':
        selectedPlans = Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CheckmarkButton(
                onTap: () {
                  setState(() {
                    category = 'Daily';
                  });
                  fetchPlans();
                },
                buttonValue: 'Daily',
                stateVal: category,
                buttonVal: 'Daily',
              ),
              CheckmarkButton(
                onTap: () {
                  setState(() {
                    category = 'Weekly';
                  });
                  fetchPlans();
                },
                buttonValue: 'Weekly',
                stateVal: category,
                buttonVal: 'Weekly',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CheckmarkButton(
                onTap: () {
                  setState(() {
                    category = 'Monthly';
                  });
                  fetchPlans();
                },
                buttonValue: 'Monthly',
                stateVal: category,
                buttonVal: 'Monthly',
              ),
              CheckmarkButton(
                onTap: () {
                  setState(() {
                    category = 'Yearly';
                  });
                  fetchPlans();
                },
                buttonValue: 'Yearly',
                stateVal: category,
                buttonVal: 'Yearly',
              ),
            ],
          ),
        ]);
        break;
      default:
        selectedPlans =
            const Text('Select Network Provider to view Plan Categories');
        break;
    }

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
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Mobile number:'),
                            ),
                            SizedBox(height: screenHeight * 0.003),
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
                                style: TextButton.styleFrom(
                                  minimumSize: Size.zero,
                                  padding: const EdgeInsets.all(5),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
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
                                    fetchPlans();
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
                                    fetchPlans();
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
                                    fetchPlans();
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
                                    fetchPlans();
                                  },
                                  buttonValue: '9mobile',
                                  stateValue: provider,
                                  buttonImage: 'assets/logos/9mobile_logo.png',
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.005),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Data Plan Categories:'),
                            ),
                            SizedBox(height: screenHeight * 0.005),
                            Center(
                              child: selectedPlans,
                            ),
                            SizedBox(height: screenHeight * 0.005),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Plans:'),
                            ),
                            SizedBox(
                                width: 0.75 * screenWidth,
                                child: DropdownButton(
                                    isExpanded: true,
                                    value: selectedPlan,
                                    hint: const Text(
                                        "Select plan category to see plans"),
                                    items: plans
                                        ?.map<DropdownMenuItem<Object>>((e) {
                                      return DropdownMenuItem<Object>(
                                        value: e,
                                        child: Text(
                                          e['title'],
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        selectedPlan = val;
                                        if (val != null) {
                                          productId = (val
                                              as Map<String, dynamic>)['id'];
                                          amount = val['amount'];
                                        }
                                      });
                                    })),
                            SizedBox(height: screenHeight * 0.01),
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
                                        'Error: Phone number cannot be empty',
                                        'Please enter a valid phone number',
                                        false);
                                      setState(() {
                                        _isLoading = true;
                                      });
                                    return;
                                  }
                                  if (provider.isEmpty) {
                                    toastSuccess(
                                        context,
                                        'Error: Network provider not selected',
                                        'Please select a network provider',
                                        false);
                                      setState(() {
                                        _isLoading = true;
                                      });
                                    return;
                                  }
                                  if (category.isEmpty) {
                                    toastSuccess(
                                        context,
                                        'Error: Plan category not selected',
                                        'Please select a plan category',
                                        false);
                                      setState(() {
                                        _isLoading = true;
                                      });
                                    return;
                                  }
                                  final String? url = category
                                              .contains('SME') ==
                                          false
                                      ? await FinanceService.dataPaystack(
                                          context,
                                          _phoneController.text,
                                          productId)
                                      : await FinanceService.smeDataPaystack(
                                          context,
                                          _phoneController.text,
                                          productId);
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return PaymentDialog(
                                        amount: amount.toDouble(),
                                        onPay: (pin) {
                                          return category.contains('SME') ==
                                                  false
                                              ? WalletService
                                                  .topupDataWithWallet(
                                                      context,
                                                      _phoneController.text,
                                                      productId,
                                                      pin)
                                              : WalletService
                                                  .topupSmeDataWithWallet(
                                                      context,
                                                      _phoneController.text,
                                                      productId,
                                                      pin);
                                        },
                                        payStackUrl: url,
                                        type: 'Data',
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
                                                  'Plan:',
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Container(
                                                  constraints:
                                                      const BoxConstraints(
                                                    maxWidth: 150,
                                                  ),
                                                  child: Text(
                                                    selectedPlan['title'],
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.right,
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
                                    _isLoading = true;
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
