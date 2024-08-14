import 'package:flutter/material.dart';

Widget prayerContainer({required String imageUrl, required String title}) {
  return Container(
    width: 150,
    height: 150,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      image: DecorationImage(
        image: NetworkImage(imageUrl),
        fit: BoxFit.cover,
      ),
    ),
    child: Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 150,
        height: 50,
        decoration: const BoxDecoration(
          color: Color.fromARGB(38, 238, 238, 238),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}

Widget saintContainer({required String imageUrl, required String title}) {
  return Container(
    width: 150,
    height: 150,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      image: DecorationImage(
        image: NetworkImage(imageUrl),
        fit: BoxFit.cover,
      ),
    ),
    child: Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 150,
        height: 50,
        decoration: const BoxDecoration(
          color: Color.fromARGB(38, 238, 238, 238),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}
