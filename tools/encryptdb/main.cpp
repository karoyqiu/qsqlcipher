/*! ***********************************************************************************************
 *
 * \file        main.cpp
 * \brief       encryptdb 主源文件。
 *
 * \version     0.1
 * \date        2018-1-10
 *
 * \author      Roy QIU <karoyqiu@gmail.com>
 * \copyright   © 2018 Roy QIU。
 *
 **************************************************************************************************/
#include <stdio.h>
#include <sqlite3.h>


int main(int argc, char *argv[])
{
    if (argc != 4)
    {
        fprintf(stderr, "Usage: %s plaintext-db encrypted-db key\n", argv[0]);
        return 1;
    }

    sqlite3 *db = nullptr;
    int r = sqlite3_open_v2(argv[2], &db, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, NULL);

    char cmd[1024] = { 0 };
    snprintf(cmd, sizeof(cmd), R"(PRAGMA key = "%s";)", argv[3]);
    r = sqlite3_exec(db, cmd, NULL, NULL, NULL);

    r = sqlite3_close(db);

    r = sqlite3_open_v2(argv[1], &db, SQLITE_OPEN_READWRITE, NULL);

    snprintf(cmd, sizeof(cmd), R"(ATTACH DATABASE '%s' AS encrypted KEY "%s";)",
             argv[2], argv[3]);
    r = sqlite3_exec(db, cmd, NULL, NULL, NULL);
    r = sqlite3_exec(db, "SELECT sqlcipher_export('encrypted');", NULL, NULL, NULL);

    sqlite3_exec(db, "DETACH DATABASE encrypted;", NULL, NULL, NULL);
    sqlite3_close(db);

    return r;
}
