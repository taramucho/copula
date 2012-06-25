FUNCTION gumbel,u1,u2,theta
 
  IF theta eq 1. THEN BEGIN
     copula = 1.                ;no correlation copula
  ENDIF ELSE BEGIN
     p1     = -alog(u1)
     p2     = -alog(u2)
     sigma  = p1^theta + p2^theta
     copula = (1./u1/u2) *(p1^(theta-1.)) *(p2^(theta-1.)) * exp(-sigma^(1./theta)) $
              *( sigma^(1./theta) +theta -1. ) *(sigma^(1./theta-2.)) 
  ENDELSE
  
  RETURN,copula
END
