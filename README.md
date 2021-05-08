# design_index_sequence
Calculate edit distances within  a list of sequence

## Background and motivation
To compute a good set of indexes, making sure that the index are unique and diverse, as well as GC balance and do not contain excessive runs of bases. 

## Implementation
R markdown notebooks are used because so that user can knit a document by supplying their list of indexes. Different heatmap and statistic can be recorded in the same document, making it easy to visualize the quality of the set of indexes. 
For use of notebooks, please see the instructions within the notebook document. 

## TODOs
1. The way the run of bases are calculated will consider broken up repeats as runs, which may be too conservative and do not accurately represent the run of bases in the index.
2. Infinite-monkey way of identifying sets of indexes are not efficient at all. Instead, a bottom up approach in generating a set of indexes based on a set of rules may be more appropirate. 
