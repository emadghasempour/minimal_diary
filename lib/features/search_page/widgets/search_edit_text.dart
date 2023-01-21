import 'package:flutter/material.dart';

class SearchEditText extends StatelessWidget {
  const SearchEditText({
    this.onSubmitted,
    this.textEditingController,
    Key? key,
  }) : super(key: key);

  final void Function(String)? onSubmitted;
  final TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    
    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 5,
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          hintStyle: TextStyle(color: Colors.grey[400]),
          hintText: "Search anything...",
        ),
        onSubmitted: onSubmitted,
      ),
    );
  }
}
