import 'package:flutter/material.dart';

import '../controllers/address_controller.dart';
import '../models/address_model.dart';

class AddressProvider with ChangeNotifier {
  List<Address> _addresses = [];

  List<Address> get addresses {
    return [..._addresses];
  }

  void addAddress(Address address) async {
    final addressController = AddressController();
    addressController.addAddress(address);
     notifyListeners();
  }

  void removeAddress(Address address) async {
    final addressController = AddressController();
    await addressController.removeAddress(address.id);
    _addresses.remove(address);
    notifyListeners();
  }

  Future<void> _fetchAddresses() async {
    final addressController = AddressController();
    _addresses = await addressController.getAddresses();
    notifyListeners();
  }

  Future<void> refreshAddresses() async {
    await _fetchAddresses();
  }
}
