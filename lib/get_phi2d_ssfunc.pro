;ssfunc --- Schechter for mass and Saunders for SFR
;log_M   = mk_arr(10.,12.,20)
;log_SFR = mk_arr(10.,12.,20)
FUNCTION get_phi2d_ssfunc,log_M,log_SFR,phi_sch,phi_sa,Param,copula_name,copula=copula

  print,'get_phi2d_ssfunc...'
  sz_M   = n_elements(M)
  sz_sfr = n_elements(sfr)
  phi_2d = replicate(!values.f_nan,sz_M,sz_sfr)
  copula = replicate(!values.f_nan,sz_M,sz_sfr)
  u1     = replicate(!values.f_nan,sz_M)
  u2     = replicate(!values.f_nan,sz_sfr)


  I_sch_mid = qromo('schechter_q', alog10(M_int_lim),   /midexp)
  I_sa_mid  = qromo('saunders_q',  alog10(sfr_int_lim), /midexp)

  I_sch_max = qromo('schechter_q', alog10(M_int_lim),   alog10(max(M)))
  I_sa_max  = qromo('saunders_q',  alog10(sfr_int_lim), alog10(max(sfr)))

  I_sch = (I_sch_mid > I_sch_max)
  I_sa  = (I_sa_mid  > I_sa_max)  ;debug for integration

  FOR i=0L,sz_M-1L DO BEGIN
     psi_sch = qromo('schechter_q', alog10(M_int_lim), alog10(M[i]))
     u1[i]   = psi_sch/I_sch
  ENDFOR
  FOR i=0L,sz_sfr-1L DO BEGIN
     psi_sa  = qromo('saunders_q',  alog10(sfr_int_lim), alog10(sfr[i]))
     u2[i]   = psi_sa/I_sa
  ENDFOR
  

  FOR i=0L,sz_M-1L DO BEGIN
     FOR j=0L,sz_sfr-1L DO BEGIN
        
        IF u1[i] ge 1. OR u2[j] ge 1. THEN BEGIN
           message,'error --- u1,u2'
        ENDIF
        
        copula[i,j] = cal_copula(u1[i],u2[j],Param,copula_name=copula_name)
        phi_2d[i,j] = copula[i,j] $
                      *phi_sch[i]*phi_sa[j]/I_sch/I_sa
     ENDFOR
  ENDFOR

  RETURN,phi_2d

  
  

  message,'hoge'

  RETURN,'hoge'
END
