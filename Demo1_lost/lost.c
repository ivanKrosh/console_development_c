/* Демо 1. Куди зник текст.
   Гачок заняття і розв'язка блоку буферизації. Запускати парами:

       Demo1_lost.exe crash                 -> у консолі видно всі три кроки
       Demo1_lost.exe crash > out.txt       -> out.txt порожній
       Demo1_lost.exe crash flush > out.txt -> з fflush текст на місці

   Спосіб завершення задається першим аргументом:
       crash  - звернення за нульовою адресою (аварія)
       kill   - TerminateProcess: процес знищено ззовні
       exit   - exit(3): штатне завершення з кодом помилки
       (без аргументу) - return 0 з main
   Другий аргумент flush - викликати fflush(stdout) перед завершенням.

   Збірка: cl /utf-8 /W4 lost.c                                   */
#include <windows.h>
#include <stdio.h>
#include <string.h>

int main(int argc, char* argv[])
{
    const char* how = argc > 1 ? argv[1] : "return";

    /* Щоб аварія не відкривала вікно звіту про помилку. */
    SetErrorMode(SEM_NOGPFAULTERRORBOX);

    printf("Step 1: file opened\n");
    printf("Step 2: data processed\n");
    printf("Step 3: finishing (%s)", how);      /* без \n - навмисно */

    if (argc > 2 && strcmp(argv[2], "flush") == 0)
        fflush(stdout);                        /* виштовхнути буфер CRT */

    if (strcmp(how, "crash") == 0) {
        volatile int* p = NULL;
        *p = 42;                               /* аварія */
    }
    if (strcmp(how, "kill") == 0)
        TerminateProcess(GetCurrentProcess(), 3);
    if (strcmp(how, "exit") == 0)
        exit(3);

    return 0;
}
