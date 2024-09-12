import 'package:flutter/material.dart';
import 'package:tcslocator/src/models/office_location_data.dart';
import 'package:tcslocator/src/view/tcs_locator_details.dart';

class FlutterSearchListView extends StatelessWidget{
  final Locations item;
  const FlutterSearchListView({super.key,required this.item});


  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0,
          vertical: 5.0),
      child: Column(
        children: [
          ListTile(

            title: Text(item.location.toString(),style:
            const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${item.geo} - ${item.area}"),
              ],
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          TcsLocatorDetails(items: item)));
            },
          ),

        ],
      ),
    )
    );
    }

}