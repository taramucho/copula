FUNCTION integrated_gumbel,u1,u2,theta
 
  IF theta eq 1. THEN BEGIN
     integrated_copula = u1*u2 ;no correlation integrated copula
  ENDIF ELSE BEGIN
     p1     = -alog(u1)
     p2     = -alog(u2)
     sigma  = p1^theta + p2^theta
     integrated_copula = exp( -sigma^(1./theta) )
  ENDELSE
 
  RETURN,integrated_copula
END
