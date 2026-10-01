/* Демо 4. Що насправді робить scanf.
   Програма читає число, потім один символ - і показує, що саме
   отримала. Запускати двічі з різним введенням:

       42      -> scanf returned 1; char code = 10 (це \n після 42)
       abc     -> scanf returned 0; n = -1 (не змінилося); char code = 97 ('a')

   Збірка: cl /utf-8 /W4 scanf.c                                  */
#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>

int main(void)
{
    int  n = -1;
    char c = '?';
    int  r;
                
    printf("Enter an integer: ");
    r = scanf("%d", &n);
    printf("scanf returned %d, n = %d\n", r, n);

    printf("Enter a character: ");
    r = scanf("%c", &c);
    printf("scanf returned %d, char code = %d ('%c')\n", r, c, c);

    return 0;
}
