import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:techx_app/models/product_model.dart';
import 'package:techx_app/pages/product/product_detail_page.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({super.key});

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  static List<Product> productsList = [
    Product(1, 'iPhone 15 Pro Max', 2, 'https://cdn.tgdd.vn/Products/Images/42/305658/iphone-15-pro-max-blue-1-1.jpg', 
    'Apple', 33190000, 34990000, 14, 'Titan xanh', 'OLED 6.7\" Super Retina XDR', 'iOS 17', 'Chính 48 MP & Phụ 12 MP, 12 MP', 
    'Apple A17 Pro 6 nhân', '8 GB', '256 GB', '4422mAh 20W', 'Mô tả', 2),
    Product(49, 'Samsung Galaxy A15', 1, 'https://cdn.tgdd.vn/2023/12/campaign/B4C9F311-6B6E-41FE-A3CB-A2A0CA4FBBBB-600x620.png',
    'Samsung', 5590000, 5590000, 14, 'Vàng nhạt', 'Super AMOLED 6.5\" Full HD+', 'Android 13', 'Chính 50 MP & Phụ 5 MP, 2 MP', 
    'MediaTek Helio G99', '8 GB', '256 GB', '5000mAh 25W', 'Mô tả', 1),
    Product(58, 'OPPO Find N3 Flip 5G', 3, 'https://cdn.tgdd.vn/Products/Images/42/317981/oppo-find-n3-flip-pink-1.jpg',
    'OPPO', 22990000, 22990000, 14, 'Hồng', 'AMOLED Chính 6.8\" & Phụ 3.26\"Full HD+', 'Android 13', 'Chính 50 MP & Phụ 48 MP, 32 MP', 
    'MediaTek Dimensity 9200 5G 8 nhân', '12 GB', '256 GB', '4300mAh 44W', 'Mô tả', 1),
  ];

  List<Product> displayList = List.from(productsList);

  void updateList(String value) {
    setState(() {
      displayList = productsList
          .where((element) =>
              element.name!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  // Định dạng đơn vị tiền tệ
  String formatCurrency(double orginalCurrency) {
    var formatter = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    return formatter.format(orginalCurrency);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leadingWidth: 30,
        title: TextField(
          onChanged: (value) => updateList(value),
          style: const TextStyle(
            color: Colors.black,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(hexColor('#F0F1F0')),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide.none,
            ),
            hintText: "Tìm kiếm tại đây...",
            hintStyle: TextStyle(
              color: Color(hexColor('#9aa0a6')),
              fontWeight: FontWeight.w300,
            ),
            prefixIcon: const Icon(Icons.search),
            prefixIconColor: Color(hexColor('#9aa0a6')),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Expanded(
          child: displayList.isEmpty ? Center(child: Text('Không tìm thấy kết quả', style: TextStyle(color: Color(hexColor('#9DA2A7')), fontSize: 18))) :
          ListView.builder(
            itemCount: displayList.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => const ProductDetailPage()));
              },
              child: ListTile(
                title: Text(
                  displayList[index].name!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${displayList[index].ram!}/ ${displayList[index].storage!}/ ${displayList[index].color!}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xff727880),
                      ),
                    ),
                    Text(
                      formatCurrency(displayList[index].newPrice!),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                leading: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Color(hexColor('#ecedef')),
                      width: 2,
                    )
                  ),
                  child: Image.network(
                    '${displayList[index].imageUrl}',
                    height: 80,
                    width: 60,
                  )
                ),
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