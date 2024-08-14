import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget customImageContainer({
  required String imageUrl,
  required String title,
  required bool isFavorite,
  required VoidCallback onFavoriteTap,
}) {
  return Stack(
    children: [
      Container(
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
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
      Positioned(
        top: 0,
        right: 0,
        child: Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          child: IconButton(
            icon: FaIcon(
              isFavorite ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
              color: Colors.red,
              size: 20,
            ),
            onPressed: onFavoriteTap,
          ),
        ),
      ),
    ],
  );
}

// Usage example:
Widget prayerContainer({
  required String imageUrl,
  required String title,
  required bool isFavorite,
  required VoidCallback onFavoriteTap,
}) {
  return customImageContainer(
    imageUrl: imageUrl,
    title: title,
    isFavorite: isFavorite,
    onFavoriteTap: onFavoriteTap,
  );
}

Widget saintContainer({
  required String imageUrl,
  required String title,
  required bool isFavorite,
  required VoidCallback onFavoriteTap,
}) {
  return customImageContainer(
    imageUrl: imageUrl,
    title: title,
    isFavorite: isFavorite,
    onFavoriteTap: onFavoriteTap,
  );
}

Widget quizContainer({
  required String imageUrl,
  required String title,
  required bool isFavorite,
  required VoidCallback onFavoriteTap,
}) {
  return customImageContainer(
    imageUrl: imageUrl,
    title: title,
    isFavorite: isFavorite,
    onFavoriteTap: onFavoriteTap,
  );
}
