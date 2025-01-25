import 'package:approval_ai/screens/agent_interactions/controller/agent_controller.dart';
import 'package:approval_ai/screens/agent_interactions/screens/messages_screen.dart';
import 'package:approval_ai/screens/home/model/lender_data.dart';
import 'package:approval_ai/screens/home/widgets/custom_headings.dart';
import 'package:approval_ai/screens/home/widgets/styles.dart';
import 'package:approval_ai/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

/// Helper class for shared table components and styles
class TableHelper {
  static Widget buildInteractionTableHeader(List<String> columns) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: columns.map((column) {
          return Expanded(
            flex: column == 'preview' ? 2 : 1,
            child: Text(
              TableConfig.columnHeaders[column]!,
              style: TableHelper.getHeaderStyle(),
            ),
          );
        }).toList(),
      ),
    );
  }

  static Widget buildLeaderboardTableHeader(List<String> columns) {
    return Container(
      padding: const EdgeInsets.only(left: 40, right: 40, top: 24, bottom: 22),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: columns.map((column) {
          if (column == 'rank') {
            return Container(
              width: 100,
              child: Text(
                TableConfig.columnHeaders[column]!,
                style: TableHelper.getHeaderStyle(),
              ),
            );
          }
          return Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                TableConfig.columnHeaders[column]!,
                style: TableHelper.getHeaderStyle(),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // lenderData parameter used to construct Agent Interactions Table
  // lenderLeaderboardData param used to construct Leaderboard Table
  static Widget buildTableRow(
      {LenderData? lenderData,
      LenderLeaderboardMetric? lenderLeaderboardData,
      required List<String> columns,
      required BuildContext context}) {
    var data = (lenderData != null) ? lenderData : lenderLeaderboardData!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 35),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: columns
            .map((column) => (lenderData != null)
                ? buildInteractionTableCell(column, data as LenderData, context)
                : buildLeaderboardTableCell(
                    column, data as LenderLeaderboardMetric, context))
            .toList(),
      ),
    );
  }

  static Widget buildLeaderboardTableCell(String column,
      LenderLeaderboardMetric leaderboardData, BuildContext context) {
    switch (column) {
      case 'rank':
        return Container(
          width: 100,
          alignment: Alignment.centerLeft,
          child: Text(leaderboardData.rank.toString(),
              style: LeaderboardStyles.getMetricStyle()),
        );
      case 'lender':
        return Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(right: 16.0),
            child: Text(
              textAlign: TextAlign.left,
              leaderboardData.name,
              style: LeaderboardStyles.getMetricStyle(),
            ),
          ),
        );
      case 'monthlyPayment':
        return Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text(formatMoney(leaderboardData.monthlyPayments),
                style: LeaderboardStyles.getMetricStyle()),
          ),
        );
      case 'totalPayments':
        return Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text(formatMoney(leaderboardData.totalPayments),
                style: LeaderboardStyles.getBoldMetricStyle()),
          ),
        );
      case '':
        return Expanded(
          flex: 1,
          child: SecondaryTextButton(
            label: "Get connected",
            onPressed: () {},
          ),
        );
      default:
        return const Expanded(child: SizedBox());
    }
  }

  static String formatMoney(String amount) {
    final value = int.parse(amount.replaceAll("\$", ""));
    return '\$${(value).toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        )}';
  }

  static Widget buildInteractionTableCell(
      String column, LenderData lenderData, BuildContext context) {
    // check if messages exist
    if (lenderData.messages == null) {
      return const Expanded(child: SizedBox());
    }
    // sort messages
    var messages = AgentController.sortMessages(lenderData.messages!);
    DateTime lastContacted = messages.last.timestamp;
    String preview = messages.last.content;
    switch (column) {
      case 'lender':
        return Expanded(
          child: Text(lenderData.name, style: TableHelper.getLenderNameStyle()),
        );
      case 'status':
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LenderStatusBadge(type: lenderData.currStatus),
              ],
            ),
          ),
        );
      case 'lastContacted':
        return Expanded(
          child: Text(
            DateFormat('MMM d, h:mm a').format(lastContacted),
            style: TableHelper.getRowStyle(),
          ),
        );
      case 'messages':
        return Expanded(
          child: Text(
            messages.length.toString(),
            style: TableHelper.getRowStyle(),
          ),
        );
      case 'preview':
        return Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  preview,
                  style: TableHelper.getRowStyle(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                TableHelper.buildPreviewBtn(onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => MessagesScreen(
                      messages: messages,
                      loanOfficer: lenderData.loanOfficer,
                      lender: lenderData.name,
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      case 'estimate':
        var estimateData = lenderData.mostRecentEstimate;
        return Expanded(
          child: estimateData != null
              ? TableHelper.buildEstimateBtn(onPressed: () async {
                  final Uri url = Uri.parse(estimateData.estimateUrl);
                  if (!await launchUrl(url)) {
                    throw Exception(
                        'Could not launch ${estimateData.estimateUrl}');
                  }
                })
              : Text("Awaiting Estimate",
                  style: TableHelper.getLenderNameStyle()),
        );
      default:
        return const Expanded(child: SizedBox());
    }
  }

  /// Creates a preview button with customizable onPressed behavior
  static Widget buildPreviewBtn({
    required VoidCallback onPressed,
    String label = 'View',
  }) {
    return SecondaryTextButton(label: label, onPressed: onPressed);
  }

  /// Creates an estimate button with customizable onPressed behavior
  static Widget buildEstimateBtn({
    required VoidCallback onPressed,
    String label = 'View Document',
  }) {
    return Container(
      alignment: Alignment.centerLeft,
      child: TextButton(
        style: getButtonStyle(),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(label),
            const SizedBox(width: 4),
            Transform.translate(
              offset: const Offset(0, 3),
              child: const Icon(
                Icons.open_in_new,
                size: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Returns the common button style used across table buttons
  static ButtonStyle getButtonStyle() {
    return ButtonStyle(
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      padding: WidgetStateProperty.all(EdgeInsets.zero),
      iconColor: WidgetStateProperty.all(Colors.black),
      foregroundColor: WidgetStateProperty.all(Colors.black),
      textStyle: WidgetStateProperty.all(
        GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  /// Returns the header text style used in tables
  static TextStyle getHeaderStyle() {
    return GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Color(0xff6A6A6A),
    );
  }

  /// Returns the row text style used in tables
  static TextStyle getRowStyle() {
    return GoogleFonts.inter(
      fontSize: 14,
      color: const Color(0xff697282),
      fontWeight: FontWeight.w400,
    );
  }

  /// Returns the lender name text style used in tables
  static TextStyle getLenderNameStyle() {
    return GoogleFonts.inter(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );
  }

  /// Checks if the current screen width is mobile-sized
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 800;
  }
}

class TableConfig {
  static const Map<String, double> columnWidths = {
    'lender': 200,
    'status': 150,
    'lastContacted': 150,
    'messages': 100,
    'preview': 300,
    'estimate': 150,
  };

  static const Map<String, String> columnHeaders = {
    'lender': 'Lender',
    'status': 'Status',
    'lastContacted': 'Last Contacted',
    'messages': 'Messages',
    'preview': 'Preview',
    'estimate': 'Estimate',
    'rank': 'Rank',
    'monthlyPayment': 'Monthly Payment',
    'totalPayments': 'Total Payments',
    'place': 'Place',
    '': '',
  };

  static List<String> getColumnsForScreenSize(double width) {
    if (width > 1400) {
      return [
        'lender',
        'status',
        'lastContacted',
        'messages',
        'preview',
        'estimate'
      ];
    } else if (width >= 900) {
      return ['lender', 'status', 'preview', 'estimate'];
    } else {
      return ['lender', 'preview'];
    }
  }
}
