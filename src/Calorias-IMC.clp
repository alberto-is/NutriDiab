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

(defrule parse-actividad 
    (declare (salience 6))
    (persona (actividad ?actividad))
    =>
    (if (eq ?actividad "Baja")
        then
        (assert (actividad-num 1))
        else
        (if (eq ?actividad "Media")
            then
            (assert (actividad-num 1.3))
            else
            (if (eq ?actividad "Alta")
                then
                (assert (actividad-num 1.55))
            )
        )
    )
)
(defrule imc-bajo-peso
    (declare (salience 4))
    (imc ?imc)
    (test (<= ?imc 18.4))
    =>
    (assert (imc-et "IMC-bajo")) ; imc etiqueta bajo
    (printout t "IMC bajo peso" crlf)
)
(defrule imc-normal
    (declare (salience 4))
   (imc ?imc)
   (test (< ?imc 25))
    (test (>= ?imc 18.5))
   =>
    (assert (imc-et "IMC-normal")) ; imc etiqueta normal
   (printout t "IMC normal" crlf))
(defrule imc-sobrepeso 
    (declare (salience 4))
   (imc ?imc)
   (test (< ?imc 30))
   (test (>= ?imc 25))
   =>
    (assert (imc-et "IMC-sobrepeso")) ; imc etiqueta sobrepeso
   (printout t "IMC sobrepeso" crlf))
(defrule imc-obesidad-tipo-1
    (declare (salience 4))
    (imc ?imc)
    (test (>= ?imc 30))
    (test (< ?imc 35))
    =>
    (assert (imc-et "IMC-obesidad-tipo-1")) ; imc etiqueta obesidad tipo 1
    (printout t "IMC obesidad tipo 1" crlf)
)
(defrule imc-obesidad-tipo-2
    (declare (salience 4))
    (imc ?imc)
    (test (>= ?imc 35))
    (test (< ?imc 40))
    =>
    (assert (imc-et "IMC-obesidad-tipo-2")) ; imc etiqueta obesidad tipo 2
    (printout t "IMC obesidad tipo 2" crlf)
)
(defrule imc-obesidad-tipo-3
    (declare (salience 4))
    (imc ?imc)
    (test (>= ?imc 40))
    =>
    (assert (imc-et "IMC-obesidad-tipo-3")) ; imc etiqueta obesidad tipo 3
    (printout t "IMC obesidad tipo 3" crlf)
)

(defrule cm-a-metros ; conversion de cm a metros
    (declare (salience 6))
    (persona (edad ?edad) (sexo ?sexo) (peso ?peso) (altura ?altura) (intolerancia ?intolerancia) (actividad ?actividad))
   =>
    (bind ?*altura-metros* (/ ?altura 100))
    (printout t "Altura en metros: " ?*altura-metros* crlf)
) 

(defrule calular-imc  ; calculo del imc en kg/m2
    (declare (salience 5))
    (persona (peso ?peso) (altura ?altura))
   =>
   (bind ?imc (/ ?peso (* ?*altura-metros* ?*altura-metros*)))
   (assert (imc ?imc))
   (printout t "IMC: " ?imc crlf)
)
(defrule calorias-niño
    (declare (salience 4))
    (persona (edad ?edad) (sexo ?sexo) (peso ?peso) (altura ?altura))
    (test (<= ?edad  10))
    =>
    (if (eq ?sexo "Masculino")
        then
        (bind ?calorias 1400)
        else
        (bind ?calorias 1400)
    )
    (assert (calorias ?calorias))
    (printout t "Calorias: " ?calorias crlf)
)
(defrule calorias-adolescente
    (declare (salience 4))
    (persona (edad ?edad) (sexo ?sexo) (peso ?peso) (altura ?altura))
    (test (>= ?edad  11))
    (test (<= ?edad  17))
    =>
    (if (eq ?sexo "Masculino")
        then
        (bind ?calorias 2000)
        else
        (bind ?calorias 1800)
    )
    (assert (calorias ?calorias))
    (printout t "Calorias: " ?calorias crlf)
)

(defrule calorias-adulto
    (declare (salience 4))
    (persona (edad ?edad) (sexo ?sexo) (peso ?peso) (altura ?altura))
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
    (persona (edad ?edad) (sexo ?sexo) (peso ?peso) (altura ?altura))
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
(defrule calcularias-total-menores
    (declare (salience 2))
    (persona (edad ?edad))
    (calorias ?calorias)
    (actividad-num ?actividad-num)
    (test (<= ?edad  17))
    =>
    (bind ?calorias-totales (* ?calorias ?actividad-num))
    (assert (calorias-totales ?calorias-totales))  
    (printout t "Calorias totales: " ?calorias-totales crlf)
)

;FIXME: Hay que añadir que tenga en cuenta el imc
(defrule calcularias-total-adultos
    (declare (salience 2))
    (persona (edad ?edad))
    (calorias ?calorias)
    (test (>= ?edad  18))
    =>
    (assert (calorias-totales ?calorias))  
    (printout t "Calorias: " ?calorias crlf)
)