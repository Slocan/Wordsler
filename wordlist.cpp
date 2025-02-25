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
#include "wordlist.h"
#include <QtCore/QFile>
#include <cstring>
#include <QDebug>

const int LEN_MAX=30;//Rounded to a round number for safety (sentinel and null terminator have room)
bool wordCheck(char word[LEN_MAX]);

WordList::WordList(QObject *parent, QString locale) :
    QObject(parent)
{
    //init(locale);
}

WordList* WordList::m_instance = 0;
WordList* WordList::instance(QString locale)
{
    if(m_instance)
        return m_instance;
    else
        m_instance = new WordList(0, locale);
    return m_instance;
}

bool WordList::isPartialWord(const QString &c)
{
    return isPartialWord(c.toAscii().toLower().data());
}

bool WordList::isWord(const QString &string)
{
    return m_words.contains(string.toLower());
}

QStringList WordList::wordsIn(const QString &str)
{
    QStringList ret;
    wordsInHelper(QLatin1String(""), str, ret);
    return ret;
}

//Using a C style global array since I'm using C style strings anyways
const int WORD_MAX=340000;
char dict[WORD_MAX][LEN_MAX];
int idx[26*26];
int numWords;

void WordList::init(const QString locale){
    //Create 'Binary Tree'
    //QFile in(":/words.dict");//Assumed to be in alphabetical order already
    QFile in;

    if (locale=="fr") {
        in.setFileName(":/liste_fr.txt");
    } else {
        in.setFileName(":/wordlist2.txt");
    }
    bool opened = in.open(QFile::Text | QFile::ReadOnly);
    Q_ASSERT(opened);
    int c=0;
    char cur[LEN_MAX];
    char curIdx[2];//Assumed all words have at least 2 letters
    curIdx[0] = ' ';
    curIdx[1] = ' ';
    m_words.clear();
    while(in.readLine(cur,LEN_MAX) > 0){
            //qDebug() << QString(cur).toLower().trimmed();
            if(cur[0]=='\n' || cur[0]=='\0')
                continue;
            m_words << QString(cur).toLower().trimmed();
            sprintf(dict[c],"%s", cur);

            if(curIdx[0] < cur[0]){//Assumed each of the 26 letters starts at least one word
                curIdx[0] = cur[0];
                curIdx[1] = 'a';
                idx[(curIdx[0]-'a') * 26] = c;
            }
            while(curIdx[1] < cur[1]){
                curIdx[1]++;
                Q_ASSERT(curIdx[1] >= 'a' && curIdx[1] <= 'z');
                idx[(curIdx[0]-'a') * 26 + (curIdx[1] - 'a')] = c;
            }
            c++;
    }
    numWords = c;
    Q_ASSERT(m_words.count() == c);//Assumed no duplicates
    in.close();
}

bool WordList::isPartialWord(char *c)
{
    int l = strlen(c);
    if(l < 2)
        return true;
    int i = idx[(c[0]-'a') * 26 + (c[1]-'a')];
    for(i; i<numWords && strncmp(dict[i],c,l) < 0; i++){};
    return (strncmp(dict[i],c,l) == 0);
}


void WordList::wordsInHelper(const QString &given, const QString &left, QStringList &ret)
{
    for(int i=0; i<left.length(); i++){
        QString part = given + left[i];
        if(isPartialWord(part)){
            if(isWord(part)){
                if(ret.contains(part))
                    return;//We've hit a duplicate letter arrangement
                ret << part;
            }
            QString nowLeft(left);
            nowLeft.remove(i,1);
            wordsInHelper(part, nowLeft, ret);
        }

    }
}
