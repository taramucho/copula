;d/dx C(x,y)
;C --- integrated Clayton function
FUNCTION dx_integrated_clayton,u1,u2,theta
 
  IF theta eq 0. THEN BEGIN
     copula = u2                ;no correlation copula
  ENDIF ELSE BEGIN
     u_sum = u1^(-theta) + u2^(-theta) -1.
     IF u_sum ge 0. THEN BEGIN
        copula = u1^(-theta-1.)*(u_sum^(-1.-1./theta))
     ENDIF ELSE BEGIN
        copula = 0.
     ENDELSE
  ENDELSE
  
  RETURN,copula
END
