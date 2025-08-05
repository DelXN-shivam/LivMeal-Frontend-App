import 'package:flutter/material.dart';
import 'fade_shimmer.dart';

class MessCardShimmer extends StatelessWidget {
  final int index;

  const MessCardShimmer({super.key, this.index = 0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      height: 190, // Fixed total height to match MessCard
      child: Material(
        borderRadius: BorderRadius.circular(16),
        elevation: 2,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              // Image section - fixed height (100px)
              SizedBox(
                height: 100,
                width: double.infinity,
                child: FadeShimmer(
                  width: double.infinity,
                  height: 100,
                  radius: 0,
                  fadeTheme: FadeTheme.light,
                  millisecondsDelay: index * 100,
                ),
              ),
              // Content section - fixed height (90px)
              Container(
                height: 90, // 190 total - 100 image = 90 content
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and location section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FadeShimmer(
                          width: 180,
                          height: 16,
                          radius: 4,
                          fadeTheme: FadeTheme.light,
                          millisecondsDelay: index * 100 + 200,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            FadeShimmer.round(
                              size: 12,
                              fadeTheme: FadeTheme.light,
                              millisecondsDelay: index * 100 + 300,
                            ),
                            const SizedBox(width: 4),
                            Flexible(
                              child: FadeShimmer(
                                width: 140,
                                height: 12,
                                radius: 4,
                                fadeTheme: FadeTheme.light,
                                millisecondsDelay: index * 100 + 400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // Spacer to push price to bottom
                    const Expanded(child: SizedBox.shrink()),
                    // Price and delivery section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FadeShimmer(
                              width: 80,
                              height: 12,
                              radius: 4,
                              fadeTheme: FadeTheme.light,
                              millisecondsDelay: index * 100 + 500,
                            ),
                            const SizedBox(height: 2),
                            FadeShimmer(
                              width: 100,
                              height: 12,
                              radius: 4,
                              fadeTheme: FadeTheme.light,
                              millisecondsDelay: index * 100 + 600,
                            ),
                          ],
                        ),
                        FadeShimmer(
                          width: 60,
                          height: 20,
                          radius: 5,
                          fadeTheme: FadeTheme.light,
                          millisecondsDelay: index * 100 + 700,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessListShimmer extends StatelessWidget {
  final int itemCount;

  const MessListShimmer({super.key, this.itemCount = 5});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.25,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        // padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const BouncingScrollPhysics(),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: index == itemCount - 1 ? 20 : 16),
            child: MessCardShimmer(index: index),
          );
        },
      ),
    );
  }
}
