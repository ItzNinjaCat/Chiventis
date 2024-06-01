import 'package:flutter/material.dart';

class WalletInputGroup extends StatefulWidget {
  final ValueChanged<String> onChangedMainAmount;
  final ValueChanged<String> onChangedSecondAmount;
  const WalletInputGroup(
      {super.key,
      required this.onChangedMainAmount,
      required this.onChangedSecondAmount});

  @override
  WalletInputGroupState createState() => WalletInputGroupState();
}

class WalletInputGroupState extends State<WalletInputGroup> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _amountController2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 45,
            width: 45,
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey, width: 1),
                left: BorderSide(color: Colors.grey, width: 1),
                bottom: BorderSide(color: Colors.grey, width: 1),
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                bottomLeft: Radius.circular(5),
              ),
            ),
            child: const Align(
              alignment: Alignment.center,
              child: Text(
                '₦',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 45,
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: _amountController,
                onChanged: (value) {
                  widget.onChangedMainAmount(value);
                },
                decoration: const InputDecoration(
                  hintText: 'Enter Amount',
                  isDense: true,
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.zero),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 45,
            width: 45,
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey, width: 1),
                right: BorderSide(color: Colors.grey, width: 1),
                bottom: BorderSide(color: Colors.grey, width: 1),
              ),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
            ),
            child: Align(
              alignment: Alignment.center,
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: _amountController2,
                onChanged: (value) {
                  widget.onChangedSecondAmount(value);
                },
                decoration: const InputDecoration(
                  hintText: '.00',
                  isDense: true,
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
