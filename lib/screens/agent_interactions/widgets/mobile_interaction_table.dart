// import 'package:approval_ai/screens/agent_interactions/model/interaction_data.dart';
// import 'package:approval_ai/screens/agent_interactions/widgets/table_helper.dart';
// import 'package:flutter/material.dart';

// class MobileInteractionTable extends StatelessWidget {
//   final List<InteractionData> interactionData;
//   const MobileInteractionTable({super.key, required this.interactionData});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         _buildMobileTableHeader(context),
//         ...interactionData.map((interactionData) => _buildRow(interactionData)),
//       ],
//     );
//   }

//   _buildMobileTableHeader(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 40, vertical: 25),
//       decoration: BoxDecoration(
//         border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Expanded(
//               flex: 1,
//               child: Text("Lender", style: TableHelper.getHeaderStyle())),
//           Expanded(
//               flex: 2,
//               child: Text("Preivew", style: TableHelper.getHeaderStyle())),
//         ],
//       ),
//     );
//   }

//   _buildRow(InteractionData interactionData) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
//       decoration: BoxDecoration(
//         border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Expanded(
//             flex: 1,
//             child: Text(interactionData.lender,
//                 style: TableHelper.getLenderNameStyle()),
//           ),
//           Expanded(
//             flex: 2,
//             child: Padding(
//               padding: const EdgeInsets.only(right: 16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     interactionData.preview,
//                     style: TableHelper.getRowStyle(),
//                   ),
//                   TableHelper.buildPreviewBtn(onPressed: () {}),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
