import 'package:approval_ai/controllers/ssn_encryption.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFunctions {
  static final String baseUrl =
      "https://us-central1-approval-ai.cloudfunctions.net";

  // add new user to firebase
  static Future<void> addUserDetails(
      Map<String, dynamic> userInfoAndPreferences) async {
    print(userInfoAndPreferences);
    // encrypt ssn from userdata
    final ssn = userInfoAndPreferences['userData']['personalInfo']['ssn'];
    final encryptedSsn = SSNEncryption.encryptSSN(ssn.toString());
    userInfoAndPreferences['userData']['personalInfo']['ssn'] = encryptedSsn;
    try {
      // URL encode the text parameter to handle special characters
      // add lender data to colleciton
      QuerySnapshot lenderInfo = await getLenderDetails();
      Map<String, dynamic> lenderDetails = {};
      lenderInfo.docs.forEach(
        (doc) {
          // doc.id = lender name
          // doc.data() = Map<String, dynamic> (lender name -> lender data)
          lenderDetails[doc.id] = {
            "status": {
              "contacted": true,
              "estimateReceived": false,
              "negotiationInProgress": false,
              "negotiationCompleted": false,
            },
            "loanOfficer": (doc.data() as Map)['loanOfficer']
                [0] // get first loan officer
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
// Firebase service
class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> storeUserSSN(String ssn) async {
    try {
      final encryptedSSN = SSNEncryption.encryptSSN(ssn);
      
      await _firestore.collection('users').doc(userId).set({
        'ssn': encryptedSSN,
        'lastUpdated': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      throw Exception('Failed to store encrypted SSN: $e');
    }
  }

  Future<String> retrieveUserSSN(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      if (!doc.exists || !doc.data()!.containsKey('ssn')) {
        throw Exception('SSN not found');
      }

      final encryptedSSN = doc.data()!['ssn'] as String;
      return SSNEncryption.decryptSSN(encryptedSSN);
    } catch (e) {
      throw Exception('Failed to retrieve SSN: $e');
    }
  }
}

// Usage example
void main() async {
  final userService = UserService();
  
  // Storing SSN
  await userService.storeUserSSN('user123', '123-45-6789');
  
  // Retrieving SSN
  final decryptedSSN = await userService.retrieveUserSSN('user123');
  print('Decrypted SSN: $decryptedSSN');
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
*/
