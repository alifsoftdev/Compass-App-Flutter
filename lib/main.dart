//import 'dart:math';
import 'package:compass_app/const/AppColor.dart';
import 'package:compass_app/home.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_compass/flutter_compass.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: AppColor.primaryColor
      ),
      debugShowCheckedModeBanner: false,

      home: Home(),
    );
  }
}

// class Compass extends StatefulWidget {
//   @override
//   _CompassState createState() => _CompassState();
// }
//
// class _CompassState extends State<Compass> {
//   double? heading = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     FlutterCompass.events!.listen((event) {
//       setState(() {
//         heading = event.heading;
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: Text(
//           "Compass",
//           style: TextStyle(
//               color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.black,
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             "${heading!.ceil()}°",
//             style: TextStyle(
//                 fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//           Padding(
//             padding: EdgeInsets.all(20),
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 Image.asset('assets/compass.png'),
//                 Transform.rotate(
//                   angle: ((heading ?? 0)*(pi / 180)*-1),
//                   child:Image.asset('assets/cadrant.png',scale: 1.1,) ,
//                 ),
//
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
