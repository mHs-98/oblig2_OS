#!/bin/bash

# author: Mahamed H said Bitsec 

if [[ -d $1 ]]; then	#hvis directory eksisterer
	full=$(df -h $1| tail -n 1 | awk '{print $5}')	#df-h: vis i menneske lesbar format, tail: skriv ut siste del
	files=$(find $1 -depth -type f | wc -l)
	#tr: ta bort newline, du=="disk usage"
	#files0-from= : leser filnavn fra stdin og beregner dets størrelse 
	largest=$(find $1 -depth -type f | tr '\n' '\0' | du -ah --files0-from=- | sort -h | tail -n 1)   #største filen
	#https://stackoverflow.com/questions/1251999/how-can-i-replace-a-newline-n-using-sed/1252010#1252010
	totalSize=$(find $1 -depth -type f | tr '\n' '\0' | du -a --files0-from=- | awk '{print $1}' | sed ':a;N;$!ba;s/\n/+/g' | bc)
	average=$(($totalSize/$files))
	#prin0:print ut hele filnavnet
	#xargs: gjør til ekskverbar og ta bort newline og mellomrom
	# ls:
	hardLinks=$(find "$1" -depth -type f -print0 | xargs --null ls -la | awk '{print $2 , $9 }' | sort -n | tail -n 1)

	echo "Partisjonen $1 befinner seg på er $full full"
	echo "Det finnes $files filer"
	echo "Den største er $(echo $largest | awk '{print $2'}) som er $(echo $largest | awk '{print $1}') stor."
	echo "Gjennomsnittlig filstørrelse er ca $average bytes."
	echo "Filen $(echo $hardLinks | awk '{print $2}') har flest hardlinks, den har $(echo $hardLinks | awk '{print $1}')."
else
	echo "$1 er  ikke directory..."
fi