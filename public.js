
function addUnit(val, valSize, unit='°') {
    return `<span style="font-size:${valSize}px">${val}</span>` +
            `<span style="font-size:${unit === '°' ? valSize : Math.floor(valSize * 0.86)}px">${unit}</span>`;
}


function getOpenWeather_APIKEY() {
    return "50977a629137b9412dc80f4210270f3c"
}

function openWeatherMapRequestlink(x, y, z, layer, apiKey) {
    return `https://tile.openweathermap.org/map/${layer}/${z}/${x}/${y}.png?appid=${apiKey}`;
}

var varDailyProperties = [
            "temperature_2m",
            "relative_humidity_2m",
            "apparent_temperature",
            "is_day",
            "precipitation",
            "rain",
            "showers",
            "snowfall",
            "weather_code",
            "cloud_cover",
            "pressure_msl",
            "surface_pressure",
            "wind_speed_10m",
            "wind_direction_10m",
            "wind_gusts_10m",
        ]
var constMateoLink = "https://api.open-meteo.com"
