/* Демо 7. Кирилиця: де закінчується мова C.
   Стандарт C не знає, як консоль перетворює байти на символи.
   Той самий рядок - чотири способи вивести його. Запускати по черзі:

       Demo7_cyr.exe raw    -> printf як є: UTF-8 байти в кодовій сторінці 866
       Demo7_cyr.exe cp     -> SetConsoleOutputCP(65001) + printf
       Demo7_cyr.exe wide   -> _setmode(_O_U16TEXT) + wprintf
       Demo7_cyr.exe api    -> WriteConsoleW: мимо бібліотеки C, одразу в консоль

   Потім те саме з "> out.txt" - і порівняти, що опиниться у файлі.

   Збірка: cl /utf-8 /W4 cyr.c                                    */
#include <windows.h>
#include <stdio.h>
#include <string.h>
#include <io.h>
#include <fcntl.h>

int main(int argc, char* argv[])
{
    const char* how = argc > 1 ? argv[1] : "raw";
    UINT oldcp = GetConsoleOutputCP();

    printf("[console code page: %u]\n", oldcp);
    fflush(stdout);                                   /* перед зміною режиму */

    if (strcmp(how, "raw") == 0) {
        printf("Привіт, консоле!\n");
    }
    else if (strcmp(how, "cp") == 0) {
        SetConsoleOutputCP(CP_UTF8);                  /* діє на всю консоль, */
        printf("Привіт, консоле!\n");
        SetConsoleOutputCP(oldcp);                    /* тож повертаємо назад */
    }
    else if (strcmp(how, "wide") == 0) {
        _setmode(_fileno(stdout), _O_U16TEXT);        /* після цього printf заборонено */
        wprintf(L"Привіт, консоле!\n");
    }
    else if (strcmp(how, "api") == 0) {
        const wchar_t* s = L"Привіт, консоле!\n";
        DWORD written = 0;
        BOOL ok = WriteConsoleW(GetStdHandle(STD_OUTPUT_HANDLE),
                                s, (DWORD)wcslen(s), &written, NULL);
        if (!ok)
            fprintf(stderr, "WriteConsoleW failed, error %lu: not a console\n",
                    GetLastError());
    }
    return 0;
}
