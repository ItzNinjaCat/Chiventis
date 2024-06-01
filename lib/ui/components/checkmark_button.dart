import 'package:flutter/material.dart';

class CheckmarkButton extends StatefulWidget {
  final VoidCallback onTap;
  final String buttonValue;
  final dynamic buttonVal;
  final dynamic stateVal;
  final Color? color;
  final IconData? icon; // New optional icon property

  const CheckmarkButton({
    Key? key, // Added key parameter
    required this.onTap,
    required this.buttonValue,
    required this.buttonVal,
    required this.stateVal,
    this.color,
    this.icon, // Added icon parameter
  }) : super(key: key); // Added super constructor call

  @override
  CheckmarkButtonState createState() => CheckmarkButtonState();
}

class CheckmarkButtonState extends State<CheckmarkButton> {
  bool _isChecked = false;

  @override
  void didUpdateWidget(covariant CheckmarkButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.buttonVal == widget.stateVal) {
      setState(() {
        _isChecked = true;
      });
    } else {
      setState(() {
        _isChecked = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: screenWidth * 0.36,
          height: screenHeight * 0.06,
        ),
        GestureDetector(
          onTap: () {
            widget.onTap();
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: widget.color ?? Colors.grey[300],
              border: Border.all(
                color: widget.color ?? Colors.grey[300]!,
                width: 1,
              ),
            ),
            width: screenWidth * 0.32, // Button width as 30% of the screen
            height: screenHeight * 0.05, // Button height as 5% of the screen
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.icon != null) // Render the icon if provided
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0, right: 4.0),
                    child: Icon(
                      widget.icon,
                      color: Colors.black, // Icon color
                    ),
                  ),
                Text(
                  widget.buttonValue,
                  style: const TextStyle(
                    color: Colors.black, // Button text color
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: Visibility(
            visible: _isChecked,
            child: Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                color: Colors.green, // Checkmark circle color
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  size: 15,
                  Icons.check,
                  color: Colors.white, // Checkmark icon color
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
