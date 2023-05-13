import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:krankenhaus/common/text_widget.dart';
import 'package:krankenhaus/models/qr_model.dart';
import 'package:krankenhaus/screens/display_data/display_data.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class Scanner extends StatefulWidget {
  const Scanner({Key? key}) : super(key: key);

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  Dio dio = Dio();
  // bool loading = false;
  getData(id) async {
    try {
      // print(id);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Column(mainAxisSize: MainAxisSize.min, children: const [
            SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(),
            ),
            TextWidget(text: "Processing Request...")
          ]),
        ),
      );
      var response = await dio
          .get('https://hospital-ms-api.herokuapp.com/transactions/$id');
      if (response.data['success']) {
        QRModel dataModel = QRModel.fromJson(response.data);
        // print(response.data);
        // Navigator.of(context).pop();
        Get.back(closeOverlays: true);
        controller!.resumeCamera();

        Get.to(
          () => DataPage(
            data: dataModel,
          ),
        );
        // Navigator.pop(context);

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => DisplayData(data: dataModel)),
        // );
      } else {
        Get.back(closeOverlays: true);
        controller!.resumeCamera();
        // log(response.data['message']);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.data['message'])),
        );
      }
    } catch (e) {
      Get.back(closeOverlays: true);
      controller!.resumeCamera();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occured!! Try again")),
      );
    }
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      await HapticFeedback.lightImpact();
      controller.pauseCamera();
      // getData(scanData.code!);

      getData(scanData.code);
      // log("data =>>> ${scanData.code!}");
      // print(scanData.format);
      // if(scanData.format == BarcodeFormat.qrcode){

      // }

      // setState(() {
      //   result = scanData;
      // });
    });

    controller.pauseCamera();
    controller.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 400.0;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: QRView(
              overlay: QrScannerOverlayShape(
                borderColor: Colors.red,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: scanArea,
              ),
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
