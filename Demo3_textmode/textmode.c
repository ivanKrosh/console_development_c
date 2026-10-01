/* Демо 3. Текстовий режим: один \n у коді - два байти на диску.
   Ті самі три рядки записуються у два файли: у текстовому ("w")
   і двійковому ("wb") режимі. Потім програма показує розміри і байти.

       Demo3_textmode.exe

   Збірка: cl /utf-8 /W4 textmode.c                               */
#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>

static void dump(const char* path)
{
    FILE* f = fopen(path, "rb");        /* читаємо як є, без перетворень */
    long size;
    int c;

    fseek(f, 0, SEEK_END);
    size = ftell(f);
    rewind(f);
    printf("%-9s %2ld bytes: ", path, size);
    while ((c = fgetc(f)) != EOF)
        printf("%02X ", c);
    printf("\n");
    fclose(f);
}

int main(void)
{
    const char* text = "ab\ncd\nef\n";   /* 9 символів, з них три \n */
    FILE* t = fopen("text.txt", "w");
    FILE* b = fopen("bin.txt", "wb");

    fputs(text, t);
    fputs(text, b);
    fclose(t);
    fclose(b);

    dump("text.txt");                    /* 0D 0A замість кожного 0A */
    dump("bin.txt");
    return 0;
}
