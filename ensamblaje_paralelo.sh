#!/bin/bash

set -uex


cat /mnt/Almacenamiento2/PCORTE/CA/ids.txt | parallel 'java -jar /home/sergio/Escritorio/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
/mnt/Almacenamiento2/PCORTE/CA/{}_R1.fastq /mnt/Almacenamiento2/PCORTE/CA/{}_R2.fastq \
/mnt/Almacenamiento2/PCORTE/CA/{}_paired1.fastq /mnt/Almacenamiento2/PCORTE/CA/{}_unpaired1.fastq \
/mnt/Almacenamiento2/PCORTE/CA/{}_paired2.fastq /mnt/Almacenamiento2/PCORTE/CA/{}_unpaired2.fastq SLIDINGWINDOW:4:20'

