import 'package:flutter/material.dart';

enum LenderStatusEnum { contacted, received, negotiating, complete }

// Style data for each metric type
class MetricStyle {
  final Color backgroundColor;
  final Color foregroundColor;
  final IconData icon;
  final String iconLabel;
  final String lenderLabel;

  const MetricStyle({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.icon,
    required this.iconLabel,
    required this.lenderLabel,
  });
}

// Static styles for each metric type
final Map<LenderStatusEnum, MetricStyle> kMetricStyles = {
  LenderStatusEnum.contacted: MetricStyle(
      backgroundColor: Color(0xffE8F3FE),
      foregroundColor: Color(0xff198AF4),
      icon: Icons.phone_outlined,
      iconLabel: "Lenders Contacted",
      lenderLabel: "Lender Contacted"),
  LenderStatusEnum.received: MetricStyle(
      backgroundColor: Color(0xffEEEBFF),
      foregroundColor: Color(0xff5A36FF),
      icon: Icons.document_scanner_outlined,
      iconLabel: "Estimates Received",
      lenderLabel: "Estimate Received"),
  LenderStatusEnum.negotiating: MetricStyle(
    backgroundColor: Color(0xffFFF2E6),
    foregroundColor: Color(0xffFF8001),
    icon: Icons.attach_money,
    iconLabel: "Negotiations In Progress",
    lenderLabel: "Negotiation In Progress",
  ),
  LenderStatusEnum.complete: MetricStyle(
    backgroundColor: Color(0xffE5F9EE),
    foregroundColor: Color(0xff00C257),
    icon: Icons.handshake_outlined,
    iconLabel: "Negotiations Completed",
    lenderLabel: "Negotiation Completed",
  ),
};

class OverviewMetricCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const OverviewMetricCard({
    required this.icon,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20),
        SizedBox(width: 8),
        Text(label),
      ],
    );
  }
}

/*
// Map of metric types to their data
const Map<LenderStatusEnum, MetricData> kMetricInfo = {
  LenderStatusEnum.contacted: MetricData(type: LenderStatusEnum.contacted),
  LenderStatusEnum.received: MetricData(type: LenderStatusEnum.received),
  LenderStatusEnum.negotiating: MetricData(type: LenderStatusEnum.negotiating),
  LenderStatusEnum.complete: MetricData(type: LenderStatusEnum.complete),
};
*/
