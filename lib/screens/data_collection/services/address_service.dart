import 'package:cloud_functions/cloud_functions.dart';

class AddressService {
  final FirebaseFunctions _functions = FirebaseFunctions.instance;

  Future<List<String>> getAddressSuggestions(String input) async {
    try {
      final HttpsCallable callable =
          _functions.httpsCallable('getAddressSuggestions');
      final result = await callable.call({
        'input': input,
      });

      if (result.data['status'] == 'OK') {
        return (result.data['predictions'] as List)
            .map((prediction) => prediction['description'] as String)
            .toList();
      }
      return [];
    } catch (e) {
      print('Error calling function: $e');
      return [];
    }
  }
}
