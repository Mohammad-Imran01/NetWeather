#include "datahandler.h"



DataHandler::DataHandler(QObject *parent)
    : QObject{parent}
{
    connect(&manager, &QNetworkAccessManager::finished, this, &DataHandler::onFinished);
    connect(&openWeatherManager, &QNetworkAccessManager::finished, this, &DataHandler::parseIconData);
    connect(&queryLatLon, &QNetworkAccessManager::finished, this, &DataHandler::parseLatLongData);
}

void DataHandler::onFinished(QNetworkReply *reply) {
    if (reply->error() == QNetworkReply::NoError) {
        QByteArray data = reply->readAll();

        // qWarning() << Q_FUNC_INFO << "Data readed length: " << data.size();// << data;

        parseCurrentData(data);
    } else {
        qWarning() << "Error:" << reply->errorString();
    }
    reply->deleteLater();
}

void DataHandler::urlhandler(const QString &url_) {
    manager.get(QNetworkRequest(QUrl(url_)));

    qDebug() << Q_FUNC_INFO << "Handling New URL: " << url_;
}

void DataHandler::setIconVal(const QString &lat, const QString &lon) {
    QString apiUrl = openWeatherLink + QString("/data/2.5/weather?lat=%1&lon=%2&appid=%3").arg(lat).arg(lon).arg(API_KEY_OPEN_WEATHER);

    openWeatherManager.get(QNetworkRequest(QUrl(apiUrl)));

    // qWarning() << Q_FUNC_INFO << "str for icon: " << apiUrl;
}

void DataHandler::parseIconData(QNetworkReply *reply) {
    if (reply->error() == QNetworkReply::NoError) {
        QByteArray data = reply->readAll();

        // qWarning() << Q_FUNC_INFO << "Data for icon read length: " << data.size();

        QJsonDocument jsonDoc = QJsonDocument::fromJson(data);

        if (!jsonDoc.isNull()) {
            QJsonObject jsonObj = jsonDoc.object();

            if (jsonObj.contains("weather") && jsonObj["weather"].isArray()) {
                QJsonArray weatherArray = jsonObj["weather"].toArray();
                if (!weatherArray.isEmpty()) {
                    QJsonObject weatherObj = weatherArray.first().toObject();
                    if (weatherObj.contains("icon") && weatherObj["icon"].isString()) {
                        setVarIconType(weatherObj["icon"].toString());
                        reply->deleteLater();
                        return;
                    }
                }
            }
        }
        qWarning() << Q_FUNC_INFO << "Error in icon data";
    } else {
        qWarning() << "Error&reason:" << reply->errorString();
    }
    reply->deleteLater();
}

void DataHandler::parseLatLongData(QNetworkReply *reply)
{
    if (reply->error() == QNetworkReply::NoError) {
        QByteArray data = reply->readAll();

        // qWarning() << Q_FUNC_INFO << "Data for icon read length: " << data.size();

        QJsonDocument jsonDoc = QJsonDocument::fromJson(data);

        if (!jsonDoc.isNull()) {
            QJsonArray jsonArray = jsonDoc.array();
            QStringList results;

            for (const QJsonValue &value : jsonArray) {
                QJsonObject jsonObj = value.toObject();
                QString name = jsonObj["name"].toString();
                QString state = jsonObj.contains("state") ? jsonObj["state"].toString() : "";
                QString country = jsonObj["country"].toString();
                double lat = jsonObj["lat"].toDouble();
                double lon = jsonObj["lon"].toDouble();
                QString result = QString("%1, %2, %3: %4, %5").arg(name, state, country).arg(lat).arg(lon);
                results.append(result);
                qDebug() << result
                    ;
            }

            setLatlongSearchResult(results);
        }
    }
}


