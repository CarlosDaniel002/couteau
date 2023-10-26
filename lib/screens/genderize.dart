//Carlos Daniel Taveras Liranzo (2021-2021)
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class genderize extends StatefulWidget {
  const genderize({super.key});

  @override
  State<genderize> createState() => _genderizeState();
}

class _genderizeState extends State<genderize> {
  TextEditingController nameController = TextEditingController();
  String gender = "unknown"; // Inicialmente desconocido

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predictor de Género'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image.network('https://target.scene7.com/is/image/Target/GUEST_32630f75-2876-425f-aba1-85c2b8664530'),
            ),
            Text(
              'Ingresa un nombre:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Ejemplo: Jhon',
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                predictGender(nameController.text);
              },
              child: Text('Predecir Género'),
            ),
            SizedBox(height: 20),
            Container(
              width: 100,
              height: 100,
              color: gender == "female" ? Colors.pink  : Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  // Función para predecir el género utilizando la API
void predictGender(String name) async {
  var url = Uri.parse("https://api.genderize.io/?name=$name");
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    setState(() {
      gender = data['gender'];
    });
  }
}
}