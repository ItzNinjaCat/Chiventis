import 'package:flutter/material.dart';

class InputGroup extends StatefulWidget {
  final ValueChanged<String> onChanged;
  const InputGroup({super.key, required this.onChanged});

  @override
  InputGroupState createState() => InputGroupState();
}

class InputGroupState extends State<InputGroup> {
  final TextEditingController _amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 45,
            width: 40,
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
                  widget.onChanged(value);
                },
                decoration: const InputDecoration(
                  hintText: 'Enter Amount',
                  isDense: true,
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(style: BorderStyle.none),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
