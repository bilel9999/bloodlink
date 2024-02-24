import 'package:bloodlink/Views/auth/SignUP/MultipleChoiceForm%20.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Info_Form extends StatefulWidget {
  const Info_Form({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<Info_Form> createState() => _Info_FormState();
}

class _Info_FormState extends State<Info_Form> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  int _numberOfDonations = 0;
  DateTime? _lastDonationDate;
  String? _bloodType;
  String? _rhFactor;
  bool _donatedBefore = false;

  late double height;
  late double width;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _lastDonationDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _lastDonationDate) {
      setState(() {
        _lastDonationDate = picked;
      });
    }
  }

  Future<void> checkOrCreateDatabase(Map<String, dynamic> object) async {
    try {
      final documentReference = firestore.collection('InfoForm').doc(widget.id);
      final documentSnapshot = await documentReference.get();

      if (documentSnapshot.exists) {
        print('Database InfoForm already exists.');
      } else {
        await documentReference.set(object);
        print('New database created.');
      }
    } catch (e) {
      print('Error: $e');
      print('Creating new database...');
      try {
        await firestore.collection('InfoForm').doc(widget.id).set(object);
        print('New database created.');
      } catch (error) {
        print('Error creating database: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * 0.05,
        centerTitle: true,
        backgroundColor: Color(0xffF95C5C),
        title: Text(
          "User Information",
          style: GoogleFonts.jomhuria(fontSize: 30),
        ),
      ),
      body: Container(
        color: Color(0xfff6e5e5),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          labelText: 'Name',
                          prefixIcon: Icon(Icons.person),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _surnameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        labelText: 'Surname',
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your surname';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _nationalityController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        labelText: 'Nationality',
                        prefixIcon: Icon(Icons.flag),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your nationality';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        labelText: 'Phone Number',
                        prefixIcon: Icon(Icons.phone),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    ListTile(
                      title: Text('Blood Type'),
                      subtitle: Row(
                        children: [
                          Radio<String>(
                            value: 'A',
                            groupValue: _bloodType,
                            onChanged: (String? value) {
                              setState(() {
                                _bloodType = value;
                              });
                            },
                          ),
                          Text('A'),
                          Radio<String>(
                            value: 'B',
                            groupValue: _bloodType,
                            onChanged: (String? value) {
                              setState(() {
                                _bloodType = value;
                              });
                            },
                          ),
                          Text('B'),
                          Radio<String>(
                            value: 'AB',
                            groupValue: _bloodType,
                            onChanged: (String? value) {
                              setState(() {
                                _bloodType = value;
                              });
                            },
                          ),
                          Text('AB'),
                          Radio<String>(
                            value: 'O',
                            groupValue: _bloodType,
                            onChanged: (String? value) {
                              setState(() {
                                _bloodType = value;
                              });
                            },
                          ),
                          Text('O'),
                        ],
                      ),
                    ),
                    ListTile(
                      title: Text('Rh Factor'),
                      subtitle: Row(
                        children: [
                          Radio<String>(
                            value: '+',
                            groupValue: _rhFactor,
                            onChanged: (String? value) {
                              setState(() {
                                _rhFactor = value;
                              });
                            },
                          ),
                          Text('+'),
                          Radio<String>(
                            value: '-',
                            groupValue: _rhFactor,
                            onChanged: (String? value) {
                              setState(() {
                                _rhFactor = value;
                              });
                            },
                          ),
                          Text('-'),
                        ],
                      ),
                    ),
                    TextFormField(
                      controller: _weightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        labelText: 'Weight en Kg',
                        prefixIcon: Icon(Icons.monitor_weight_rounded),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your surname';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _heightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        labelText: 'Height en cm',
                        prefixIcon: Icon(Icons.height),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your surname';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    ListTile(
                      title: Text('Donated Blood Before?'),
                      trailing: Switch(
                        value: _donatedBefore,
                        onChanged: (bool value) {
                          setState(() {
                            _donatedBefore = value;
                          });
                        },
                      ),
                    ),
                    if (_donatedBefore)
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                labelText: 'Number of Blood Donations',
                                prefixIcon: Icon(Icons.numbers),
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  _numberOfDonations = int.tryParse(value) ?? 0;
                                });
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Last Blood Donations date'),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xfff6e5e5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  )),
                              onPressed: () => _selectDate(context),
                              label: Text(
                                'Select date',
                                style: TextStyle(color: Color(0xff000000)),
                              ),
                              icon: Icon(
                                Icons.date_range_outlined,
                                color: Color(0xff000000),
                              ),
                            ),
                          ]),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _locationController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        labelText: 'Location',
                        prefixIcon: Icon(Icons.location_on),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your location';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Process the
                          // sendDataToFirebase();
                          print({
                            'UID': widget.id,
                            'name': _nameController.text,
                            'surname': _surnameController.text,
                            'nationality': _nationalityController.text,
                            'phoneNumber': _phoneNumberController.text,
                            'bloodType':
                                _bloodType.toString() + _rhFactor.toString(),
                            'weight': _weightController.text,
                            'height': _heightController.text,
                            'last Donation Date':
                                DateFormat.yMMMMd().format(_lastDonationDate!),
                            'number Of Donations': _numberOfDonations,
                            'donatedBefore': _donatedBefore.toString(),
                            'location': _locationController.text,
                          });
                          checkOrCreateDatabase({
                            'UID': widget.id,
                            'name': _nameController.text,
                            'surname': _surnameController.text,
                            'nationality': _nationalityController.text,
                            'phoneNumber': _phoneNumberController.text,
                            'bloodType':
                                _bloodType.toString() + _rhFactor.toString(),
                            'weight': _weightController.text,
                            'height': _heightController.text,
                            'last Donation Date':
                                DateFormat.yMMMMd().format(_lastDonationDate!),
                            'number Of Donations': _numberOfDonations,
                            'donatedBefore': _donatedBefore.toString(),
                            'location': _locationController.text,
                          });
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MultipleChoiceForm(id: widget.id)),
                        );
                      },
                      // child: Text(
                      //   'Edit Profile',
                      //   style: GoogleFonts.jomhuria(
                      //       fontSize: 20, color: Colors.white),
                      // ),
                      icon: Icon(
                        Icons.send,
                        color: Color(0xfff6e5e5),
                      ),
                      label: Text(
                        'Submit Information',
                        style: GoogleFonts.jomhuria(
                            fontSize: 20, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffF95C5C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 50),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
