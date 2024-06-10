import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:delivery/pages/address/NewAddressPage.dart';
import 'package:delivery/pages/address/AddressChange.dart';

class AddressManagePage extends StatefulWidget {

  final String userNumber;

  const AddressManagePage({Key? key, required this.userNumber});

  @override
  _AddressManagePageState createState() => _AddressManagePageState();
}

class _AddressManagePageState extends State<AddressManagePage> {
  int _selectedIndex = -1; // 현재 선택된 항목의 인덱스를 추적합니다.

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
                  MaterialPageRoute(builder: (context) => NewAddressPage(userNumber: widget.userNumber,)),
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
            child: _buildAddressList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressList() {
    return Consumer<ItemListNotifier>(
      builder: (context, notifier, child) {
        String? homeAddress = notifier.homeAddress;
        String? workAddress = notifier.otherAddresses;
        List<String> addresses = notifier.addresses;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                '    집',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text(homeAddress ?? '집 주소가 없습니다.', style: TextStyle(fontWeight: FontWeight.w700)),
                onTap: () {
                  setState(() {
                    _selectedIndex = -1; // 집 주소가 선택될 때 _selectedIndex를 -1로 설정하여 다른 항목이 선택되지 않도록 합니다.
                  });
                },
                trailing: _selectedIndex == -1 ? Icon(Icons.check_circle, color: Colors.blue) : null,
              ),
              SizedBox(height: 10),
              Text(
                '    회사',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              ListTile(
                leading: Icon(Icons.work),
                title: Text(workAddress ?? '회사 주소가 없습니다.', style: TextStyle(fontWeight: FontWeight.w700)),
                onTap: () {
                  setState(() {
                    _selectedIndex = -2; // 회사 주소가 선택될 때 _selectedIndex를 -2로 설정하여 다른 항목이 선택되지 않도록 합니다.
                  });
                },
                trailing: _selectedIndex == -2 ? Icon(Icons.check_circle, color: Colors.blue) : null,
              ),
              SizedBox(height: 10),
              Text(
                '    기타',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: addresses.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text(addresses[index], style: TextStyle(fontWeight: FontWeight.w700)),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        notifier.removeAddress(index);
                      },
                    ),
                    onTap: () {
                      setState(() {
                        _selectedIndex = index; // 다른 항목이 선택될 때 _selectedIndex를 해당 인덱스로 설정합니다.
                      });
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
