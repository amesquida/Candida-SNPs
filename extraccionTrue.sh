#!/bin/bash

# Lee la lista de muestras desde el archivo "ids_tot.txt" y almacénalas en un arreglo
List=()
while IFS= read -r line; do
  List+=("$line")
done < ids_tot.txt

# Iterar sobre cada muestra en el arreglo List
for i in "${!List[@]}"; do
  muestra1=${List[$i]}

  # Iterar sobre las muestras restantes
  for j in "${!List[@]}"; do
    if [ $j -gt $i ]; then
      muestra2=${List[$j]}
      echo "Comparando muestras: $muestra1 y $muestra2"

      # Generar archivo de posiciones de diferencias con 5 columnas
      awk '$NF=="True" {print}' "${muestra1}_${muestra2}_posiciones.txt" > "${muestra1}_${muestra2}_posicionesTRUE.txt"

    fi
  done
done

