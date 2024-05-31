import 'package:ecommerce/screens/helpPoliciesPage.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/model/UserClass.dart';

class MenuDrawer extends StatelessWidget {
  var name = "Claire";
  var usermail = "chomu@gmail.com";
  var phone = "8366483746";

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              accountName: Text(
                '${name}',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 23),
              ),
              accountEmail: null,
              currentAccountPicture: CircleAvatar(
                radius: 70,
                child: ClipOval(
                  child: Image.network(
                      "https://img.freepik.com/premium-vector/man-avatar-profile-round-icon_24640-14044.jpg?w=360"),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.email, color: Colors.white),
              title: Text(
                '${usermail}',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.white),
              title: Text(
                '${phone}',
                style: TextStyle(color: Colors.white),
              ),
            ),
           Container(
              padding: EdgeInsets.symmetric(vertical: 450.0),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HelpPoliciesPage()),
                      );
                    },
                   child: Text(
                    'Help & Policies',
                    style: TextStyle(color: Colors.white, fontSize: 16.0), 
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
