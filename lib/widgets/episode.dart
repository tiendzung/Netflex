// import 'package:flutter/material.dart';
//
// import '../assets.dart';
//
// class Episode extends StatelessWidget {
//   const Episode({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Stack(
//                 // alignment: Alignment.topLeft,
//                 children: [
//                   Container(
//                     height: 100.0,
//                     width: 160.0,
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                         image: AssetImage(Assets.kotaro_ep1),
//                         fit: BoxFit.cover,
//                       ),
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                     // color: Colors.white,
//                   ),
//                   Positioned(
//                     left: 0,
//                     right: 0,
//                     bottom: 0,
//                     top: 0,
//                     child: SizedBox(
//                       height: 60.0,
//                       child: Icon(Icons.play_circle),
//                     ),
//                   )
//                 ],
//               ),
//               const SizedBox(
//                 width: 15.0,
//               ),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       '1. Episode 1',
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 16.0,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       '26m',
//                       style: TextStyle(
//                         color: Colors.white.withOpacity(0.7),
//                         fontSize: 11.0,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Icon(
//                 Icons.download,
//                 color: Colors.white,
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10.0),
//             child: Text(
//               'A strange four-year-old boy named Kotaro moves into Shimizu Apartment all on his own. He doest seem to have any parents or family around.',
//               style: TextStyle(
//                 color: Colors.white.withOpacity(0.8),
//                 fontSize: 12.0,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
