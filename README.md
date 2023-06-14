# Candida-SNPs
El pipeline tiene los siguientes pasos:
  1. Ejecutar el scritp ensamblaje_paralelo.sh está escrito en bash.
  2. Hacer un fastqc de todos los archivos hay que hacerlo en los archiovs acabados en "_paired1/2".
  3. En el entorno snakemake-tutorial:
      3.1. Hacer el archivo config.
      3.2. Ejecutar snakafile.
      3.3. Ejecutar snakefile2.
  4. Hacer el análisis de coverage y estadísticas con el script "coverage.sh"
  5. Ejecutar en el terminal el scritp escrito en post_variantcalling.txt.
      5.1. Primera parte anotar todos los cambios.
      5.2. Arhivos para hacer el arbol de SNPs con iTol.
  6. Hacer un archivo tanto con todos los directorios de las muestras (dir_tot) con el nombre de las muestras (ids_tot) en .txt
  7. Ejecujutar el script comparaciones.sh
  8. Ejecutar el script script_matriz.sh
  9. Anotar los cambios de las combios dos a dos:
      9.1. Extraer los cambios con extraccionTrue.sh en bash.
      9.2. Anotar esos cambios con ann_True.sh
