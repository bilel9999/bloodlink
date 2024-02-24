import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Profile_Info extends StatefulWidget {
  const Profile_Info({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<Profile_Info> createState() => _Profile_InfoState();
}

class _Profile_InfoState extends State<Profile_Info> {
  int numberOfDonations = 0;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> _fetchNumberOfDonations() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('InfoForm')
          .doc(widget.id)
          .get();
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      setState(() {
        numberOfDonations = data['number Of Donations'] ?? 0;
      });
    } catch (e) {
      print("Error fetching number of donations: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchNumberOfDonations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffF95C5C),
        title: Text(
          "Profile Information",
          style: GoogleFonts.jomhuria(fontSize: 40),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('InfoForm')
            .doc(widget.id)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.data() == null) {
            return Center(child: Text('Document does not exist'));
          }

          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          dynamic numberOfDonationsData =
              data['number Of Donations']; // Retrieve the value from Firestore
          int numberOfDonations = numberOfDonationsData is int
              ? numberOfDonationsData
              : int.parse(numberOfDonationsData ?? '0');

          return Center(
            child: Container(
              color: Color(0xfff6e5e5),
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Number of Donations: $numberOfDonations",
                    style: GoogleFonts.jomhuria(fontSize: 40),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xffF95C5C),
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    onPressed: () async {
                      // Show DatePicker to select new donation date
                      DateTime? newDonationDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2101),
                      );
                      if (newDonationDate != null) {
                        try {
                          // Update Firestore document with new donation date and increment number of donations
                          FirebaseFirestore.instance
                              .collection('InfoForm')
                              .doc(widget.id)
                              .update({
                            'last Donation Date':
                                DateFormat.yMMMMd().format(newDonationDate),
                            'number Of Donations': (numberOfDonations + 1)
                                .toString(), // Increment number of donations by 1
                          });
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'Donation details updated successfully')));
                          setState(() {
                            // Update local state with new values
                            numberOfDonations++;
                          });
                        } catch (e) {
                          print("Error updating donation details: $e");
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text('Error updating donation details')));
                        }
                      }
                    },
                    child: Text(
                      "Set New Donation Date",
                      style: GoogleFonts.jomhuria(fontSize: 25),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
