import 'package:flutter/material.dart';
import 'package:chisquarex/pages/postListScreen.dart';
import 'package:chisquarex/post_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatelessWidget {
  final PostData postData;

  const Home({super.key, required this.postData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Post',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
      body: CreatePostScreen(postData: postData),
    );
  }
}

class CreatePostScreen extends StatelessWidget {
  final PostData postData;

  const CreatePostScreen({super.key, required this.postData});

  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;

    const List<String> airports = <String>[
      'Ahmedabad - Sardar Vallabhbhai Patel International Airport (AMD)',
      'Amritsar - Sri Guru Ram Dass Jee International Airport (ATQ)',
      'Bagdogra - Bagdogra Airport (IXB)',
      'Bengaluru - Kempegowda International Airport (BLR)',
      'Bhopal - Raja Bhoj Airport (BHO)',
      'Bhubaneswar - Biju Patnaik International Airport (BBI)',
      'Chandigarh - Chandigarh International Airport (IXC)',
      'Chennai - Chennai International Airport (MAA)',
      'Coimbatore - Coimbatore International Airport (CJB)',
      'Dehradun - Jolly Grant Airport (DED)',
      'Delhi - Indira Gandhi International Airport (DEL)',
      'Goa - Goa International Airport (GOI)',
      'Guwahati - Lokpriya Gopinath Bordoloi International Airport (GAU)',
      'Hyderabad - Rajiv Gandhi International Airport (HYD)',
      'Indore - Devi Ahilyabai Holkar International Airport (IDR)',
      'Jaipur - Jaipur International Airport (JAI)',
      'Jammu - Jammu Airport (IXJ)',
      'Kochi - Cochin International Airport (COK)',
      'Kolkata - Netaji Subhas Chandra Bose International Airport (CCU)',
      'Kozhikode - Calicut International Airport (CCJ)',
      'Lucknow - Chaudhary Charan Singh International Airport (LKO)',
      'Madurai - Madurai International Airport (IXM)',
      'Mangalore - Mangalore International Airport (IXE)',
      'Nagpur - Dr. Babasaheb Ambedkar International Airport (NAG)',
      'Patna - Lok Nayak Jayaprakash Airport (PAT)',
      'Pune - Pune Airport (PNQ)',
      'Raipur - Swami Vivekananda Airport (RPR)',
      'Ranchi - Birsa Munda Airport (IXR)',
      'Srinagar - Sheikh ul-Alam International Airport (SXR)',
      'Thiruvananthapuram - Trivandrum International Airport (TRV)',
      'Udaipur - Maharana Pratap Airport (UDR)',
      'Varanasi - Lal Bahadur Shastri International Airport (VNS)',
      'Vijayawada - Vijayawada International Airport (VGA)',
      'Visakhapatnam - Visakhapatnam International Airport (VTZ)',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Share Your Travel Plans"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  return airports.where((String option) {
                    return option
                        .toLowerCase()
                        .contains(textEditingValue.text.toLowerCase());
                  });
                },
                onSelected: (String selected) {
                  postData.updateOrigin(selected);
                },
                fieldViewBuilder: (BuildContext context,
                    TextEditingController textEditingController,
                    FocusNode focusNode,
                    VoidCallback onFieldSubmitted) {
                  return TextField(
                    controller: textEditingController,
                    focusNode: focusNode,
                    decoration: const InputDecoration(
                      labelText: 'Origin Airport',
                    ),
                  );
                },
              ),
              Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  return airports.where((String option) {
                    return option
                        .toLowerCase()
                        .contains(textEditingValue.text.toLowerCase());
                  });
                },
                onSelected: (String selected) {
                  postData.updateDestination(selected);
                },
                fieldViewBuilder: (BuildContext context,
                    TextEditingController textEditingController,
                    FocusNode focusNode,
                    VoidCallback onFieldSubmitted) {
                  return TextField(
                    controller: textEditingController,
                    focusNode: focusNode,
                    decoration: const InputDecoration(
                      labelText: 'Destination Airport',
                    ),
                  );
                },
              ),
              TextButton(
                onPressed: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (selectedDate != null) {
                    postData.updateTravelDate(selectedDate);
                  }
                },
                child: Text(
                  postData.travelDate?.toString().split(' ')[0] ??
                      "Select Travel Date",
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: "Weight Allowance (e.g., 5kg)",
                ),
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  postData.updateWeightAllowance(value);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (postData.origin != postData.destination) {
                      if (postData.isValid()) {
                        final docRef = await firestore.collection('posts').add({
                          'origin': postData.origin,
                          'destination': postData.destination,
                          'travelDate': postData.travelDate,
                          'availableWeight': postData.availableWeight,
                        });
                        print(
                            "Post submitted successfully: Document ID - ${docRef.id}");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PostListScreen()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill in all required fields'),
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Origin and Destination cannot be the same.'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade200,
                    foregroundColor: Colors.black,
                  ),
                  child: const Text("Submit Post"),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PostListScreen()),
          );
        },
        backgroundColor: Colors.blue.shade200,
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}
