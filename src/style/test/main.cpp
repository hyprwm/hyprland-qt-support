#include <qcoreapplication.h>
#include <qguiapplication.h>
#include <qobject.h>
#include <qnamespace.h>
#include <qqmlapplicationengine.h>
#include <qquickstyle.h>
#include <qtenvironmentvariables.h>

int main(int argc, char** argv) {
    auto app = QGuiApplication(argc, argv);

    QGuiApplication::setApplicationName("Hyprland style gallery");

    if (qEnvironmentVariableIsEmpty("QT_QUICK_CONTROLS_STYLE"))
        QQuickStyle::setStyle("org.hyprland.style");

    QQmlApplicationEngine engine;

    QObject::connect(
        &engine, &QQmlApplicationEngine::objectCreationFailed, &app,
        []() { QCoreApplication::exit(-1); }, Qt::QueuedConnection);

    engine.load("qrc:/qt/qml/org/hyprland/style/test/main.qml");

    return QGuiApplication::exec();
}
