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

class Person {
  final String firstName;
  final String lastName;
  final String photoUrl;
  final String email;
  final String phone;
  final String region;
  final String gender;
  final String dob;
  bool favorite = false;

  Person(
      {this.firstName,
      this.lastName,
      this.photoUrl,
      this.email,
      this.phone,
      this.region,
      this.gender,
      this.dob});

  factory Person.fromJson(Map<String, dynamic> jsonBody) {
    return Person(
        firstName: jsonBody['name'],
        lastName: jsonBody['surname'],
        photoUrl: jsonBody['photo'],
        email: jsonBody['email'],
        phone: jsonBody['phone'],
        region: jsonBody['region'],
        gender: jsonBody['gender'],
        dob: jsonBody['birthday']['mdy']);
  }

  String getFullName() {
    if (lastName?.isNotEmpty == true) {
      return (firstName?.isNotEmpty == true)
          ? "$firstName $lastName"
          : lastName;
    } else {
      return firstName;
    }
  }
}
