import QtQuick 2.15
import QtLocation 5.15
import QtPositioning 5.15

Item {
    width: 800
    height: 600

    Map {
        id: map
        anchors.fill: parent

        plugin: Plugin {
            name: "osm" // OpenStreetMap plugin
        }

        // Center the map
        center: QtPositioning.coordinate(0, 0) // You can set this to your desired location
        zoomLevel: 2 // Adjust as necessary

        // Custom map tile source
        MapItemView {
            model: COpenWeatherMap {
                id: tileModel

                layer: "precipitation_new" // Change this to the desired layer

                function tileUrl(x, y, z) {
                    return `https://tile.openweathermap.org/map/${layer}/${z}/${x}/${y}.png?appid=${apiKey}`;
                }
            }

            delegate: MapQuickItem  {
                sourceItem: model.tileUrl(tile.x, tile.y, tile.z)
                anchors.centerIn: parent
                coordinate: tile.coordinate
                opacity: 0.7 // Adjust opacity as needed
            }
        }
    }
}
