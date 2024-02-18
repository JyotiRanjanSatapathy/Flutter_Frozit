import 'package:flutter/material.dart';
import 'package:frozit/widgets/appbar.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FrozitAppbar(title: 'Address'),
      body: Center(
        child: Text('Address Screen'),
      ),
    );
  }
}