void DataHandler::parseCurrentData(const QByteArray &data)
{
    // reset();
    QJsonDocument jsonDoc = QJsonDocument::fromJson(data);

    if (jsonDoc.isNull()) {
        qWarning() << Q_FUNC_INFO << "Data is empty.";
        emit dataAvailableChanged();
        return;
    }

    QJsonObject jsonObj = jsonDoc.object();

    double lat = 0, lon = 0, genTime_ms = 0, utcOffset = 0;
    QString timezone, timezone_abbreviation;
    int elevation = 0;

    if (jsonObj.contains("latitude") && jsonObj["latitude"].isDouble())
        lat = jsonObj["latitude"].toDouble();

    if (jsonObj.contains("longitude") && jsonObj["longitude"].isDouble())
        lon = jsonObj["longitude"].toDouble();

    if (jsonObj.contains("generationtime_ms") && jsonObj["generationtime_ms"].isDouble())
        genTime_ms = jsonObj["generationtime_ms"].toDouble();

    if (jsonObj.contains("utc_offset_seconds") && jsonObj["utc_offset_seconds"].isDouble())
        utcOffset = jsonObj["utc_offset_seconds"].toDouble();

    if (jsonObj.contains("timezone") && jsonObj["timezone"].isString())
        timezone = jsonObj["timezone"].toString();

    if (jsonObj.contains("timezone_abbreviation") && jsonObj["timezone_abbreviation"].isString())
        timezone_abbreviation = jsonObj["timezone_abbreviation"].toString();

    if (jsonObj.contains("elevation") && jsonObj["elevation"].isDouble())
        elevation = jsonObj["elevation"].toDouble();


    // qDebug ()
    //     << "lat: "                    << lat
    //     << "lon: "                    << lon
    //     << "genTime_ms: "             << genTime_ms
    //     << "utcOffset: "              << utcOffset
    //     << "timezone: "               << timezone
    //     << "timezone_abbreviation: "  << timezone_abbreviation
    //     << "elevation: "              << elevation;

    // Parsing current data units
    if (jsonObj.contains("current_units") && jsonObj["current_units"].isObject()) {
        QJsonObject unitsObj = jsonObj["current_units"].toObject();
        // qDebug() << Q_FUNC_INFO << "Contains unit";
    } else {
        qWarning() << Q_FUNC_INFO << "No units related data";
    }

    // Parsing current data
    if (jsonObj.contains("current") && jsonObj["current"].isObject()) {
        QJsonObject dataObj = jsonObj["current"].toObject();

        if (dataObj.contains("temperature_2m") && dataObj["temperature_2m"].isDouble())
            m_Temperature_2m = dataObj["temperature_2m"].toDouble();

        if (dataObj.contains("relative_humidity_2m") && dataObj["relative_humidity_2m"].isDouble())
            m_Relative_humidity_2m = dataObj["relative_humidity_2m"].toDouble();

        if (dataObj.contains("apparent_temperature") && dataObj["apparent_temperature"].isDouble())
            m_Apparent_temperature = dataObj["apparent_temperature"].toDouble();

        if (dataObj.contains("is_day") && dataObj["is_day"].isDouble())
            m_Is_day = dataObj["is_day"].toDouble();

        if (dataObj.contains("precipitation") && dataObj["precipitation"].isDouble())
            m_Precipitation = dataObj["precipitation"].toDouble();

        if (dataObj.contains("rain") && dataObj["rain"].isDouble())
            m_Rain = dataObj["rain"].toDouble();

        if (dataObj.contains("showers") && dataObj["showers"].isDouble())
            m_Showers = dataObj["showers"].toDouble();

        if (dataObj.contains("snowfall") && dataObj["snowfall"].isDouble())
            m_Snowfall = dataObj["snowfall"].toDouble();

        if (dataObj.contains("weather_code") && dataObj["weather_code"].isDouble())
            m_Weather_code = dataObj["weather_code"].toDouble();

        if (dataObj.contains("cloud_cover") && dataObj["cloud_cover"].isDouble())
            m_Cloud_cover = dataObj["cloud_cover"].toDouble();

        if (dataObj.contains("pressure_msl") && dataObj["pressure_msl"].isDouble())
            m_Pressure_msl = dataObj["pressure_msl"].toDouble();

        if (dataObj.contains("surface_pressure") && dataObj["surface_pressure"].isDouble())
            m_Surface_pressure = dataObj["surface_pressure"].toDouble();

        if (dataObj.contains("wind_speed_10m") && dataObj["wind_speed_10m"].isDouble())
            m_Wind_speed_10m = dataObj["wind_speed_10m"].toDouble();

        if (dataObj.contains("wind_direction_10m") && dataObj["wind_direction_10m"].isDouble())
            m_Wind_direction_10m = dataObj["wind_direction_10m"].toDouble();

        if (dataObj.contains("wind_gusts_10m") && dataObj["wind_gusts_10m"].isDouble())
            m_Wind_gusts_10m = dataObj["wind_gusts_10m"].toDouble();

        // if (dataObj.contains("time") && dataObj["time"].isString())
        //     qDebug() << Q_FUNC_INFO << dataObj["time"].toString();

        // if (dataObj.contains("interval") && dataObj["interval"].isDouble())
        //     qDebug() << Q_FUNC_INFO << dataObj["interval"].toDouble();
    }

    emit dataAvailableChanged();
}


bool DataHandler::dataAvailable() const
{
    return m_dataAvailable;
}

void DataHandler::setDataAvailable(bool newDataAvailable)
{
    if (m_dataAvailable == newDataAvailable)
        return;
    m_dataAvailable = newDataAvailable;
    emit dataAvailableChanged();
}

QString DataHandler::varIconType() const
{
    return m_varIconType;
}

void DataHandler::setVarIconType(const QString &newVarIconType)
{
    if (m_varIconType == newVarIconType)
        return;
    m_varIconType = newVarIconType;
    emit varIconTypeChanged();
}

QStringList DataHandler::latlongSearchResult() const
{
    return m_latlongSearchResult;
}

void DataHandler::setLatlongSearchResult(const QStringList &newLatlongSearchResult)
{
    if (m_latlongSearchResult == newLatlongSearchResult)
        return;
    m_latlongSearchResult = newLatlongSearchResult;
    emit latlongSearchResultChanged();
}
