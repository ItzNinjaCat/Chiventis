import 'package:flutter/material.dart';

void toastSuccess(
    BuildContext context, String header, String message, bool successful) {
  OverlayState? overlayState = Overlay.of(context);
  OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width,
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
            width: 300, // Adjust width as needed
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: successful ? Colors.green[800] : Colors.red[800],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  header,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );

  overlayState.insert(overlayEntry);

  // Remove the toast after 2 seconds
  Future.delayed(const Duration(seconds: 2), () {
    overlayEntry.remove();
  });
}
