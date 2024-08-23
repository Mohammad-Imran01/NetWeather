#ifndef WEATHERMODEL_H
#define WEATHERMODEL_H

#include "weathervariables.h"

#include <QAbstractListModel>
#include <QString>
#include <QVector>
#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>

using namespace wa;

class WeatherModel : public QAbstractListModel {
    Q_OBJECT

public:
    enum WeatherRoles {
        RoleDay = Qt::UserRole + 1,
        RoleMinTemp,
        RoleMaxTemp,
        RoleWeatherType
    };

    WeatherModel(QObject *parent = nullptr);

    void setWeather(const QList<wa::WeatherInfo> &data);
    void addWeather(const WeatherInfo &weather);
    void clear();

    Qt::ItemFlags flags(const QModelIndex &index) const;
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE void urlhandler(const QString &url_);
    void onFinished(QNetworkReply *reply);
    void parseWeatherDaysData(const QByteArray &data);


signals:
    void urlAvailable(const QString&);
private:
    QList<WeatherInfo> m_data;
    QNetworkAccessManager manager;
};

#endif // WEATHERMODEL_H
