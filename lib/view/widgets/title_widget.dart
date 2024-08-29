import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_app/utils/app_colors.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final bool viewAll;
  const TitleWidget({super.key, required this.title, this.viewAll = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.actor(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          viewAll
              ? Text.rich(
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap =
                          () => debugPrint('==>onTap Wiew all Categories'),
                    children: [
                      TextSpan(
                        text: 'View All',
                        style: GoogleFonts.actor(
                          color: Colors.black38,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      WidgetSpan(
                        child: Container(
                          height: 18,
                          width: 18,
                          margin: const EdgeInsets.only(left: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: AppColors.primary.withOpacity(.4),
                          ),
                          child: const Icon(
                            CupertinoIcons.forward,
                            size: 12,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
