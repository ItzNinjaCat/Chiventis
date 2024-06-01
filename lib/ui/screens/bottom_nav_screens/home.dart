import 'package:chiventis/routes.dart';
import 'package:chiventis/services/auth_service.dart';
import 'package:chiventis/services/wallet_service.dart';
import 'package:chiventis/ui/components/fund_wallet_dialog.dart';
import 'package:chiventis/ui/components/image_ckeckmark_button.dart';
import 'package:flutter/material.dart';
import 'package:chiventis/ui/screens/settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool showBalance = false;
  late Future<dynamic> _futureData = initialLoad();
  String provider = '';

  @override
  void initState() {
    super.initState();
    _futureData = initialLoad();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return FutureBuilder<dynamic>(
        future: _futureData,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          return SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      children: [
                        Icon(
                          Icons.account_circle_outlined,
                          size: screenWidth * 0.1,
                          color: Colors.grey,
                        ),
                        Text(
                            "${snapshot.data?['name']} ${snapshot.data?['lastname']}"),
                      ],
                    ),
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'e-Wallet',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ))),
                Container(
                    width: screenWidth * 0.85,
                    height: screenHeight * 0.12,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  width: screenWidth * 0.4,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Text(
                                        '₦',
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w200),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        showBalance
                                            ? snapshot.data['balance']
                                                .toString()
                                            : '*****',
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: showBalance ? 18 : 24,
                                            fontWeight: FontWeight.w200),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            if (snapshot.data?['balance'] !=
                                                null) {
                                              setState(() {
                                                showBalance = !showBalance;
                                              });
                                            }
                                          },
                                          icon: Icon(
                                            (showBalance
                                                ? Icons.visibility
                                                : Icons.visibility_off),
                                            size: 24,
                                          ))
                                    ],
                                  )),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      snapshot.data?['balance'] == null
                                          ? TextButton(
                                              onPressed: () {
                                                print('navigating');
                                                Navigator.pushNamed(context,
                                                    Routes.verifyWallet,
                                                    arguments: {
                                                      'name':
                                                          snapshot.data['name'],
                                                      'email':
                                                          snapshot.data['email']
                                                    });
                                              },
                                              style: TextButton.styleFrom(
                                                minimumSize: Size.zero,
                                                padding: EdgeInsets.zero,
                                                tapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                              ),
                                              child: const Text('Inactive',
                                                  style: TextStyle(
                                                      color: Colors.grey)))
                                          : Row(
                                              children: [
                                                Container(
                                                  width: 20,
                                                  height: 20,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.green,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: const Center(
                                                    child: Icon(
                                                      size: 18,
                                                      Icons.check,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 5),
                                                const Text(
                                                  'Active',
                                                )
                                              ],
                                            ),
                                      TextButton(
                                          onPressed: () {
                                            if (snapshot.data?['balance'] !=
                                                null) {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return const FundWalletDialog();
                                                  });
                                            } else {
                                              Navigator.pushNamed(
                                                  context, Routes.verifyWallet,
                                                  arguments: {
                                                    'name':
                                                        snapshot.data['name'],
                                                    'email':
                                                        snapshot.data['email']
                                                  });
                                            }
                                          },
                                          style: TextButton.styleFrom(
                                            minimumSize: Size.zero,
                                            padding: EdgeInsets.zero,
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
                                          ),
                                          child: const Text('Fund wallet'))
                                    ],
                                  ))
                            ]))),
                const SizedBox(height: 20),
                Transform.translate(
                  offset: const Offset(
                      0, 0), // Move the entire Column up by 10 pixels
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Text(
                          "Sharp-sharp links",
                          style: TextStyle(
                            fontSize: screenHeight * 0.025,
                            color: const Color(0xFF424242),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Airtime',
                            style: TextStyle(
                              fontSize: screenHeight * 0.02,
                              color: const Color(0xFF424242),
                            ),
                          )),
                      Transform.translate(
                        offset: const Offset(
                            0, 0), // Move the Row widget up by 10 pixels
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width:
                                  screenHeight * 0.1, // Set the desired width
                              height:
                                  screenHeight * 0.1, // Set the desired height
                              child: ImageCheckmarkButton(
                                onTap: () {},
                                buttonValue: 'airtime-glo',
                                stateValue: provider,
                                buttonImage: 'assets/logos/glo_logo.png',
                              ),
                            ),
                            SizedBox(
                              width:
                                  screenHeight * 0.1, // Set the desired width
                              height:
                                  screenHeight * 0.1, // Set the desired height
                              child: ImageCheckmarkButton(
                                onTap: () {},
                                buttonValue: 'mtn',
                                stateValue: provider,
                                buttonImage: 'assets/logos/mtn_logo.png',
                              ),
                            ),
                            SizedBox(
                              width:
                                  screenHeight * 0.1, // Set the desired width
                              height:
                                  screenHeight * 0.1, // Set the desired height
                              child: ImageCheckmarkButton(
                                onTap: () {},
                                buttonValue: 'airtel',
                                stateValue: provider,
                                buttonImage: 'assets/logos/airtel_logo.png',
                              ),
                            ),
                            SizedBox(
                              width:
                                  screenHeight * 0.1, // Set the desired width
                              height:
                                  screenHeight * 0.1, // Set the desired height
                              child: ImageCheckmarkButton(
                                onTap: () {},
                                buttonValue: '9mobile',
                                stateValue: provider,
                                buttonImage: 'assets/logos/9mobile_logo.png',
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Transform.translate(
                  offset: const Offset(
                      0, 0), // Move the entire Column up by 10 pixels
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Data',
                          style: TextStyle(
                            fontSize: screenHeight * 0.02,
                            color: const Color(0xFF424242),
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(
                            0, 0), // Move the Row widget up by 10 pixels
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width:
                                  screenHeight * 0.1, // Set the desired width
                              height:
                                  screenHeight * 0.1, // Set the desired height
                              child: ImageCheckmarkButton(
                                onTap: () {},
                                buttonValue: 'glo',
                                stateValue: provider,
                                buttonImage: 'assets/logos/glo_logo.png',
                              ),
                            ),
                            SizedBox(
                              width:
                                  screenHeight * 0.1, // Set the desired width
                              height:
                                  screenHeight * 0.1, // Set the desired height
                              child: ImageCheckmarkButton(
                                onTap: () {},
                                buttonValue: 'airtel',
                                stateValue: provider,
                                buttonImage: 'assets/logos/airtel_logo.png',
                              ),
                            ),
                            SizedBox(
                              width:
                                  screenHeight * 0.1, // Set the desired width
                              height:
                                  screenHeight * 0.1, // Set the desired height
                              child: ImageCheckmarkButton(
                                onTap: () {},
                                buttonValue: 'mtn',
                                stateValue: provider,
                                buttonImage: 'assets/logos/mtn_logo.png',
                              ),
                            ),
                            SizedBox(
                              width:
                                  screenHeight * 0.1, // Set the desired width
                              height:
                                  screenHeight * 0.1, // Set the desired height
                              child: ImageCheckmarkButton(
                                onTap: () {},
                                buttonValue: '9mobile',
                                stateValue: provider,
                                buttonImage: 'assets/logos/9mobile_logo.png',
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Transform.translate(
                  offset: const Offset(
                      0, 0), // Move the entire Column up by 10 pixels
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Electricity & Cable TV',
                          style: TextStyle(
                            fontSize: screenHeight * 0.02,
                            color: Color.fromRGBO(66, 66, 66, 1),
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(
                            0, 0), // Move the Row widget up by 10 pixels
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width:
                                  screenHeight * 0.1, // Set the desired width
                              height:
                                  screenHeight * 0.1, // Set the desired height
                              child: ImageCheckmarkButton(
                                onTap: () {},
                                buttonValue: 'glo',
                                stateValue: provider,
                                buttonImage: 'assets/logos/jos_logo.png',
                              ),
                            ),
                            SizedBox(
                              width:
                                  screenHeight * 0.1, // Set the desired width
                              height:
                                  screenHeight * 0.1, // Set the desired height
                              child: ImageCheckmarkButton(
                                onTap: () {},
                                buttonValue: 'airtel',
                                stateValue: provider,
                                buttonImage: 'assets/logos/aedc_logo.png',
                              ),
                            ),
                            SizedBox(
                              width:
                                  screenHeight * 0.1, // Set the desired width
                              height:
                                  screenHeight * 0.1, // Set the desired height
                              child: ImageCheckmarkButton(
                                onTap: () {},
                                buttonValue: 'mtn',
                                stateValue: provider,
                                buttonImage: 'assets/logos/dstv_logo.png',
                              ),
                            ),
                            SizedBox(
                              width:
                                  screenHeight * 0.1, // Set the desired width
                              height:
                                  screenHeight * 0.1, // Set the desired height
                              child: ImageCheckmarkButton(
                                onTap: () {},
                                buttonValue: '9mobile',
                                stateValue: provider,
                                buttonImage: 'assets/logos/gotv_logo.png',
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ));
        });
  }
}

class SubPage extends StatelessWidget {
  const SubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SubPage'),
      ),
      body: const Center(
        child: Text('SubPage'),
      ),
    );
  }
}

Future<dynamic> initialLoad() async {
  final user = await AuthService.getUser();
  final balance = await WalletService.getWalletBalance();
  user['balance'] = balance;
  return user;
}
