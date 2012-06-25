;d/dx G(x,y)
;G --- integrated Gumbel function
FUNCTION dx_integrated_gumbel,u1,u2,theta
 
  IF theta eq 1. THEN BEGIN
     copula = 1.                ;no correlation copula
  ENDIF ELSE BEGIN
     p1     = -alog(u1)
     p2     = -alog(u2)
     sigma  = p1^theta + p2^theta
     copula = 1./u1 $
              * ( p1^(theta-1.) * integrated_gumbel(u1,u2,theta) * sigma^(1./theta-1.) ) 
  ENDELSE
  
  RETURN,copula
END
