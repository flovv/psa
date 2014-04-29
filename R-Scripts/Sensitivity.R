## Sensitivity Analysis

require(rbounds)
data(lalonde)

Y  <- lalonde$re78   #the outcome of interest
Tr <- lalonde$treat #the treatment of interest
attach(lalonde)
#The covariates we want to match on
X = cbind(age, educ, black, hisp, married, nodegr, u74, u75, re75, re74)
#The covariates we want to obtain balance on
BalanceMat <- cbind(age, educ, black, hisp, married, nodegr, u74, u75, re75, re74,
					I(re74*re75))
detach(lalonde)

gen1 <- GenMatch(Tr=Tr, X=X, BalanceMat=BalanceMat, pop.size=50,
                  data.type.int=FALSE, print=0, replace=FALSE)
mgen1 <- Match(Y=Y, Tr=Tr, X=X, Weight.matrix=gen1, replace=FALSE)
summary(mgen1)

psens(mgen1, Gamma=1.5, GammaInc=.1)
hlsens(mgen1, Gamma=1.5, GammaInc=.1, .1)
