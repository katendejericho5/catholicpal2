import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

Widget customImageContainer({
  required String imageUrl,
  required String title,
  required bool isFavorite,
  required VoidCallback onFavoriteTap,
  required VoidCallback onTap,
  double? height,
  required bool showFavorite,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Stack(
      children: [
        Container(
          width: 150,
          height: height ?? 150, // Use provided height or default to 150
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: CachedNetworkImageProvider(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  color: Colors.white,
                  height: height ?? 150,
                  width: 150,
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: 150,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5), // Dark translucent color
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Center(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        if (showFavorite) // Only show the favorite icon if showFavorite is true
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
                  isFavorite
                      ? FontAwesomeIcons.solidHeart
                      : FontAwesomeIcons.heart,
                  color: Colors.red,
                  size: 20,
                ),
                onPressed: onFavoriteTap,
              ),
            ),
          ),
      ],
    ),
  );
}

Widget prayerContainer({
  required String imageUrl,
  required String title,
  required bool isFavorite,
  required VoidCallback onFavoriteTap,
  required VoidCallback onTap, // Add this parameter
}) {
  return customImageContainer(
    imageUrl: imageUrl,
    title: title,
    isFavorite: isFavorite,
    onFavoriteTap: onFavoriteTap,
    onTap: onTap, showFavorite: true, // Pass the onTap callback
  );
}

Widget saintContainer({
  required String imageUrl,
  required String title,
  required bool isFavorite,
  required VoidCallback onFavoriteTap,
  required VoidCallback onTap, // Add this parameter
}) {
  return customImageContainer(
      imageUrl: imageUrl,
      title: title,
      isFavorite: isFavorite,
      onFavoriteTap: onFavoriteTap,
      onTap: onTap, // Pass the onTap callback
      showFavorite: true);
}

Widget FaithGuideContainer({
  required String imageUrl,
  required String title,
  required bool isFavorite,
  required VoidCallback onFavoriteTap,
  required VoidCallback onTap, // Add this parameter
}) {
  return customImageContainer(
      imageUrl: imageUrl,
      title: title,
      isFavorite: isFavorite,
      onFavoriteTap: onFavoriteTap,
      onTap: onTap, // Pass the onTap callback
      showFavorite: true);
}

class UpdateSection extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description;
  final VoidCallback onTap;

  const UpdateSection({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Display the image from network
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: Image.network(
                imageUrl,
                height: 120,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) =>
                    const Center(child: Icon(Icons.error)),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title of the section
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Description of the section
                  Text(
                    description,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
