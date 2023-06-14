#Primejo ejecutamos esto en el terminal
cat dir.txt | parallel 'cp /mnt/Almacenamiento2/ENVIO_VALENCIA_2022/Resultados/Parapsilosis/{}/*_sorted_dedup_reads.bam /mnt/Almacenamiento2/ENVIO_VALENCIA_2022/Resultados/Albicans/coverage/'

#Despues exportamos el programa de coverage

export PATH=$PATH:~/Escritorio/samtools-1.10

#Hacemos el coverage y los stats, y los archivamos cada uno en un txt, obtenemos un txt por cepa
cat ids.txt | parallel 'samtools coverage {}_sorted_dedup_reads.bam > coverage_{}.txt'

cat ids.txt | parallel 'samtools flagstat {}_sorted_dedup_reads.bam > stats_{}.txt'

#Para concatenar cada uno y que estén separados por cepa y no todo seguido sin titulo
more coverage*.txt > total_cov.txt

more stats*.txt > total_stats.txt
