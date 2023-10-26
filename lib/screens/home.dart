//Carlos Daniel Taveras Liranzo (2021-2021)
import 'package:flutter/material.dart';

class home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Caja de Herramientas'),
      ),
      body: Center(
        child: Image.asset('home.png'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text('Genderize'),
              onTap: () {
                Navigator.of(context).pushNamed('/genderize');
              },
            ),
            ListTile(
              title: Text('Age'),
              onTap: () {
                Navigator.of(context).pushNamed('/age');
              },
            ),
            ListTile(
              title: Text('Universities View'),
              onTap: () {
                Navigator.of(context).pushNamed('/UniversitiesView');
              },
            ),
            ListTile(
              title: Text('Weather'),
              onTap: () {
                Navigator.of(context).pushNamed('/weather');
              },
            ),
            ListTile(
              title: Text('WordPress Page View'),
              onTap: () {
                Navigator.of(context).pushNamed('/WordPressPageView');
              },
            ),
            ListTile(
              title: Text('Contact'),
              onTap: () {
                Navigator.of(context).pushNamed('/contact');
              },
            ),
          ],
        ),
      ),
    );
  }
}