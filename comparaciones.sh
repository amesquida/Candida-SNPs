#!/bin/bash

export PATH=$PATH:/home/sergio/Escritorio/vcftools_0.1.13/bin
export PATH=$PATH:/home/sergio/Escritorio/gatk-4.1.7.0

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

      # Primera parte del script en bash
      echo "Comando 1: $muestra1 y $muestra2"
      columna=$((i+10))
      cut -f 1,2,3,4,5,6,7,8,9,$columna allsample_final_snps.vcf > ${muestra1}_${muestra2}.vcf
      vcftools --vcf allsample_final_snps.vcf --extract-FORMAT-info GT --out ${muestra1}_${muestra2}_unicas --indv ${muestra1} --indv ${muestra2}
      cp ${muestra1}_${muestra2}_unicas.GT.FORMAT ${muestra1}_${muestra2}_unicas_editado.txt
      sed -i 's/|/\//g' "${muestra1}_${muestra2}_unicas_editado.txt"
      sed -i 's/\.\/\./NADA/g' "${muestra1}_${muestra2}_unicas_editado.txt"
      sed -i 's/0\/2/NADA/g' "${muestra1}_${muestra2}_unicas_editado.txt"
      sed -i 's/1\/2/NADA/g' "${muestra1}_${muestra2}_unicas_editado.txt"
      sed -i 's/2\/2/NADA/g' "${muestra1}_${muestra2}_unicas_editado.txt"
      sed '/NADA/d' "${muestra1}_${muestra2}_unicas_editado.txt" > "${muestra1}_${muestra2}_unicas_editado.csv"
      
      # Generar archivo de posiciones de diferencias con 5 columnas
	awk -F'\t' '{
	    split($3, a, "/");
	    split($4, b, "/");
	    if ((a[1] != b[1]) || (a[2] != b[2])) {
		print $1, $2, $3, $4, "True";
	    } else {
		print $1, $2, $3, $4, "False";
	    }
	}' "${muestra1}_${muestra2}_unicas_editado.csv" > "${muestra1}_${muestra2}_posiciones.txt"

    fi
  done
done

