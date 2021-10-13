import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';

class LoadingBooks extends StatelessWidget {
  const LoadingBooks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 200,
          width: Get.width,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                blurRadius: 15,
                spreadRadius: 5,
                color: Colors.grey.shade200,
              )
            ],
          ),
          child: SkeletonItem(
              child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              //Libro
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                    width: 120,
                    height: 170,
                    // minHeight: MediaQuery.of(context).size.height / 8,
                    maxHeight: MediaQuery.of(context).size.height / 2,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              SizedBox(
                width: Get.width * 0.45,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Testo
                    SkeletonParagraph(
                      style: SkeletonParagraphStyle(
                        lines: 3,
                        spacing: 6,
                        lineStyle: SkeletonLineStyle(
                          randomLength: true,
                          height: 10,
                          borderRadius: BorderRadius.circular(8),
                          minLength: MediaQuery.of(context).size.width / 2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    //Categories
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 16,
                          width: 64,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
