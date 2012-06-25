FUNCTION gauss_copula,u1,u2,theta
 
  p_cvf = 1.-u1
  q_cvf = 1.-u2
  p = gauss_cvf(p_cvf)
  q = gauss_cvf(q_cvf)
  naka = (2.*theta*p*q-theta*theta*p*p-theta*theta*q*q) / (2.*(1.-theta*theta))
  copula = exp(naka)/sqrt(1.-theta*theta)
  
  RETURN,copula
END
