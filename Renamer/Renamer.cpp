#include "Renamer.h"
#include <QDir>
#include <QFileInfo>
#include <QRegularExpression>
#include <QDate>

Renamer::Renamer(QObject *parent)
    : QObject(parent)
    , _path()
    , _contents()
{
}

QString Renamer::path() const
{
    return _path;
}

void Renamer::setPath(const QString &path)
{
    if (_path == path)
        return;

    _path = path;
    emit pathChanged();

    updateContents();
}

QStringList Renamer::contents() const
{
    return _contents;
}

void Renamer::updateContents()
{
    QDir dir(_path);
    QStringList dirs;

    for (const QFileInfo &entry : dir.entryInfoList(QDir::Dirs | QDir::NoDotAndDotDot, QDir::Name)) {
        dirs << entry.fileName();
    }

    if (_contents != dirs) {
        _contents = dirs;
        emit contentsChanged();
    }
}

QString Renamer::convert(const QString &name) const
{
    // Match date in formats like: "1 January 2024", with or without a leading description
    static QRegularExpression re(R"(^(?:(.*),\s*)?(\d{1,2}) ([A-Za-z]+) (\d{4})$)");
    QRegularExpressionMatch match = re.match(name);

    if (!match.hasMatch())
        return name;  // fallback – return unmodified if no match

    QString description = match.captured(1).trimmed();
    int day = match.captured(2).toInt();
    QString monthName = match.captured(3);
    int year = match.captured(4).toInt();

    QDate date;
    date = QDate::fromString(QString("%1 %2 %3").arg(day).arg(monthName).arg(year), "d MMMM yyyy");

    if (!date.isValid())
        return name;

    QString iso = date.toString("yyyy-MM-dd");
    return description.isEmpty() ? iso : QString("%1, %2").arg(iso, description);
}

QVariantMap Renamer::conversionDryRun() const
{
    QVariantMap result;
    for (const QString &name : _contents) {
        result.insert(name, convert(name));
    }
    return result;
}

void Renamer::doConversion()
{
    QDir dir(_path);

    for (const QString &name : _contents) {
        QString newName = convert(name);
        if (name != newName) {
            dir.rename(name, newName);
        }
    }

    updateContents();
}
