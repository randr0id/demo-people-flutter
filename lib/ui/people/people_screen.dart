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

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:people/data/people_api.dart';
import 'package:people/data/person.dart';
import 'package:people/strings.dart';
import 'package:people/ui/people/person_screen.dart';

class PeopleScreen extends StatefulWidget {
  PeopleScreen();

  @override
  createState() => PeopleScreenState(title: Strings.titlePeople);
}

class PeopleScreenState extends State<PeopleScreen> {
  PeopleScreenState({this.title});

  final String title;

  List<Person> people;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: FutureBuilder<List<Person>>(
          future: people != null ? _getPeople() : PeopleApi.getPeople(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Center(child: Text(Strings.errorNoConnection));
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return Center(
                      child: Text(Strings.errorMessage + snapshot.error));
                } else {
                  return _createListView(context, snapshot.data);
                }
            }
          },
        ));
  }

  Future<List<Person>> _getPeople() async => people;

  Widget _createListView(BuildContext context, List<Person> items) {
    people = items;

    return ListView.builder(
      itemCount: people?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: <Widget>[
            ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage("images/profile_circle.png"),
                  backgroundColor: Colors.blue,
                  child: ClipOval(
                      child:
                          Image(image: NetworkImage(people[index].photoUrl))),
                ),
                trailing: Icon(
                  people[index].favorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.pinkAccent,
                ),
                title: Text(people[index].getFullName()),
                subtitle: Text(people[index].phone),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PersonScreen(person: people[index])),
                  );
                }),
            Divider(
              height: 2.0,
            ),
          ],
        );
      },
    );
  }
}
