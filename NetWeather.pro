

QT  += core gui webenginecore quick qml webenginewidgets webenginequick quickcontrols2

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0
QMAKE_PROJECT_DEPTH = 0

SOURCES += \
    src/app/mainview.cpp \
    src/data/datahandler.cpp \
    src/data/weathermodel.cpp \
    src/data/weathervariables.cpp \
    src/main.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    src/app/mainview.h \
    src/data/datahandler.h \
    src/data/weathermodel.h \
    src/data/weathervariables.h

DISTFILES +=
