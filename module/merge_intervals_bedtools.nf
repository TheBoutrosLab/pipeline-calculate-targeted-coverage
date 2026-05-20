include { generate_standard_filename } from '../external/pipeline-Nextflow-module/modules/common/generate_standardized_filename/main.nf'
/*
*   Module/process description here
*
*   @input  <name>  <type>  <description>
*   @params <name>  <type>  <description>
*   @output <name>  <type>  <description>
*/
process run_merge_BEDtools {
    container params.docker_image_bedtools

    publishDir path: "${params.workflow_output_dir}/output/",
        pattern: "*.bed",
        mode: "copy"

    input: 
        path input_depth_bed

    output:
        path "*.bed", emit: bed

    script:

    output_filename = generate_standard_filename(
        "BEDtools-${params.bedtools_version}",
        params.dataset_id,
        params.sample_id,
        [
            'additional_information': "collapsed-coverage.bed"
        ]
    )

    """
    set -euo pipefail

    bedtools \
        merge \
        -i ${input_depth_bed} \
        -c 4 \
        -o ${params.merge_operation} \
        > ${output_filename}
    """
}
