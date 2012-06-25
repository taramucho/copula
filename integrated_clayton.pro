FUNCTION integrated_clayton,u1,u2,theta
 
  IF theta eq 0. THEN BEGIN
     integrated_copula = u1*u2 ;no correlation integrated copula
  ENDIF ELSE BEGIN
     u_sum = u1^(-theta) + u2^(-theta) -1.
     IF u_sum ge 0. THEN BEGIN 
        integrated_copula = u_sum^(-1./theta)
     ENDIF ELSE BEGIN
        integrated_copula = 0.
     ENDELSE
  ENDELSE
 
  RETURN,integrated_copula
END
