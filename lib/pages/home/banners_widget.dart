import 'dart:async';
import 'package:flutter/material.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

final List<String> imagePaths = [
  'https://didongthongminh.vn/upload_images/images/2022/01/15/1.png',
  'https://cdn.tgdd.vn/Files/2021/12/20/1405658/269276486_4934536153260180_6368779938187000715_n_1200x628-800-resize.jpg',
  'https://cdn.hoanghamobile.com/Uploads/2024/09/19/banner-ip16-640x266_638623672138643943.png;width=460;height=210;mode=crop;',
  'https://news.khangz.com/wp-content/uploads/2021/09/back-to-school-1-2-750x418.jpg',
  'https://cellphones.com.vn/sforum/wp-content/uploads/2021/08/CleanShot-2021-08-18-at-12.30.45@2x-scaled.jpg',
  'https://shopdunk.com/images/thumbs/0021910_banner%20iphone%2015-3_PC_1600.jpeg',
];

late List<Widget> _pages;

int _activePage = 0;

final PageController _pageController = PageController(initialPage: 0);

Timer? _timer;

class _BannerWidgetState extends State<BannerWidget> {
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.page == imagePaths.length - 1) {
        _pageController.animateToPage(0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
      } else {
        _pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _pages = List.generate(
        imagePaths.length,
        (index) => ImagePlaceholder(
              imagePath: imagePaths[index],
            ));
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 4,
          child: PageView.builder(
            controller: _pageController,
            itemCount: imagePaths.length,
            onPageChanged: (value) {
              setState(() {
                _activePage = value;
              });
            },
            itemBuilder: (context, index) {
              return _pages[index];
            },
          ),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Container(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(
                _pages.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: InkWell(
                    onTap: () {
                      _pageController.animateToPage(index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn);
                    },
                    child: CircleAvatar(
                      radius: 3,
                      backgroundColor:
                          _activePage == index ? Colors.white : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class ImagePlaceholder extends StatelessWidget {
  final String? imagePath;
  const ImagePlaceholder({super.key, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 137,
      width: 335,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(8)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          imagePath!,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

