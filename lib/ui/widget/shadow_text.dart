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

class ShadowText extends StatelessWidget {
  ShadowText(this.text, {this.style}) : assert(text != null);

  final String text;
  final TextStyle style;

  Widget build(BuildContext context) {
    TextStyle textStyle = style ?? TextStyle();

    return ClipRect(
      child: Stack(
        children: [
          Positioned(
            top: 1.0,
            left: 1.0,
            child: Text(
              text,
              style: textStyle.copyWith(color: Colors.black.withOpacity(0.5)),
            ),
          ),
          Text(
            text,
            style: textStyle,
          ),
        ],
      ),
    );
  }
}
