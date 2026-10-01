/* Демо 8. Два рівні введення: getchar і ReadConsoleInput.
   Запускати двічі й натискати ті самі клавіші - літери, стрілки, Enter:

       Demo8_keys.exe line    -> getchar: нічого до Enter, стрілок немає взагалі
       Demo8_keys.exe events  -> ReadConsoleInput: кожна подія окремо, Esc - вихід

   У першому режимі рядок редагує консоль (стрілки, Backspace, історія),
   а програма отримує вже готовий результат. У другому - сирі події
   з вхідного буфера, про який ішлося на занятті 6.

   Збірка: cl /utf-8 /W4 keys.c                                   */
#include <windows.h>
#include <stdio.h>
#include <string.h>

static const char* keyname(WORD vk)
{
    switch (vk) {
    case VK_UP:     return "arrow up";
    case VK_DOWN:   return "arrow down";
    case VK_LEFT:   return "arrow left";
    case VK_RIGHT:  return "arrow right";
    case VK_RETURN: return "Enter";
    case VK_ESCAPE: return "Esc";
    case VK_BACK:   return "Backspace";
    default:        return "";
    }
}

int main(int argc, char* argv[])
{
    const char* how = argc > 1 ? argv[1] : "line";

    if (strcmp(how, "line") == 0) {
        int c;
        printf("getchar: type a line and press Enter\n");
        while ((c = getchar()) != '\n' && c != EOF)
            printf("  got code %3d '%c'\n", c, c);
        printf("  got code  10 (Enter)\n");
        return 0;
    }

    /* events */
    HANDLE in = GetStdHandle(STD_INPUT_HANDLE);
    INPUT_RECORD r;
    DWORD n;

    printf("ReadConsoleInput: press keys, Esc to quit\n");
    for (;;) {
        ReadConsoleInputW(in, &r, 1, &n);
        if (r.EventType != KEY_EVENT)
            continue;                              /* миша, розмір вікна... */
        KEY_EVENT_RECORD k = r.Event.KeyEvent;
        printf("  %-10s VK=0x%02X  char=%3u  %s\n",
               k.bKeyDown ? "key down" : "key up",
               k.wVirtualKeyCode, (unsigned)k.uChar.UnicodeChar,
               keyname(k.wVirtualKeyCode));
        if (k.bKeyDown && k.wVirtualKeyCode == VK_ESCAPE)
            break;
    }
    return 0;
}
