/* Демо 2. Сімейство printf: більше, ніж %d.
   Одна таблиця - усі частини специфікатора: прапорці, ширина, точність.
   Наприкінці - що printf повертає, і пастка з кирилицею в ширині поля.

       Demo2_printf.exe

   Збірка: cl /utf-8 /W4 printf.c                                 */
#include <stdio.h>
#include <string.h>
#include <windows.h>

int main(void)
{
    SetConsoleOutputCP(CP_UTF8);

    const char* name[] = { "notepad.exe", "cmd.exe", "explorer.exe" };
    unsigned    pid[]  = { 4312, 980, 7044 };
    double      mem[]  = { 12.5, 3.25, 145.875 };
    int n;

    /* %-14s: ширина 14, вирівнювання вліво (прапорець -)
       %6u  : ширина 6, вирівнювання вправо (за замовчуванням)
       %#8x : шістнадцятковий вигляд з префіксом 0x (прапорець #), ширина 8
       %9.2f: ширина 9, два знаки після коми (точність)                  */
    printf("%-14s %6s %8s %9s\n", "Image", "PID", "PID(hex)", "Mem, MB");
    printf("%-14s %-6u %#8x %9.4f\n", name[0], pid[0], pid[0], mem[0]);
    printf("%-14s %6u %#8x %9.2f\n", name[1], pid[1], pid[1], mem[1]);
    printf("%-14s %6u %#8x %9.2f\n", name[2], pid[2], pid[2], mem[2]);

    /* Ширину можна передати аргументом: зірочка замість числа. */
    printf("[%*d]  [%-*d]  [%06d]\n", 6, 42, 6, 42, 42);

    /* %zu - для size_t (результат sizeof і strlen). */
    printf("sizeof(double) = %zu, strlen(\"%s\") = %zu\n",
           sizeof(double), name[2], strlen(name[2]));

    /* printf повертає кількість виведених БАЙТІВ, а не символів. */
    n = printf("abc\n");
    printf("  -> returned %d\n", n);
    n = printf("абв\n");
    printf("  -> returned %d\n", n);

    /* Звідси пастка: ширина поля теж рахується в байтах. */
    printf("[%-8s]\n[%-8s]\n", "abc", "абв");

    return 0;
}
