
#include <Rcpp.h>
#include <foo.h>
using namespace Rcpp;

// [[Rcpp::export]]
int rcpp_best_number() {
    BestNumber obj;
    int x = obj.get();
    return x;
}
