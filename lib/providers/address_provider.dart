import 'package:flutter/material.dart';

import '../controllers/address_controller.dart';
import '../models/address_model.dart';

class AddressProvider with ChangeNotifier {
  List<Address> _addresses = [];
  Address? _addressDefault;

  List<Address> get addresses {
    return [..._addresses];
  }

  Address? get addressDefault {
    return _addressDefault;
  }

  Future<void> addAddress(Address address) async {
    final addressController = AddressController();
    addressController.addAddress(address);
    notifyListeners();
  }

  Future<void> updateAddress(Address address) async {
    final addressController = AddressController();
    addressController.updateAddress(address);
    notifyListeners();
  }

  Future<void> removeAddress(Address address) async {
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

  Future<void> _fetchAddressesDefault() async {
    final addressController = AddressController();
    _addressDefault = await addressController.getAddressesDefault();
    notifyListeners();
  }

  Future<void> refreshAddresses() async {
    await _fetchAddresses();
  }

  Future<void> refreshAddressesDefault() async {
    await _fetchAddressesDefault();
  }
}
