;return theta of a Kendall tau
FUNCTION cal_theta,tau,coupla_name=copula_name

  IF strmatch(copula_name,'Gauss') OR strmatch(copula_name,'t') THEN BEGIN
     theta = sin(!PI*tau/2.)
  ENDIF ELSE IF strmatch(copula_name,'Frank') THEN BEGIN 
     message,'mendokusai'
  ENDIF ELSE IF strmatch(copula_name,'Gumbel') THEN BEGIN
     theta = 1./(1.-tau)
  ENDIF ELSE IF strmatch(copula_name,'Clayton') THEN BEGIN
     theta = tau/2./(1.-tau)
  ENDIF ELSE BEGIN
     message,'error --- copula'
  ENDELSE

  RETURN,theta
END
