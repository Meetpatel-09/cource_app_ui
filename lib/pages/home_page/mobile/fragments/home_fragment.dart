import 'package:course_app_ui/services/google_sign_in_api.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:course_app_ui/widgets/home/category/category_widget.dart';
import 'package:course_app_ui/widgets/home/search_bar.dart';
import 'package:course_app_ui/widgets/home/share_box.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({Key? key}) : super(key: key);

  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        Row(
          children: const [
            Icon(Icons.home),
            SizedBox(width: 10,),
            Text('Home'),
          ],
        ),
        actions: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(onPressed: ()  async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('token');
              await GoogleSignInAPI.logout();
              Navigator.pushNamedAndRemoveUntil(
                context,
                MyRoutes.loginRoute,
                    (route) => false,
              );
            },
                icon: const Icon(Icons.logout)
            ),
          )
        ],
      ),
      backgroundColor: context.canvasColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: const [
              SearchBar(),
              SizedBox(height: 15.0,),
              ShareBox(),
              SizedBox(height: 10.0,),
              CategoryWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
