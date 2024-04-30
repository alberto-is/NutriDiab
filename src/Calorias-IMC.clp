
(defglobal ?*altura-metros* = -1)

(defrule parse-actividad 
    (declare (salience 10))
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

(defrule cm-a-metros ; conversion de cm a metros
    (declare (salience 10))
    (persona (altura ?altura))
   =>
    (bind ?*altura-metros* (/ ?altura 100))
    (printout t "Altura en metros: " ?*altura-metros* crlf)
) 

(defrule calular-imc  ; calculo del imc en kg/m2
    (declare (salience 9))
    (persona (peso ?peso) (altura ?altura))
   =>
   (bind ?imc (/ ?peso (* ?*altura-metros* ?*altura-metros*)))
   (assert (imc ?imc))
   (printout t "IMC: " ?imc crlf)
)


(defrule imc-bajo-peso
    (declare (salience 9))
    (imc ?imc)
    (test (<= ?imc 18.4))
    =>
    (assert (imc-et "IMC-bajo")) ; imc etiqueta bajo
    (printout t "IMC bajo peso" crlf)
)
(defrule imc-normal
    (declare (salience 9))
   (imc ?imc)
   (test (< ?imc 25))
    (test (>= ?imc 18.5))
   =>
    (assert (imc-et "IMC-normal")) ; imc etiqueta normal
   (printout t "IMC normal" crlf))
(defrule imc-sobrepeso 
    (declare (salience 9))
   (imc ?imc)
   (test (< ?imc 30))
   (test (>= ?imc 25))
   =>
    (assert (imc-et "IMC-sobrepeso")) ; imc etiqueta sobrepeso
   (printout t "IMC sobrepeso" crlf))
(defrule imc-obesidad-tipo-1
    (declare (salience 9))
    (imc ?imc)
    (test (>= ?imc 30))
    (test (< ?imc 35))
    =>
    (assert (imc-et "IMC-obesidad-tipo-1")) ; imc etiqueta obesidad tipo 1
    (printout t "IMC obesidad tipo 1" crlf)
)
(defrule imc-obesidad-tipo-2
    (declare (salience 9))
    (imc ?imc)
    (test (>= ?imc 35))
    (test (< ?imc 40))
    =>
    (assert (imc-et "IMC-obesidad-tipo-2")) ; imc etiqueta obesidad tipo 2
    (printout t "IMC obesidad tipo 2" crlf)
)
(defrule imc-obesidad-tipo-3
    (declare (salience 9))
    (imc ?imc)
    (test (>= ?imc 40))
    =>
    (assert (imc-et "IMC-obesidad-tipo-3")) ; imc etiqueta obesidad tipo 3
    (printout t "IMC obesidad tipo 3" crlf)
)



(defrule calorias-niño
    (declare (salience 9))
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
    (declare (salience 9))
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
    (declare (salience 9))
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
    (declare (salience 9))
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
(defrule calcular-calorias-totales
    (declare (salience 9))
    (persona (edad ?edad))
    (calorias ?calorias)
    (actividad-num ?actividad-num)
    =>
    (bind ?calorias-totales (* ?calorias ?actividad-num))
    (assert (calorias-totales ?calorias-totales))  
    (printout t "Calorias totales: " ?calorias-totales crlf)
)

;; Deficit calorico Adultos
;deficit calorico para personas con sobrepeso
(defrule calcular-deficit-calorico-sobrepeso
    (declare (salience 9))
    (imc-et "IMC-sobrepeso")
    ?f <- (calorias-totales ?calorias-totales)
    (not(deficit-calorico))
    (persona (edad ?edad))
    (test (>= ?edad  18))
    =>
    (bind ?calorias-totales (- ?calorias-totales 200))
    (retract ?f)
    (assert (calorias-totales ?calorias-totales))
    (assert (deficit-calorico))
    (printout t "Calorias totales despues del deficit: " ?calorias-totales crlf)
)
;deficit calorico para personas con obesidad tipo-1
(defrule calcular-deficit-calorico-obesidad-tipo-1
    (declare (salience 9))
    (imc-et "IMC-obesidad-tipo-1")
    ?f <- (calorias-totales ?calorias-totales)
    (not(deficit-calorico))
    (persona (edad ?edad))
    (test (>= ?edad  18))
    =>
    (bind ?calorias-totales (- ?calorias-totales 300))
    (retract ?f)
    (assert (calorias-totales ?calorias-totales))
    (assert (deficit-calorico))
    (printout t "Calorias totales despues del deficit: " ?calorias-totales crlf)
)
;deficit calorico para personas con obesidad tipo-2
(defrule calcular-deficit-calorico-obesidad-tipo-2
    (declare (salience 9))
    (imc-et "IMC-obesidad-tipo-2")
    ?f <- (calorias-totales ?calorias-totales)
    (not(deficit-calorico))
    (persona (edad ?edad))
    (test (>= ?edad  18))
    =>
    (bind ?calorias-totales (- ?calorias-totales 450))
    (retract ?f)
    (assert (calorias-totales ?calorias-totales))
    (assert (deficit-calorico))
    (printout t "Calorias totales despues del deficit: " ?calorias-totales crlf)
)
;deficit calorico para personas con obesidad tipo-3
(defrule calcular-deficit-calorico-obesidad-tipo-3
    (declare (salience 9))
    (imc-et "IMC-obesidad-tipo-3")
    ?f <- (calorias-totales ?calorias-totales)
    (not(deficit-calorico))
    (persona (edad ?edad))
    (test (>= ?edad  18))
    =>
    (bind ?calorias-totales (- ?calorias-totales 600))
    (retract ?f)
    (assert (calorias-totales ?calorias-totales))
    (assert (deficit-calorico))
    (printout t "Calorias totales despues del deficit: " ?calorias-totales crlf)
)

;; Deficit calorico Menores
;deficit calorico para personas con sobrepeso
(defrule calcular-deficit-calorico-sobrepeso-menor
    (declare (salience 9))
    (imc-et "IMC-sobrepeso")
    ?f <- (calorias-totales ?calorias-totales)
    (not(deficit-calorico))
    (persona (edad ?edad))
    (test (<= ?edad  17))
    =>
    (bind ?calorias-totales (- ?calorias-totales 100))
    (retract ?f)
    (assert (calorias-totales ?calorias-totales))
    (assert (deficit-calorico))
    (printout t "Calorias totales despues del deficit: " ?calorias-totales crlf)
)
;deficit calorico para personas con obesidad tipo-1
(defrule calcular-deficit-calorico-obesidad-tipo-1-menor
    (declare (salience 9))
    (imc-et "IMC-obesidad-tipo-1")
    ?f <- (calorias-totales ?calorias-totales)
    (not(deficit-calorico))
    (persona (edad ?edad))
    (test (<= ?edad  17))
    =>
    (bind ?calorias-totales (- ?calorias-totales 200))
    (retract ?f)
    (assert (calorias-totales ?calorias-totales))
    (assert (deficit-calorico))
    (printout t "Calorias totales despues del deficit: " ?calorias-totales crlf)
)
;deficit calorico para personas con obesidad tipo-2
(defrule calcular-deficit-calorico-obesidad-tipo-2-menor
    (declare (salience 9))
    (imc-et "IMC-obesidad-tipo-2")
    ?f <- (calorias-totales ?calorias-totales)
    (not(deficit-calorico))
    (persona (edad ?edad))
    (test (<= ?edad  17))
    =>
    (bind ?calorias-totales (- ?calorias-totales 300))
    (retract ?f)
    (assert (calorias-totales ?calorias-totales))
    (assert (deficit-calorico))
    (printout t "Calorias totales despues del deficit: " ?calorias-totales crlf)
)
;deficit calorico para personas con obesidad tipo-3
(defrule calcular-deficit-calorico-obesidad-tipo-3-menor
    (declare (salience 9))
    (imc-et "IMC-obesidad-tipo-3")
    ?f <- (calorias-totales ?calorias-totales)
    (not(deficit-calorico))
    (persona (edad ?edad))
    (test (<= ?edad  17))
    =>
    (bind ?calorias-totales (- ?calorias-totales 400))
    (retract ?f)
    (assert (calorias-totales ?calorias-totales))
    (assert (deficit-calorico))
    (printout t "Calorias totales despues del deficit: " ?calorias-totales crlf)
)

;; Superavit calorico
;superavit calorico para menores con bajo peso
(defrule calcular-superavit-calorico-bajo-peso-menor
    (declare (salience 9))
    (imc-et "IMC-bajo")
    ?f <- (calorias-totales ?calorias-totales)
    (not(superavit-calorico))
    (persona (edad ?edad))
    (test (<= ?edad  17))
    =>
    (bind ?calorias-totales (+ ?calorias-totales 100))
    (retract ?f)
    (assert (calorias-totales ?calorias-totales))
    (assert (superavit-calorico))
    (printout t "Calorias totales despues del superavit: " ?calorias-totales crlf)
)
;superavit calorico para adultos con bajo peso
(defrule calcular-superavit-calorico-bajo-peso
    (declare (salience 9))
    (imc-et "IMC-bajo")
    ?f <- (calorias-totales ?calorias-totales)
    (not(superavit-calorico))
    (persona (edad ?edad))
    (test (>= ?edad  18))
    =>
    (bind ?calorias-totales (+ ?calorias-totales 200))
    (retract ?f)
    (assert (calorias-totales ?calorias-totales))
    (assert (superavit-calorico))
    (printout t "Calorias totales despues del superavit: " ?calorias-totales crlf)
)