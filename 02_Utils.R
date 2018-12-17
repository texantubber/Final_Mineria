# Calcular la moda de un vector
getmode <- function(x) {
  uniqx <- unique(x)
  uniqx[which.max(tabulate(match(x, uniqx)))]
}

imputarLags<-function(x){
  
  non_na<-which(is.na(x)==FALSE)[1]
  
  if(non_na>1){
  x[which(is.na(x))]<-x[non_na]
  }
  x
}
