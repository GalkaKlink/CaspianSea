# CaspianSea
**Scripts for paper "Temporal change in plant communities and its relationship to soil salinity and microtopography on the Caspian Sea coast"**

The following scripts are located in this folder:

lost_species.BINOMIAL.pl - perl script for calculating hypergeometric probablity of over- 
                           or underrepresentation of families among species thet were lost
                           in old site in compare with young site

NRI.Caspii.pl - perl scripts for calculating Mean Pairwise Distance (MPD) and significance of its
                 difference from the expectation. Also calculates Net Relatedness Index (NRI).

BareGround_vs_Salinity.R - R sript. Calculates Spaerman correlation between percent of bare ground 
                           and salinity on different depths. 

PlantFeaturesImportance.R - R script. Calculates Fisher's exact test to test the importance of
                            several plant features for growing in the old key site.

Association_with_tamarix.R = R script. Calculates Fisher's exact test to test the dependency of each species
                         on the presence of Tamarix bushes.

BareGround_vs_Microtopography.R - R script. Compares % of bare ground in microhighs and microlows of young 
                                  and old sites with Mann-Whitney test.

Species_and_Microtopography.R - R script. Using Fisher's exact test, tests the assumption of random distribution of each species 
                                between microhighs and microlows. 
                                
TaxonomicDiversityIndex.R - R script. Calculates the taxonomic distinctness index for a community 

ProbOfLoss_vs_ProjectiveCover.R - R script. Tests the hypothesis that species that were lost and retained in the 'late' site had similar prevalence in the 'early' site

