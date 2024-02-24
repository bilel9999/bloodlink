import 'package:bloodlink/Views/Screens/Home_Screen.dart';
import 'package:bloodlink/Views/auth/constants/Routes.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// class MultipleChoiceForm extends StatefulWidget {
//   const MultipleChoiceForm({Key? key, required this.id}) : super(key: key);
//   final String id;
//   @override
//   _MultipleChoiceFormState createState() => _MultipleChoiceFormState();
// }

class MultipleChoiceForm extends StatefulWidget {
  const MultipleChoiceForm({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<MultipleChoiceForm> createState() => _MultipleChoiceFormState();
}

class _MultipleChoiceFormState extends State<MultipleChoiceForm> {
  Map<String, String?> _responses = {};
  // _responses["id"] = widget.id;
  @override
  void initState() {
    super.initState();
    _responses = {};
    _responses["userID"] = widget.id;
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> checkOrCreateDatabase(Map<String, dynamic> object) async {
    try {
      final documentReference =
          firestore.collection('Medical_History').doc(widget.id);
      final documentSnapshot = await documentReference.get();

      if (documentSnapshot.exists) {
        print('Database Medical_History already exists.');
      } else {
        await documentReference.set(object);
        print('New database created.');
      }
    } catch (e) {
      print('Error: $e');
      print('Creating new database...');
      try {
        await firestore
            .collection('Medical_History')
            .doc(widget.id)
            .set(object);
        print('New database created.');
      } catch (error) {
        print('Error creating database: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medical History Form'),
      ),
      body: ListView(
        children: [
          for (int i = 0; i < questions.length; i++)
            YesNoCard(
              question: questions[i],
              questionNumber: i + 1,
              onChanged: (bool? value) {
                setState(() {
                  _responses[(i + 1).toString()] = value.toString();
                });
              },
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        // onPressed: _responses.isEmpty ? null : _sendToFirebase,
        onPressed: () {
          print(_responses);
          checkOrCreateDatabase(_responses);
          Routes.instance
              .push(widget: ProfileScreen(id: widget.id), context: context);
        },
        child: Icon(Icons.send),
      ),
    );
  }
}

class YesNoCard extends StatefulWidget {
  final String question;
  final int questionNumber;
  final ValueChanged<bool?> onChanged;

  YesNoCard(
      {required this.question,
      required this.questionNumber,
      required this.onChanged});

  @override
  _YesNoCardState createState() => _YesNoCardState();
}

class _YesNoCardState extends State<YesNoCard> {
  bool? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.question,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<bool>(
                  value: true,
                  groupValue: _selectedValue,
                  onChanged: (value) {
                    widget.onChanged(value);
                    setState(() {
                      _selectedValue = value;
                    });
                  },
                ),
                Text('Yes'),
                Radio<bool>(
                  value: false,
                  groupValue: _selectedValue,
                  onChanged: (value) {
                    widget.onChanged(value);
                    setState(() {
                      _selectedValue = value;
                    });
                  },
                ),
                Text('No'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

List<String> questions = [
  "Have you had any recent illness, surgery, or medical procedures?",
  "Are you currently taking any medications, supplements, or herbal remedies?",
  "Have you ever been diagnosed with or treated for any of the following conditions: heart disease, diabetes, cancer, or blood disorders?",
  "Do you have any allergies, particularly to medications or latex?",
  "Have you ever had a blood transfusion or received blood products in the past?",
  "Do you smoke cigarettes or use tobacco products?",
  "How often do you consume alcoholic beverages? (frequency and quantity)",
  "Have you ever used intravenous (IV) drugs or shared needles?",
  "Have you ever engaged in risky sexual behaviors or had multiple sexual partners?",
  "Have you traveled to or lived in areas with a high risk of infectious diseases (e.g., malaria, Zika virus)?",
  "Have you experienced any recent symptoms of illness, such as fever, cough, or fatigue?",
  "Have you ever been diagnosed with HIV/AIDS, hepatitis, or any sexually transmitted infections (STIs)?",
  "Have you ever had a positive test result for any infectious diseases, such as hepatitis B or C, syphilis, or HIV?",
];
