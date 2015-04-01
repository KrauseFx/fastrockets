#include <stdio.h>

int main(void) 
{
  char mychar;
  while(1)
  {
    printf("Enter a characater:\n");
    scanf("%c", &mychar);
    printf("--%c--\n", mychar);// NOTE the missing `&` in front of `mychar` here
  }

  return 0;
}