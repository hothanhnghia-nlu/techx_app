import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techx_app/models/address_model.dart';
import 'package:techx_app/models/logistic/district_model.dart';
import 'package:techx_app/models/logistic/province_model.dart';
import 'package:techx_app/models/logistic/ward_model.dart';
import 'package:techx_app/providers/address_provider.dart';
import 'package:techx_app/services/logistic_service.dart';

class MyAddressesPage extends StatefulWidget {
  const MyAddressesPage({super.key});

  @override
  State<MyAddressesPage> createState() => _MyAddressesPageState();
}

class _MyAddressesPageState extends State<MyAddressesPage> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final provinceController = TextEditingController();
  final districtController = TextEditingController();
  final wardController = TextEditingController();
  final addressDetailController = TextEditingController();

  LogisticService service = LogisticService();

  Province? _provinceSelected;
  District? _districtSelected;
  Ward? _wardSelected;

  List<Province> _provinceList = [];
  List<District> _districtList = [];
  List<Ward> _wardList = [];

  @override
  void initState() {
    super.initState();
    _fetchProvinces();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    provinceController.dispose();
    districtController.dispose();
    wardController.dispose();
    addressDetailController.dispose();
    super.dispose();
  }

  // Get Provinces
  Future<void> _fetchProvinces() async {
    try {
      log('MyAddressesPage: initState');

      List<Province> provinces = await service.getProvinces();
      print(provinces);
      log('MyAddressesPage: initState123');

      if (mounted) {
        setState(() {
          _provinceList = provinces;
          if (_provinceList.isNotEmpty) {
            _provinceSelected = _provinceList[0];
            _fetchDistricts(_provinceSelected!.provinceID);
          }
        });
      }
    } catch (e) {
      throw Exception('Error fetching provinces: $e');
    }
  }

  // Get Districts by province id
  Future<void> _fetchDistricts(int provinceId) async {
    try {
      List<District> districts = await service.getDistricts(provinceId);
      if (mounted) {
        setState(() {
          _districtList = districts;
          _districtSelected = _districtList.isNotEmpty ? _districtList[0] : null;
          if (_districtSelected != null) {
            _fetchWards(_districtSelected!.districtID);
          } else {
            _wardList.clear();
          }
        });
      }
    } catch (e) {
      throw Exception('Error fetching provinces: $e');
    }
  }

  // Get Wards by district id
  Future<void> _fetchWards(int districtId) async {
    try {
      List<Ward> wards = await service.getWards(districtId);
      if (mounted) {
        setState(() {
          _wardList = wards;
          _wardSelected = _wardList.isNotEmpty ? _wardList[0] : null;
        });
      }
    } catch (e) {
      throw Exception('Error fetching provinces: $e');
    }
  }

  void _saveButton() async {
    String detail = addressDetailController.text;
    String ward = _wardSelected?.wardName ?? '';
    String city = _districtSelected?.districtName ?? '';
    String province = _provinceSelected?.provinceName ?? '';
    String? note = null; // Add logic to get note if needed
    int status = 1; // Set status as needed

    if (detail.isNotEmpty &&
        ward.isNotEmpty &&
        city.isNotEmpty &&
        province.isNotEmpty) {
      Address newAddress = Address(
        id: DateTime.now().millisecondsSinceEpoch, // Generate a unique ID
        detail: detail,
        ward: ward,
        city: city,
        province: province,
        note: note,
        status: status,
      );

      Provider.of<AddressProvider>(context, listen: false)
          .addAddress(newAddress);
      //  fetchAddresses();
      Provider.of<AddressProvider>(context, listen: false).refreshAddresses();
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng điền đầy đủ thông tin'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 5,
        shadowColor: Color(hexColor('#F0F1F0')),
        title: const Text(
          'Địa chỉ giao hàng',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Họ và tên',
                    ),
                    obscureText: false,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Số điện thoại',
                    ),
                    obscureText: false,
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField(
                    value: _provinceSelected,
                    items: _provinceList.map((province) {
                      return DropdownMenuItem(
                        value: province,
                        child: Text(province.provinceName ?? ''),
                      );
                    }).toList(),
                    onChanged: (Province? newProvince) {
                      setState(() {
                        _provinceSelected = newProvince;
                        _districtSelected = null;
                        _wardSelected = null;
                        _districtList.clear();
                        _wardList.clear();
                      });
                      if (newProvince != null) {
                        _fetchDistricts(newProvince.provinceID);
                      }
                    },
                    icon: const Icon(
                      Icons.arrow_drop_down_circle,
                      color: Colors.deepPurple,
                    ),
                    dropdownColor: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Tỉnh/ Thành phổ',
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField(
                    value: _districtSelected,
                    items: _districtList.map((district) {
                      return DropdownMenuItem(
                        value: district,
                        child: Text(district.districtName ?? ''),
                      );
                    }).toList(),
                    onChanged: (District? newDistrict) {
                      setState(() {
                        _districtSelected = newDistrict;
                        _wardSelected = null;
                        _wardList.clear();
                      });
                      if (newDistrict != null) {
                        _fetchWards(newDistrict.districtID);
                      }
                    },
                    icon: const Icon(
                      Icons.arrow_drop_down_circle,
                      color: Colors.deepPurple,
                    ),
                    dropdownColor: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Quận/ Huyện',
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField(
                    value: _wardSelected,
                    items: _wardList.map((ward) {
                      return DropdownMenuItem(
                        value: ward,
                        child: Text(ward.wardName ?? ''),
                      );
                    }).toList(),
                    onChanged: (Ward? newWard) {
                      setState(() {
                        _wardSelected = newWard;
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_drop_down_circle,
                      color: Colors.deepPurple,
                    ),
                    dropdownColor: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Phường/ Xã',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: addressDetailController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Địa chỉ nhận hàng',
                    ),
                    obscureText: false,
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: _saveButton,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(50)),
                      child: const Center(
                        child: Text(
                          'Xác nhận',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

int hexColor(String color) {
  String newColor = "0xff$color";
  newColor = newColor.replaceAll('#', '');
  int finalColor = int.parse(newColor);
  return finalColor;
}
