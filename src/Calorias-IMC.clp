; (deftemplate persona
;    (slot edad)
;    (slot sexo)
;    (slot peso)
;    (slot altura)
;    (slot intolerancia)
;    (slot actividad))
; (defglobal
;     ?*altura-metros* = Miguel_Angel Sanz Bobi 
; )
(defglobal ?*altura-metros* = -1)

(defrule imc-bajo-peso
    (imc ?imc)
    (test (<= ?imc 18.4))
    =>
    (printout t "IMC bajo peso" crlf)
)
(defrule imc-normal
   (imc ?imc)
   (test (< ?imc 25))
    (test (>= ?imc 18.5))
   =>
   (printout t "IMC normal" crlf))
(defrule imc-sobrepeso 
   (imc ?imc)
   (test (< ?imc 30))
   (test (>= ?imc 25))
   =>
   (printout t "IMC sobrepeso" crlf))
(defrule imc-obesidad-tipo-1
    (imc ?imc)
    (test (>= ?imc 30))
    (test (< ?imc 35))
    =>
    (printout t "IMC obesidad tipo 1" crlf)
)
(defrule imc-obesidad-tipo-2
    (imc ?imc)
    (test (>= ?imc 35))
    (test (< ?imc 40))
    =>
    (printout t "IMC obesidad tipo 2" crlf)
)
(defrule imc-obesidad-tipo-3
    (imc ?imc)
    (test (>= ?imc 40))
    =>
    (printout t "IMC obesidad tipo 3" crlf)
)

(defrule cm-a-metros ; conversion de cm a metros
    (declare (salience 6))
    ?p <-(persona (edad ?edad) (sexo ?sexo) (peso ?peso) (altura ?altura) (intolerancia ?intolerancia) (actividad ?actividad))
   =>
    (bind ?*altura-metros* (/ ?altura 100))
    ;(modify ?p (altura ?altura-metros))
    (printout t "Altura en metros: " ?*altura-metros* crlf)
) 

(defrule calular-imc  ; calculo del imc en kg/m2
    (declare (salience 5))
    ?p <-(persona (peso ?peso) (altura ?altura))
   =>
   (bind ?imc (/ ?peso (* ?*altura-metros* ?*altura-metros*)))
   (assert (imc ?imc))
   (printout t "IMC: " ?imc crlf)
)
(defrule calorias-niño
    (declare (salience 4))
    ?p <-(persona (edad ?edad) (sexo ?sexo) (peso ?peso) (altura ?altura))
    (test (<= ?edad  10))
    =>
    (if (eq ?sexo "Masculino")
        then
        (bind ?calorias(1400))
        else
        (bind ?calorias(1400))
    )
    (assert (calorias ?calorias))
    (printout t "Calorias: " ?calorias crlf)
)
(defrule calorias-adolescente
    (declare (salience 4))
    ?p <-(persona (edad ?edad) (sexo ?sexo) (peso ?peso) (altura ?altura))
    (test (>= ?edad  11))
    (test (<= ?edad  17))
    =>
    (if (eq ?sexo "Masculino")
        then
        (bind ?calorias(2000))
        else
        (bind ?calorias(1800))
    )
    (assert (calorias ?calorias))
    (printout t "Calorias: " ?calorias crlf)
)

(defrule calorias-adulto
    (declare (salience 4))
    ?p <-(persona (edad ?edad) (sexo ?sexo) (peso ?peso) (altura ?altura))
    (test (>= ?edad  18))
    (test (<= ?edad  50))
    =>
    (if (eq ?sexo "Masculino")
        then
        (bind ?calorias(+ 66.47 (* 13.75 ?peso) (* 5 ?altura) (* -6.77 ?edad)))
        else
        (bind ?calorias(+ 665.1 (* 9.56 ?peso) (* 1.85 ?altura) (* -4.68 ?edad)))
    )
    (assert (calorias ?calorias))
    (printout t "Calorias: " ?calorias crlf)
)
(defrule calorias-adulto-mayor
    (declare (salience 4))
    ?p <-(persona (edad ?edad) (sexo ?sexo) (peso ?peso) (altura ?altura))
    (test (>= ?edad  50))
    =>
    (if (eq ?sexo "Masculino")
        then
        (bind ?calorias(+ 66.47 (* 13.75 ?peso) (* 5 ?altura) (* -6.77 50)))
        else
        (bind ?calorias(+ 665.1 (* 9.56 ?peso) (* 1.85 ?altura) (* -4.68 50)))
    )
    (assert (calorias ?calorias))
    (printout t "Calorias: " ?calorias crlf)
)
; (defrule calcularias-total
;     (declare (salience 3))
;     ?c <- (calorias ?calorias)
;     =>
;     (assert (calorias-totales ?calorias))
;     (printout t "Calorias: " ?calorias crlf)
; )