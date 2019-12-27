import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// import 'package:qr_mobile_vision/qr_camera.dart';


class QrScaningPage extends StatefulWidget {
  @override
  _QrScaningPageState createState() => new _QrScaningPageState();
}

class _QrScaningPageState extends State<QrScaningPage> {
  String qr;
  bool camState = false;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  AppBar(
        title:  Text('QR Scaning'),
      ),
      body:  Center(
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             Expanded(
                child: camState
                    ?  Center(
                        child:  SizedBox(
                          width: 300.0,
                          height: 600.0,
                        //   //QrCamera s
                        //   child:  QrCamera(
                        //     onError: (context, error) => Text(
                        //           error.toString(),
                        //           style: TextStyle(color: Colors.red),
                        //         ),
                        //     qrCodeCallback: (code) {
                        //       setState(() {
                        //         qr = code;
                        //       });
                        //     },
                        //     child:  Container(
                        //       decoration:  BoxDecoration(
                        //         color: Colors.transparent,
                        //         border: Border.all(color: Colors.orange, width: 10.0, style: BorderStyle.solid),
                        //       ),
                        //     ),
                        //   ),
                        ),
                      )
                    :  Center(child:  Text("Camera inactive"))
              ),
             Text("QRCODE: $qr"),
          ],
        ),
      ),
      floatingActionButton:  FloatingActionButton(
          child:  Text(
            "press !",
            textAlign: TextAlign.center,
          ),
          onPressed: () {
            setState(() {
              camState = !camState;
            });
          }),
    );
  }
}