import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final IconData? icon; // Make the icon optional
  final Color iconColor;
  final ScrollController scrollController;
  final int scrollOffset;
  final Color appBarColor;
  final Color boxShadowColor;
  final FontWeight titleFontWeight;

  const CustomAppBar({
    super.key,
    required this.title,
    this.icon, // Optional icon parameter
    this.iconColor = Colors.deepOrange,
    required this.scrollController,
    this.scrollOffset = 34,
    this.appBarColor = Colors.white,
    this.boxShadowColor = Colors.black,
    this.titleFontWeight = FontWeight.bold,
    required List<IconButton> actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar>
    with TickerProviderStateMixin {
  double topBarOpacity = 0.0;
  late Animation<double> topBarAnimation;
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    animationController.forward();
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: animationController,
            curve: const Interval(0, 0.5, curve: Curves.fastOutSlowIn)));

    widget.scrollController.addListener(() {
      if (widget.scrollController.offset >= widget.scrollOffset) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (widget.scrollController.offset <= widget.scrollOffset &&
          widget.scrollController.offset >= 0) {
        if (topBarOpacity !=
            widget.scrollController.offset / widget.scrollOffset) {
          setState(() {
            topBarOpacity =
                widget.scrollController.offset / widget.scrollOffset;
          });
        }
      } else if (widget.scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return getAppBarUI(context);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Widget getAppBarUI(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget? child) {
        return Container(
          decoration: BoxDecoration(
            color: widget.appBarColor.withOpacity(topBarOpacity),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: widget.boxShadowColor.withOpacity(0.4 * topBarOpacity),
                offset: const Offset(1.1, 1.1),
                blurRadius: 10.0,
              ),
            ],
          ),
          child: AppBar(
            centerTitle: false,
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget.icon != null) ...[
                  Icon(
                    widget.icon!,
                    color: widget.iconColor,
                    size: 28,
                  ),
                  const SizedBox(width: 10),
                ],
                Text(
                  widget.title,
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: widget.titleFontWeight,
                    color: Colors.black87,
                    shadows: const [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black12,
                        offset: Offset(3, 3),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
