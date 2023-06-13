

configfile:
    "config.json"

SAMPLES = config['samples']
DIRS = config['directories']
    


rule all:
    input:
        multiext(config['genome'],".amb", ".ann", ".bwt", ".pac", ".sa"),
        expand(config['data']+"/{dir}/{sample}_aligned_reads.sam", zip, dir=DIRS, sample=SAMPLES),
        expand(config['data']+"/{dir}/{sample}_dedup_metrics.txt", zip, dir=DIRS, sample=SAMPLES),
        expand(config['data']+"/{dir}/{sample}_sorted_dedup_reads.bam", zip, dir=DIRS, sample=SAMPLES),
        expand(config['data']+"/{dir}/{sample}_raw_variants.g.vcf", zip, dir=DIRS, sample=SAMPLES),
        expand(config['data']+"/{dir}/{sample}.bamout.bam", zip, dir=DIRS, sample=SAMPLES)
    	     	 
     
rule referencia:
    input:
    	ref = config['genome']
    
    output:
    	out1=multiext(config['genome'],".amb", ".ann", ".bwt", ".pac", ".sa")
    	
  	 
    conda:
    	"environment.yaml"	
    shell:
    	"""
    	bwa index {input.ref} > {output.out1}
   	picard CreateSequenceDictionary R={input.ref}
   	samtools faidx {input.ref}
   	"""


rule alignment:
    input:
    	multiext( config['genome'],".amb", ".ann", ".bwt", ".pac", ".sa"),
    	fastq1=config['data']+"/{sample}_paired1.fastq",
    	fastq2=config['data']+"/{sample}_paired2.fastq"
    	
     
    output:
    	config['data']+"/{dir}/{sample}_aligned_reads.sam"
	
    params:
    	rg = "@RG\\tID:{sample}\\tLB:{sample}\\tPL:ILLUMINA\\tPM:HISEQ\\tSM:{sample}",
      	ref = config['genome']
    conda:
    	"environment.yaml"
    shell:
    	"bwa mem -K 100000000 -Y -R '{params.rg}' {params.ref} {input.fastq1} {input.fastq2} > {output}"
	


rule duplicates:
    input:
    	config['data']+"/{dir}/{sample}_aligned_reads.sam"
    output:
    	metrics=config['data']+"/{dir}/{sample}_dedup_metrics.txt",
    	sorted=config['data']+"/{dir}/{sample}_sorted_dedup_reads.bam"
    conda:
    	"environment.yaml"
    shell:
    	"gatk MarkDuplicatesSpark -I {input} -M {output.metrics} -O {output.sorted}"
    	



rule calling:
    input:
    	ref=config['genome'],
    	sorted=config['data']+"/{dir}/{sample}_sorted_dedup_reads.bam"
    	
    output:
    	raw=config['data']+"/{dir}/{sample}_raw_variants.g.vcf",
    	bamoutfile=config['data']+"/{dir}/{sample}.bamout.bam"
    conda:
    	"environment.yaml"
    shell:
    	"gatk HaplotypeCaller -ERC GVCF -bamout {output.bamoutfile} -R {input.ref} -I {input.sorted} -O {output.raw}"
    



