#!/bin/bash

archivo="allsample_alelosRAW.txt"
salida="cambios_por_muestraRAW.txt"

# Extraer los nombres de las muestras de la primera línea del archivo
read -r -a nombres_muestras <<< "$(head -n 1 "$archivo" | cut -f3-)"


# Inicializar el contador de cambios por muestra
declare -A cambios_por_muestra

# Leer el archivo línea por línea
while IFS=$'\t' read -r chrom pos muestras; do
  # Convertir la línea en un array
  muestras_array=($muestras)

  # Iterar sobre cada muestra y contar los cambios
  for ((i = 2; i < ${#muestras_array[@]}; i++)); do
    if [[ ${muestras_array[$i]} == "0/1" || ${muestras_array[$i]} == "1/1" ]]; then
      if [[ ${cambios_por_muestra[${nombres_muestras[$i-2]}]} ]]; then
        cambios_por_muestra[${nombres_muestras[$i-2]}]=$((cambios_por_muestra[${nombres_muestras[$i-2]}] + 1))
      else
        cambios_por_muestra[${nombres_muestras[$i-2]}]=1
      fi
    fi
  done
done < "$archivo"

# Escribir los resultados en el archivo de salida
echo "Muestra Cambios" > "$salida"
for muestra in "${!cambios_por_muestra[@]}"; do
  echo "$muestra ${cambios_por_muestra[$muestra]}" >> "$salida"
done

echo "El archivo \"$salida\" ha sido generado con éxito."

