/* Демо 9. Колір і курсор: два способи і що з ними стається у файлі.

       Demo9_color.exe              -> кольоровий вивід у консолі
       Demo9_color.exe > out.txt    -> у файлі: чистий текст першого
                                        способу і "сміття" з другого

   Спосіб 1: SetConsoleTextAttribute - функція WinAPI, змінює атрибути
             екранного буфера. З файлом просто не спрацьовує.
   Спосіб 2: VT-послідовності - звичайні байти в потоці виводу,
             які консоль (або термінал) тлумачить як команди.

   Збірка: cl /utf-8 /W4 color.c                                  */
#include <windows.h>
#include <stdio.h>

int main(void)
{
    HANDLE out = GetStdHandle(STD_OUTPUT_HANDLE);
    CONSOLE_SCREEN_BUFFER_INFO info;
    DWORD mode = 0;
    BOOL console = GetConsoleScreenBufferInfo(out, &info);

    if (console)
        printf("buffer %dx%d, window %dx%d, cursor (%d,%d)\n",
               info.dwSize.X, info.dwSize.Y,
               info.srWindow.Right - info.srWindow.Left + 1,
               info.srWindow.Bottom - info.srWindow.Top + 1,
               info.dwCursorPosition.X, info.dwCursorPosition.Y);

    /* Спосіб 1. Кольори - біти атрибута: FOREGROUND_* і BACKGROUND_*. */
    fflush(stdout);          /* текст іде через буфер CRT, атрибут - одразу */
    SetConsoleTextAttribute(out, FOREGROUND_GREEN | FOREGROUND_INTENSITY);
    printf("[WinAPI] green text\n");
    fflush(stdout);
    SetConsoleTextAttribute(out, console ? info.wAttributes : 7);  /* повернути! */

    /* Спосіб 2. Увімкнути обробку VT і писати керівні послідовності. */
    GetConsoleMode(out, &mode);
    SetConsoleMode(out, mode | ENABLE_VIRTUAL_TERMINAL_PROCESSING);
    printf("\x1b[33m[VT] yellow text\x1b[0m\n");
    printf("\x1b[1;36m[VT] bright cyan\x1b[0m and normal\n");

    return 0;
}
