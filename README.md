### Description
Abnormal Detection using NNMF on MIT video surveillance dataset
% updated: 01 July 2016
### Contact
Dr Vu Nguyen, v.nguyen@deakin.edu.au

### Citation
  Bayesian Nonparametric Approaches to Abnormality Detection in Video Surveillance. Nguyen, V., Phung, D., Pham, D. S., & Venkatesh, S  In Annals of Data Science, pp 1-21, 2015.
  Interactive Browsing System for Anomaly Video Surveillance. T.V. Nguyen, D. Phung, S. K. Gupta, and S Venkatesh In IEEE Eighth International Conference on Intelligent Sensors, Sensor Networks and Information Processing (ISSNIP), pp 384-389, 2013.

### Run
The data has been preprocessed for background subtraction. (see script script_extract_feature.m)
In the paper, we use Bayesian Nonparametric Factor Analysis which identifies K=40 hidden patterns from the data. However the posterior inference is slow. Thus, here we use the built-in function nnmf from Matlab for optimizing speed.

run the demo_abnormal_detection.m	

