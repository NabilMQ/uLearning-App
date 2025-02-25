import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/pages/profile/settings/bloc/settings_bloc.dart';
import 'package:ulearning_app/pages/profile/settings/bloc/settings_states.dart';
import 'package:ulearning_app/pages/profile/settings/widgets/settings_widgets.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildSettingsAppBar(),
      body: SingleChildScrollView(
        child: BlocBuilder <SettingsBloc, SettingsStates>(
          builder: (context, state) {
            return Column(
              children: [
                logOutButton(context),
              ],
            );
          },
        ),
      ),
    );
  }
}