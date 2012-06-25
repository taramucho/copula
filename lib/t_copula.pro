FUNCTION t_copula,u1,u2,theta,dof
 
  p_cvf = 1.-u1
  q_cvf = 1.-u2
  p = t_cvf(p_cvf, dof)         ;dof (degree of freedom)
  q = t_cvf(q_cvf, dof)
  ko   = ( 1.+ (p*p+q*q-2.*theta*p*q)/(dof*(1.-theta*theta)) )^(-(dof+2.)/2.)
  haha = 2.*!PI*sqrt(1.-theta*theta)*t_dist(p,dof)*t_dist(q,dof) 
  copula = ko/haha
  
  RETURN,copula
END
