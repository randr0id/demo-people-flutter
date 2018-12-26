/*
 * Copyright 2018 Randy Webster. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:flutter/material.dart';
import 'package:people/data/person.dart';
import 'package:people/strings.dart';
import 'package:people/ui/widget/shadow_text.dart';
import 'package:url_launcher/url_launcher.dart';

class PersonScreen extends StatefulWidget {
  PersonScreen({this.person});

  final Person person;

  @override
  createState() => PersonScreenState(person: person);
}

class PersonScreenState extends State<PersonScreen> {
  PersonScreenState({this.person}) : assert(person != null);

  final Person person;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Builder(builder: (BuildContext context) {
        return CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              expandedHeight: 280.0,
              flexibleSpace: FlexibleSpaceBar(
                title: ShadowText(person.getFullName()),
                background: Image(
                  image: NetworkImage(person.photoUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(16.0),
              sliver: SliverList(
                  delegate: SliverChildListDelegate([
                _createItemRow(context, Icons.cake, person.dob),
                _createItemRow(context, Icons.phone, person.phone, () {
                  _launchUrl(context, 'tel:${person.phone}');
                }),
                _createItemRow(context, Icons.email, person.email, () {
                  _launchUrl(context,
                      'mailto:${person.email}?subject=${Strings.textEmailSubject}');
                }),
                _createItemRow(context, Icons.place, person.region)
              ])),
            ),
            SliverFillRemaining()
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          person.favorite ? Icons.favorite : Icons.favorite_border,
        ),
        backgroundColor: Colors.pinkAccent,
        onPressed: () {
          setState(() => person.favorite = !person.favorite);
        },
      ),
    );
  }

  Widget _createItemRow(BuildContext context, IconData icon, String text,
      [Function function]) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            icon,
            size: 32.0,
            color: Colors.grey[700],
          ),
          title: Text(
            text,
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          onTap: () {
            if (function != null) {
              function();
            } else {
              _showAlert(context, text);
            }
          },
        ),
        Divider(
          height: 8.0,
          indent: 72.0,
        )
      ],
    );
  }

  _launchUrl(BuildContext context, String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      _showAlert(context, 'Unable to launch: "$url"', true);
    }
  }

  _showAlert(BuildContext context, String message, [bool isError = false]) {
    Scaffold.of(context).showSnackBar(SnackBar(
      backgroundColor: isError ? Colors.red : Colors.blue,
      content: Text(
        message,
        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      ),
    ));
  }
}
