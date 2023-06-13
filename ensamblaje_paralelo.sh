#!/bin/bash

set -uex
#cd /home/sergio/Escritorio/prueba


#cat /mnt/Almacenamiento2/ENVIO_VALENCIA_2022/Resultados/Albicans/dir.txt | parallel 'mkdir {}'


#cat /home/sergio/Escritorio/prueba/ids.txt | parallel 'java -jar /home/sergio/Escritorio/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
#/home/sergio/Escritorio/prueba/{}_r1.fastq /home/sergio/Escritorio/prueba/{}_r2.fastq /home/sergio/Escritorio/prueba/{}_paired1.fastq \
#/home/sergio/Escritorio/prueba/{}_unpaired1.fastq /home/sergio/Escritorio/prueba/{}_paired2.fastq /home/sergio/Escritorio/prueba/{}_unpaired2.fastq ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 SLIDINGWINDOW:4:20' 


cat /mnt/Almacenamiento2/PCORTE/CA/ids.txt | parallel 'java -jar /home/sergio/Escritorio/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
/mnt/Almacenamiento2/PCORTE/CA/{}_R1.fastq /mnt/Almacenamiento2/PCORTE/CA/{}_R2.fastq \
/mnt/Almacenamiento2/PCORTE/CA/{}_paired1.fastq /mnt/Almacenamiento2/PCORTE/CA/{}_unpaired1.fastq \
/mnt/Almacenamiento2/PCORTE/CA/{}_paired2.fastq /mnt/Almacenamiento2/PCORTE/CA/{}_unpaired2.fastq SLIDINGWINDOW:4:20'


#cat /home/sergio/Escritorio/prueba/ids.txt | parallel 'python /home/sergio/Escritorio/SPAdes-3.13.0-Linux/bin/spades.py -o {} -1 {}_paired1.fastq -2 {}_paired2.fastq --careful -t 8 -k 79,89,99,115'



#cat /home/sergio/Escritorio/prueba/ids.txt | parallel 'python /home/sergio/Escritorio/redundans/redundans.py -i {}_paired1.fastq {}_paired2.fastq -o {}/{}'
