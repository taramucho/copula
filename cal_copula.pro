;calculate 2-dim various copulas
;(u1,u2) --- cumulative probability funciton at x1,x2
;Param   --- {theta, dof}
;theta     --- charcteristic parameter of a copula 
;dof     --- degree of freedom (only for t distribution)
;copula_name = {Gauss, Frank, Gumbel, t}
;copula = {Gauss, Frank, Gumbel, t}
;
;
;==========  theta range ===========================
;This program is unstable
; at minmax(theta) and limit theta
; due to unstability of used programs.
;
;
;Gauss        0<=theta<=1     
;Frank        -inf<theta<inf
;Gumbel       1<=theta
;t            0<=theta<=1, 0<dof
;Clayton      -1<theta<inf          (unstable theta<-0.5)
;extended copula 0<=t1,t2<=1
;=================================================
FUNCTION cal_copula,u1,u2,Param,copula_name=copula_name
 
  theta = Param.theta
  
  IF u1 lt 0. OR u1 gt 1. OR u2 lt 0. OR u2 gt 1. THEN BEGIN
     message,'error --- (u1,u2) need [0,1]'
  ENDIF

  ;which copula?
  IF strmatch(copula_name,'Gauss') THEN BEGIN
     copula = gauss_copula(u1,u2,theta)
  ENDIF ELSE IF strmatch(copula_name,'Frank') THEN BEGIN
     copula = frank(u1,u2,theta)
  ENDIF ELSE IF strmatch(copula_name,'Gumbel') THEN BEGIN
     copula = gumbel(u1,u2,theta)
  ENDIF ELSE IF strmatch(copula_name,'t') THEN BEGIN
     copula = t_copula(u1,u2,theta,Param.dof)
  ENDIF ELSE IF strmatch(copula_name,'Clayton') THEN BEGIN
     copula = clayton(u1,u2,theta)
  ENDIF ELSE IF strmatch(copula_name,'ext_Gumbel') THEN BEGIN
     
     t1 = Param.t1
     t2 = Param.t2
     mae    = -t1*u1^t1 * $
              ( (t2-1.)*dx_integrated_gumbel(u1^t1,u2^t2,theta) $
                -t2*u2^t2*gumbel(u1^t1,u2^t2,theta) )
     
     ushiro = -(t1-1.)*t2*u2^t2*dx_integrated_gumbel(u2^t2,u1^t1,theta) $ ;due to symmetry
              +(t1-1.)*(t2-1.)*integrated_gumbel(u1^t1,u2^t2,theta)
     sum = mae + ushiro

     copula = u1^(-t1) * u2^(-t2) *  sum

  ENDIF ELSE IF strmatch(copula_name,'ext_Clayton') THEN BEGIN
     
     t1 = Param.t1
     t2 = Param.t2
     mae    = -t1*u1^t1 * $
              ( (t2-1.)*dx_integrated_clayton(u1^t1,u2^t2,theta) $
                -t2*u2^t2*clayton(u1^t1,u2^t2,theta) )
     
     ushiro = -(t1-1.)*t2*u2^t2*dx_integrated_clayton(u2^t2,u1^t1,theta) $ ;due to symmetry
              +(t1-1.)*(t2-1.)*integrated_clayton(u1^t1,u2^t2,theta)
     sum = mae + ushiro

     copula = u1^(-t1) * u2^(-t2) *  sum
     
  ENDIF ELSE IF strmatch(copula_name,'ext_Frank') THEN BEGIN
     
     t1 = Param.t1
     t2 = Param.t2
     mae    = -t1*u1^t1 * $
              ( (t2-1.)*dx_integrated_frank(u1^t1,u2^t2,theta) $
                -t2*u2^t2*frank(u1^t1,u2^t2,theta) )
     
     ushiro = -(t1-1.)*t2*u2^t2*dx_integrated_frank(u2^t2,u1^t1,theta) $ ;due to symmetry
              +(t1-1.)*(t2-1.)*integrated_frank(u1^t1,u2^t2,theta)
     sum = mae + ushiro

     copula = u1^(-t1) * u2^(-t2) *  sum

  ENDIF ELSE BEGIN
     message,'error --- copula'
  ENDELSE 
  
  RETURN,copula
END
