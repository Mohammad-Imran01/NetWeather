#ifndef DATAHANDLER_H
#define DATAHANDLER_H


#include "src/data/weathervariables.h"

#include <QObject>
#include <QString>
#include <QVector>
#include <QObject>
#include <QJsonArray>
#include <QJsonObject>
#include <QNetworkReply>
#include <QJsonDocument>
#include <QAbstractListModel>
#include <QNetworkAccessManager>

#define API_KEY_OPEN_WEATHER "50977a629137b9412dc80f4210270f3c"
#define OPEN_WEATHER_MAP_REQUEST "https://tile.openweathermap.org/map/%1/%2/%3/%4.png?appid=%5"

// using namespace wa;
class DataHandler : public QObject
{
    Q_OBJECT
    // Q_PROPERTY(MainPageData_St_t mainPageData MEMBER m_mainPageData)
    Q_PROPERTY(double varTemperature_2m       MEMBER m_Temperature_2m      )
    Q_PROPERTY(int    varRelative_humidity_2m MEMBER m_Relative_humidity_2m)
    Q_PROPERTY(double varApparent_temperature MEMBER m_Apparent_temperature)
    Q_PROPERTY(int    varIs_day               MEMBER m_Is_day              )
    Q_PROPERTY(int    varPrecipitation        MEMBER m_Precipitation       )
    Q_PROPERTY(double varRain                 MEMBER m_Rain                )
    Q_PROPERTY(int    varShowers              MEMBER m_Showers             )
    Q_PROPERTY(int    varSnowfall             MEMBER m_Snowfall            )
    Q_PROPERTY(int    varWeather_code         MEMBER m_Weather_code        )
    Q_PROPERTY(int    varCloud_cover          MEMBER m_Cloud_cover         )
    Q_PROPERTY(int    varPressure_msl         MEMBER m_Pressure_msl        )
    Q_PROPERTY(double varSurface_pressure     MEMBER m_Surface_pressure    )
    Q_PROPERTY(double varWind_speed_10m       MEMBER m_Wind_speed_10m      )
    Q_PROPERTY(int    varWind_direction_10m   MEMBER m_Wind_direction_10m  )
    Q_PROPERTY(int    varWind_gusts_10m       MEMBER m_Wind_gusts_10m      )

    Q_PROPERTY(QString varIconType READ varIconType WRITE setVarIconType NOTIFY varIconTypeChanged FINAL)

    Q_PROPERTY(bool dataAvailable READ dataAvailable WRITE setDataAvailable NOTIFY dataAvailableChanged FINAL)

    Q_PROPERTY(QStringList latlongSearchResult READ latlongSearchResult WRITE setLatlongSearchResult NOTIFY latlongSearchResultChanged FINAL)

public:
    explicit DataHandler(QObject *parent = nullptr);
    void onFinished(QNetworkReply *reply);

    Q_INVOKABLE void urlhandler(const QString &url_);
    Q_INVOKABLE void setIconVal(const QString& lat, const QString& lon);
    bool dataAvailable() const;
    void setDataAvailable(bool newDataAvailable);

    QString varIconType() const;
    void setVarIconType(const QString &newVarIconType);


    Q_INVOKABLE void getLanLon(const QString& city, const QString& state = "", const QString& country = "") {
        QString query = city.trimmed();
        if (!state.isEmpty()) {
            query += "," + state.trimmed();
        }
        if (!country.isEmpty()) {
            query += "," + country.trimmed();
        }

        QString apiUrl = openWeatherLink + QString("/geo/1.0/direct?q=%1&limit=%2&appid=%3").arg(query).arg(20).arg(API_KEY_OPEN_WEATHER);
        queryLatLon.get(QNetworkRequest(QUrl(apiUrl)));
        qWarning() << Q_FUNC_INFO << apiUrl;
    }


    QStringList latlongSearchResult() const;
    void setLatlongSearchResult(const QStringList &newLatlongSearchResult);

private:
    double  m_Temperature_2m      ;
    int     m_Relative_humidity_2m;
    double  m_Apparent_temperature;
    int     m_Is_day              ;
    int     m_Precipitation       ;
    double  m_Rain                ;
    int     m_Showers             ;
    int     m_Snowfall            ;
    int     m_Weather_code        ;
    int     m_Cloud_cover         ;
    int     m_Pressure_msl        ;
    double  m_Surface_pressure    ;
    double  m_Wind_speed_10m      ;
    int     m_Wind_direction_10m  ;
    int     m_Wind_gusts_10m      ;

signals:

    void dataAvailableChanged();

    void varIconTypeChanged();

    void latlongSearchResultChanged();

private:
    void parseCurrentData(const QByteArray& data);
    void parseIconData(QNetworkReply *reply);
    void parseLatLongData(QNetworkReply* reply);
    QNetworkAccessManager
        manager,
        openWeatherManager,
        queryLatLon//openWeather GeoCoding API
        ;
    // MainPageData_St_t m_mainPageData;
    bool m_dataAvailable;

    const QString openWeatherLink ="https://api.openweathermap.org";
    QString m_varIconType;
    QStringList m_latlongSearchResult;
};

#endif // DATAHANDLER_H
