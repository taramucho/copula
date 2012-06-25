IDL/ITTで2次元copulaを実装しました。

___統計の方のcopulaです。___

copulaの詳細は「経済物理学（著 青山秀明 他, 共同出版）」が分かりやすいです。

###計算できるcopula

* Gauss
* Frank
* Gumbel
* t
* Clayton
* extended Gumbel
* extended Clayton
* extended Frank


###使い方
x1, x2でのcopulaを求める。

>
\> copula = cal_copula(u1, u2, Param, copula_name=copula_name)
>

* (u1,u2) --- cumulative probability funciton at x1,x2
* Param   --- {theta, dof}
* theta     --- charcteristic parameter of a copula 
* dof     --- degree of freedom (only for t distribution)
* copula_name = {Gauss, Frank, Gumbel, t, Clayton, ext_Gumbel}

例えば、gaussian copulaの場合は、

>
\> gauss_copula = cal_copula(u1, u2, {theta=0.1,})
>


###parameter ranges

* Gauss        0<=θ<=1     
* Frank        -inf<θ<inf
* Gumbel       1<=θ
* t            0<=θ<=1, 0<dof
* Clayton      -1<θ<inf          (unstable θ<-0.5)
* extended copula 0<=t1,t2<=1

thetaの端っこでは不安定。

###テスト
#####色々なcopulaを持つgaussian*gaussianの2次元分布を描く
>
\> .comp gauss_gauss
\>  gauss_gauss
>


###必要なライブラリ
* The IDL Astronomy User's Library http://idlastro.gsfc.nasa.gov/
* Coyote IDL Program Libraries http://www.idlcoyote.com/

###その他
GDL (Gnu Data Language, http://gnudatalanguage.sourceforge.net) でも動くかも（未確認）。

###TODO
* 引数周りすっきりさせる（もはや本人すら戸惑うレベル）。
* テストを簡単なものに書き換える。
* 計算できるパラメータの限界とその対処をする。



