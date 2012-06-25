FUNCTION dx_integrated_frank,u1,u2,theta
 
  IF theta eq 0. THEN BEGIN
     copula = u2                ;no correlation copula
  ENDIF ELSE BEGIN
     ko     =  exp(theta) * ( exp(theta*u2)-1. )
     haha   = -exp(theta*(u1+u2)) + exp(theta*(u1+1.)) + exp(theta*(u2+1.)) - exp(theta) 
     copula = ko/haha
  ENDELSE
  
  RETURN,copula
END
