import 'package:flutter/material.dart';
import 'package:tcslocator/src/models/office_location_data.dart';
import 'package:tcslocator/src/view/component/flutterlitst.dart';

import '../controller/tcs_locator_controller.dart';
import 'component/search.dart';
import "package:collection/collection.dart";

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Locations> _characters = <Locations>[];
  List<Locations> _charactersDisplay = <Locations>[];
  List<String> countryList=<String>[];
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();

    fetchTcsLocatorData().then((value) {
      setState(() {
       // _isLoading = false;
        _characters.addAll(value.locations as Iterable<Locations>);
        _charactersDisplay = _characters;
        var newMap = groupBy(_characters, (Locations obj) => obj.area );

        countryList.add("All");
        for (var k in newMap.keys) {
          countryList.add(k!);
          }
        //print(countryList);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.indigo,
        title: Text(widget.title,style:const TextStyle(color: Colors.white,fontSize: 25.0, fontWeight: FontWeight.bold )),
        actions: const [
          Image(
            height: 150,
            image: AssetImage('assets/ic_logo_tcs.png'),
          ),
        ],
      ),
        backgroundColor: Colors.white,
      body: SafeArea(
          minimum: const EdgeInsets.fromLTRB(10.0,10.0,10.0,0),
        child: ListView.builder(
            itemBuilder: (context,index){
              return index == 0
                  ?
                  MySearch(
                    hintText: 'Search here.',
                    onChanged: (searchText) {
                      searchText = searchText.toLowerCase();
                      setState(() {
                        _charactersDisplay = _characters.where((u) {
                          var nameLowerCase = u.location?.toLowerCase();
                          var nicknameLowerCase = u.area?.toLowerCase();
                          var portrayedLowerCase = u.geo?.toLowerCase();
                          return nameLowerCase!.contains(searchText) ||
                              nicknameLowerCase!.contains(searchText) ||
                              portrayedLowerCase!.contains(searchText);
                        }).toList();
                      });
                    },
                    onTapFilter:(text) {
                      _showBottomSheet(context);
                    }
                  ): FlutterSearchListView(item: _charactersDisplay[index - 1]);
            },
            itemCount: _charactersDisplay.length + 1,
        )
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /*const Expanded(
                    child: Text(
                      '',
                    ),
                  ),*/
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
          Flexible(
              child: ListView.builder(itemBuilder: (context,index){
                return RadioListTile(
                  value: index,
                  groupValue: _selectedIndex,
                  onChanged: (value) {

                    setState(() {
                      print(countryList[_selectedIndex+1]);
                      print(_selectedIndex);
                      _selectedIndex = value!;

                      _charactersDisplay = _selectedIndex==0? _characters:_characters.where((u) {
                        var nicknameLowerCase = u.area?.toLowerCase();
                        return nicknameLowerCase!.contains(countryList[_selectedIndex].toLowerCase());
                      }).toList();
                    });
                    Navigator.pop(context);
                  },
                  title: Text(countryList[index]),)
                ;
              },
              itemCount: countryList.length,)
          )
            ],
          ),
        );
      },
    );
  }
}

