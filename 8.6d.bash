#!/bin/bash
#author: Mahamed H. Said Bitsec 

#Fil="/Home/Skrivebord/Personal/OS sys/obliger/oblig2/iikos-oblig2_said-mahamed/PID-date.meminfo"

#if [ ! -e "$Fil" ]; then
   # echo "Lager fil med navn:" $Fil
#echo "Eksempel på datoformat: $(date +%Y%m%d-%H:%M:%S)"| tee -a $Fil
#fi


touch "$fileNavn"

{ function skrivTilFIl {  #denne funskjonen leser inn info om en gitt process og skriver til fil
	currentDate=$(date +%Y%m%d-%H:%M:%S)
	fileNavn="$pid-$currentDate.meminfo"
	echo "******** Minne info om prosess med PID $pid ********" 
	echo "Total bruk av virtuelt minne (VmSize):	$VmSize KB"
	echo "Mengde private virtuelt minne(VmData+VmStk+VmExe): 	$VmPriv KB" 
	echo "Mengde shared virtuelt minne (VmLiB):	$VmLib KB" 
	echo "Total bruk av fysisk minne (VmRSS):	$VmRSS KB"  
	echo "Mengde fysisk minne som benyttes til page table (VmPTE):	$VmPTE KB" 
}
} >> "$fileNavn"



for pid in "$@"; do	    # hent inn envher tall(processnummer) fra bruker

# (-e sjekker om filen eksisterer, og -r sjekker om nåværende bruker har riktig rettigheter read permission)
	if [[ -e /proc/$pid/status && -r /proc/$pid/status ]]; then	
		status=$(cat /proc/"$pid"/status)		# lager en array og lagrer inni "status" skal brukes gjennom hele programet
	VmSize=$(echo "$status" | grep VmSize | awk '{print $2}') # Total VmSize reservert, inkludert space for VmData og VmStk to grow
	
	#https://stackoverflow.com/questions/1251999/how-can-i-replace-a-newline-n-using-sed/1252010#1252010
		#VmPriv=$(echo "$status" | egrep 'Vm[Stk][Exe]' | awk '{print $2}' | tr '\n' ' '| bc) # den virket ikke helt!
		VmPriv=$(echo "$status" | grep -E 'VmData|VmStk|VmExe' | awk '{print $2}' | sed ':a;N;$!ba;s/\n/ /g' )
		
		VmLib=$(echo "$status" | grep VmLib | awk '{print $2}')

		VmRSS=$(echo "$status" | grep VmRSS | awk '{print $2}')

		VmPTE=$(echo "$status" | grep VmPTE | awk '{print $2}')

		#awk '{print $2}'== fordi tallene ligger i andre kolonne og navn på første kolonne
		skrivTilFIl # skriv alt til fil
		echo "Proccess med pid $pid eksisterer ikke og/eller du har lese/skrive rettigheter" # en eller annen feil
	fi
done
