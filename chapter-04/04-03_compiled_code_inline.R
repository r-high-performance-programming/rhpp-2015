library(inline)
mov.avg.inline <- cfunction(
    sig=signature(x="numeric", n="integer"),
    body="
    /* Coerce arguments to the correct types needed.
       x needs to be a numeric vector (type REALSXP), and n
       needs to be an integer vector (type INTSXP). */
    SEXP x2 = PROTECT(coerceVector(x, REALSXP));
    SEXP n2 = PROTECT(coerceVector(n, INTSXP));
    
    /* Create accessors to the actual data being pointed to by
       the two SEXP's. */
    double *x_p = REAL(x2);
    int n_val = asInteger(n2);
    
    // Vector lengths
    int x_len = length(x2);
    int res_len = x_len - n_val + 1;
    
    /* Create and initialize a numeric vector (type REALSXP)
       of length res_len, using allocVector().
       Since memory is allocated, use PROTECT to protect the
       object from R's garbage collection. */
    SEXP res = PROTECT(allocVector(REALSXP, res_len));
    double *res_p = REAL(res);
    for (int i = 0; i < res_len; i++) {
        res_p[i] = 0;
    }
    
    // Compute window sum.
    for (int j = 0; j < n_val; j++) {
        for (int k = 0; k < res_len; k++) {
            res_p[k] += x_p[j + k];
        }
    }
    
    // Compute moving average.
    for (int l = 0; l < res_len; l++) {
        res_p[l] /= n_val;
    }
    
    // Unprotect allocated memory and return results.
    UNPROTECT(3);
    return res;
    ",
    language="C"
)

# Test and benchmark
x <- runif(100)
all(mov.avg(x, 20) == mov.avg.inline(x, 20))
library(microbenchmark)
microbenchmark(mov.avg(x, 20), mov.avg.inline(x, 20))
y <- runif(1e7)
microbenchmark(mov.avg(y, 20), mov.avg.inline(y, 20))
