import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import 'package:latlong2/latlong.dart';
import 'package:qareeb_models/global.dart';
import 'package:qareeb_models/points/data/model/trip_point.dart';

import '../../../generated/assets.dart';


extension IconPoint on num {

  String get iconPoint {
    switch (toInt()) {
      case 0:
        return Assets.iconsA;
      case 1:
        return Assets.iconsB;
      case 2:
        return Assets.iconsC;
      case 3:
        return Assets.iconsD;
    }
    return Assets.iconsE;
  }
}
class MyMarker {
  LatLng point;
  num? key;
  double? bearing;
  MyMarkerType type;
  dynamic item;

  ///Number of users pickup
  int nou;

  MyMarker({
    required this.point,
    this.key,
    this.bearing,
    this.item,
    this.nou = 0,
    this.type = MyMarkerType.location,
  });

  Marker getWidget(int index) {
    switch (type) {
      case MyMarkerType.location:
        return Marker(
          point: point,
          height: 40.0.r,
          width: 40.0.r,
          builder: (context) {
            return Transform.rotate(
              angle: bearing ?? 0.0,
              child: ImageMultiType(
                url: Assets.iconsMainColorMarker,
                height: 40.0.r,
                width: 40.0.r,
              ),
            );
          },
        );
      case MyMarkerType.driver:
        return Marker(
          point: point,
          builder: (context) => 0.0.verticalSpace,
        );
      case MyMarkerType.point:
        return Marker(
          point: point,
          height: 70.0.r,
          width: 70.0.r,
          builder: (context) {
            return InkWell(
              onTap: null,
              child: Column(
                children: [
                  Transform.rotate(
                    angle: bearing ?? 0.0,
                    child: Container(
                      height: 30,
                      width: 30,
                      padding: const EdgeInsets.all(5.0).r,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const ImageMultiType(
                        url: Assets.iconsMainColorMarker,
                        height: 25.0,
                        width: 25.0,
                      ),
                    ),
                  ),
                  if (item is TripPoint)
                    Container(
                      width: 70.0.r,
                      color: Colors.white,
                      padding: const EdgeInsets.all(3.0).r,
                      child: DrawableText(
                        text: (item as TripPoint).arName,
                        size: 12.0.sp,
                        maxLines: 1,
                        matchParent: true,
                        textAlign: TextAlign.center,
                      ),
                    )
                ],
              ),
            );
          },
        );
      case MyMarkerType.sharedPint:
        return Marker(
          point: point,
          height: 50.0.r,
          width: 50.0.r,
          builder: (context) {
            return Builder(builder: (context) {
              var nou = 0;
              return Column(
                children: [
                  if (nou != 0)
                    Container(
                      height: 35.0.r,
                      width: 70.0.r,
                      margin: EdgeInsets.only(bottom: 5.0.r),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0.r),
                      ),
                      alignment: Alignment.center,
                      child: DrawableText(
                        text: '$nou مقعد',
                        color: Colors.black,
                        size: 12.0.sp,
                      ),
                    ),
                  ImageMultiType(
                    url: index.iconPoint,
                    height: 50.0.r,
                    width: 50.0.r,
                  ),
                ],
              );
            });
          },
        );
      case MyMarkerType.bus:
        return Marker(
          point: point,
          height: 40.0.r,
          width: 40.0.r,
          builder: (context) {
            return Transform.rotate(
              angle: bearing ?? 0.0,
              child: ImageMultiType(
                url: Assets.iconsLocator,
                height: 40.0.r,
                width: 40.0.r,
              ),
            );
          },
        );
    }
  }

  @override
  String toString() {
    return 'MyMarker{point: $point, key: $key, type: $type, nou: $nou}';
  }
}

class MyPolyLine {
  LatLng? endPoint;
  num? key;
  String encodedPolyLine;
  Color? color;

  MyPolyLine({this.endPoint, this.key, this.encodedPolyLine = '', this.color});
}
