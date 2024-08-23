import QtQuick 2.0

Item {
    id: container

    property string weatherIcon: "01d"

    onWeatherIconChanged: {
        console.log("New Icon type: " + weatherIcon)
    }

    property bool useServerIcon: false // true

    Image {
        id: img
        source: {
            if (useServerIcon) {
                return "http://openweathermap.org/img/w/" + container.weatherIcon + ".png";
            } else {
                switch (weatherIcon) {
                case "01d":
                case "01n":
                    return "qrc:/images/icons/weather-sunny.png";
                case "02d":
                case "02n":
                    return "qrc:/images/icons/weather-sunny-very-few-clouds.png";
                case "03d":
                case "03n":
                    return "qrc:/images/icons/weather-few-clouds.png";
                case "04d":
                case "04n":
                    return "qrc:/images/icons/weather-overcast.png";
                case "09d":
                case "09n":
                    return "qrc:/images/icons/weather-showers.png";
                case "10d":
                case "10n":
                    return "qrc:/images/icons/weather-showers.png";
                case "11d":
                case "11n":
                    return "qrc:/images/icons/weather-thundershower.png";
                case "13d":
                case "13n":
                    return "qrc:/images/icons/weather-snow.png";
                case "50d":
                case "50n":
                    return "qrc:/images/icons/weather-fog.png";
                default:
                    return "qrc:/images/icons/weather-unknown.png";
                }
            }
        }
        smooth: true
        anchors.fill: parent
    }
}
