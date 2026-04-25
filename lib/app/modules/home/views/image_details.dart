import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:share_plus/share_plus.dart';
import '../../../constants/index.dart';
import '../../../model/index.dart';
import '../../../reusable/index.dart';
import '../controllers/home_controller.dart';

class ImageDetails extends GetView<HomeController> {
  const ImageDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Hit data = Get.arguments;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Main Image with Hero Animation
          Positioned.fill(
            child: Hero(
              tag: data.largeImageUrl ?? "",
              child: InteractiveViewer(
                minScale: 1.0,
                maxScale: 4.0,
                child: networkImage(
                  data.largeImageUrl ?? emptyString,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Gradient Overlay for readability
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.4),
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black.withOpacity(0.8),
                  ],
                  stops: const [0.0, 0.2, 0.7, 1.0],
                ),
              ),
            ),
          ),

          // Top Action Bar
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 20,
            right: 20,
            child: FadeInDown(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _glassButton(
                    icon: Icons.arrow_back_ios_new_rounded,
                    onTap: () => Get.back(),
                  ),
                  Row(
                    children: [
                      _glassButton(
                        icon: Iconsax.copy,
                        onTap: () {
                          if (data.largeImageUrl != null) {
                            Share.share('${data.largeImageUrl}');
                          }
                        },
                      ),
                      const SizedBox(width: 15),
                      _glassButton(
                        icon: Iconsax.document_download,
                        onTap: () {
                          if (data.largeImageUrl != null) {
                            controller.downloadImage(data.largeImageUrl!);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Bottom Info Panel
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: FadeInUp(
              duration: const Duration(milliseconds: 800),
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 30),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Photographer Info
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: data.userImageUrl != null &&
                                      data.userImageUrl!.isNotEmpty
                                  ? CachedNetworkImage(
                                      imageUrl: data.userImageUrl!,
                                      width: 48,
                                      height: 48,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          Container(color: Colors.grey[800]),
                                      errorWidget: (context, url, error) =>
                                          Container(
                                        color: Colors.grey[800],
                                        child: const Icon(Icons.person,
                                            color: Colors.white),
                                      ),
                                    )
                                  : Container(
                                      width: 48,
                                      height: 48,
                                      color: Colors.grey[800],
                                      child: const Icon(Icons.person,
                                          color: Colors.white),
                                    ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.user ?? "Unknown Artist",
                                    style: prozaLibreText.get18.w700.xffFFFFFF,
                                  ),
                                  Text(
                                    "@${data.user?.toLowerCase().replaceAll(" ", "_") ?? "artist"}",
                                    style: prozaLibreText.get14.w400
                                        .textColor(Colors.white70),
                                  ),
                                ],
                              ),
                            ),
                            Obx(() => GestureDetector(
                                  onTap: () {
                                    data.isLiked(!data.isLiked.value);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: data.isLiked.value
                                          ? Colors.red.withOpacity(0.2)
                                          : Colors.white.withOpacity(0.1),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: data.isLiked.value
                                            ? Colors.red.withOpacity(0.5)
                                            : Colors.white.withOpacity(0.1),
                                      ),
                                    ),
                                    child: Icon(
                                      data.isLiked.value
                                          ? Iconsax.heart5
                                          : Iconsax.heart,
                                      color: data.isLiked.value
                                          ? Colors.red
                                          : Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                )),
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: appColors.xff649676,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                "Follow",
                                style: prozaLibreText.get14.w600.xffFFFFFF,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),

                        // Stats Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _statItem(
                                Iconsax.heart5, data.likes.toString(), "Likes"),
                            _statItem(
                                Iconsax.eye, data.views.toString(), "Views"),
                            _statItem(Iconsax.message_text,
                                data.comments.toString(), "Comments"),
                          ],
                        ),
                        const SizedBox(height: 25),

                        // Tags
                        if (data.tags != null)
                          SizedBox(
                            height: 35,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: data.tags!.split(",").length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 10),
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.white.withOpacity(0.1)),
                                  ),
                                  child: Text(
                                    data.tags!.split(",")[index].trim(),
                                    style: prozaLibreText.get12.w500.xffFFFFFF,
                                  ),
                                );
                              },
                            ),
                          ),
                        const SizedBox(height: 30),

                        // Primary Action Button
                        GestureDetector(
                          onTap: () {
                            Get.snackbar(
                              "Coming Soon",
                              "This feature is coming soon 🚀",
                              snackPosition: SnackPosition.BOTTOM,
                              duration: Duration(seconds: 2),
                            );
                            // if (data.largeImageUrl != null) {
                            //   controller.setWallpaper(data.largeImageUrl!);
                            // }
                          },
                          child: Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  appColors.xff649676,
                                  appColors.xff67864a
                                ],
                              ),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: appColors.xff649676.withOpacity(0.3),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                "Set as Wallpaper",
                                style: prozaLibreText.get18.w700.xffFFFFFF,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _glassButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 22,
            ),
          ),
        ),
      ),
    );
  }

  Widget _statItem(IconData icon, String count, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(height: 6),
        Text(
          count,
          style: prozaLibreText.get16.w700.xffFFFFFF,
        ),
        Text(
          label,
          style: prozaLibreText.get12.w400.textColor(Colors.white60),
        ),
      ],
    );
  }
}
