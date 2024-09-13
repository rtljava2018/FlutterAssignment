import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:tcslocator/src/models/office_location_data.dart';
import 'package:url_launcher/url_launcher.dart';
import '../service/map_utils.dart';

class TcsLocatorDetails extends StatefulWidget {
  final Locations items;

  const TcsLocatorDetails({super.key, required this.items});

  @override
  MyTcsLocatorDetailsState createState() => MyTcsLocatorDetailsState();
}

  class MyTcsLocatorDetailsState extends State<TcsLocatorDetails> {

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Tcs Locator'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 300.0,
                child: FlutterMap(
                  options:
                  MapOptions(initialCenter: LatLng(
                      widget.items.geometry!.lat!.toDouble(),
                      widget.items.geometry!.lng!.toDouble()),
                      initialZoom: 11.0),
                  children: [
                    TileLayer(
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png'),
                    MarkerLayer(markers: [
                      Marker(
                          width: 30.0,
                          height: 30.0,
                          point: LatLng(widget.items.geometry!.lat!.toDouble(),
                              widget.items.geometry!.lng!.toDouble()),
                          child: const Icon(
                            Icons.location_on,
                            color: Colors.blueAccent,
                            size: 40,
                          ))
                    ])
                  ],
                ),
              ),
              buildOfficeInfoDisplay(
                  widget.items.location.toString(), "TCS center Name",
                  Icons.home),
              buildOfficeInfoDisplay(
                  "${widget.items.area}- ${widget.items.geo}.", "Location",
                  Icons.location_city),
              buildOfficePhoneDisplay(
                  widget.items.phone.toString(), "Phone", Icons.phone),
              buildOfficeEmailDisplay(
                  widget.items.email.toString(), "Email", Icons.email),
              buildOfficeMapInfo(widget.items.address.toString(), "Address",
                  Icons.location_on_rounded),
              buildOfficeInfoDisplay(
                  widget.items.officeType!.join(" ").toString(), "Office Type",
                  Icons.type_specimen),
              const SizedBox(
                height: 12.0,
              ),
            ],
          ),
        ),
      );
    }

    buildOfficePhoneDisplay(String phone, String title, IconData icon) {
      Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 1,
              ),
              Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ))),
                  child: Row(children: [
                    Expanded(
                      child: Text(
                        phone,
                        style: const TextStyle(
                          fontSize: 16.0,
                          height: 1.2,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    IconButton(icon: const Icon(Icons.phone,
                      color: Colors.grey,
                      size: 28.0,
                    ),
                        onPressed: () {
                          _makePhoneCall(widget.items.phone.toString());
                        })
                  ]))
            ],
          ));
    }

    // Widget builds the display item with the proper formatting to display the user's info
    Widget buildOfficeInfoDisplay(String getValue, String title,
        IconData iconData) =>
        Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 1,
                ),
                Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ))),
                    child: Row(children: [
                      Expanded(
                        child: Text(
                          getValue,
                          style: const TextStyle(
                            fontSize: 16.0,
                            height: 1.2,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      IconButton(icon: Icon(iconData,
                        color: Colors.grey,
                        size: 28.0,
                      ),
                          onPressed: () =>
                          {
                          })
                    ]))
              ],
            ));

    Widget buildOfficeMapInfo(String getValue, String title,
        IconData iconData) =>
        Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 1,
                ),
                Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ))),
                    child: Row(children: [
                      Expanded(
                        child: Text(
                          getValue,
                          style: const TextStyle(
                            fontSize: 16.0,
                            height: 1.2,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      IconButton(icon: Icon(iconData,
                        color: Colors.grey,
                        size: 28.0,
                      ),
                          onPressed: () =>
                          {
                            MapUtils.openMap(-3.823216, -38.481700)
                          })
                    ]))
              ],
            ));

    Future<void> _makePhoneCall(String phoneNumber) async {
      final Uri launchUri = Uri(
        scheme: 'tel',
        path: phoneNumber,
      );
      await launchUrl(launchUri);
    }

    Future<void> _createMail(Uri url) async {
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    buildOfficeEmailDisplay(String email, String title, IconData icon) {
      Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 1,
              ),
              Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ))),
                  child: Row(children: [
                    Expanded(
                      child: Text(
                        widget.items.email.toString(),
                        style: const TextStyle(
                          fontSize: 16.0,
                          height: 1.2,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    IconButton(icon: const Icon(Icons.email,
                      color: Colors.grey,
                      size: 28.0,
                    ),
                        onPressed: () {
                          String? encodeQueryParameters(
                              Map<String, String> params) {
                            return params.entries
                                .map((MapEntry<String, String> e) =>
                            '${Uri.encodeComponent(e.key)}=${Uri
                                .encodeComponent(e.value)}')
                                .join('&');
                          }
                          final Uri emailLaunchUri = Uri(
                            scheme: 'mailto',
                            path: email,
                            query: encodeQueryParameters(<String, String>{
                              'subject': 'Test Mail To Office!',
                            }),
                          );
                          _createMail(emailLaunchUri);
                        })
                  ]))
            ],
          ));
    }


  }
