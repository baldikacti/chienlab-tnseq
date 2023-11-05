# --- Concatanate tab files --- #
## concat_ttl_full           : Concatanates .tab count files into a single tsv file
rule concat_ttl_full:
    input:
        script = config["script"] + "concat.R",
        ref = config["ref"]["map_full"],
        data_dir = config["results"] + "read_counts/totalcounts_full/",
        data = expand(config["results"] + "read_counts/totalcounts_full/{smp}.totalcounts.tab",smp=SAMPLES)
    output:
        config["results"] + "read_counts/totalcounts_full.tsv"
    shell:
        "Rscript {input.script} {input.ref} {input.data_dir} {output}"

rule concat_ttl_mid:
    input:
        script = config["script"] + "concat.R",
        ref = config["ref"]["map_full"],
        data_dir = config["results"] + "read_counts/totalcounts_mid/",
        data = expand(config["results"] + "read_counts/totalcounts_mid/{smp}.totalcounts.tab",smp=SAMPLES)
    output:
        config["results"] + "read_counts/totalcounts_mid.tsv"
    shell:
        "Rscript {input.script} {input.ref} {input.data_dir} {output}"

rule concat_unq_full:
    input:
        script = config["script"] + "concat.R",
        ref = config["ref"]["map_full"],
        data_dir = config["results"] + "read_counts/uniquecounts_full/",
        data = expand(config["results"] + "read_counts/uniquecounts_full/{smp}.uniquecounts.tab",smp=SAMPLES)
    output:
        config["results"] + "read_counts/uniquecounts_full.tsv"
    shell:
        "Rscript {input.script} {input.ref} {input.data_dir} {output}"

rule concat_unq_mid:
    input:
        script = config["script"] + "concat.R",
        ref = config["ref"]["map_full"],
        data_dir = config["results"] + "read_counts/uniquecounts_mid/",
        data = expand(config["results"] + "read_counts/uniquecounts_mid/{smp}.uniquecounts.tab",smp=SAMPLES)
    output:
        config["results"] + "read_counts/uniquecounts_mid.tsv"
    shell:
        "Rscript {input.script} {input.ref} {input.data_dir} {output}"