import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:techx_app/utils/constant.dart';

class ProductsDetailScreen extends StatefulWidget {
  final Map<String, dynamic>? productData; // Null nếu tạo mới, có dữ liệu nếu chỉnh sửa

  const ProductsDetailScreen({Key? key, this.productData}) : super(key: key);

  @override
  State<ProductsDetailScreen> createState() => _ProductsDetailScreenState();
}

class _ProductsDetailScreenState extends State<ProductsDetailScreen> {
  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController originalPriceController = TextEditingController();
  final TextEditingController newPriceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController screenController = TextEditingController();
  final TextEditingController osController = TextEditingController();
  final TextEditingController cameraController = TextEditingController();
  final TextEditingController cpuController = TextEditingController();
  final TextEditingController ramController = TextEditingController();
  final TextEditingController storageController = TextEditingController();
  final TextEditingController batteryController = TextEditingController();
  final TextEditingController producedYearController = TextEditingController();

  final baseUrl = Constant.api;

  // List of providers (will be updated from API)
  List<Map<String, dynamic>> providers = [];
  int? selectedProviderId;

  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Nếu có dữ liệu sản phẩm, điền vào các trường
    if (widget.productData != null) {
      final data = widget.productData!;
      nameController.text = data['name'] ?? '';
      originalPriceController.text = data['originalPrice']?.toString() ?? '';
      newPriceController.text = data['newPrice']?.toString() ?? '';
      quantityController.text = data['quantity']?.toString() ?? '';
      colorController.text = decodeUtf8(data['color'] ?? '');
      screenController.text = decodeUtf8(data['screen'] ?? '');
      osController.text = data['operatingSystem'] ?? '';
      cameraController.text = decodeUtf8(data['camera'] ?? '');
      cpuController.text = decodeUtf8(data['cpu'] ?? '');
      ramController.text = data['ram'] ?? '';
      storageController.text = data['storage'] ?? '';
      batteryController.text = data['battery'] ?? '';
      producedYearController.text = data['producedYear']?.toString() ?? '';
      selectedProviderId = data['providerId'];
    }

    // Tải danh sách providers từ API
    _loadProviders();
  }

  // Hàm tải danh sách providers từ API
  Future<void> _loadProviders() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/providers'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          providers = data.map((provider) {
            return {
              "id": provider['id'],
              "name": provider['name'],
            };
          }).toList();
        });
      } else {
        print("Lỗi khi tải danh sách nhà cung cấp: ${response.statusCode}");
      }
    } catch (e) {
      print("Lỗi kết nối: $e");
    }
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  Future<void> saveProduct() async {
    final String apiUrl = widget.productData == null
        ? "$baseUrl/products"
        : "$baseUrl/products/${widget.productData!['id']}";

    try {
      var request = http.MultipartRequest(
        widget.productData == null ? 'POST' : 'PUT',
        Uri.parse(apiUrl),
      );

      request.fields['name'] = nameController.text;
      request.fields['providerId'] = selectedProviderId.toString();
      request.fields['originalPrice'] = originalPriceController.text;
      request.fields['newPrice'] = newPriceController.text;
      request.fields['quantity'] = quantityController.text;
      request.fields['color'] = colorController.text;
      request.fields['screen'] = screenController.text;
      request.fields['operatingSystem'] = osController.text;
      request.fields['camera'] = cameraController.text;
      request.fields['cpu'] = cpuController.text;
      request.fields['ram'] = ramController.text;
      request.fields['storage'] = storageController.text;
      request.fields['battery'] = batteryController.text;
      request.fields['producedYear'] = producedYearController.text;

      if (_selectedImage != null) {
        var imageFile = await http.MultipartFile.fromPath('imageFile', _selectedImage!.path);
        request.files.add(imageFile);
      }

      var response = await request.send();
      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Lưu sản phẩm thành công!')),
        );
        Navigator.pop(context);
      } else {
        print("Lưu thất bại: ${response.statusCode}");
      }
    } catch (e) {
      print("Lỗi kết nối: $e");
    }
  }

  Widget buildTextField(String label, TextEditingController controller, {TextInputType inputType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          labelText: label,
        ),
      ),
    );
  }

  Widget buildDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<int>(
        value: selectedProviderId,
        items: providers.isEmpty
            ? [DropdownMenuItem(child: Text('Đang tải...'))] // Hiển thị khi đang tải
            : providers.map((provider) {
          return DropdownMenuItem<int>(
            value: provider['id'],
            child: Text(provider['name']),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedProviderId = value;
          });
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          labelText: "Chọn hãng",
        ),
      ),
    );
  }

  // Decode UTF8
  String decodeUtf8(String value) {
    try {
      return utf8.decode(value.runes.toList());
    } catch (e) {
      return value;
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
        title: Text(
          widget.productData == null ? "Tạo sản phẩm mới" : "Chỉnh sửa sản phẩm",
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildTextField("Tên sản phẩm", nameController),
            buildDropdown(),
            buildTextField("Giá gốc", originalPriceController, inputType: TextInputType.number),
            buildTextField("Giá mới", newPriceController, inputType: TextInputType.number),
            buildTextField("Số lượng", quantityController, inputType: TextInputType.number),
            buildTextField("Màu sắc", colorController),
            buildTextField("Màn hình", screenController),
            buildTextField("Hệ điều hành", osController),
            buildTextField("Camera", cameraController),
            buildTextField("CPU", cpuController),
            buildTextField("RAM", ramController),
            buildTextField("Dung lượng lưu trữ", storageController),
            buildTextField("Dung lượng pin", batteryController),
            buildTextField("Năm sản xuất", producedYearController, inputType: TextInputType.number),

            // Chọn ảnh
            const SizedBox(height: 16),
            _selectedImage != null
                ? Image.file(_selectedImage!, height: 150)
                : const Text("Chưa chọn ảnh"),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text("Chọn ảnh từ thiết bị"),
            ),

            // Nút lưu sản phẩm
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: saveProduct,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white),
              child: const Text("Lưu sản phẩm"),
            ),
          ],
        ),
      ),
    );
  }
}

int hexColor(String color) {
  String newColor = "0xff$color";
  newColor = newColor.replaceAll('#', '');
  return int.parse(newColor);
}
