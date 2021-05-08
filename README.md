# design_index_sequence
Calculate edit distances within  a list of sequence

## Background and motivation
To compute a good set of indexes, making sure that the index are unique and diverse, as well as GC balance and do not contain excessive runs of bases. 

## Implementation
R markdown notebooks are used because so that user can knit a document by supplying their list of indexes. Different heatmap and statistic can be recorded in the same document, making it easy to visualize the quality of the set of indexes. 
For use of notebooks, please see the instructions within the notebook document. 

## Thoughts
This repo is only intended for exploration. As there are sets of indexes already generated and can be purchased from various companies, there are little reason to generate a new set of not validated indexes. Instead, the value of this repo is to verify the incoming list index, such that we can make sure that the set of indexes are well within user-defined threshold.
In brief, please treat it as a validation tool, instead of a index-generator. 

## TODOs
1. The way the run of bases are calculated will consider broken up repeats as runs, which may be too conservative and do not accurately represent the run of bases in the index.
2. Infinite-monkey way of identifying sets of indexes is not efficient. Instead, a bottom up approach in generating a set of indexes based on a set of rules may be more appropriate. 
