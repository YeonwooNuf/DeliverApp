import 'package:delivery/service/sv_homeAddress.dart';
import 'package:flutter/material.dart';
import 'package:delivery/pages/address/NewAddressPage.dart';

class AddressManagePage extends StatefulWidget {
  final String userNumber;

  const AddressManagePage({Key? key, required this.userNumber}) : super(key: key);

  @override
  _AddressManagePageState createState() => _AddressManagePageState();
}

class _AddressManagePageState extends State<AddressManagePage> {
  List<Map<String, dynamic>> addresses = [];

  @override
  void initState() {
    super.initState();
    _fetchAddresses();
  }

  Future<void> _fetchAddresses() async {
    try {
      List<Map<String, dynamic>> fetchedAddresses = await getAddressListByuser(widget.userNumber);
      setState(() {
        addresses = fetchedAddresses;
      });
    } catch (error) {
      print('Failed to fetch addresses: $error');
    }
  }

  Future<void> _deleteAddress(int index) async {
    try {
      await deleteAddress(int.parse(widget.userNumber), addresses[index]['homeAddressNumber'] as int);
      setState(() {
        addresses.removeAt(index);
      });
    } catch (error) {
      print('Failed to delete address: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width * 0.9;
    return Scaffold(
      appBar: AppBar(
        title: Text('주소 관리'),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          SizedBox(
            width: buttonWidth,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewAddressPage(userNumber: widget.userNumber)),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Colors.grey),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_circle_outline, size: 30, color: Colors.black),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '새 주소 추가',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30),
          Container(
            height: 4,
            color: Colors.grey[300],
          ),
          SizedBox(height: 10),
          Text(
            '현재 주소 목록',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Container(
            height: 4,
            color: Colors.grey[300],
          ),
          SizedBox(height: 30),
          Expanded(
            child: addresses.isEmpty
                ? Center(
                    child: Text(
                      '주소가 없습니다.',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    itemCount: addresses.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            title: Text(
                              addresses[index]['address'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                _deleteAddress(index);
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
