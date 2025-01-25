import 'package:approval_ai/screens/home/model/overview_data.dart';
import 'package:approval_ai/widgets/buttons.dart';
import 'package:approval_ai/widgets/table_helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:approval_ai/screens/home/controller/home_controller.dart';

class CustomOverviewCard extends StatelessWidget {
  final String metricData;
  final LenderStatusEnum metricType;
  final HomeController controller;

  const CustomOverviewCard({
    required this.metricData,
    required this.controller,
    required this.metricType,
    super.key,
  });

  _getMetricIconAndLabel() {
    switch (metricType) {
      case LenderStatusEnum.contacted:
        return [Icons.phone_outlined, "Lenders Contacted"];
      case LenderStatusEnum.received:
        return [Icons.document_scanner_outlined, "Estimates Received"];
      case LenderStatusEnum.negotiating:
        return [Icons.attach_money_outlined, "Current Negotiations"];
      case LenderStatusEnum.complete:
        return [Icons.handshake_outlined, "Negotiations Completed"];
    }
  }

  @override
  Widget build(BuildContext context) {
    var iconAndLabel = _getMetricIconAndLabel();
    return Container(
      width: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Color(0xffF7FAFF), // Color(0xfff8f8ff), // Color(0xfffffff)
        border: Border.all(
          color: Color(0xffffffff), // Color(0xfffffff)
          width: 1,
        ),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.shade200,
        //     blurRadius: 10,
        //     offset: Offset(0, 4),
        //   ),
        // ],
      ),
      padding: EdgeInsets.only(left: 24, right: 24, bottom: 24, top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // icon
          Icon(iconAndLabel[0], size: 22),
          // spacer
          SizedBox(height: 12),
          // title
          Text(
            iconAndLabel[1],
            style: GoogleFonts.inter(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
          ),
          // data
          SizedBox(height: 8),
          Text(
            metricData,
            style: GoogleFonts.inter(
                fontSize: 24, fontWeight: FontWeight.w500, color: Colors.black),
          ),
          // cta
          SizedBox(height: 24),
          SecondaryTextButton(
            label: "View",
            onPressed: () => controller.setCurrentPage("Messages"),
          ),
          // Container(
          //   width: 60,
          //   alignment: Alignment.centerLeft,
          //   child: TextButton(
          //     style: TableHelper.getButtonStyle(),
          //     onPressed: () => controller.setCurrentPage("Messages"),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       mainAxisSize: MainAxisSize.min,
          //       crossAxisAlignment: CrossAxisAlignment.baseline,
          //       textBaseline: TextBaseline.alphabetic,
          //       children: [
          //         Text("View",
          //             style: TextStyle(
          //                 decoration: TextDecoration.underline,
          //                 decorationColor: Colors.black)),
          //         const SizedBox(width: 1),
          //         Transform.translate(
          //           offset: const Offset(0, 3),
          //           child: const Icon(
          //             Icons.chevron_right,
          //             size: 14,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
