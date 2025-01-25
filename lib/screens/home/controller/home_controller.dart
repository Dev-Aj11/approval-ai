import 'package:approval_ai/controllers/ssn_encryption.dart';
import 'package:approval_ai/firebase_functions.dart';
import 'package:approval_ai/screens/agent_interactions/model/interaction_data.dart';
import 'package:approval_ai/screens/home/model/estimate_data.dart';
import 'package:approval_ai/screens/home/model/overview_data.dart';
import 'package:encrypt/encrypt.dart';
import 'package:approval_ai/screens/home/model/lender_data.dart';
import 'package:flutter/material.dart';
import 'package:approval_ai/controllers/auth_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeController extends ChangeNotifier {
  Map<LenderStatusEnum, int> lenderStatusCount = {
    LenderStatusEnum.contacted: 0,
    LenderStatusEnum.received: 0,
    LenderStatusEnum.negotiating: 0,
    LenderStatusEnum.complete: 0,
  };

  String _currentPage = "Home";
  String get currentPage => _currentPage;

  void setCurrentPage(String page) {
    _currentPage = page;
    // this notifies the listener in home_screen.dart to rebuild everything
    // inside the ListenableBuilder
    notifyListeners();
  }

  List<LoanEstimateData> getRecentLoanEstimatesForEachLender(lenderDataItems) {
    List<LoanEstimateData> recentLoanEstimates = [];

    for (var lenderDataItem in lenderDataItems) {
      if (lenderDataItem.estimateData != null) {
        // check if there are more than one estimate
        if (lenderDataItem.estimateData!.length > 1) {
          // sorting in descending order
          lenderDataItem.estimateData.sort(
              (LoanEstimateData a, LoanEstimateData b) =>
                  b.timestamp.compareTo(a.timestamp));
          // add the most recent estimate
        }
        recentLoanEstimates.add(lenderDataItem.estimateData![0]);
      }
    }
    return recentLoanEstimates;
  }

  // provide BuildContext to sign out
  Future<void> signOut(BuildContext context) async {
    try {
      await context.read<AuthProvider>().logout().then((value) {
        context.go('/login');
      });
    } catch (e) {
      print('Error during logout: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign out failed: $e')),
      );
    }
  }

  Future<String> getUserFirstName() async {
    try {
      final documentSnapshotOnUsers = await FirebaseFunctions.getUserData();
      final userInfo = documentSnapshotOnUsers.data() as Map<String, dynamic>;
      final firstName = userInfo["userData"]["personalInfo"]["firstName"];
      return firstName;
    } catch (e) {
      return "";
    }
  }

  Future<List<LenderData>> getLenderData() async {
    try {
      // get lender status for each user
      final documentSnapshotOnUsers = await FirebaseFunctions.getUserData();
      final userInfo = documentSnapshotOnUsers.data() as Map<String, dynamic>;
      final userLenderStatusInfo = userInfo["lenderData"];
      final encryptedBase64 = userInfo['userData']['personalInfo']['ssn'];

      try {
        final encrypted = Encrypted.fromBase64(encryptedBase64);
        final ssn = SSNEncryption.decryptSSN(encrypted);

        // SSN Encryption.testEncryptDecrypt() is working as expected
        // hmm this is not working as expected; unable to decrypt ssn
        print('Decrypted SSN: $ssn');
      } catch (e) {
        print('Detailed decryption error: $e');
        // Continue with the rest of the function even if SSN decryption fails
      }
      // get lender metada (lender name, type, logo, loan officer)
      final querySnapshotOnLenders = await FirebaseFunctions.getLenderDetails();

      // create list of lender metadata for each user
      final updatedLenderData =
          querySnapshotOnLenders.docs.map((lenderDataDoc) {
        final lenderInfo = lenderDataDoc.data() as Map<String, dynamic>;
        final loanOfficers = lenderInfo['loanOfficer'];
        final loanOfficerInfo = loanOfficers.first;
        final loanOfficerName =
            "${loanOfficerInfo['firstName']} ${loanOfficerInfo['lastName']}";

        // return lender data class
        return LenderData(
          name: lenderInfo['name'],
          type: lenderInfo['bankType'],
          logoUrl: lenderInfo['logoUrl'],
          loanOfficer: loanOfficerName,
          currStatus: _getLenderStatus(userLenderStatusInfo[lenderDataDoc.id]),
          estimateData:
              _buildEstimateData(userLenderStatusInfo[lenderDataDoc.id]),
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

  List<MessageData>? _buildLenderMessages(userLenderStatusInfo) {
    try {
      if (userLenderStatusInfo['messages'] == null) {
        return null;
      }
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
    } catch (e) {
      print("Error getting lender messages: $e");
      return [];
    }
  }

  List<LenderStatusEnum> _getLenderStatus(userLenderStatusInfo) {
    try {
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
    } catch (e) {
      print("Error getting lender status: $e");
      return [];
    }
  }

  List<LoanEstimateData>? _buildEstimateData(userLenderStatusInfo) {
    try {
      List<LoanEstimateData> estimateDataItems = [];
      if (userLenderStatusInfo['estimateData'] == null) {
        return null;
      }
      final estimateData =
          userLenderStatusInfo['estimateData'] as List<dynamic>;

      for (var estimateDataItem in estimateData) {
        final closingCosts =
            _getClosingCosts(estimateDataItem['closingCosts']) as ClosingCosts;

        final monthlyPaymentRange =
            _getMonthlyPaymentRange(estimateDataItem['monthlyPaymentRange']);
        final comparisons = _getComparisons(estimateDataItem['comparisons']);
        final loanDetails = _getLoanDetails(estimateDataItem['loanDetails']);

        estimateDataItems.add(
          LoanEstimateData(
            lenderName: estimateDataItem['lenderName'],
            estimateUrl: estimateDataItem['estimateUrl'],
            balloonPayment: estimateDataItem['balloonPayment'],
            prepaymentPenalty: estimateDataItem['prepaymentPenalty'],
            monthlyPaymentAndInterest:
                estimateDataItem['monthlyPaymentAndInterest'],
            timestamp: estimateDataItem['timestamp'],
            monthlyPaymentRange: monthlyPaymentRange,
            closingCosts: closingCosts,
            comparisons: comparisons, // estimateData['comparisons'],
            loanDetails: loanDetails, //estimateData['loanDetails'],
          ),
        );
      }
      return estimateDataItems;
    } catch (e) {
      print("Error getting estimate data: $e");
      return null;
    }
  }

  _getLoanDetails(loanDetails) {
    try {
      final interestRate = loanDetails['interestRate'];
      return LoanDetails(
        term: loanDetails['term'],
        loanAmount: loanDetails['loanAmount'],
        interestRate: _getInterestRate(interestRate),
      );
    } catch (e) {
      print("Error getting loan details: $e");
      return null;
    }
  }

  _getInterestRate(interestRate) {
    try {
      final adjustableData = interestRate['adjustable'];
      bool isAdjustable = adjustableData['isAdjustable'];
      var adjustableObj = Adjustable(isAdjustable: isAdjustable, details: null);
      if (isAdjustable) {
        final details = adjustableData['details'];
        adjustableObj.details = AdjustmentDetails(
          adjustmentFrequency: details['adjustmentFrequency'],
          initialChangeMonth: details['initialChangeMonth'],
          indexMargin: details['indexMargin'],
          minRate: details['minRate'],
          maxRate: details['maxRate'],
          firstChangeLimit: details['firstChangeLimit'],
          subsequentChangeLimit: details['subsequentChangeLimit'],
        );
      }
      return InterestRate(
        initial: interestRate['initial'],
        adjustable: adjustableObj,
      );
    } catch (e) {
      print("Error getting interest rate: $e");
      return null;
    }
  }

  _getMonthlyPaymentRange(monthlyPaymentRange) {
    try {
      return MonthlyPaymentRange(
        min: monthlyPaymentRange['min'],
        max: monthlyPaymentRange['max'],
      );
    } catch (e) {
      print("Error getting monthly payment range: $e");
      return null;
    }
  }

  _getComparisons(comparisons) {
    try {
      final annualPercentageRate = comparisons['annualPercentageRate'];
      final principalPaidIn5Years = comparisons['principalPaidIn5Years'];
      final totalInterestPercentage = comparisons['totalInterestPercentage'];
      final totalPaidIn5Years = comparisons['totalPaidIn5Years'];

      return Comparisons(
        annualPercentageRate: annualPercentageRate,
        principalPaidIn5Years: principalPaidIn5Years,
        totalInterestPercentage: totalInterestPercentage,
        totalPaidIn5Years: totalPaidIn5Years,
      );
    } catch (e) {
      print("Error getting comparisons: $e");
      return null;
    }
  }

  _getClosingCosts(clostingCostsdata) {
    try {
      final breakdown = clostingCostsdata['breakdown'];
      final loanCosts = breakdown['loanCosts'];
      final otherCosts = breakdown['otherCosts'];

      // constructs closing costs Breakdown Object
      final otherCostsObj = OtherCosts(
        taxes: otherCosts['taxes'],
        prepaids: otherCosts['prepaids'],
        escrow: otherCosts['escrow'],
        optionalCosts: otherCosts['optionalCosts'],
      );

      final loanCostsObj = LoanCosts(
        originationCharges: loanCosts['originationCharges'],
        servicesCannotShopFor: loanCosts['servicesCannotShopFor'],
        servicesCanShopFor:
            loanCosts['servicesCanShopFor'], // change to servicesCanShopFor
      );

      final closingCostsBreakdown = ClosingCostsBreakdown(
        loanCosts: loanCostsObj,
        otherCosts: otherCostsObj,
      );
      return ClosingCosts(
        totalClosingCosts: clostingCostsdata['totalClosingCosts'],
        cashToClose: clostingCostsdata['cashToClose'],
        breakdown: closingCostsBreakdown,
      );
    } catch (e) {
      print("Error getting closing costs: $e");
      return null;
    }
  }
}
