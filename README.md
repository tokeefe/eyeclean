# eyeclean: Automated ICA-based ocular correction algorithm for EEG

> [!WARNING]
> This was my very first open-source software release (originally published 
> circa 2010 on code.google.com). It is now hosted here on GitHub for 
> historical reference. More advanced and robust tools for ocular artifact 
> removal in EEG are now available. Use this project mainly for educational 
> or archival purposes.

eyeClean is a fully-automated, ocular correction (saccades, blinks) algorithm 
for EEG data, based on second-order blind identification (SOBI ICA) and 
sliding-window correlations.

Requires EEGLAB SOBI sobi() method.

Generalized to clean any arbitrary Matlab array (e.g. EEG) by input of a 
known set of artifact timeseries e.g. EOG.

function discard = clean(data,artifact,window,nits,alpha,debug,EEG)

Output: discard - returns IC row indices identified as artifact

Input: data - Matlab array of EEG timeseries artifact - artifact timeseries window - sliding window width nits - number of iterations (to build null hypothesis) alpha - reject probability threshold debug - plot channel topology (requires EEGLAB) EEG - EEGLAB EEG struct

All code written in Matlab.

# Acknowledgements

Special thanks to Jerome N. Sanes PhD, Elie Bienenstock PhD, and Rick Archibald PhD.
