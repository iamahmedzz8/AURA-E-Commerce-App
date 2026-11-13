import 'package:shared_preferences/shared_preferences.dart';

class SelectedAddressService {
  final SharedPreferences preferences;

  SelectedAddressService({required this.preferences});

  static const String _addressIdKey = 'selected_address_id';

  Future<void> saveAddressId(String id) async {
    await preferences.setString(_addressIdKey, id);
  }

  String? getAddressId() {
    return preferences.getString(_addressIdKey);
  }
}
