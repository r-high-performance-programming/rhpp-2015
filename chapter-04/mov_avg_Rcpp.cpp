#include <Rcpp.h>

// [[Rcpp::export]]
Rcpp::NumericVector mov_avg_Rcpp(Rcpp::NumericVector x,
                                 int n=20) {
    // Vector lengths
    int x_len = x.size();
    int res_len = x_len - n + 1;
    
    // Create and initialize vector for results
    Rcpp::NumericVector res(res_len);
    
    // Compute window sum
    for (int j = 0; j < n; j++) {
        for (int k = 0; k < res_len; k++) {
            res[k] += x[j + k];
        }
    }
    
    // Compute moving average
    for (int l = 0; l < res_len; l++) {
        res[l] /= n;
    }
    
    // Return results
    return res;
}
