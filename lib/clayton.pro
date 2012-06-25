FUNCTION clayton,u1,u2,theta
 
  IF theta eq 0. THEN BEGIN
     copula = 1.                ;no correlation copula
  ENDIF ELSE BEGIN
     u_sum = u1^(-theta) + u2^(-theta) -1.
     IF u_sum ge 0. THEN BEGIN
        copula = (1.+theta) * (u1^(-theta-1.)) * (u2^(-theta-1.)) $
                 * (u_sum^(-1./theta-2.))
     ENDIF ELSE BEGIN
        copula = 0.
     ENDELSE
  ENDELSE
    
  RETURN,copula
END
