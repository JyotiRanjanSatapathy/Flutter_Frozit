import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:frozit/views/account/model/account_provider.dart';
import 'package:frozit/widgets/appbar.dart';
import 'package:frozit/widgets/button.dart';
import 'package:frozit/widgets/text_field.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final AccountProvider accountProvider = context.read<AccountProvider>();
    _nameController.text = accountProvider.user?.address?.name ?? '';
    _addressController.text = accountProvider.user?.address?.area ?? '';
    _cityController.text = accountProvider.user?.address?.city ?? '';
    _stateController.text = accountProvider.user?.address?.state ?? '';
    _pincodeController.text = accountProvider.user?.address?.pincode ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FrozitAppbar(title: 'Address'),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FrozitTextField(
                  label: 'Name',
                  controller: _nameController,
                ),
                const SizedBox(height: 20),
                FrozitTextField(
                  label: 'Address',
                  controller: _addressController,
                ),
                const SizedBox(height: 20),
                FrozitTextField(
                  label: 'City',
                  controller: _cityController,
                ),
                const SizedBox(height: 20),
                FrozitTextField(
                  label: 'State',
                  controller: _stateController,
                ),
                const SizedBox(height: 20),
                FrozitTextField(
                  label: 'Pincode',
                  controller: _pincodeController,
                ),
              ],
            ),
            FrozitPrimaryButton(
              text: 'Save Address',
              onPressed: () {
                // Save address
                final String address = _addressController.text;
                final String city = _cityController.text;
                final String state = _stateController.text;
                final String pincode = _pincodeController.text;

                log('Address: $address, City: $city, State: $state, Pincode: $pincode');
                context.read<AccountProvider>().saveAddress(
                      name: 'Home',
                      address: address,
                      city: city,
                      state: state,
                      pincode: pincode,
                    );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
