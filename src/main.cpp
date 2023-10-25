#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>

int main(int argc, char *argv[])
{
    QGuiApplication application(argc, argv);
    QQmlApplicationEngine engine;

    // Determine the operating system and set the style accordingly
    if (QSysInfo::productType() == "android")
    {

        // Set the style to Material for Android
        QQuickStyle::setStyle("Material");

    }
    else if (QSysInfo::productType() == "ios")
    {

        // Set the style to iOS for iOS
        QQuickStyle::setStyle("iOS");

    }
    else
    {

        // Set the style to Universal for Windows
        QQuickStyle::setStyle("Material");

    }
    // else
    // {

    //     // Set the style to Fusion for all other platforms
    //     QQuickStyle::setStyle("Material");

    // }

    application.setApplicationVersion("1.0.0");

    const QUrl url(u"qrc:/mainLib/interfaces/main.qml"_qs);
    QObject::connect(
        &engine, &QQmlApplicationEngine::objectCreated, &application, [url](QObject *obj, const QUrl &objUrl)
        {
        if(!obj && objUrl == url)
            QGuiApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);

    qDebug() << "Applicaiton name: " << QGuiApplication::applicationName()
             << " | Applicaiton version: " << QGuiApplication::applicationVersion()
             << " | Platform name: " << QGuiApplication::platformName()
             << " | Platform name: " << application.platformName()
             << " | Device pixel ratio: " << application.devicePixelRatio();

    return application.exec();
}
