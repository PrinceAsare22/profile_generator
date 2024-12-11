import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:profile_generator/components/custom_container.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'profile_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileModel? profileModel;
  bool isLoading = true;

  // Function to fetch profile from API
  Future<void> fetchProfile() async {
    const baseUrl = 'https://randomuser.me/api/';
    final url = Uri.parse(baseUrl);

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        setState(() {
          profileModel = ProfileModel.fromJson(jsonResponse['results'][0]);
          isLoading = false;
        });
      } else {
        print('Failed to fetch profile: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching profile: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        title: const Center(
            child: Text(
          'Profile',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
        )),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : profileModel == null
              ? const Center(
                  child: Text('Failed to load profile'),
                )
              : Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 100,
                          backgroundImage: NetworkImage(profileModel!.large),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            color: Colors.deepPurple[600],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    '${profileModel!.title} ${profileModel!.first} ${profileModel!.last}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Gender:',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                                const SizedBox(height: 5),
                                CustomContainer(
                                    icon: Icons.person_2,
                                    text: profileModel!.gender),
                                const SizedBox(height: 10),
                                const Text(
                                  'Email: ',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                                const SizedBox(height: 5),
                                CustomContainer(
                                  icon: Icons.email,
                                  text: profileModel!.email,
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Phone: ',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                                const SizedBox(height: 5),
                                CustomContainer(
                                    icon: Icons.phone,
                                    text: profileModel!.phone),
                                const SizedBox(height: 50),
                                Center(
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          fixedSize: const Size(200, 50)),
                                      onPressed: fetchProfile,
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(Icons.refresh, size: 30),
                                          Text(
                                            'Generate',
                                            style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.deepPurple),
                                          ),
                                        ],
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
    );
  }
}
