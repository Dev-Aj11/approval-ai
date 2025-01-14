// import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFunctions {
  static final String baseUrl =
      "https://us-central1-approval-ai.cloudfunctions.net";

  static Future<void> addUserDetails(
      Map<String, dynamic> userInfoAndPreferences) async {
    try {
      // URL encode the text parameter to handle special characters
      // add lender data to colleciton
      QuerySnapshot lenderInfo = await getLenderDetails();
      Map<String, dynamic> lenderDetails = {};
      lenderInfo.docs.forEach(
        (doc) {
          lenderDetails[doc.id] = {
            "messagesExchanged": null,
            "estimateAnalysis": null,
            "negotiationAnalysis": null
          };
        },
      );
      userInfoAndPreferences["lenderData"] = lenderDetails;

      // add user to firestore with user data and lender data
      final currentUser = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser?.uid)
          .set(userInfoAndPreferences);
    } catch (e) {
      print('Error calling function: $e');
    }
  }

  static Future<QuerySnapshot> getLenderDetails() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('lenders').get();
    return querySnapshot;
  }

  static Future<DocumentSnapshot> getUserData() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser?.uid)
        .get();
  }
}

/*
      if (currentUser == null) throw Exception('No user logged in');
      final url = Uri.parse('$baseUrl/addUserDetails');
      var body = jsonEncode({currentUser.uid: userInfoAndPreferences});
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200) {
        print('Success: ${response.body}');
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error calling function: $e');
    }
  }
}
*/
