#!/bin/bash

export PATH=$PATH:/home/sergio/Escritorio/vcftools_0.1.13/bin
export PATH=$PATH:/home/sergio/Escritorio/gatk-4.1.7.0


      vcftools --vcf allsample_raw_snps.vcf --extract-FORMAT-info GT --out allsample_alelosRAW
      cp allsample_alelosRAW.GT.FORMAT allsample_alelosRAW.txt
      sed -i 's/|/\//g' "allsample_alelosRAW.txt"
      sed -i 's/\.\/\./NADA/g' "allsample_alelosRAW.txt"
      sed -i 's/0\/2/NADA/g' "allsample_alelosRAW.txt"
      sed -i 's/1\/2/NADA/g' "allsample_alelosRAW.txt"
      sed -i 's/2\/2/NADA/g' "allsample_alelosRAW.txt"
      sed '/NADA/d' "allsample_alelosRAW.txt" > "allsample_alelosRAW.csv"
