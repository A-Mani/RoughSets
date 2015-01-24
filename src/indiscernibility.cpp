#include <Rcpp.h>
using namespace Rcpp;

template<typename T>
inline bool filter(T const & x){
  return x.size() <= 1;
}

// [[Rcpp::export]]
List compute_indiscernibility(List input, CharacterVector attr_val, CharacterVector unique_attr_val) {
  std::map<String, int> numbers;
  for (int i=0; i<unique_attr_val.size(); ++i) {
    numbers[unique_attr_val[i]] = i;
  }
  int numbers_size = numbers.size();
  int input_size = input.size();
  std::vector<std::vector<int> > result(input_size*numbers_size);
  for (int i=0; i<input_size; ++i) {
    IntegerVector ind_class = input[i];
    int ind_class_size = ind_class.size();
    for (int j=0; j<ind_class_size; ++j) {
      result[i*numbers_size+numbers[attr_val[ind_class[j]-1]]].push_back(ind_class[j]);  
    }
  }
  result.erase(std::remove_if(result.begin(), result.end(), filter<std::vector<int> >), result.end());
  return wrap(result);
}
