import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        children: [
          Text('About'),
          Text(
            'Students',
            style: TextStyle(
              color: Colors.blue,
            ),
          )
        ],
      )),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            students('AB', 'Agwe Bryan', 'CT19A004', Colors.amber),
            students('AM', 'Ayo Mendi Gabby', 'CT20A072', Colors.blue),
            students('NK', 'Ngong Kwale Cedric', 'CT20A209', Colors.white),
          ],
        ),
      ),
    );
  }

  Widget students(String initials, String stdName, String mat, Color bckColor) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: bckColor,
          child: Text(
            initials,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
        title: Text(
          stdName,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          mat,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
