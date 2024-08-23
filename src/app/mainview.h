#ifndef MAINVIEW_H
#define MAINVIEW_H

#include <QObject>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickItem>
#include <QStringLiteral>

#include "src/data/weathermodel.h"
#include "src/data/datahandler.h"

class MainView : public QQmlApplicationEngine
{
    Q_OBJECT
public:
    explicit MainView(const QString &fileAddress, QObject *parent = nullptr);
    ~MainView();

private:
    void connectSlots();
    void startHandler(QObject *object, const QUrl &url);
    WeatherModel* weatherModel = nullptr;
    QQuickItem* qRoot = nullptr;
    QQmlContext* qContext = nullptr;
    DataHandler* dataHandler = nullptr;
};

#endif // MAINVIEW_H
