import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../app_colors.dart';

barcodeScanner(BuildContext mainContext){
  return showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: mainContext,
    builder: (context){
      return Container(
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.7),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
          color: Colors.blue.shade100,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    color: mainColor
                  ),
                  child: Stack(
                    children: [
                      MobileScanner(
                        controller: MobileScannerController(
                          detectionSpeed: DetectionSpeed.noDuplicates
                        ),
                        onDetect: (capture) async {
                          final List<Barcode> barcodes = capture.barcodes;
                          for (final barcode in barcodes) {
                            if (barcode.rawValue == null) {
                              debugPrint('Failed to scan Barcode');
                              Navigator.pop(context);
                            } else {
                              String code = barcode.rawValue!;
                              Navigator.pop(context, code);
                            }
                          }
                        }
                      ),
                      Center(child: SizedBox(height: 300, width: 300,child: Lottie.asset('lib/images/lottie/scanner.json'))),
                    ],
                  )
                ),
              )
            ],
          ),
        ),
      );
    }
  );
}
