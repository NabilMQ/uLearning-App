import 'package:flutter/material.dart';
import 'package:ulearning_app/pages/profile/widgets/profile_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildProfileAppBar(),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
                profileIconAndEditButton(),
                buildListViewVertical(context),
            ],
          ),
        ),
      ),
    );
  }
}