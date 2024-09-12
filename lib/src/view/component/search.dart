import 'package:flutter/material.dart';

class MySearch extends StatefulWidget {
  final void Function(String)? onChanged;
  final void Function(String)? onTapFilter;
  final String? hintText;
  const MySearch({super.key, this.onChanged, this.hintText, this.onTapFilter});

  @override
  State<MySearch> createState() => _MySearchState();
}


class _MySearchState extends State<MySearch> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    autofocus: false,
                    onChanged: widget.onChanged,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.search),
                      hintText: widget.hintText,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                child: const Icon(Icons.filter_alt, color: Colors.black,size: 40,),
                onTap: () {
                 // print("testttttt");
                  widget.onTapFilter!("tap to filter");
                 // _showBottomSheet(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
  /*class _MySearchState1 extends State<MySearch> {
  @override
  Widget build(BuildContext context) {
  return Padding(
  padding: const EdgeInsets.all(12.0),
  child: TextField(
  autofocus: false,
  onChanged: widget.onChanged,
  decoration: InputDecoration(
  border: const OutlineInputBorder(),
  prefixIcon: const Icon(Icons.search),
  hintText: widget.hintText,
  ),
  ),
  );
  }
  }*/
}