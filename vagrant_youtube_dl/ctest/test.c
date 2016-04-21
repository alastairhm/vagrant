#include <stdio.h>
#include <string.h>

void main () {

 char test_msg [] = "normally I'd insist on that, but after the debacle of macros and templates, anything to blot out the memory would do =8/........";
 char msg1[64] = " ";
 char msg2[64] = " ";
 int buf_size = 16;
 int i;

 printf("%d = %s\n\n",strlen(test_msg),test_msg);

 for (i=0;i<128;i+=buf_size){
 strncpy(msg1,test_msg+i,buf_size);
 printf("[%s][%d]\n",msg1,strlen(msg1));
}

}
