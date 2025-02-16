import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialIcons {
  // Using brand-specific icons from FontAwesome
  static IconData get google => FontAwesomeIcons.google;
  static IconData get facebook => FontAwesomeIcons.facebook;
  static IconData get apple => FontAwesomeIcons.apple;

  // Fallback icons in case FontAwesome is not available
  static const IconData googleFallback = Icons.g_mobiledata;
  static const IconData facebookFallback = Icons.facebook;
  static const IconData appleFallback = Icons.apple;
} 