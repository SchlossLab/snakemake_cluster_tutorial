######################################################
#                                                    #
#             Cluster Tutorial Snakefile:            #
#          Analyzing and plotting book text          #
#                                                    #
######################################################


# # Setting the workflow config file (if desired)
# # NOTE: If using, comment out line 17 and change all calls
# # for 'BOOKS' to config['BOOKS'] throughout Snakefile
# configfile: "config/config.yaml"

# OR

# Defining book names within workflow
BOOKS = glob_wildcards('books/{book}.txt').book

# Defining which rules to run locally when submitted to cluster
# (will not be ran as job submissions)
localrules: all, clean, make_archive



### Running the Workflow ###

# Run the entire workflow
rule all:
    input:
        'results/zipf_analysis.tar.gz'


# Delete everything so we can re-run things
rule clean:
    shell:  
        '''
        rm -rf results/ __pycache__/
        '''



### Workflow Rules ###

### 1. Generating Results ###

# Count words in one of our "books"
rule count_words:
    input:  
        script='code/wordcount.py',
        book='books/{book}.txt'
    output:
        data='results/{book}.dat'
    shell:
        'python {input.script} {input.book} {output.data}'


# Create a plot for each book
rule make_plot:
    input:
        script='code/plotcount.py',
        book=rules.count_words.output.data
    output:
        plot='results/{book}.png'
    shell:
        'python {input.script} {input.book} {output.plot}'


# Generate summary table
rule zipf_test:
    input:  
        script='code/zipf_test.py',
        book=expand(rules.count_words.output.data,
            book=BOOKS)
    output:
        table='results/results.txt'
    shell:
        'python {input.script} {input.book} > {output.table}'



### 2. Archiving Results ###

# Create an archive with all of our results
rule make_archive:
    input:
        data=expand(rules.count_words.output.data,
            book=BOOKS),
        plot=expand(rules.make_plot.output.plot,
            book=BOOKS),
        table=rules.zipf_test.output.table
    output:
        tar='results/zipf_analysis.tar.gz'
    shell:
        'tar -czvf {output.tar} {input}'
