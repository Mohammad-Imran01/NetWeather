#include "weathermodel.h"

#include <QDebug>

WeatherModel::WeatherModel(QObject *parent)
    : QAbstractListModel(parent)
{
    connect(&manager, &QNetworkAccessManager::finished, this, &WeatherModel::onFinished);
    connect(this, &WeatherModel::urlAvailable, this, &WeatherModel::urlhandler);
}

void WeatherModel::setWeather(const QList<WeatherInfo> &data) {
    beginResetModel();
    m_data = data;
    endResetModel();
}

void WeatherModel::addWeather(const WeatherInfo &weather) {
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_data << weather;
    endInsertRows();
}

void WeatherModel::clear() {
    if (rowCount() > 0) {
        beginRemoveRows(QModelIndex(), 0, rowCount() - 1);
        m_data.clear();
        endRemoveRows();
    }
}

Qt::ItemFlags WeatherModel::flags(const QModelIndex &index) const {
    if (!index.isValid())
        return Qt::NoItemFlags;
    return Qt::ItemIsEnabled | Qt::ItemIsSelectable;
}

int WeatherModel::rowCount(const QModelIndex &parent) const {
    if (parent.isValid())
        return 0;
    return m_data.count();
}

QVariant WeatherModel::data(const QModelIndex &index, int role) const {
    if (!index.isValid())
        return QVariant();

    const WeatherInfo &weather = m_data[index.row()];

    switch (role) {

    case RoleDay:
        return weather.day;
    case RoleMinTemp:
        return weather.minTemp;
    case RoleMaxTemp:
        return weather.maxTemp;
    case RoleWeatherType:
        return weather.weatherType;

    default:
        return QVariant();
    }
}

QHash<int, QByteArray> WeatherModel::roleNames() const {
    QHash<int, QByteArray> roles;

    roles[RoleDay] = "day";
    roles[RoleMinTemp] = "minTemp";
    roles[RoleMaxTemp] = "maxTemp";
    roles[RoleWeatherType] = "weatherType";

    return roles;
}

void WeatherModel::urlhandler(const QString &url_) {
    manager.get(QNetworkRequest(QUrl(url_)));
    // QUrl url(url_);
    // QNetworkRequest request(url);
    // manager.get(request);

    // qDebug() << Q_FUNC_INFO << "Handling New URL!";
}
void WeatherModel::onFinished(QNetworkReply *reply) {
    if (reply->error() == QNetworkReply::NoError) {
        QByteArray data = reply->readAll();

        // qWarning() << Q_FUNC_INFO << "Data readed length: " << data.size();// << data;
        // parseWeatherData(data);
        parseWeatherDaysData(data);
    } else {
        qWarning() << "Error:" << reply->errorString();
    }
    reply->deleteLater();
}
void WeatherModel::parseWeatherDaysData(const QByteArray &data) {
    clear();
    QJsonDocument jsonDoc = QJsonDocument::fromJson(data);
    if (!jsonDoc.isNull()) {
        QJsonObject jsonObj = jsonDoc.object();

        if (jsonObj.contains("daily") && jsonObj["daily"].isObject()) {
            QJsonObject dailyObj = jsonObj["daily"].toObject();

            if (dailyObj.contains("time") && dailyObj["time"].isArray() &&
                dailyObj.contains("weather_code") && dailyObj["weather_code"].isArray() &&
                dailyObj.contains("temperature_2m_max") && dailyObj["temperature_2m_max"].isArray() &&
                dailyObj.contains("temperature_2m_min") && dailyObj["temperature_2m_min"].isArray()) {

                QJsonArray
                    timeArray = dailyObj["time"].toArray(),
                    weatherCodeArray = dailyObj["weather_code"].toArray(),
                    maxTempArray = dailyObj["temperature_2m_max"].toArray(),
                    minTempArray = dailyObj["temperature_2m_min"].toArray();

                int arraySize = qMin(qMin(timeArray.size(), weatherCodeArray.size()), qMin(maxTempArray.size(), minTempArray.size()));
                for (int i = 0; i < arraySize; ++i) {
                    wa::WeatherInfo info;
                    info.day = timeArray[i].toString();

                    int weatherCode = weatherCodeArray[i].toInt();
                    auto it = wa::weatherCodes.find(weatherCode);
                    if (it != wa::weatherCodes.end()) {
                        info.weatherType = it.value();  // Assign the corresponding weather type description
                    } else {
                        info.weatherType = QString::number(weatherCode);  // Fallback to the code itself if not found
                    }

                    info.maxTemp = QString::number(maxTempArray[i].toDouble()) + " °C";
                                                                                 info.minTemp = QString::number(minTempArray[i].toDouble()) + " °C";
                          // m_data.append(info);
                          addWeather(info);
                    // qDebug()<< "day" << m_data[i].day
                    //          << "weatherCodes" << m_data[i].weatherType
                    //          << "maxTemp" << m_data[i].maxTemp
                    //          << "minTemp" << m_data[i].minTemp;
                }
            } else {
                qWarning() << Q_FUNC_INFO << "One or more required arrays (time, weather_code, temperature_2m_max, temperature_2m_min) are missing or not arrays.";
            }
        } else {
            qWarning() << Q_FUNC_INFO << "Key 'daily' is missing or not an object.";
        }
    } else {
        qWarning() << Q_FUNC_INFO << "Failed to parse JSON data.";
    }
    // emit dataAvailable(m_data);
}
