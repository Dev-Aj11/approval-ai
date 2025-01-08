import 'package:flutter/material.dart';

enum Status { contacted, received, negotiating, complete }

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
final Map<Status, MetricStyle> kMetricStyles = {
  Status.contacted: MetricStyle(
      backgroundColor: Color(0xffE8F3FE),
      foregroundColor: Color(0xff198AF4),
      icon: Icons.phone,
      iconLabel: "Lenders Contacted",
      lenderLabel: "Lender Contacted"),
  Status.received: MetricStyle(
      backgroundColor: Color(0xffEEEBFF),
      foregroundColor: Color(0xff5A36FF),
      icon: Icons.document_scanner_outlined,
      iconLabel: "Estimates Received",
      lenderLabel: "Estimate Received"),
  Status.negotiating: MetricStyle(
    backgroundColor: Color(0xffFFF2E6),
    foregroundColor: Color(0xffFF8001),
    icon: Icons.attach_money,
    iconLabel: "Negotiations In Progress",
    lenderLabel: "Negotiation In Progress",
  ),
  Status.complete: MetricStyle(
    backgroundColor: Color(0xffE5F9EE),
    foregroundColor: Color(0xff00C257),
    icon: Icons.handshake_outlined,
    iconLabel: "Negotiations Completed",
    lenderLabel: "Negotiation Completed",
  ),
};

class MetricData {
  final Status type;
  static const double _iconSize = 54.0;
  static const double _iconInnerSize = 24.0;

  const MetricData({required this.type});

  String getMetricName() => kMetricStyles[type]!.iconLabel;

  Widget getMetricIcon() {
    final style = kMetricStyles[type]!;

    return Container(
      width: _iconSize,
      height: _iconSize,
      decoration: BoxDecoration(
        color: style.backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Icon(
        style.icon,
        color: style.foregroundColor,
        size: _iconInnerSize,
      ),
    );
  }
}

// Map of metric types to their data
const Map<Status, MetricData> kMetricInfo = {
  Status.contacted: MetricData(type: Status.contacted),
  Status.received: MetricData(type: Status.received),
  Status.negotiating: MetricData(type: Status.negotiating),
  Status.complete: MetricData(type: Status.complete),
};