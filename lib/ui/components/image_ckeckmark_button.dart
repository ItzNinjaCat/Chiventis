import 'package:flutter/material.dart';

class ImageCheckmarkButton extends StatefulWidget {
  final VoidCallback onTap;
  final String buttonValue;
  final String stateValue;
  final String buttonImage;

  const ImageCheckmarkButton(
      {super.key,
      required this.onTap,
      required this.buttonValue,
      required this.stateValue,
      required this.buttonImage});

  @override
  ImageCheckmarkButtonState createState() => ImageCheckmarkButtonState();
}

class ImageCheckmarkButtonState extends State<ImageCheckmarkButton> {
  bool _isChecked = false;

  @override
  void didUpdateWidget(covariant ImageCheckmarkButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.buttonValue == widget.stateValue) {
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

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: screenWidth * 0.195,
          height: 75,
        ),
        GestureDetector(
          onTap: () {
            widget.onTap();
          },
          child: SizedBox(
            width: screenWidth * 0.18, // Button width as 30% of the screen
            height: 60,

            child: Center(child: Image.asset(widget.buttonImage)),
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
