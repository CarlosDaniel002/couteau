//Carlos Daniel Taveras Liranzo (2021-2021)
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class age extends StatefulWidget {
  const age({super.key});

  @override
  State<age> createState() => _ageState();
}

class _ageState extends State<age> {
 final TextEditingController _nameController = TextEditingController();
  String _age = "";
  String _status = "";
  String _imageUrl = "";

  Future<void> _getAgeFromApi(String name) async {
    final response = await http.get(Uri.parse('https://api.agify.io/?name=$name'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _age = data['age'].toString();
        // Determine status based on age
        if (data['age'] > 0 && data['age'] < 17) {
          _status = "Joven";
          _imageUrl = "https://staticg.sportskeeda.com/editor/2022/05/2e62b-16515718969061-1920.jpg"; 
        } else if (data['age'] > 18 && data['age'] < 60) {
          _status = "Adulto";
          _imageUrl = "https://imgix.bustle.com/elite-daily/2015/04/06081918/up_04ec9ba8.jpg?w=1200&h=630&fit=crop&crop=faces&fm=jpg"; 
        } else {
          _status = "Anciano";
          _imageUrl = "https://miro.medium.com/v2/resize:fit:700/1*s6BLjvLVgnmrYUG0Zge9BQ.png";
        }
      });
    } else {
      throw Exception('Failed to load age');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predictor de edad'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Container(
              width: 300,
              height: 300,
              child: Image.network('https://hackster.imgix.net/uploads/attachments/233435/z21ddjtefu8VfS7fzhEu.uploads/tmp/8f8c359a-eabc-43a5-a11c-979485af104c/tmp_image_0?auto=compress%2Cformat&w=400&h=300&fit=min'),
            ),
            Text(
              'Ingrese el nombre:',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Ej. Juan',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final name = _nameController.text;
                if (name.isNotEmpty) {
                  _getAgeFromApi(name);
                }
              },
              child: Text('Calcular Edad'),
            ),
            SizedBox(height: 20),
            Text('Edad: $_age años'),
            Text('Estado: $_status'),
            _imageUrl.isNotEmpty
                ? Image.network(
                    _imageUrl,
                     width: 400,
                    height: 400,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}





