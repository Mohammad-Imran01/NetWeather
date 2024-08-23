// weathercodes.h

#ifndef WEATHERCODES_H
#define WEATHERCODES_H

#include <QMap>
#include <QString>
#include <QObject>



namespace wa {
extern QMap<int, QString> weatherCodes;
struct WeatherInfo {
    QString day;
    QString minTemp,maxTemp;
    QString weatherType;
};

struct MainPageData_St_t {
//     Q_GADGET
// public:


//     void reset() {
//         m_Temperature_2m       = -1;
//         m_Relative_humidity_2m = -1;
//         m_Apparent_temperature = -1;
//         m_Is_day               = -1;
//         m_Precipitation        = -1;
//         m_Rain                 = -1;
//         m_Showers              = -1;
//         m_Snowfall             = -1;
//         m_Weather_code         = -1;
//         m_Cloud_cover          = -1;
//         m_Pressure_msl         = -1;
//         m_Surface_pressure     = -1;
//         m_Wind_speed_10m       = -1;
//         m_Wind_direction_10m   = -1;
//         m_Wind_gusts_10m       = -1;
//     }
//     bool operator==(const MainPageData_St_t &other) const {return m_Temperature_2m == other.m_Temperature_2m;}
//     bool operator!=(const MainPageData_St_t &other) const {return !(this == other);}
};

} // namespace wa


// Q_DECLARE_METATYPE(wa::MainPageData_St_t)


#endif // WEATHERCODES_H

