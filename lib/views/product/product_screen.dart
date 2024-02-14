import 'package:chip_list/chip_list.dart';
import 'package:flutter/material.dart';

import '../../common/colors.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<String> listOfChipNames = [
    'All',
    'Fruits',
    'Vegetables',
    'Dairy',
    'Bakery',
    'Meat',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: const TextSpan(
                  text: 'Frozit\n',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: kContainerColor2,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Range',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: kPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              ChipList(
                showCheckmark: false,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: kSecondaryColor,
                ),
                checkmarkColor: Colors.white,
                listOfChipNames: listOfChipNames,
                activeBgColorList: List.generate(
                  listOfChipNames.length,
                  (index) => kPrimaryColor,
                ),
                activeTextColorList: List.generate(
                  listOfChipNames.length,
                  (index) => Colors.white,
                ),
                inactiveTextColorList: List.generate(
                    listOfChipNames.length, (index) => kSecondaryColor),
                listOfChipIndicesCurrentlySeclected:
                    List.generate(listOfChipNames.length, (index) => index),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
