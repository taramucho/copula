PRO pl_gauss_gauss,Param,copula_name=copula_name,no_1dim_pl=no_1dim_pl
  COMMON XW, XW

  print,Param
  sz_x   = 60
  sz_y   = 60
  x      = findgen(sz_x)/10.-3.
  y      = findgen(sz_y)/10.-3.
  delx   = x[1]-x[0]
  dely   = y[1]-y[0]
  z      = replicate(!values.f_nan,sz_x,sz_y)
  copula = replicate(!values.f_nan,sz_x,sz_y)
  u1     = replicate(!values.f_nan,sz_x)
  u2     = replicate(!values.f_nan,sz_y)
  fx     = replicate(!values.f_nan,sz_x)
  fy     = replicate(!values.f_nan,sz_y)
  

  FOR i=0L,sz_x-1L DO BEGIN
     u1[i] = 1.-qromo('norm_gauss',x[i],/midexp)
  ENDFOR
  FOR i=0L,sz_y-1L DO BEGIN
     u2[i] = 1.-qromo('norm_gauss',y[i],/midexp)
  ENDFOR

  FOR i=0L,sz_x-1L DO BEGIN
     print,i,'/',sz_x
     FOR j=0L,sz_y-1L DO BEGIN
        copula[i,j] = cal_copula(u1[i],u2[j],Param,copula_name=copula_name)
        z[i,j]      = copula[i,j]*norm_gauss(x[i])*norm_gauss(y[j])
     ENDFOR
  ENDFOR
  
  loadct,3
  mk_window,XW
  cgcontour,z,x,y,nlevels=20L, $
            /fill,xtit='x',ytit='y',tit='Prob Gaussian * Gaussian',$
            xr=minmax(x),yr=minmax(y),/xsty,/ysty
  
  loadct,33
  mk_window,XW
  cgcontour,alog10(copula),u1,u2,nlevels=20L, $
            /fill,xtit='u1',ytit='u2',tit='log (copula density)',$
            xr=[0.,1.],yr=[0.,1.],/xsty,/ysty
  
  
  ;check 1-dim distribution
  FOR i=0L,sz_x-1L DO BEGIN
     fx[i] = total(z[i,*])*delx
  ENDFOR
  FOR i=0L,sz_y-1L DO BEGIN
     fy[i] = total(z[*,i])*dely
  ENDFOR

  IF ~keyword_set(no_1dim_pl) THEN BEGIN
     loadct,0
     mk_window,XW
     plot,x,fx,xtit='x',ytit='prob. density',chars=1.1,/xsty,/ysty,psym=8
     oplot,x,norm_gauss(x),col=fsc_color('red')
     mk_window,XW
     plot,y,fy,xtit='y',ytit='prob. density',chars=1.1,/xsty,/ysty,psym=8
     oplot,y,norm_gauss(y),col=fsc_color('red')
     wait,0.5
   
     delete_window,XW
     delete_window,XW
  ENDIF

END

PRO gauss_gauss
  COMMON XW, XW
  XW = {sz:{x:200L,y:200L}, x:0L, y:800L}
  plotsym,0,1,/fill


  sz_x   = 60
  sz_y   = 60
  x      = findgen(sz_x)/10.-3.
  y      = findgen(sz_y)/10.-3.
  delx   = x[1]-x[0]
  dely   = y[1]-y[0]
  z      = replicate(!values.f_nan,sz_x,sz_y)
  copula = replicate(!values.f_nan,sz_x,sz_y)
  u1     = replicate(!values.f_nan,sz_x)
  u2     = replicate(!values.f_nan,sz_y)
  fx     = replicate(!values.f_nan,sz_x)
  fy     = replicate(!values.f_nan,sz_y)

  ;copula = {Gauss, Frank, Gumbel, t, Clayton}
  ;Gauss   0<=theta<=1
  ;Frank   -inf<theta<inf
  ;Gumbel  1<=theta
  ;t       0<=theta<=1, 0<dof
  ;Clayton -1<theta<inf          (unstable theta<-0.5)
  ;extended Gumbel 0<=t1,t2<=1
  copula_name = 'ext_Frank'
  ;tau = 0.5
  ;theta = cal_theta(tau,coupla_name=copula_name)
  theta = 5.
  ;dof   for t distribution
  ;t1,t2 for extended Gumbel
 
  Param = {theta:theta, dof:!values.f_nan, t1:1., t2:1.}
  WHILE Param.t1 ge 0. DO BEGIN
     Param.t1 -= 0.1
     pl_gauss_gauss,Param,copula_name=copula_name;,/no_1dim_pl
     wait,0.5
  ENDWHILE

  message,'END'
END
