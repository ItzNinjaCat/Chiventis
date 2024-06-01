import 'package:chiventis/routes.dart';
import 'package:chiventis/services/auth_service.dart';
import 'package:chiventis/services/wallet_service.dart';
import 'package:chiventis/ui/components/fund_wallet_dialog.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentDialog extends StatefulWidget {
  final String type;
  final Column content;
  final String? payStackUrl;
  final Function? onPay;
  final double amount;
  const PaymentDialog({
    super.key,
    required this.type,
    required this.content,
    required this.payStackUrl,
    this.onPay,
    required this.amount,
  });

  @override
  PaymentDialogState createState() => PaymentDialogState();
}

class PaymentDialogState extends State<PaymentDialog> {
  String? errorMessage;

  late final Future<dynamic> _balanceFuture = initialLoad();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return FutureBuilder<dynamic>(
      future: _balanceFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final balance = snapshot.data?['balance'];
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const SizedBox(width: 30),
                      const Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Confirm Your Payment',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          'Payment Summary',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text(
                            'Type:',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Color(0xFF424242),
                            ),
                          ),
                          Text(
                            widget.type,
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      widget.content,
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: screenWidth * 0.32,
                            height: 30,
                            child: ElevatedButton(
                              onPressed:
                                  balance == null || balance < widget.amount
                                      ? null
                                      : () {
                                          Navigator.of(context).pop();
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              final TextEditingController
                                                  pinController =
                                                  TextEditingController();
                                              return StatefulBuilder(
                                                builder: (context, setState) {
                                                  return AlertDialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                    ),
                                                    backgroundColor:
                                                        Colors.white,
                                                    title: const Text(
                                                      'Enter Wallet PIN to continue',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    content:
                                                        SingleChildScrollView(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: SizedBox(
                                                          height: screenHeight *
                                                              0.1,
                                                          child: Column(
                                                            children: [
                                                              TextFormField(
                                                                controller:
                                                                    pinController,
                                                                obscureText:
                                                                    true,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize:
                                                                      12.0,
                                                                ),
                                                                decoration:
                                                                    InputDecoration(
                                                                  hintText:
                                                                      'Enter wallet PIN',
                                                                  contentPadding:
                                                                      const EdgeInsets
                                                                          .symmetric(
                                                                          horizontal:
                                                                              10),
                                                                  hintStyle:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12.0,
                                                                    color: Colors
                                                                        .grey,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                  ),
                                                                  alignLabelWithHint:
                                                                      false,
                                                                  border:
                                                                      const OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(5.0)),
                                                                    borderSide:
                                                                        BorderSide(
                                                                            color:
                                                                                Colors.grey),
                                                                  ),
                                                                  errorBorder:
                                                                      const OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(5.0)),
                                                                    borderSide:
                                                                        BorderSide(
                                                                            color:
                                                                                Colors.red),
                                                                  ),
                                                                  focusedErrorBorder:
                                                                      const OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(5.0)),
                                                                    borderSide:
                                                                        BorderSide(
                                                                            color:
                                                                                Colors.red),
                                                                  ),
                                                                  errorStyle: const TextStyle(
                                                                      color: Colors
                                                                          .red,
                                                                      fontSize:
                                                                          12.0),
                                                                  errorText:
                                                                      errorMessage,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    actions: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            style: ButtonStyle(
                                                              shape:
                                                                  MaterialStateProperty
                                                                      .all(
                                                                RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5.0),
                                                                  side: const BorderSide(
                                                                      color: Colors
                                                                          .grey),
                                                                ),
                                                              ),
                                                              backgroundColor:
                                                                  MaterialStateProperty
                                                                      .all(Colors
                                                                          .white),
                                                              padding:
                                                                  MaterialStateProperty.all(
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0)),
                                                            ),
                                                            child: const Text(
                                                              'Cancel',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 8.0),
                                                          ElevatedButton(
                                                            onPressed:
                                                                () async {
                                                              print(
                                                                  pinController
                                                                      .text);
                                                              try {
                                                                final res = await widget
                                                                        .onPay!(
                                                                    pinController
                                                                        .text);
                                                                if (res ==
                                                                    null) {
                                                                  throw Exception(
                                                                      'Error');
                                                                }
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return AlertDialog(
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5.0),
                                                                      ),
                                                                      backgroundColor:
                                                                          Colors
                                                                              .green,
                                                                      title:
                                                                          const Text(
                                                                        'Payment Successful',
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                      actions: [
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            ElevatedButton(
                                                                              onPressed: () {
                                                                                Navigator.of(context).pop();
                                                                              },
                                                                              style: ButtonStyle(
                                                                                shape: MaterialStateProperty.all(
                                                                                  RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(5.0),
                                                                                  ),
                                                                                ),
                                                                                backgroundColor: MaterialStateProperty.all(Colors.white),
                                                                                padding: MaterialStateProperty.all(const EdgeInsets.all(8.0)),
                                                                              ),
                                                                              child: const Text(
                                                                                'OK',
                                                                                style: TextStyle(
                                                                                  color: Colors.black,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
                                                                );
                                                              } catch (e) {
                                                                setState(() {
                                                                  errorMessage =
                                                                      'Incorrect Wallet PIN!';
                                                                });
                                                              }
                                                            },
                                                            style: ButtonStyle(
                                                              shape:
                                                                  MaterialStateProperty
                                                                      .all(
                                                                RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5.0),
                                                                ),
                                                              ),
                                                              backgroundColor:
                                                                  MaterialStateProperty
                                                                      .all(Theme.of(
                                                                              context)
                                                                          .primaryColor),
                                                              padding:
                                                                  MaterialStateProperty.all(
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0)),
                                                            ),
                                                            child: const Text(
                                                              'Pay',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                          );
                                        },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                                backgroundColor: balance == null ||
                                        balance < widget.amount
                                    ? const MaterialStatePropertyAll(
                                        Colors.grey)
                                    : MaterialStateProperty.all(Colors.green),
                                padding:
                                    MaterialStateProperty.all(EdgeInsets.zero),
                              ),
                              child: const Text(
                                'Pay with Wallet',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.32,
                            height: 30,
                            child: ElevatedButton(
                              onPressed: () {
                                if (widget.payStackUrl == null) return;
                                final controller = WebViewController()
                                  ..setJavaScriptMode(
                                      JavaScriptMode.unrestricted)
                                  ..setUserAgent('Flutter;Webview')
                                  ..loadRequest(
                                    Uri.parse(widget.payStackUrl as String),
                                  );
                                Navigator.of(context).pop();
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Scaffold(
                                      backgroundColor:
                                          Colors.white.withOpacity(0.85),
                                      body: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        child: WebViewWidget(
                                          controller: controller,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context).primaryColor),
                                padding:
                                    MaterialStateProperty.all(EdgeInsets.zero),
                              ),
                              child: const Text(
                                'Pay with PayStack',
                                style: TextStyle(fontSize: 12),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                balance == null || balance < widget.amount
                                    ? const Text(
                                        'Insufficient Wallet Balance',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.red,
                                        ),
                                      )
                                    : const SizedBox(),
                                TextButton(
                                  onPressed: () {
                                    if (snapshot.data?['balance'] != null) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const FundWalletDialog();
                                        },
                                      );
                                    } else {
                                      Navigator.pushNamed(
                                        context,
                                        Routes.verifyWallet,
                                        arguments: {
                                          'name': snapshot.data?['name'],
                                          'email': snapshot.data?['email']
                                        },
                                      );
                                    }
                                  },
                                  style: TextButton.styleFrom(
                                    minimumSize: Size.zero,
                                    padding: const EdgeInsets.only(bottom: 5),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: Text(
                                    'Fund Wallet',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                )
                              ]),
                          SizedBox(
                            height: screenHeight * 0.07,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

Future<dynamic> initialLoad() async {
  final user = await AuthService.getUser();
  final balance = await WalletService.getWalletBalance();
  user['balance'] = balance;
  return user;
}
