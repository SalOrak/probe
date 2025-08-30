#include <stdio.h>
#include <unistd.h> 


int main(){
  static const char *emacsorgcapture[]  = { "emacsclient", "-e","(sk-window-popup-org-capture)", NULL};

  execvp(emacsorgcapture[0], (char **)emacsorgcapture);

  perror("execvp");
  return 0;
  
}

