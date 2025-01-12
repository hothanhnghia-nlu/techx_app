import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techx_app/models/address_model.dart';
import 'package:techx_app/models/logistic/district_model.dart';
import 'package:techx_app/models/logistic/province_model.dart';
import 'package:techx_app/models/logistic/ward_model.dart';
import 'package:techx_app/providers/address_provider.dart';
import 'package:techx_app/services/logistic_service.dart';

import '../../models/logistic/_address_suggestion.dart';

class MyAddressesPage extends StatefulWidget {
  final Address? address; // Địa chỉ được truyền từ ListAddressPage
  const MyAddressesPage({super.key, this.address});

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
  final FocusNode _addressFocusNode = FocusNode();
  bool isDefaultAddress = false; // Mặc định là không tích
  LogisticService service = LogisticService();

  // Province? _provinceSelected;
  // District? _districtSelected;
  // Ward? _wardSelected;
  //
  // List<Province> _provinceList = [];
  // List<District> _districtList = [];
  // List<Ward> _wardList = [];

  List<AddressSuggestion> _addressSuggestions = [];
  bool _isLoadingSuggestions = false;

  @override
  void initState() {
    super.initState();
    _initializeAddressFields(); // Gán dữ liệu vào các trường nếu có
    print(widget.address.toString());

    // Lắng nghe trạng thái tiêu điểm của ô nhập liệu "Địa chỉ nhận hàng"
    _addressFocusNode.addListener(() {
      if (!_addressFocusNode.hasFocus) {
        // Nếu mất tiêu điểm, ẩn danh sách gợi ý
        setState(() {
          _addressSuggestions = [];
        });
      }
    });
  }

  void _initializeAddressFields() {
    if (widget.address != null) {
      // Nếu có địa chỉ được truyền vào, gán dữ liệu vào các TextEditingController
      nameController.text = widget.address!.fullName;
      phoneController.text = widget.address!.phoneNumber;
      addressDetailController.text = widget.address!.detail;
      provinceController.text = widget.address!.province;
      districtController.text = widget.address!.city;
      wardController.text = widget.address!.ward;
      isDefaultAddress = widget.address!.status == 0 ? true : false;
    }
  }

  @override
  void dispose() {
    _addressFocusNode.dispose(); // Hủy FocusNode
    nameController.dispose();
    phoneController.dispose();
    provinceController.dispose();
    districtController.dispose();
    wardController.dispose();
    addressDetailController.dispose();
    super.dispose();
  }

  void fetchAddressSuggestions(String input) async {
    print('Fetching suggestions for: $input');
    if (input.length < 3) {
      setState(() => _addressSuggestions = []);
      return;
    }
    if (input.isEmpty) {
      setState(() {
        _addressSuggestions = [];
      });
      return;
    }
    if (_isLoadingSuggestions) return; // Tránh gọi API liên tục
    setState(() {
      _isLoadingSuggestions = true;
    });
    try {
      final suggestions = await service.suggestedAddress(input);
      if (mounted) {
        setState(() {
          _addressSuggestions = suggestions;
          _isLoadingSuggestions = false;
          print('Number of suggestions: ${_addressSuggestions.length}');
        });
      }
      // Hiển thị danh sách gợi ý
      for (var suggestion in suggestions) {
        print('Address: ${suggestion.toString()}');
        print('---');
      }
    } catch (e) {
      print('Error fetching address suggestions: $e');
      setState(() {
        _isLoadingSuggestions = false;
      });
    }
  }

  // Hàm xử lý khi người dùng chọn một địa chỉ
  void onAddressSelected(AddressSuggestion suggestion) {
    setState(() {
      addressDetailController.text = suggestion.detailAddress;
      provinceController.text = suggestion.province;
      districtController.text = suggestion.district;
      wardController.text = suggestion.commune;

      // Xóa danh sách gợi ý
      _addressSuggestions = [];
    });
  }

