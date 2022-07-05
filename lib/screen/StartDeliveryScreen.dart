// import 'dart:async';
//
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:kitchen/Menu/menu_bean.dart';
// import 'package:kitchen/utils/Utils.dart';
// import 'package:location/location.dart';
//
// import '../res.dart';
//
// const double CAMERA_ZOOM = 13;
// const double CAMERA_TILT = 0;
// const double CAMERA_BEARING = 30;
//
// class StartDeliveryScreen extends StatefulWidget {
//   var deliveryAddress;
//   final String orderid;
//
//   StartDeliveryScreen(this.deliveryAddress, this.orderid);
//
//   @override
//   StartDeliveryScreenState createState() => StartDeliveryScreenState();
// }
//
// class StartDeliveryScreenState extends State<StartDeliveryScreen> {
//   CameraPosition _cameraPosition;
//   double cameraZOOM = 14;
//   double cameraTILT = 0;
//   double cameraBEARING = 30;
//   String _error;
//   LatLng SOURCE_LOCATION = LatLng(0.0, 0.0);
//   LatLng DEST_LOCATION = LatLng(0.0, 0.0);
//
//   List<Data> data;
//
// /*  LatLng DEST_LOCATION = LatLng(42.6871386, -71.2143403);*/
//
//   Completer<GoogleMapController> _controller = Completer();
//   Set<Marker> _markers = {};
//
//   Set<Polyline> _polylines = {};
//   List<LatLng> polylineCoordinates = [];
//   PolylinePoints polylinePoints = PolylinePoints();
//   String googleAPIKey = "AIzaSyBn9ZKmXc-MN12Fap0nUQotO6RKtYJEh8o";
//
//   var kitchenlat = 0.0;
//   var kitchenlong = 0.0;
//   var deliverylatitude = 0.0;
//   var deliverylongitude = 0.0;
//   // for my custom icons
//   BitmapDescriptor sourceIcon;
//   BitmapDescriptor destinationIcon;
//
//   LatLng sourceLatLng;
//   LatLng destLatLng;
//   GoogleMapController _mapController;
//
//   Location _locationTracker;
//   StreamSubscription _locationSubscription;
//   Future future;
//   String userId;
//   LocationData currentLocation;
//   final Set<Marker> _markers1 = {};
//   Map<PolylineId, Polyline> _polylinesList1 = <PolylineId, Polyline>{};
//   bool loadingMap = false;
//
//   @override
//   void initState() {
//     _locationTracker = new Location();
//     super.initState();
//     Future.delayed(Duration.zero, () {
//       _listenLocation();
//       setSourceAndDestinationIcons();
//     });
//     Future.delayed(Duration.zero, () {});
//   }
//
//   onMapCreated(GoogleMapController _cntlr) {
//     _mapController = _cntlr;
//     if (sourceLatLng != null && destLatLng != null) {
//       var list = [sourceLatLng, destLatLng];
//       CameraUpdate u2 =
//           CameraUpdate.newLatLngBounds(boundsFromLatLngList(list), 50);
//       _mapController.animateCamera(u2).then((void v) {
//         check(u2, _mapController);
//       });
//     }
//     setMapPins();
//     setPolylines();
//   }
//
// /*  void onMapCreated(GoogleMapController controller) {
//     _controller.complete(controller);
//
//   }*/
//   void setSourceAndDestinationIcons() async {
//     sourceIcon = await BitmapDescriptor.fromAssetImage(
//         ImageConfiguration(devicePixelRatio: 2.5), Res.ic_account);
//     destinationIcon = await BitmapDescriptor.fromAssetImage(
//         ImageConfiguration(devicePixelRatio: 2.5), Res.ic_account);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
//     FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
//     return Scaffold(
//         backgroundColor: Colors.white,
//         body: Column(
//           children: [
//             Expanded(
//               child: Stack(
//                 children: [
//                   googleMap(),
//                   Row(
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           Navigator.pop(context);
//                         },
//                         child: Padding(
//                             padding: EdgeInsets.only(top: 50, left: 16),
//                             child: Image.asset(
//                               Res.ic_back,
//                               width: 16,
//                               height: 16,
//                             )),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(left: 16, top: 50),
//                         child: Text(
//                           "Location",
//                           style: TextStyle(color: Colors.black, fontSize: 15),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Positioned.fill(
//                     child: Align(
//                       alignment: Alignment.bottomCenter,
//                       child: Container(
//                         decoration: BoxDecoration(
//                             color: Colors.black,
//                             borderRadius: BorderRadius.circular(13)),
//                         margin:
//                             EdgeInsets.only(left: 16, right: 16, bottom: 16),
//                         width: double.infinity,
//                         height: 150,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.only(left: 16, top: 16),
//                               child: Text(
//                                 "Delivery Address",
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: 15),
//                               ),
//                             ),
//                             Expanded(
//                               child: Padding(
//                                 padding: EdgeInsets.only(left: 16, top: 16),
//                                 child: Text(
//                                   widget.deliveryAddress,
//                                   style: TextStyle(
//                                       color: Colors.white, fontSize: 15),
//                                 ),
//                               ),
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 InkWell(
//                                   onTap: () {},
//                                   child: Container(
//                                     width: 100,
//                                     margin:
//                                         EdgeInsets.only(right: 16, bottom: 16),
//                                     decoration: BoxDecoration(
//                                         gradient: LinearGradient(
//                                           colors: [
//                                             Color(0xff7ED39C),
//                                             Color(0xff089E90)
//                                           ],
//                                           begin: Alignment.topLeft,
//                                           end: Alignment.bottomCenter,
//                                           stops: [0, 1],
//                                         ),
//                                         borderRadius: BorderRadius.circular(8)),
//                                     child: Center(
//                                       child: Row(
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                           Center(
//                                             child: Text(
//                                               "Delivered",
//                                               style: TextStyle(
//                                                   color: Colors.white),
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                     height: 40,
//                                   ),
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ));
//   }
//
//   void setMapPins() {
//     setState(() {
//       // source pin
//       _markers.add(Marker(
//           markerId: MarkerId('sourcePin'),
//           position: SOURCE_LOCATION,
//           icon: sourceIcon));
//       // destination pin
//       _markers.add(Marker(
//           markerId: MarkerId('destPin'),
//           position: DEST_LOCATION,
//           icon: destinationIcon));
//     });
//   }
//
//   setPolylines() async {
// /*    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(googleAPIKey, PointLatLng( SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude),
//         PointLatLng( DEST_LOCATION.latitude, DEST_LOCATION.longitude),
//
//         travelMode: TravelMode.driving,
//         wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]
//     );
//     if (result.points.isNotEmpty) {
//          result.points.forEach((PointLatLng point) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       });
//     }*/
//     List<PointLatLng> result = (await polylinePoints.getRouteBetweenCoordinates(
//         googleAPIKey,
//         SOURCE_LOCATION.latitude,
//         SOURCE_LOCATION.longitude,
//         DEST_LOCATION.latitude,
//         DEST_LOCATION.longitude));
// /*    List<PointLatLng> result = (await polylinePoints.getRouteBetweenCoordinates(googleAPIKey, double.parse(kitchenlat),double.parse(kitchenlong), double.parse(deliverylatitude),double.parse(deliverylongitude),));*/
//     if (result.isNotEmpty) {
//       // loop through all PointLatLng points and convert them
//       // to a list of LatLng, required by the Polyline
//       result.forEach((PointLatLng point) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       });
//     }
//
//     setState(() {
//       // create a Polyline instance
//       // with an id, an RGB color and the list of LatLng pairs
//       Polyline polyline = Polyline(
//           width: 4,
//           polylineId: PolylineId("poly"),
//           color: Color.fromARGB(255, 40, 122, 198),
//           points: polylineCoordinates);
//
//       // add the constructed polyline as a set of points
//       // to the polyline set, which will eventually
//       // end up showing up on the map
//       _polylines.add(polyline);
//     });
//   }
//
//   googleMap() {
//     if (data != null) {
//       return GoogleMap(
//           myLocationEnabled: true,
//           compassEnabled: false,
//           tiltGesturesEnabled: false,
//           markers: _markers,
//           polylines: _polylines,
//           mapType: MapType.normal,
//           zoomControlsEnabled: true,
//           myLocationButtonEnabled: false,
//           onMapCreated: onMapCreated,
//           initialCameraPosition: _cameraPosition
//           /*CameraPosition(
//              zoom: CAMERA_ZOOM,
//              bearing: CAMERA_BEARING,
//              tilt: CAMERA_TILT,
//              target: SOURCE_LOCATION
//
//          ),*/
//           );
//     } else {
//       return Container();
//     }
//   }
//
//   updatePinOnMap() async {
// /*
//
//      // create a new CameraPosition instance
//      // every time the location changes, so the camera
//      // follows the pin as it moves with an animation
//      CameraPosition cPosition = CameraPosition(
//        zoom: CAMERA_ZOOM,
//        tilt: CAMERA_TILT,
//        bearing: CAMERA_BEARING,
//        target: LatLng(currentLocation.latitude, currentLocation.longitude),
//      );
//      final GoogleMapController controller = await _controller.future;
//      controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
//      // do this inside the setState() so Flutter gets notified
//      // that a widget update is due
//      setState(() {
//        // updated position
//        var pinPosition = LatLng(currentLocation.latitude, currentLocation.longitude);
//
//        sourcePinInfo.location = pinPosition;
//
//        // the trick is to remove the marker (by id)
//        // and add it again at the updated location
//        _markers.removeWhere((m) => m.markerId.value == 'sourcePin');
//        _markers.add(Marker(
//            markerId: MarkerId('sourcePin'),
//            onTap: () {
//              setState(() {
//                currentlySelectedPin = sourcePinInfo;
//                pinPillPosition = 0;
//              });
//            },
//            position: pinPosition, // updated position
//            icon: sourceIcon));
//      });*/
//
//     _cameraPosition = CameraPosition(
//       zoom: cameraZOOM,
//       tilt: cameraTILT,
//       bearing: cameraBEARING,
//       target: LatLng(SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude),
//     );
//     _mapController
//         .animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
//     setState(() {
//       _markers1.removeWhere((m) => m.markerId.value == "sourcePin");
//       _markers1.add(
//         Marker(
//             markerId: MarkerId("sourcePin"),
//             position:
//                 LatLng(SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude),
//             flat: true,
//             anchor: Offset(0.5, 0.5),
//             infoWindow: InfoWindow(title: "first"),
//             icon: sourceIcon),
//       );
//     });
//   }
//
//   Future _listenLocation() async {
//     print("updatePinOnMap");
//     _locationSubscription =
//         _locationTracker.onLocationChanged.handleError((dynamic err) {
//       setState(() {
//         _error = err.code;
//       });
//       _locationSubscription.cancel();
//     }).listen((LocationData currentLocation) {
//       _error = null;
//       updatePinOnMap();
//     });
//   }
//
//   LatLngBounds boundsFromLatLngList(List<LatLng> list) {
//     assert(list.isNotEmpty);
//     double x0, x1, y0, y1;
//     for (LatLng latLng in list) {
//       if (x0 == null) {
//         x0 = x1 = latLng.latitude;
//         y0 = y1 = latLng.longitude;
//       } else {
//         if (latLng.latitude > x1) x1 = latLng.latitude;
//         if (latLng.latitude < x0) x0 = latLng.latitude;
//         if (latLng.longitude > y1) y1 = latLng.longitude;
//         if (latLng.longitude < y0) y0 = latLng.longitude;
//       }
//     }
//     return LatLngBounds(northeast: LatLng(x1, y1), southwest: LatLng(x0, y0));
//   }
//
//   void check(CameraUpdate u, GoogleMapController c) async {
//     c.animateCamera(u);
//     // _mapController.animateCamera(u);
//     LatLngBounds l1 = await c.getVisibleRegion();
//     LatLngBounds l2 = await c.getVisibleRegion();
//     print(l1.toString());
//     print(l2.toString());
//     if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90)
//       check(u, c);
//   }
//
//   @override
//   void dispose() {
//     if (_locationSubscription != null) {
//       _locationSubscription.cancel();
//     }
//     super.dispose();
//   }
// }
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
// import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kitchen/model/start_delivery.dart';
import 'package:kitchen/network/ApiProvider.dart';
import 'package:kitchen/utils/HttpException.dart';
import 'package:kitchen/utils/Utils.dart';
import 'package:location/location.dart';

