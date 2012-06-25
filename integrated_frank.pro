FUNCTION integrated_frank,u1,u2,theta
 
  IF theta eq 0. THEN BEGIN
     copula = u1*u2                ;no correlation copula
  ENDIF ELSE BEGIN
     ko     = ( exp(-theta*u1)-1. ) * ( exp(-theta*u2)-1. )
     haha   = exp(-theta) - 1.
     copula = -1./theta*alog(1.+ko/haha)
  ENDELSE
  
  RETURN,copula
END
