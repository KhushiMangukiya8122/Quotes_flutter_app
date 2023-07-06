import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

int index = 0;

List<String> images = [
  "assets/images/popular/p1.jpg",
  "assets/images/popular/p2.jpg",
  "assets/images/popular/p3.jpg",
  "assets/images/popular/p4.jpg",
  "assets/images/popular/p5.jpg",
  "assets/images/motivational/m1.jpg",
  "assets/images/motivational/m2.jpg",
  "assets/images/motivational/m3.jpg",
  "assets/images/motivational/m4.jpg",
  "assets/images/motivational/m5.jpg",
  "assets/images/occassional/o1.jpg",
  "assets/images/occassional/o2.jpg",
  "assets/images/occassional/o3.jpg",
  "assets/images/occassional/o4.jpg",
  "assets/images/occassional/o5.jpg",
  "assets/images/feelings/f1.jpg",
  "assets/images/feelings/f2.jpg",
  "assets/images/feelings/f3.jpg",
  "assets/images/feelings/f4.jpg",
  "assets/images/feelings/f5.jpg",
  "assets/images/family/fa1.jpg",
  "assets/images/family/fa2.jpg",
  "assets/images/family/fa3.jpg",
  "assets/images/family/fa4.jpg",
  "assets/images/family/fa5.jpg",
  "assets/images/moments/mo1.jpg",
  "assets/images/moments/mo2.jpg",
  "assets/images/moments/mo3.jpg",
  "assets/images/moments/mo4.jpg",
  "assets/images/moments/mo5.jpg",
  "assets/images/objects/b1.jpg",
  "assets/images/objects/b2.jpg",
  "assets/images/objects/b3.jpg",
  "assets/images/objects/b4.jpg",
  "assets/images/objects/b5.jpg",
];

List<Map<String, dynamic>> popular = [
  {
    "image": "assets/images/popular/p1.jpg",
    "name": "Love",
    "json": "assets/json/popular.json",
  },
  {
    "image": "assets/images/popular/p2.jpg",
    "name": "Family",
    "json": "assets/json/popular.json",
  },
  {
    "image": "assets/images/popular/p3.jpg",
    "name": "Friendship",
    "json": "assets/json/popular.json",
  },
  {
    "image": "assets/images/popular/p4.jpg",
    "name": "Mom",
    "json": "assets/json/popular.json",
  },
  {
    "image": "assets/images/popular/p5.jpg",
    "name": "Work",
    "json": "assets/json/popular.json",
  },
];

List<Map<String, dynamic>> motivational = [
  {
    "image": "assets/images/motivational/m1.jpg",
    "name": "Motivational",
  },
  {
    "image": "assets/images/motivational/m2.jpg",
    "name": "Courage",
  },
  {
    "image": "assets/images/motivational/m3.jpg",
    "name": "Freedom",
  },
  {
    "image": "assets/images/motivational/m4.jpg",
    "name": "Knowledge",
  },
  {
    "image": "assets/images/motivational/m5.jpg",
    "name": "Life",
  },
];

List<Map<String, dynamic>> occassional = [
  {
    "image": "assets/images/occassional/o1.jpg",
    "name": "Mother's Day",
  },
  {
    "image": "assets/images/occassional/o2.jpg",
    "name": "Father's Day",
  },
  {
    "image": "assets/images/occassional/o3.jpg",
    "name": "New year",
  },
  {
    "image": "assets/images/occassional/o4.jpg",
    "name": "Valentine Day",
  },
  {
    "image": "assets/images/occassional/o5.jpg",
    "name": "Bro-Sis",
  },
];

List<Map<String, dynamic>> feelings = [
  {
    "image": "assets/images/feelings/f1.jpg",
    "name": "Sad",
  },
  {
    "image": "assets/images/feelings/f2.jpg",
    "name": "Trust",
  },
  {
    "image": "assets/images/feelings/f3.jpg",
    "name": "Attitude",
  },
  {
    "image": "assets/images/feelings/f4.jpg",
    "name": "Jealousy",
  },
  {
    "image": "assets/images/feelings/f5.jpg",
    "name": "Smile",
  },
];

