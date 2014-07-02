This package contains a set of function to compute the gradient singular value decomposition image quality assessment measure proposed in:

"Non-reference assessment of sharpness in blur/noise
degraded images", Ospina-Borras, J.E., Benitez-Restrepo, H.D.,2014.

The main function is gsvd.m. 

Given an image I and model_gsvd.mat, an example of the use of this function is:

I=imread('Man.png');
score=gsvd(I);

This code uses auxiliar functions:
-SVDCoherence.m		, which computes the singular value decomposition of the image gradient
-AnisoSetEst.m		, which identifies the anisotropic patches of the image I
-mscn.m			, which computes the mean substract contrast normalization of the image I


Moreover, this package contains one function  (compute_model.m) to create the reference model of the above image quality assessment measure, but it need a set of pristine images available at http://live.ece.utexas.edu/research/quality/pristinedata.zip, which must be located in 'GSVD_release'. Also, three folders has been created with the performance results in LIVE, CSIQ and TID2008 image databases. Each one contains the prediction for a set of No-reference and Full-reference image quality assessment measures, and contains one routine that computes: Spearman Rank-order (SRCC), Pearson linear (PLCC), and Kendall correlation coefficients (KCC) and the root mean square error (RMSE).


Copyright (c) 2014 Pontificia Universidad Javeriana Sede Cali
All rights reserved.

Permission is hereby granted, without written agreement and without license or royalty fees, to use, copy, modify, and distribute this code and its documentation for any purpose, provided that the copyright notice in its entirety appear in all copies of this code, and the original source of this code, the Pontificia Universidad Javeriana Sede Cali, is acknowledged in any publication that reports research using this code. The research is to be cited in the bibliography as:

1) J.E Ospina-Borras and H.D. Benitez-Restrepo, "GSVD Software Release", 
URL: XXX, 2014

2) J.E Ospina-Borras and H.D. Benitez-Restrepo, "Non-reference assessment of sharpness in blur/noise degraded images"
submitted

Author  : J.E Ospina-Borras  
Version : 1.0

The authors are with the Department of Electronics and Computer Science, Pontificia Universidad Javeriana-Cali.

Kindly report any suggestions or corrections to ospina.juanesteban@gmail.com



