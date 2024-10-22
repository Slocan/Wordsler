/****************************************************************************
**
** Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the demonstration applications of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:LGPL$
** No Commercial Usage
** This file contains pre-release code and may not be distributed.
** You may use this file in accordance with the terms and conditions
** contained in the Technology Preview License Agreement accompanying
** this package.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 2.1 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPL included in the
** packaging of this file.  Please review the following information to
** ensure the GNU Lesser General Public License version 2.1 requirements
** will be met: http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** In addition, as a special exception, Nokia gives you certain additional
** rights.  These rights are described in the Nokia Qt LGPL Exception
** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
**
** If you have questions regarding the use of this file, please contact
** Nokia at qt-info@nokia.com.
**
**
**
**
**
**
**
**
** $QT_END_LICENSE$
**
****************************************************************************/

#ifndef WORDLIST_H
#define WORDLIST_H

#include <QObject>
#include <QSet>
#include <QStringList>

class WordList : public QObject
{
    Q_OBJECT
    /*
       This object provides a set of functions that word games might need.
       They use a built in word list.

       When you import the WordGame module, it is added as the 'wordList'
       item in the root QML context.
    */
public:
    explicit WordList(QObject *parent = 0, QString locale = "en");
    Q_INVOKABLE static WordList *instance(QString locale);
    bool isPartialWord(char*);//Convenience for the C style code
signals:

public slots:
    //Returns true iff str is in word list
    Q_INVOKABLE bool isWord(const QString &str);
    //Returns true iff there exists 0 or more letters which could be appended
    //to str so that passing the resultant word to isWord would return true.
    bool isPartialWord(const QString &str);
    //Returns the set of words you can form with the letters in str.
    //Useful for anagrams or games where you create words from a set of letters
    //This is probably slow, and is not currently put in another thread
    QStringList wordsIn(const QString &str);
    Q_INVOKABLE void init(QString locale);
private:
    static WordList* m_instance;
    QSet<QString> m_words;
    void wordsInHelper(const QString &given, const QString &left, QStringList &ret);
};

#endif // WORDLIST_H
