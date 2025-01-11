import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techx_app/models/address_model.dart';
import 'package:techx_app/pages/profile/my_addresses_page.dart';
import 'package:techx_app/providers/address_provider.dart';

class ListAddressPage extends StatefulWidget {
  const ListAddressPage({super.key});

  @override
  State<ListAddressPage> createState() => _ListAddressPageState();
}

class _ListAddressPageState extends State<ListAddressPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<AddressProvider>(context, listen: false).refreshAddresses();
  }

  void _navigateToMyAddressPage({Address? address}) async {
    await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => MyAddressesPage(address: address),
      ),
    );
   await Provider.of<AddressProvider>(context, listen: false).refreshAddresses();
  }

  void _deleteAddress(Address address) {
    Provider.of<AddressProvider>(context, listen: false).removeAddress(address);
  }

  void _confirmDeleteAddress(Address address) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this address?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                _deleteAddress(address);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Addresses'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () =>
                _navigateToMyAddressPage(), // Thêm mới (không truyền địa chỉ)
          ),
        ],
      ),
      body: Consumer<AddressProvider>(
        builder: (context, addressProvider, child) {
          return ListView.builder(
            itemCount: addressProvider.addresses.length,
            itemBuilder: (context, index) {
              Address address = addressProvider.addresses[index];
              return Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: ListTile(
                  leading: Icon(Icons.location_on,
                      color: Theme.of(context).primaryColor),
                  title: Text(
                    '${address.detail}, ${address.ward}, ${address.city}, ${address.province}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Tap to view details'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () => _navigateToMyAddressPage(address: address),
                  // Truyền địa chỉ khi nhấn
                  onLongPress: () => _confirmDeleteAddress(address),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
