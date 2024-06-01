import 'package:chiventis/routes.dart';
import 'package:chiventis/services/wallet_service.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:chiventis/ui/components/wallet_input_group.dart';

class FundWalletDialog extends StatefulWidget {
  const FundWalletDialog({
    super.key,
  });

  @override
  State<FundWalletDialog> createState() => FundWalletDialogState();
}

class FundWalletDialogState extends State<FundWalletDialog> {
  double amount = 0.0;
  int stage = 1;
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
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const SizedBox(width: 30),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        stage == 1 ? 'Fund Wallet' : 'Confirm Payment',
                        style: const TextStyle(
                          fontSize: 20.0,
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
              )),
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 10.0, bottom: 10.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    stage == 1
                        ? 'How much would you like to add?'
                        : 'Payment Summary',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight:
                          stage == 1 ? FontWeight.w200 : FontWeight.bold,
                    ),
                  ),
                ),
                stage == 1
                    ? Column(children: [
                        WalletInputGroup(
                          onChangedMainAmount: (value) {
                            setState(() {
                              int mainPart = int.tryParse(value) ?? 0;
                              amount = mainPart +
                                  (amount - amount.truncateToDouble());
                            });
                          },
                          onChangedSecondAmount: (value) {
                            setState(() {
                              int fractionalPart = int.tryParse(value) ?? 0;
                              double fractionalValue = fractionalPart / 100;
                              amount =
                                  amount.truncateToDouble() + fractionalValue;
                            });
                          },
                        ),
                        amount <= 100
                            ? const Center(
                                child: Text(
                                'Enter an amount greater than N100',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.red,
                                ),
                              ))
                            : const SizedBox(),
                        const SizedBox(height: 10.0),
                        Center(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.0))),
                            ),
                            onPressed: amount <= 100
                                ? null
                                : () {
                                    setState(() {
                                      stage = 2;
                                    });
                                  },
                            child: const Text(
                              'Continue',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        )
                      ])
                    : Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            const SizedBox(height: 5.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Amount:'),
                                Text('₦${amount.toStringAsFixed(2)}')
                              ],
                            ),
                            const SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.grey),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0))),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        stage = 1;
                                      });
                                    },
                                    child: const Text(
                                      'Edit',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    )),
                                ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0))),
                                    ),
                                    onPressed: () async {
                                      final url =
                                          await WalletService.topupWallet(
                                              context, amount);
                                      print(url);
                                      if (url == null) return;
                                      final controller = WebViewController()
                                        ..setJavaScriptMode(
                                            JavaScriptMode.unrestricted)
                                        ..setUserAgent('Flutter;Webview')
                                        ..loadRequest(
                                          Uri.parse(url as String),
                                        );
                                      Navigator.of(context).pop();
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Scaffold(
                                            backgroundColor:
                                                Colors.white.withOpacity(0.85),
                                            body: SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              child: WebViewWidget(
                                                controller: controller,
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: const Text(
                                      'Continue',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ))
                              ],
                            ),
                          ],
                        )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
