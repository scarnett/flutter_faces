import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CameraOptions extends StatelessWidget {
  const CameraOptions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) =>
      Container(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
        width: MediaQuery.of(context).size.width,
        child: CarouselSlider(
          options: CarouselOptions(
            aspectRatio: 10.0,
            viewportFraction: 0.25,
            initialPage: 0,
            enableInfiniteScroll: false,
            onPageChanged: _onPageChanged,
          ),
          items: [
            Tab(
              child: Text(
                'Photo',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Tab(
              child: Text(
                'Video',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          ],
        ),
      );

  void _onPageChanged(int, CarouselPageChangedReason) {
    // TODO!
  }
}
