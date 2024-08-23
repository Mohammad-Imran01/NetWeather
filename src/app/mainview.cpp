#include "mainview.h"
#include <QCoreApplication>
#include <QQuickItem>

MainView::MainView(const QString& fileAddress, QObject *parent)
    : QQmlApplicationEngine(parent)
    , weatherModel(new WeatherModel(this))
    , dataHandler(new DataHandler(this))
{
    // Connect slots before loading QML
    connectSlots();

    if (rootContext()) {
        rootContext()->setContextProperty("weatherModel", weatherModel);
        rootContext()->setContextProperty("dataHandler", dataHandler);
    }

    // Load the QML file
    load(QUrl(/*QStringLiteral("qrc:/main.qml")*/fileAddress));

    // Now that QML is loaded, get the root object
    qRoot = rootObjects().isEmpty() ? nullptr : qobject_cast<QQuickItem*>(rootObjects().first());
}

MainView::~MainView()
{
    delete weatherModel;
    delete dataHandler; // Ensure dataHandler is also deleted
}

void MainView::connectSlots()
{
    connect(this, &MainView::objectCreated, this, &MainView::startHandler);
}

void MainView::startHandler(QObject *object, const QUrl &url)
{
    if (!object && url == QUrl(QStringLiteral("qrc:/main.qml"))) {
        qWarning() << "Failed to load QML file:" << url;
        QCoreApplication::exit(-1);
    }
}
