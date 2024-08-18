import 'package:flutter/material.dart';
import 'package:sharecar/models/user.dart';
import 'package:sharecar/pages/auth/auth_page.dart';
import 'package:sharecar/pages/map/map_view.dart';
import 'package:sharecar/repositories/user_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.grey[200],
        child: ValueListenableBuilder<User?>(
          valueListenable: UserRepository.instance.userNotifier,
          builder: (context, value, child) {
            if (value != null) {
              return value.isVerified ? _buildRideSearch(context) : AuthPageWidget(page: 2, uid: value.uid);
            } else {
              return AuthPageWidget(page: 0);
            }
          },
        ),
      ),
    );
  }

  Widget _buildRideSearch(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Current Location',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16.0),
          TextField(
            decoration: InputDecoration(
              labelText: 'Destination',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16.0),
          TextField(
            decoration: InputDecoration(
              labelText: 'Date & Time',
              border: OutlineInputBorder(),
            ),
            onTap: () async {
              DateTime? date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (date != null) {
                // Handle the date selection
              }
            },
          ),
          SizedBox(height: 16.0),
          TextField(
            decoration: InputDecoration(
              labelText: 'Number of Passengers',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Handle the search action
            },
            child: Text('Search'),
          ),
        ],
      ),
    );
  }
}
