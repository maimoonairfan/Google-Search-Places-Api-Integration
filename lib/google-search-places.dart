import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class GoogleSearchPlaces extends StatefulWidget {
  const GoogleSearchPlaces({super.key});

  @override
  State<GoogleSearchPlaces> createState() => _GoogleSearchPlacesState();
}

class _GoogleSearchPlacesState extends State<GoogleSearchPlaces> {
  TextEditingController controller = TextEditingController();
  var uuid = Uuid();
  String sessiontoken = '122433';
  List<dynamic> placesList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(() {
      onChange();
    });
  }

  onChange() {
    if (sessiontoken == null) {
      setState(() {
        sessiontoken = uuid.v4();
      });
    }
    getSuggestion(controller.text);
  }

  void getSuggestion(String input) async {
    String k_API_KEY = "AIzaSyCfynzqxOGew1dv_AQWskUoKQ_qUoTbrsQ";
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$k_API_KEY&sessiontoken=$sessiontoken';
    var response = await http.get(Uri.parse(request));
    print(response.body.toString());
    if (response.statusCode == 200) {
      setState(() {
        placesList = jsonDecode(response.body.toString())['predictions'];
      });
    } else {
      throw Exception("Failed to load data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Search Places Api"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            TextFormField(
              controller: controller,
              decoration: InputDecoration(hintText: 'Search Places With name'),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: placesList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(placesList[index]['description']),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
