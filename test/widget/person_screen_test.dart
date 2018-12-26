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

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:people/data/person.dart';
import 'package:people/ui/people/person_screen.dart';

import '../util/MockImageHttpClient.dart';

void main() {
  // mock object
  Person person = Person(
      firstName: "Anthony",
      lastName: "Tester",
      photoUrl: "https://example.com/api/photos/male/17.jpg",
      email: "anthony_86@example.com",
      phone: "(554) 171 6614",
      region: "United States",
      dob: "03/23/1986");

  // expected text within created widgets
  List<String> expectedTexts = [
    person.getFullName(),
    person.getFullName(),
    person.dob,
    person.phone,
    person.email,
    person.region
  ];

  testWidgets('Person Detail Widget test', (WidgetTester tester) async {
    HttpOverrides.runZoned(() async {
      await tester.pumpWidget(MaterialApp(home: PersonScreen(person: person)));

      // gets the created widgets
      Iterable<Widget> listOfWidgets = tester.allWidgets;

      checkTextWidgets(listOfWidgets, expectedTexts);
    }, createHttpClient: createMockImageHttpClient);
  });
}

void checkTextWidgets(
    Iterable<Widget> listOfWidgets, List<String> expectedTexts) {
  var index = 0;
  for (Widget widget in listOfWidgets) {
    if (widget is Text) {
      expect(widget.data, expectedTexts[index]);
      index++;
    }
  }
}
