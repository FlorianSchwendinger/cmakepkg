
#include <Rcpp.h>
#include <foo.h>
using namespace Rcpp;

// [[Rcpp::export]]
int best_number() {
    BestNumber obj;
    int x = obj.get();
    return x;
}
