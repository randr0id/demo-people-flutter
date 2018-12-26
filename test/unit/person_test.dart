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

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:people/data/person.dart';

void main() {
  List<dynamic> jsonBody;

  String peopleJson = '[{' +
      '"name": "Anthony",' +
      '"surname": "Tester",' +
      '"gender": "male",' +
      '"region": "United States",' +
      '"age": 32,' +
      '"title": "mr",' +
      '"phone": "(554) 171 6614",' +
      '"birthday": {' +
      '"dmy": "23/03/1986",' +
      '"mdy": "03/23/1986",' +
      '"raw": 512002875' +
      '},' +
      '"email": "anthony_86@example.com",' +
      '"photo":"https://example.com/api/photos/male/17.jpg"' +
      '},' +
      '{' +
      '"name": "Rose",' +
      '"surname": "Tester",' +
      '"gender": "female",' +
      '"region": "United States",' +
      '"age": 27,' +
      '"title": "ms",' +
      '"phone": "(358) 236 9987",' +
      '"birthday": {' +
      '"dmy": "19/10/1991",' +
      '"mdy": "10/19/1991",' +
      '"raw": 665237697' +
      '},' +
      '"email": "rosetester@example.com",' +
      '"photo":"https://example.com/api/photos/female/19.jpg"' +
      '}]';

  setUp(() {
    jsonBody = json.decode(peopleJson);
  });

  group("people list creation test", () {
    test('create person object', () {
      expect(jsonBody.length, 2);

      final Person person = Person.fromJson(jsonBody[0]);
      expect(person, isNot(null));
      expect(person.getFullName(), "Anthony Tester");
    });

    test('create people list', () {
      final List<Person> personList = List();

      for (int i = 0; i < jsonBody.length; i++) {
        personList.add(Person.fromJson(jsonBody[i]));
      }

      expect(personList.length, 2);
    });
  });
}
