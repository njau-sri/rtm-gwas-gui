#include <QDir>
#include <QApplication>
#include <QDesktopWidget>
#include "mainwindow.h"
#include "parameter.h"

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    QDir home = QDir::home();
#ifdef Q_OS_WIN
    home.cd(QLatin1String("Documents"));
#endif
    home.mkdir(QLatin1String("rtm-gwas_results"));
    home.cd(QLatin1String("rtm-gwas_results"));

    Parameter::work = home.absolutePath();
    Parameter::open = Parameter::work;
    QDir::setCurrent(Parameter::work);

    QRect s = QApplication::desktop()->screenGeometry();

    MainWindow w;

    w.resize(s.size() * 0.75);

    int x = (s.width() - w.width()) / 2;
    int y = (s.height() - w.height()) / 2;
    w.move(x, y);

    w.show();

    return a.exec();
}