import '../res.dart';

const double CAMERA_ZOOM = 13;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;

class StartDeliveryScreen extends StatefulWidget {
  var deliveryAddress;
  final String orderid;
  final String orderitems_id;

  StartDeliveryScreen(this.deliveryAddress, this.orderid, this.orderitems_id);

  @override
  StartDeliveryScreenState createState() => StartDeliveryScreenState();
}

class StartDeliveryScreenState extends State<StartDeliveryScreen> {
  CameraPosition _cameraPosition;
  double cameraZOOM = 14;
  double cameraTILT = 0;
  double cameraBEARING = 30;
  String _error;
  LatLng SOURCE_LOCATION = LatLng(0.0, 0.0);
  LatLng DEST_LOCATION = LatLng(0.0, 0.0);

  List<BeanStartDeliveryData> data;

/*  LatLng DEST_LOCATION = LatLng(42.6871386, -71.2143403);*/

  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};

  Set<Polyline> _polylines = {};
  Set<Polyline> _polylines2 = {};
  List<LatLng> polylineCoordinates = [];
  List<LatLng> polylineCoordinates2 = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPIKey = "AIzaSyCBZ1E4AGu6xP_VV4GWr_qjnOte9sFmh0A";

  var kitchenlat = 0.0;
  var kitchenlong = 0.0;
  var deliverylatitude = 0.0;
  var deliverylongitude = 0.0;
  // for my custom icons
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;

  LatLng sourceLatLng;
  LatLng destLatLng;
  GoogleMapController _mapController;

  Location _locationTracker;
  StreamSubscription _locationSubscription;
  Future future;
  String userId;
  LocationData currentLocation;
  final Set<Marker> _markers1 = {};
  Map<PolylineId, Polyline> _polylinesList1 = <PolylineId, Polyline>{};
  bool loadingMap = false;

  @override
  void initState() {
    _locationTracker = new Location();
    super.initState();
    Future.delayed(Duration.zero, () {
      _listenLocation();
      setSourceAndDestinationIcons();
    });
    Future.delayed(Duration.zero, () {});
  }

  onMapCreated(GoogleMapController _cntlr) {
    _mapController = _cntlr;
    if (sourceLatLng != null && destLatLng != null) {
      var list = [sourceLatLng, destLatLng];
      CameraUpdate u2 =
          CameraUpdate.newLatLngBounds(boundsFromLatLngList(list), 50);
      _mapController.animateCamera(u2).then((void v) {
        check(u2, _mapController);
      });
    }

    setMapPins();
    setPolylines();
  }

