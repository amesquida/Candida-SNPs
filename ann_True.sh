#!/bin/bash

# Lee la lista de muestras desde el archivo "ids_tot.txt" y almacénalas en un arreglo
List=()
while IFS= read -r line; do
  List+=("$line")
done < ids_tot.txt

# Ordenar el archivo "snp_final_red_tb_ANN.txt" por cromosoma y posición
sort -k1,1 -k2,2n snp_final_red_tb_ANN.txt > sorted_snp_final_red_tb_ANN.txt

# Iterar sobre cada muestra en el arreglo List
for i in "${!List[@]}"; do
  muestra1=${List[$i]}

  # Iterar sobre las muestras restantes
  for j in "${!List[@]}"; do
    if [ $j -gt $i ]; then
      muestra2=${List[$j]}
      echo "Anotando archivo: ${muestra1}_${muestra2}_posicionesTRUE.txt"

      # Realizar la anotación utilizando tanto el cromosoma como la posición como criterios de búsqueda
      awk 'BEGIN {OFS="\t"} FNR==NR {arr[$1"\t"$2]=$3"\t"$4; next} ($1"\t"$2) in arr {print $0,arr[$1"\t"$2]; next} {print $0,"N/A\tN/A"}' \
        snp_final_red_tb_ANN.txt "${muestra1}_${muestra2}_posicionesTRUE.txt" > "${muestra1}_${muestra2}_posicionesTRUE_annotated.txt"

    fi
  done
done

# Eliminar el archivo temporal de ordenación
rm sorted_snp_final_red_tb_ANN.txt

