#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QIcon>
#include <QQuickStyle>

#include "src/app/mainview.h"
#include "src/data/datahandler.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QQuickStyle::setStyle("Material");  // Set the style to Material (or Fusion, Basic, etc.)

    QGuiApplication app(argc, argv);

    // Set the application icon
    app.setWindowIcon(QIcon(":/images/appIcon.svg"));

    // Register QML types
    qmlRegisterSingletonType(QUrl(QStringLiteral("qrc:/AppStyle.qml")), "AppStyle", 1, 0, "AppStyle");
    qmlRegisterSingletonType(QUrl(QStringLiteral("qrc:/FontStyle.qml")), "FontStyle", 1, 0, "FontStyle");
    qmlRegisterType<DataHandler>("DataHandler", 1, 0, "DataHandler");

    QString mainQml("qrc:/main.qml");
    MainView mainView(mainQml);

    // QString helpQml("qrc:/Help.qml");
    // MainView mainView(helpQml);

    // Start the application event loop
    return app.exec();
}
