#pragma once

#include <QObject>
#include <QtQml/qqml.h>
#include <QString>
#include <QStringList>
#include <QVariantMap>

class Renamer : public QObject
{
    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY(QString path READ path WRITE setPath NOTIFY pathChanged)
    Q_PROPERTY(QStringList contents READ contents NOTIFY contentsChanged)

public:
    explicit Renamer(QObject *parent = nullptr);

    QString path() const;
    void setPath(const QString &path);

    QStringList contents() const;

    Q_INVOKABLE QVariantMap conversionDryRun() const;
    Q_INVOKABLE void doConversion();

signals:
    void pathChanged();
    void contentsChanged();

private:
    void updateContents();
    QString convert(const QString &name) const;

    QString _path;
    QStringList _contents;
};
