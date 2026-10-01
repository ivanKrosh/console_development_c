/* Демо 6. Два потоки - два буфери.
   Програма по черзі пише в stdout і stderr. Запускати двічі:

       Demo6_order.exe                  -> рядки в тому порядку, як у коді
       Demo6_order.exe > all.txt 2>&1   -> спочатку всі помилки, потім решта

   stderr не буферизується ніколи; stdout у файл - буферизується повністю
   і потрапляє у файл лише при завершенні програми.

   Збірка: cl /utf-8 /W4 order.c                                  */
#include <stdio.h>

int main(void)
{
    printf("stdout 1: starting\n");
    fprintf(stderr, "stderr 1: warning\n");
    printf("stdout 2: 10 records processed\n");
    fprintf(stderr, "stderr 2: error in record 7\n");
    printf("stdout 3: done\n");
    return 0;
}
