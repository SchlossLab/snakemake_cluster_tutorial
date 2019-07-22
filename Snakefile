######################################################
#                                                    #
#             Cluster Tutorial Snakefile:            #
#          Analyzing and plotting book text          #
#                                                    #
######################################################


# # Setting the workflow config file
# configfile: "config/config.yaml"

# Defining book names (data samples)
BOOKS = glob_wildcards('books/{book}.txt').book

# Defining which rules to run locally (not on the cluster)
localrules: all, clean, make_archive



### Running the Workflow

rule all:
    input:
        'zipf_analysis.tar.gz'

# delete everything so we can re-run things
# deletes a little extra for purposes of lesson prep
rule clean:
    shell:  
        '''
        rm -rf results BOOKS plots __pycache__
        rm -f results.txt zipf_analysis.tar.gz *.out *.log *.pyc
        '''


### 1. Calculating Book Statistics

# count words in one of our "books"
rule count_words:
    input:  
        wc='wordcount.py',
        book='books/{file}.txt'
    output:
        'BOOKS/{file}.dat'
    threads: 4
    log: 
        'BOOKS/{file}.log'
    shell:
        '''
        echo "Running {input.wc} with {threads} cores on {input.book}." &> {log} &&
            python {input.wc} {input.book} {output} &>> {log}
        '''


# create a plot for each book
rule make_plot:
    input:
        plotcount='plotcount.py',
        book='BOOKS/{file}.dat'
    output:
        'plots/{file}.png'
    resources:
        gpu=1
    shell: 'python {input.plotcount} {input.book} {output}'


###

# generate summary table
rule zipf_test:
    input:  
        zipf='zipf_test.py',
        books=expand('BOOKS/{book}.dat', book=BOOKS)
    output:
        'results.txt'
    shell:
        'python {input.zipf} {input.books} > {output}'

# create an archive with all of our results
rule make_archive:
    input:
        expand('plots/{book}.png', book=BOOKS),
        expand('BOOKS/{book}.dat', book=BOOKS),
        'results.txt'
    output:
        'zipf_analysis.tar.gz'
    shell:
        'tar -czvf {output} {input}'

