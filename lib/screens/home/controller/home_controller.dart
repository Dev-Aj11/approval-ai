import 'package:approval_ai/firebase_functions.dart';
import 'package:approval_ai/screens/agent_interactions/model/interaction_data.dart';
import 'package:approval_ai/screens/home/model/overview_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:approval_ai/screens/home/model/lender_data.dart';
import 'package:flutter/material.dart';

class HomeController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Map<LenderStatusEnum, int> lenderStatusCount = {
    LenderStatusEnum.contacted: 0,
    LenderStatusEnum.received: 0,
    LenderStatusEnum.negotiating: 0,
    LenderStatusEnum.complete: 0,
  };

  Future<void> signOut(context) async {
    try {
      await _auth.signOut();
      Navigator.pushNamed(context, '/login');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign out failed: $e')),
      );
    }
  }

  Future<List<LenderData>> getLenderData() async {
    try {
      // get lender status for each user
      final documentSnapshotOnUsers = await FirebaseFunctions.getUserData();
      final userInfo = documentSnapshotOnUsers.data() as Map<String, dynamic>;
      final userLenderStatusInfo = userInfo["lenderData"];

      // get lender metada (lender name, type, logo, loan officer)
      final querySnapshotOnLenders = await FirebaseFunctions.getLenderDetails();

      // create list of lender metadata for each user
      final updatedLenderData =
          querySnapshotOnLenders.docs.map((lenderDataDoc) {
        final lenderInfo = lenderDataDoc.data() as Map<String, dynamic>;
        final loanOfficerInfo =
            lenderInfo['loanOfficer'] as Map<String, dynamic>;
        final lenderName = lenderInfo['name'];

        // return lender data class
        return LenderData(
          name: lenderName,
          type: lenderInfo['bankType'],
          logoUrl: lenderInfo['logoUrl'],
          loanOfficer: loanOfficerInfo.keys.first,
          currStatus: _getLenderStatus(userLenderStatusInfo[lenderDataDoc.id]),
          metrics: _buildLenderMetrics(userLenderStatusInfo[lenderDataDoc.id]),
          messages:
              _buildLenderMessages(userLenderStatusInfo[lenderDataDoc.id]),
        );
      }).toList();
      return updatedLenderData;
    } catch (e) {
      print("Error getting lender data: $e");
      return [];
    }
  }

  List<MessageData> _buildLenderMessages(userLenderStatusInfo) {
    final messages = userLenderStatusInfo['messages'];
    final List<MessageData> messageList = [];
    // messages.entries gives you a map with all key-value pairs in the map
    for (var message in messages.entries) {
      messageList.add(
        MessageData(
          content: message.value['content'],
          timestamp: message.value['timestamp'].toDate(),
          isFromAgent: message.value['isFromAgent'],
          mode: message.value['mode'],
        ),
      );
    }
    return messageList;
  }

  List<LenderStatusEnum> _getLenderStatus(userLenderStatusInfo) {
    final lenderStatus = userLenderStatusInfo['status'];

    List<LenderStatusEnum> lenderStatusList = [];
    if (lenderStatus['contacted'] == true) {
      var contacted = LenderStatusEnum.contacted;
      lenderStatusCount[contacted] = lenderStatusCount[contacted]! + 1;
      lenderStatusList.add(contacted);
    }
    if (lenderStatus['estimateReceived'] == true) {
      var received = LenderStatusEnum.received;
      lenderStatusCount[received] = lenderStatusCount[received]! + 1;
      lenderStatusList.add(received);
    }
    if (lenderStatus['negotiationInProgress'] == true) {
      var negotiating = LenderStatusEnum.negotiating;
      lenderStatusCount[negotiating] = lenderStatusCount[negotiating]! + 1;
      lenderStatusList.add(negotiating);
    }
    if (lenderStatus['negotiationComplete'] == true) {
      var complete = LenderStatusEnum.complete;
      lenderStatusCount[complete] = lenderStatusCount[complete]! + 1;
      lenderStatusList.add(complete);
    }
    return lenderStatusList;
  }

  // create lenderDataMessagesExchanged Widget if 'messagesExchanged' is not null
  Map<LenderDetailsEnum, LenderMetricData> _buildLenderMetrics(
      userLenderStatus) {
    final metrics = <LenderDetailsEnum, LenderMetricData>{};
    if (userLenderStatus['messagesExchanged'] != null) {
      final messagesExchanged = userLenderStatus['messagesExchanged'];
      metrics[LenderDetailsEnum.messagesExchagned] =
          LenderDataMessagesExchanged(
        emailsExchanged: messagesExchanged['emailsExchanged'],
        textMessages: messagesExchanged['textMessages'],
        phoneCalls: messagesExchanged['phoneCalls'],
      );
    }

    // create lenderDataEstimateAnalysis Widget if 'estimateAnalysis' is not null
    if (userLenderStatus['estimateAnalysis'] != null) {
      final estimateAnalysis = userLenderStatus['estimateAnalysis'];
      metrics[LenderDetailsEnum.estimateAnalysis] = LenderDataEstimateAnalysis(
          interestRate: estimateAnalysis['interestRate'],
          lenderPayments: estimateAnalysis['lenderPayments'],
          totalPayments: estimateAnalysis['totalPayments']);
    }

    // create lenderDataNegotiationAnalysis Widget if 'negotiationAnalysis' is not null
    if (userLenderStatus['negotiationAnalysis'] != null) {
      final negotiationAnalysis = userLenderStatus['negotiationAnalysis'];
      metrics[LenderDetailsEnum.negotiationAnalysis] =
          LenderDataNegotiationAnalysis(
        totalSavings: negotiationAnalysis['totalSavings'],
        initialTotalPayments: negotiationAnalysis['initialTotalPayments'],
        negotiatedTotalPayments: negotiationAnalysis['negotiatedTotalPayments'],
      );
    }
    return metrics;
  }
}
