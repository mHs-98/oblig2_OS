#!/bin/bash
#bash script som skriver ut antall major page faults hver av chrome sine prosesser har forårsaket.

ChromePID="$(pgrep chrome)"              #array med process id til chrome


if [ "$ChromePID" > "0" ]; then             #det finnes minst en process som har med chrome å gjøre 
   # echo ChromePID;
    for pid in $ChromePID; do            #looper gjennom alle processene 
    
   pf="$(ps --no-headers -o maj_flt  $pid)"         #og lagrer dems Page fault i en array
       echo "Chrome $pf gjør page fault chrome gjør"    #gjør utstrkift
        if [ "$pf" -gt 1000 ]; then               # ekstra utskrift hvis mer enn 1000 page fault
            echo "Mer enn 1000 page faults"
            fi

             
    done
      
    
else
    echo "**** Chrome er ikke oppe ****"
fi