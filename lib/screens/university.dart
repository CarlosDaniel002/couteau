//Carlos Daniel Taveras Liranzo (2021-2021)

import 'package:couteau/models/UniversityModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class UniversitiesView extends StatefulWidget {
  @override
  _UniversitiesViewState createState() => _UniversitiesViewState();
}

class _UniversitiesViewState extends State<UniversitiesView> {
  final TextEditingController _countryController = TextEditingController();
  List<University> universities = [];

  Future<void> fetchUniversities(String country) async {
    final response = await http.get(
        Uri.parse('http://universities.hipolabs.com/search?country=$country'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        universities = (data as List)
            .map((university) => University.fromJson(university))
            .toList();
      });
    } else {
      throw Exception('Error al cargar las universidades');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Universidades por País'),
      ),
      body: Column(
        children: <Widget>[
          Container(
              width: 100,
              height: 100,
              child: Image.network('https://play-lh.googleusercontent.com/WL9oSrJxfO6XDrSnuERVcjFXN--XztDibPGtAxIJsJBfm2ZAv4WvkR5yFuOcFKKR0_A=w240-h480-rw') 
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _countryController,
              decoration: InputDecoration(labelText: 'País en inglés'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final country = _countryController.text;
              if (country.isNotEmpty) {
                fetchUniversities(country);
              }
            },
            child: Text('Buscar Universidades'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: universities.length,
              itemBuilder: (context, index) {
                final university = universities[index];
                return ListTile(
                  title: Text(university.name),
                  subtitle: Text('Dominio: ${university.domains[0]}'),
                  onTap: () async {
                    if (await url_launcher.canLaunch(university.webPage)) {
                      await url_launcher.launch(university.webPage);
                    } else {
                      throw 'No se pudo abrir la página: ${university.webPage}';
                    }
                  }
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