/*  void onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);

  }*/
  void setSourceAndDestinationIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), Res.ic_rider);
    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), Res.ic_placeholder);
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);

    // updatePinOnMap();

    // onMapCreated(_mapController);

    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  googleMap(),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                            padding: EdgeInsets.only(top: 50, left: 16),
                            child: Image.asset(
                              Res.ic_back,
                              width: 16,
                              height: 16,
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16, top: 50),
                        child: Text(
                          "Location",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(13)),
                        margin:
                            EdgeInsets.only(left: 16, right: 16, bottom: 16),
                        width: double.infinity,
                        height: 150,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                print(widget.orderitems_id);
                                print(widget.orderid);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(left: 16, top: 16),
                                child: Text(
                                  "Delivery Address",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 16, top: 16),
                                child: Text(
                                  widget.deliveryAddress,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  void setMapPins() {
    setState(() {
      // source pin
      _markers.clear();
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: SOURCE_LOCATION,
          icon: sourceIcon));
      // destination pin
      _markers.add(Marker(
          markerId: MarkerId('destPin'),
          position: DEST_LOCATION,
          icon: destinationIcon));
    });
  }

  setPolylines() async {
/*    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(googleAPIKey, PointLatLng( SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude),
        PointLatLng( DEST_LOCATION.latitude, DEST_LOCATION.longitude),

        travelMode: TravelMode.driving,
        wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]
    );
    if (result.points.isNotEmpty) {
         result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }*/
    polylineCoordinates2.clear();
    _polylines2.clear();
    List<PointLatLng> result = (await polylinePoints.getRouteBetweenCoordinates(
        googleAPIKey,
        PointLatLng(SOURCE_LOCATION.latitude,
        SOURCE_LOCATION.longitude),
        PointLatLng(DEST_LOCATION.latitude,
        DEST_LOCATION.longitude))) as List;
/*    List<PointLatLng> result = (await polylinePoints.getRouteBetweenCoordinates(googleAPIKey, double.parse(kitchenlat),double.parse(kitchenlong), double.parse(deliverylatitude),double.parse(deliverylongitude),));*/
    if (result.isNotEmpty) {
      // loop through all PointLatLng points and convert them
      // to a list of LatLng, required by the Polyline
      result.forEach((PointLatLng point) {
        polylineCoordinates2.add(LatLng(point.latitude, point.longitude));
        polylineCoordinates = polylineCoordinates2;
        print(polylineCoordinates.length.toString() + '45454646546464646');
      });
    }

    setState(() {
      // create a Polyline instance
      // with an id, an RGB color and the list of LatLng pairs
      Polyline polyline = Polyline(
          width: 4,
          polylineId: PolylineId("poly"),
          color: Color.fromARGB(255, 40, 122, 198),
          points: polylineCoordinates);

      // add the constructed polyline as a set of points
      // to the polyline set, which will eventually
      // end up showing up on the map
      _polylines2.add(polyline);
      _polylines = _polylines2;
    });
  }

  Future<BeanStartDelivery> getStartDelivery(
      BuildContext context,
      String orderid,
      String orderitems_id,
      String latitute,
      String longitude) async {
    try {
      var user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "token": "123456789",
        "kitchen_id": user.data.id,
        "order_id": orderid,
        'orderitems_id': orderitems_id,
      });
      BeanStartDelivery bean = await ApiProvider().updateOrderTrack(from);
      print(bean.data);
      if (bean.status == true) {
        data = bean.data;
        setState(() {
/*          kitchenlat=double.parse(bean.data[0].kitchenlatitude);
          kitchenlong=double.parse(bean.data[0].kitchenlongitude);
          deliverylatitude=double.parse(bean.data[0].deliverylatitude);
          deliverylongitude=double.parse(bean.data[0].deliverylongitude);*/

          SOURCE_LOCATION = LatLng(double.parse(bean.data[0].riderLatitude),
              double.parse(bean.data[0].riderLongitude));

          DEST_LOCATION = LatLng(double.parse(bean.data[0].deliverylatitude),
              double.parse(bean.data[0].deliverylongitude));

          print("latjhhlong" + deliverylatitude.toString());
        });
        return bean;
      } else {
        Utils.showToast(bean.message);
      }

      return null;
    } on HttpException catch (exception) {
      print(exception);
    } catch (exception) {
      print(exception);
    }
  }

  // Future Delivered(
  //     BuildContext context, String orderid, String orderitems_id) async {
  //   try {
  //     var user = await Utils.getUser();
  //     FormData from = FormData.fromMap({
  //       "userid": user.data.userId,
  //       "orderid": orderid,
  //       "token": "123456789",
  //       'orderitems_id': orderitems_id
  //     });
  //     await _locationSubscription.cancel();
  //     var bean = await ApiProvider().delivered(from);
  //     print(bean['data']);
  //     if (bean['status'] == true) {
  //       setState(() {
  //         Navigator.pushAndRemoveUntil(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) => TripSummaryScreen(orderid: orderid)),
  //             (route) => false);
  //       });
  //       return bean;
  //     } else {
  //       Utils.showToast(bean.message);
  //     }
  //
  //     return null;
  //   } on HttpException catch (exception) {
  //     print(exception);
  //   } catch (exception) {
  //     print(exception);
  //   }
  // }

  googleMap() {
    if (data != null) {
      setState(() {});
      return GoogleMap(
          myLocationEnabled: false,
          compassEnabled: false,
          tiltGesturesEnabled: false,
          markers: _markers,
          polylines: _polylines,
          mapType: MapType.normal,
          zoomControlsEnabled: true,
          myLocationButtonEnabled: false,
          onMapCreated: onMapCreated,
          initialCameraPosition: _cameraPosition
          /*CameraPosition(
             zoom: CAMERA_ZOOM,
             bearing: CAMERA_BEARING,
             tilt: CAMERA_TILT,
             target: SOURCE_LOCATION

         ),*/
          );
    } else {
      return Container();
    }
  }

  updatePinOnMap() async {
    // // create a new CameraPosition instance
    // // every time the location changes, so the camera
    // // follows the pin as it moves with an animation
    // CameraPosition cPosition = CameraPosition(
    //   zoom: CAMERA_ZOOM,
    //   tilt: CAMERA_TILT,
    //   bearing: CAMERA_BEARING,
    //   target: LatLng(currentLocation.latitude, currentLocation.longitude),
    // );
    // final GoogleMapController controller = await _controller.future;
    // controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
    // // do this inside the setState() so Flutter gets notified
    // // that a widget update is due
    // setState(() {
    //   // updated position
    //   var pinPosition = LatLng(currentLocation.latitude, currentLocation.longitude);
    //
    //   sourcePinInfo.location = pinPosition;
    //
    //   // the trick is to remove the marker (by id)
    //   // and add it again at the updated location
    //   _markers.removeWhere((m) => m.markerId.value == 'sourcePin');
    //   _markers.add(Marker(
    //       markerId: MarkerId('sourcePin'),
    //       onTap: () {
    //         setState(() {
    //           currentlySelectedPin = sourcePinInfo;
    //           pinPillPosition = 0;
    //         });
    //       },
    //       position: pinPosition, // updated position
    //       icon: sourceIcon));
    // });

    _cameraPosition = CameraPosition(
      zoom: cameraZOOM,
      tilt: cameraTILT,
      bearing: cameraBEARING,
      target: LatLng(SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude),
    );

    _mapController
        .animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));

    setState(() {
      _markers.removeWhere((m) => m.markerId.value == "sourcePin");
      _markers.add(
        Marker(
            markerId: MarkerId("sourcePin"),
            position:
                LatLng(SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude),
            flat: true,
            anchor: Offset(0.5, 0.5),
            infoWindow: InfoWindow(title: "first"),
            icon: sourceIcon),
      );
    });
  }

  Future _listenLocation() async {
    print("updatePinOnMap");
    _locationSubscription =
        _locationTracker.onLocationChanged.handleError((dynamic err) {
      setState(() {
        _error = err.code;
      });
      _locationSubscription.cancel();
    }).listen((LocationData currentLocation) {
      _error = null;
      future = getStartDelivery(
          context,
          widget.orderid,
          widget.orderitems_id,
          currentLocation.latitude.toString(),
          currentLocation.longitude.toString());
      updatePinOnMap();
      setMapPins();
      setPolylines();
    });
  }

  LatLngBounds boundsFromLatLngList(List<LatLng> list) {
    assert(list.isNotEmpty);
    double x0, x1, y0, y1;
    for (LatLng latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1) y1 = latLng.longitude;
        if (latLng.longitude < y0) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(northeast: LatLng(x1, y1), southwest: LatLng(x0, y0));
  }

  void check(CameraUpdate u, GoogleMapController c) async {
    c.animateCamera(u);
    // _mapController.animateCamera(u);
    LatLngBounds l1 = await c.getVisibleRegion();
    LatLngBounds l2 = await c.getVisibleRegion();
    print(l1.toString());
    print(l2.toString());
    if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90)
      check(u, c);
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }
}
