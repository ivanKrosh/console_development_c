/* Демо 5. Надійне введення: спочатку рядок, потім розбір.
   fgets читає весь рядок разом з \n - у буфері нічого не лишається.
   strtol перетворює текст на число і каже, де зупинився.

       42      -> number: 42
       abc     -> error: not a number
       42abc   -> error: extra characters after the number: "abc"
       Ctrl+Z  -> end of input

   Збірка: cl /utf-8 /W4 fgets.c                                  */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(void)
{
    char  line[64];
    char* end;
    long  n;

    printf("Enter an integer: ");
    if (fgets(line, sizeof line, stdin) == NULL) {
        printf("\nend of input\n");
        return 1;
    }
    line[strcspn(line, "\n")] = '\0';    /* прибрати \n у кінці */

    n = strtol(line, &end, 10);
    if (end == line)
        printf("error: not a number\n");
    else if (*end != '\0')
        printf("error: extra characters after the number: \"%s\"\n", end);
    else
        printf("number: %ld\n", n);
    return 0;
}
