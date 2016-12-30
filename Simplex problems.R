> library(lpSolve)
> obj.frm<-c(300,500)
> constr<-matrix(c(1,0,0,2,3,2), ncol=2, byrow=TRUE)
> rhs<-c(4,12,18)
> constr.dir<-c("<=","<=","<=")
> rohit.so<-lp("max", obj.frm, constr, constr.dir, rhs,compute.sens=TRUE)
> rohit.so