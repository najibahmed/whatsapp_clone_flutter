import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone_flutter/constants/colors.dart';

class WebSearchBar extends StatelessWidget {
  const WebSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width * 0.30,
      padding: EdgeInsets.all(10),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: dividerColor))),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8),
          filled: true,
            fillColor: searchBarColor,
            prefixIcon:
                const Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                  child:Icon(Icons.search_outlined) ,),
            hintText: 'Search or start a new Chat',
            hintStyle: TextStyle(fontSize: 14),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide:
                    const BorderSide(width: 0, style: BorderStyle.none))),
      ),
    );
  }
}
