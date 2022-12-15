import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MapLauncherDemo());

class MapLauncherDemo extends StatelessWidget {
  openMapsSheet(context) async {
    try {
      final coords = Coords(37.759392, -122.5107336);
      final title = "Ocean Beach";
      final availableMaps = await MapLauncher.installedMaps;

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    for (var map in availableMaps)
                      ListTile(
                        onTap: () => map.showDirections(
                          origin:Coords(30.075800, 31.344603) ,
                            directionsMode: DirectionsMode.driving,
                            destination: Coords(30.079012, 31.346609),
                            waypoints: []),
                        title: Text(map.mapName),
                        leading: SvgPicture.asset(
                          map.icon,
                          height: 30.0,
                          width: 30.0,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Map Launcher Demo'),
        ),
        body: Center(child: Builder(
          builder: (context) {
            return MaterialButton(
              onPressed: () async {
                final availableMaps = await MapLauncher.installedMaps;
                for (var map in availableMaps){
                  map.showDirections(
                      origin:Coords(30.075800, 31.344603) ,
                      directionsMode: DirectionsMode.driving,
                      destination: Coords(30.079012, 31.346609),
                      waypoints: []);
                }

              },
              child: Text('Show Maps'),
            );
          },
        )),
      ),
    );
  }
}
