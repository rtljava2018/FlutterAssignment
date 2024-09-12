import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:tcslocator/src/models/office_location_data.dart';
import 'package:url_launcher/url_launcher.dart';

import '../service/call_message_mail_location_service.dart';
import '../service/map_utils.dart';
import '../service/service_locator.dart';

class TcsLocatorDetails extends StatefulWidget {
  final Locations items;

  const TcsLocatorDetails({super.key, required this.items});

  @override
  MyTcsLocatorDetailsState createState() => MyTcsLocatorDetailsState();
}

  class MyTcsLocatorDetailsState extends State<TcsLocatorDetails>{
    final CallsAndMessagesService _service = locator<CallsAndMessagesService>();
    Future<void>? _launched;
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
                  MapOptions(initialCenter: LatLng(widget.items.geometry!.lat!.toDouble(), widget.items.geometry!.lng!.toDouble()), initialZoom: 11.0),
                  children: [
                    TileLayer(
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png'),
                    MarkerLayer(markers: [
                      Marker(
                          width: 30.0,
                          height: 30.0,
                          point: LatLng(widget.items.geometry!.lat!.toDouble(), widget.items.geometry!.lng!.toDouble()),
                          child: const Icon(
                            Icons.location_on,
                            color: Colors.blueAccent,
                            size: 40,
                          ))
                    ])
                  ],
                ),
              ),
              buildUserInfoDisplay(widget.items.location.toString(),"TCS center Name",Icons.home),
              buildUserInfoDisplay("${widget.items.area}- ${widget.items.geo}.","Location",Icons.location_city),
            Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Phone",
                      style: TextStyle(
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
                            child:Text(
                              widget.items.phone.toString(),
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
                )),
              Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Email",
                        style: TextStyle(
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
                              child:Text(
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
                                  String? encodeQueryParameters(Map<String, String> params) {
                                    return params.entries
                                        .map((MapEntry<String, String> e) =>
                                    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                        .join('&');
                                  }
                                  final Uri emailLaunchUri = Uri(
                                    scheme: 'mailto',
                                    path: 'smith@gmail.com',
                                    query: encodeQueryParameters(<String, String>{
                                      'subject': 'Example Subject Symbolsare allowed!',
                                    }),
                                  );
                                  _createMail(emailLaunchUri);
                                })
                          ]))
                    ],
                  )),
              buildMapInfo(widget.items.address.toString(),"Address",Icons.location_on_rounded),
              buildUserInfoDisplay(widget.items.officeType!.join(" ").toString(),"Office Type",Icons.type_specimen),
              const SizedBox(
                height: 12.0,
              ),
            ],
          ),
        ),
      );
    }
  }

  // Widget builds the display item with the proper formatting to display the user's info
  Widget buildUserInfoDisplay(String getValue, String title,IconData iconData) =>
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
                    child:Text(
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
              onPressed: ()=> {
              })
                  ]))
            ],
          ));

Widget buildMapInfo(String getValue, String title,IconData iconData) =>
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
                    child:Text(
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
                      onPressed: ()=> {
                        MapUtils.openMap(-3.823216,-38.481700)
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




