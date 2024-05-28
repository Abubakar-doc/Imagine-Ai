import 'package:flutter/material.dart';
import 'package:imagineai/Ui/app_screens/profile/Update_personal_info.dart';
import 'package:imagineai/Ui/theme/themeStyle.dart';
import 'package:imagineai/firebaseServices/image_sevice.dart';
import 'package:imagineai/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../settings/settings.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool loading = true;
  String userName = '';
  String profilePictureUrl = '';
  String dateOfBirth = '';
  String gender = '';
  int artworkCount = 1;
  int followersCount = 1;
  int followingCount = 1;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    setState(() {
      loading = true;
    });
    ImageQueryService().fetchUserData(context, updateState);
  }

  void updateState(String userName, String profilePictureUrl,
      String dateOfBirth, String gender, bool loading) {
    setState(() {
      this.userName = userName;
      this.profilePictureUrl = profilePictureUrl;
      this.dateOfBirth = dateOfBirth;
      this.gender = gender;
      this.loading = loading;
    });
  }

  Future<void> _refresh() async {
    setState(() {
      loading = true;
    });
    await fetchUserData();
  }

  Future<void> navigateToUpdateProfile(BuildContext context) async {
    // Navigate to Update_PersonalInfo screen and wait for result
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Update_PersonalInfo(
          userName: userName,
          profilePictureUrl: profilePictureUrl,
          dateOfBirth: dateOfBirth,
          gender: gender,
        ),
      ),
    );
    if (result == true) {
      // If true, trigger the _refresh method to update the profile data
      _refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/Imagine Ai purple transparent logo.png',
                      width: 30,
                      height: 30,
                    ),
                    const Text(
                      'Profile',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Utils().pushSlideTransition(context, const settings());
                      },
                      child: Icon(
                        Icons.settings,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? customDarkTextColor
                            : customLightTextColor,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Visibility(
                  visible: !loading, // Show content when loading is false
                  child: RefreshIndicator(
                    onRefresh: _refresh,
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 45,
                                        backgroundColor: Colors.grey[
                                            300], // Set the background color to grey
                                        child: ClipOval(
                                          child: InkWell(
                                            onTap: () {},
                                            child: Image.network(
                                              profilePictureUrl, // Replace with your image URL
                                              fit: BoxFit.cover,
                                              width:
                                                  90, // Make sure the image fits within the CircleAvatar
                                              height: 90,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return const Icon(
                                                  Icons
                                                      .person, // Placeholder icon
                                                  size: 60,
                                                  color: Colors.grey,
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        userName, // Replace with your desired text
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () async {
                                      // Navigate to Update_PersonalInfo screen and wait for result
                                      await navigateToUpdateProfile(context);
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      color: customPurple,
                                      size: 27,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildStatColumn('Artwork', artworkCount),
                                  _buildVerticalDivider(),
                                  _buildStatColumn('Followers', followersCount),
                                  _buildVerticalDivider(),
                                  _buildStatColumn('Following', followingCount),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'Creations',
                                style: TextStyle(
                                    color: customPurple,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                              Divider(
                                thickness: 2,
                                color: Colors.grey.shade200,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Loading indicator
            Visibility(
              visible: loading, // Show loading indicator when loading is true
              child: const Center(
                child: CircularProgressIndicator(
                  color: customPurple,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildStatColumn(String label, int count) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        count.toString(),
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        label,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    ],
  );
}

Widget _buildVerticalDivider() {
  return SizedBox(
    height: 50,
    child: VerticalDivider(
      color: Colors.grey.shade300,
      thickness: 1,
    ),
  );
}
