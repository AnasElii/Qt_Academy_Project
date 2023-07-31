#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication application(argc, argv);
    application.setApplicationVersion("1.2.0");
    application.setApplicationName("Reviewed");
    QQmlApplicationEngine engine;

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
             << " | Device pixel ratio: " << application.devicePixelRatio();

    return application.exec();
}