  // Get Provinces
  // Future<void> _fetchProvinces() async {
  //   try {
  //     log('MyAddressesPage: initState');
  //
  //     List<Province> provinces = await service.getProvinces();
  //     print(provinces);
  //     log('MyAddressesPage: initState123');
  //
  //     if (mounted) {
  //       setState(() {
  //         _provinceList = provinces;
  //         if (_provinceList.isNotEmpty) {
  //           _provinceSelected = _provinceList[0];
  //           _fetchDistricts(_provinceSelected!.provinceID);
  //         }
  //       });
  //     }
  //   } catch (e) {
  //     throw Exception('Error fetching provinces: $e');
  //   }
  // }
  //
  // // Get Districts by province id
  // Future<void> _fetchDistricts(int provinceId) async {
  //   try {
  //     List<District> districts = await service.getDistricts(provinceId);
  //     if (mounted) {
  //       setState(() {
  //         _districtList = districts;
  //         _districtSelected =
  //             _districtList.isNotEmpty ? _districtList[0] : null;
  //         if (_districtSelected != null) {
  //           _fetchWards(_districtSelected!.districtID);
  //         } else {
  //           _wardList.clear();
  //         }
  //       });
  //     }
  //   } catch (e) {
  //     throw Exception('Error fetching provinces: $e');
  //   }
  // }
  //
  // // Get Wards by district id
  // Future<void> _fetchWards(int districtId) async {
  //   try {
  //     List<Ward> wards = await service.getWards(districtId);
  //     if (mounted) {
  //       setState(() {
  //         _wardList = wards;
  //         _wardSelected = _wardList.isNotEmpty ? _wardList[0] : null;
  //       });
  //     }
  //   } catch (e) {
  //     throw Exception('Error fetching provinces: $e');
  //   }
  // }

  void _saveButton() async {
    if (widget.address == null) {
      String detail = addressDetailController.text;
      String fullName = nameController.text;
      String phoneNumber = phoneController.text;
      String province = provinceController.text.trim();
      String district = districtController.text.trim();
      String ward = wardController.text.trim();

      if (detail.isNotEmpty &&
          province.isNotEmpty &&
          district.isNotEmpty &&
          ward.isNotEmpty) {
        Address newAddress = Address(
          id: DateTime.now().millisecondsSinceEpoch,
          fullName: fullName,
          phoneNumber: phoneNumber,
          detail: detail,
          province: province,
          city: district,
          ward: ward,
          note: null,
          status:
              isDefaultAddress ? 0 : 1, // Nếu checkbox được tích, status = 0
        );
        await Provider.of<AddressProvider>(context, listen: false)
            .addAddress(newAddress);
        //  fetchAddresses();
        await Provider.of<AddressProvider>(context, listen: false)
            .refreshAddresses();
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Vui lòng điền đầy đủ thông tin'),
          ),
        );
      }
      return;
    }
    _update();
  }

  void _update() async {
    String fullName = nameController.text;
    String phoneNumber = phoneController.text;
    String detail = addressDetailController.text;
    String province = provinceController.text.trim();
    String district = districtController.text.trim();
    String ward = wardController.text.trim();
    widget.address?.fullName = fullName;
    widget.address?.phoneNumber = phoneNumber;
    widget.address?.detail = detail;
    widget.address?.province = province;
    widget.address?.city = district;
    widget.address?.ward = ward;
    widget.address?.status =
        isDefaultAddress ? 0 : 1; // Nếu checkbox được tích, status = 0
    await Provider.of<AddressProvider>(context, listen: false)
        .updateAddress(widget.address!);
    await Provider.of<AddressProvider>(context, listen: false)
        .refreshAddresses();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                Container(
                  height: _addressSuggestions.isNotEmpty ? 200 : 60,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: addressDetailController,
                        focusNode: _addressFocusNode,
                        // Gắn FocusNode
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          if (value.length >= 3) {
                            fetchAddressSuggestions(value);
                          } else {
                            setState(() {
                              _addressSuggestions = [];
                            });
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Địa chỉ nhận hàng',
                        ),
                      ),
                      if (_addressSuggestions.isNotEmpty)
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(top: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ListView.separated(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              shrinkWrap: true,
                              itemCount: _addressSuggestions.length,
                              separatorBuilder: (context, index) => Divider(
                                height: 1,
                                color: Colors.grey.shade200,
                                indent: 16,
                                endIndent: 16,
                              ),
                              itemBuilder: (context, index) {
                                final suggestion = _addressSuggestions[index];
                                return ListTile(
                                  dense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 4,
                                  ),
                                  leading: Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.blue.shade400,
                                    size: 20,
                                  ),
                                  title: Text(
                                    suggestion.description,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  onTap: () {
                                    onAddressSelected(suggestion);
                                    FocusScope.of(context).unfocus();
                                  },
                                  hoverColor: Colors.grey.shade100,
                                );
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: provinceController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Tỉnh/ Thành phố',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: districtController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Quận/ Huyện',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: wardController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Phường/ Xã',
                  ),
                ),
                const SizedBox(height: 0),
                CheckboxListTile(
                  title: const Text(
                    'Đặt làm địa chỉ mặc định',
                    style: TextStyle(fontSize: 16),
                  ),
                  value: isDefaultAddress,
                  onChanged: (bool? value) {
                    setState(() {
                      isDefaultAddress =
                          value ?? false; // Cập nhật trạng thái checkbox
                    });
                  },
                  controlAffinity: ListTileControlAffinity
                      .leading, // Hiển thị checkbox bên trái
                ),
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
                // const SizedBox(height: 40),
              ],
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
