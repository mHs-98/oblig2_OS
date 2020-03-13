#!/bin/bash
# no arguments, display a menu with option for info
# about processes

clear
while [ "$svar" != "9" ]
do
 echo ""
 echo "  1 - Hvem er jeg og hva er navnet på dette scriptet?"
 echo "  2 - Hvor lenge er det siden siste boot?"
 echo "  3 - Hva var gjennomsnittlig load siste minutt?"
 echo "  4 - Hvor mange prosesser og tråder finnes?"
 echo "  5 - Hvor mange context switch'er fant sted siste sekund?"
 echo "  6 - Hvor mange interrupts fant sted siste sekund?"
 echo "  9 - Avslutt dette scriptet"
 echo ""
 echo -n "Velg en funksjon: "
 read -r svar
 echo ""
 case $svar in
  1)clear
    echo "Jeg er $(whoami)"
    echo "Navnet paa dette scriptet er ${0}"
    read -r
    clear
    ;;
  2) echo "Saa lenge har gatt siden sist boot $(uptime)"
    read -r
    clear
    ;;
  3) echo " $(uptime) " | awk -F'GJennomsnittling load siste minutt :' '{ print $2 }'
    read -r
    clear
    ;;
  4) echo " Så mange prosser "$(ps aux | wc -l)" finnes, og så mange tråder  $(( `ps axms | wc -l`  - 1)) finnes"
     read -r
    clear
    ;;
  5) echo "Så mange $(grep ctxt /proc/stat | awk '{print $2}'}) context switcher fant sted siste sekund"
    read -r
    clear
    ;;
  6) echo " så mange $(grep intr /proc/stat | awk '{print $2}') interrupts har skjedd i siste sekund"
    read -r
    clear
    ;;
  9) echo Scriptet avsluttet
    exit
    ;;
  *)echo Ugyldig valg
    read -r
    clear
    ;;
 esac
done

