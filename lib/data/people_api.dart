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
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:people/data/person.dart';
import 'package:people/strings.dart';

class PeopleApi {
  static String _peopleArgs = "/api/?amount=80&region=united%20states&ext";

  static Future<List<Person>> getPeople() async {
    final response = await http.get('${Strings.urlPeople}$_peopleArgs');
    final results = json.decode(response.body);
    final List<Person> persons = new List();

    for (int i = 0; i < results.length; i++) {
      persons.add(Person.fromJson(results[i]));
    }

    return persons;
  }
}