List<Map<String, dynamic>> family = [
  {
    "image": "assets/images/family/fa1.jpg",
    "name": "Family",
  },
  {
    "image": "assets/images/family/fa2.jpg",
    "name": "Mom",
  },
  {
    "image": "assets/images/family/fa3.jpg",
    "name": "Dad",
  },
  {
    "image": "assets/images/family/fa4.jpg",
    "name": "Friendship",
  },
  {
    "image": "assets/images/family/fa5.jpg",
    "name": "Home",
  },
];

List<Map<String, dynamic>> moments = [
  {
    "image": "assets/images/moments/mo1.jpg",
    "name": "Anniversary",
  },
  {
    "image": "assets/images/moments/mo2.jpg",
    "name": "Birthday",
  },
  {
    "image": "assets/images/moments/mo3.jpeg",
    "name": "Romantic",
  },
  {
    "image": "assets/images/moments/mo4.jpg",
    "name": "Wedding",
  },
  {
    "image": "assets/images/moments/mo5.jpg",
    "name": "Dating",
  },
];

List<Map<String, dynamic>> objects = [
  {
    "image": "assets/images/objects/b1.jpg",
    "name": "Business",
  },
  {
    "image": "assets/images/objects/b2.jpg",
    "name": "Computer",
  },
  {
    "image": "assets/images/objects/b3.jpg",
    "name": "Nature",
  },
  {
    "image": "assets/images/objects/b4.jpg",
    "name": "Technology",
  },
  {
    "image": "assets/images/objects/b5.jpg",
    "name": "Time",
  },
];

int currentFontIndex = 0;
List<String?> googleFonts = [
  GoogleFonts.roboto().fontFamily,
  GoogleFonts.lato().fontFamily,
  GoogleFonts.openSans().fontFamily,
  GoogleFonts.montserrat().fontFamily,
  GoogleFonts.quicksand().fontFamily,
];

List<Color> Fontcolors = [
  Colors.red,
  Colors.blue,
  Colors.green,
  Colors.yellow,
  Colors.orange,
  Colors.purple,
  Colors.pink,
  Colors.cyan,
];

List<Color> containerColor = [
  Colors.red,
  Colors.blue,
  Colors.green,
  Colors.yellow,
  Colors.orange,
  Colors.purple,
  Colors.pink,
  Colors.cyan,
];

List<String> Themes = [
  "assets/images/Themes/1.png",
  "assets/images/Themes/2.png",
  "assets/images/Themes/3.png",
  "assets/images/Themes/4.png",
  "assets/images/Themes/5.png",
  "assets/images/Themes/6.png",
  "assets/images/Themes/7.png",
  "assets/images/Themes/8.png",
  "assets/images/Themes/9.png",
  "assets/images/Themes/10.png",
  "assets/images/Themes/11.png",
  "assets/images/Themes/12.png",
  "assets/images/Themes/13.png",
  "assets/images/Themes/14.png",
  "assets/images/Themes/15.png",
  "assets/images/Themes/16.png",
  "assets/images/Themes/17.png",
  "assets/images/Themes/18.png",
  "assets/images/Themes/19.png",
  "assets/images/Themes/20.png",
  "assets/images/Themes/21.png",
  "assets/images/Themes/22.png",
  "assets/images/Themes/23.png",
  "assets/images/Themes/24.png",
  "assets/images/Themes/25.png",
  "assets/images/Themes/26.png",
  "assets/images/Themes/27.png",
  "assets/images/Themes/28.png",
  "assets/images/Themes/29.png",
  "assets/images/Themes/30.png",
  "assets/images/Themes/31.png",
  "assets/images/Themes/32.png",
  "assets/images/Themes/33.png",
  "assets/images/Themes/34.png",
  "assets/images/Themes/35.png",
  "assets/images/Themes/36.png",
  "assets/images/Themes/37.png",
  "assets/images/Themes/38.png",
  "assets/images/Themes/39.png",
  "assets/images/Themes/40.png",
  "assets/images/Themes/41.png",
  "assets/images/Themes/42.png",
  "assets/images/Themes/43.png",
  "assets/images/Themes/44.png",
  "assets/images/Themes/45.png",
  "assets/images/Themes/46.png",
  "assets/images/Themes/47.png",
  "assets/images/Themes/48.png",
  "assets/images/Themes/49.png",
  "assets/images/Themes/50.png",
  "assets/images/Themes/51.png",
  "assets/images/Themes/52.png",
  "assets/images/Themes/53.png",
  "assets/images/Themes/54.png",
];