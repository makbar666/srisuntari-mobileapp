import 'package:flutter/material.dart';

List<DropdownMenuItem<String>> buildPuskesmasDropdownItems() {
  return [
    DropdownMenuItem(
        value: "Puskesmas Fakfak", child: Text("Puskesmas Fakfak")),
    DropdownMenuItem(
        value: "Puskesmas Sekban", child: Text("Puskesmas Sekban")),
    DropdownMenuItem(
        value: "Puskesmas Fakfak Tengah",
        child: Text("Puskesmas Fakfak Tengah")),
    DropdownMenuItem(value: "Puskesmas Karas", child: Text("Puskesmas Karas")),
    DropdownMenuItem(value: "Puskesmas Werba", child: Text("Puskesmas Werba")),
    DropdownMenuItem(value: "Puskesmas Degen", child: Text("Puskesmas Degen")),
    DropdownMenuItem(
        value: "Puskesmas Kramomongga", child: Text("Puskesmas Kramomongga")),
    DropdownMenuItem(value: "Puskesmas Kokas", child: Text("Puskesmas Kokas	")),
    DropdownMenuItem(
        value: "Puskesmas Bomberay", child: Text("Puskesmas Bomberay")),
  ];
}