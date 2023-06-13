#!/bin/bash

export PATH=$PATH:/home/sergio/Escritorio/vcftools_0.1.13/bin
export PATH=$PATH:/home/sergio/Escritorio/gatk-4.1.7.0

# Lee la lista de muestras desde el archivo "ids_tot.txt" y almacénalas en un arreglo
List=()
while IFS= read -r line; do
  List+=("$line")
done < ids_tot.txt

# Calcular el número total de elementos en la matriz
num_muestras=${#List[@]}
num_elementos=$((num_muestras * num_muestras))

# Crear un arreglo de cambios inicializado con ceros
matriz_cambios=()
for ((i=0; i<num_elementos; i++)); do
  matriz_cambios+=("0")
done

# Función para calcular el índice en el arreglo a partir de las coordenadas de la matriz
function calcular_indice {
  local fila=$1
  local columna=$2
  local indice=$((fila * num_muestras + columna))
  echo "$indice"
}

# Iterar sobre las muestras en el arreglo List
for i in "${!List[@]}"; do
  muestra1=${List[$i]}

  # Iterar sobre las muestras restantes
  for j in "${!List[@]}"; do
    if [ $j -gt $i ]; then
      muestra2=${List[$j]}
      echo "Comparando muestras: $muestra1 y $muestra2"

      # Verificar si el archivo de posiciones existe antes de leerlo
      if [ -f "${muestra1}_${muestra2}_posiciones.txt" ]; then
        # Leer el archivo de posiciones y contar los "True"
        cambios=$(awk 'NR>1 && $5 == "True" { count++ } END { print count }' "${muestra1}_${muestra2}_posiciones.txt")
      else
        cambios=0
      fi

      # Calcular los índices en el arreglo
      indice1=$(calcular_indice $i $j)
      indice2=$(calcular_indice $j $i)

      # Actualizar el arreglo de cambios con el conteo obtenido
      matriz_cambios[$indice1]=$cambios
      matriz_cambios[$indice2]=$cambios
    fi
  done
done

# Guardar la matriz en un archivo con el formato deseado
for ((i=0; i<num_muestras; i++)); do
  fila=""
  for ((j=0; j<num_muestras; j++)); do
    indice=$(calcular_indice $i $j)
    fila+="${matriz_cambios[$indice]} "
  done
  echo "${fila}"
done > matriz_cambios.txt

