#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QCursor>


int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
  //  QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
  //  QCoreApplication::setAttribute(Qt::AA_ShareOpenGLContexts);


    QCoreApplication::setAttribute(Qt::AA_UseSoftwareOpenGL);
  //  QCoreApplication::setAttribute(Qt::AA_UseDesktopOpenGL);
    //QCoreApplication::setAttribute(Qt::AA_UseOpenGLES);


#endif







    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

    QGuiApplication app(argc, argv);




    QCursor cursor(Qt::BlankCursor);
   // QGuiApplication::setOverrideCursor(cursor);
   // QGuiApplication::changeOverrideCursor(cursor);



    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
