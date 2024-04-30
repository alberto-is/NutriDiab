(deftemplate comida
    (slot nombre)
    (slot calorias)
    (slot carbohidratos)
    (slot restricciones)       ; Alto, Bajo, Medio (se refiere a lo "bueno" que está no a nada nutricional)
    (slot indice-glucemico)    ; Alto, Bajo, Medio
    (multislot ingredientes)   ; Lista de ingredientes
)

(deftemplate dieta-xl
    (slot comida1) ;Desayuno
    (slot comida2) ;PosDesayuno
    (slot comida3) ;Almuerzo
    (slot comida4) ;PosAlmuerzo
    (slot comida5) ;Cena
    (slot calorias-totales)
    (slot carbohidratos)
    (slot restricciones)
)


;;; DIETA XL;;;
(defrule seleccionar-dieta-xl
    (declare (salience 7))
    (not (dieta))
    ?c <- (calorias-totales  ?valor)
    =>
    (bind ?comidas-posibles (find-all-facts ((?c comida)) TRUE)) ; NOTE: Cambiar true a que la comida no este en la lista de intoleracias
    (if (> (length$ ?comidas-posibles) 4)
        then
        ( loop-for-count (?i 1 200)
            ; Seleccionar 5 comidas aleatorias
            (bind ?roll1 (random 1 (length$ ?comidas-posibles)))
            (bind ?comida1 (nth$ ?roll1 ?comidas-posibles))

            (bind ?roll2 (random 1 (length$ ?comidas-posibles)))
            (bind ?comida2 (nth$ ?roll2 ?comidas-posibles))

            (bind ?roll3 (random 1 (length$ ?comidas-posibles)))
            (bind ?comida3 (nth$ ?roll3 ?comidas-posibles))

            (bind ?roll4 (random 1 (length$ ?comidas-posibles)))
            (bind ?comida4 (nth$ ?roll4 ?comidas-posibles))

            (bind ?roll5 (random 1 (length$ ?comidas-posibles)))
            (bind ?comida5 (nth$ ?roll5 ?comidas-posibles))

            (bind ?calorias-totales (+ (fact-slot-value ?comida1 calorias) (fact-slot-value ?comida2 calorias) (fact-slot-value ?comida3 calorias) (fact-slot-value ?comida4 calorias) (fact-slot-value ?comida5 calorias)))
            ; creamos la dieta xl
            (assert (dieta-xl (comida1 (fact-slot-value ?comida1 nombre)) 
                                (comida2 (fact-slot-value ?comida2 nombre)) 
                                (comida3 (fact-slot-value ?comida3 nombre)) 
                                (comida4 (fact-slot-value ?comida4 nombre)) 
                                (comida5 (fact-slot-value ?comida5 nombre)) 
                                (calorias-totales ?calorias-totales)))
   
         )
    else
        (printout t "No se encontraron suficientes comidas con ese rango calórico." crlf)
    )
)

; comida3 > comida2 > comida1 > comida5
; comida4 no tiene restricciones
; Eliminar dietas que no cumplan con los requisitos
(defrule eliminar-dieta-xl
    (declare (salience 7))
    ?d <- (dieta-xl (comida1 ?comida1) (comida2 ?comida2) (comida3 ?comida3) (comida4 ?comida4) (comida5 ?comida5))
    ?c1 <- (comida (nombre ?comida1)(calorias ?calorias1))
    ?c2 <- (comida (nombre ?comida2)(calorias ?calorias2))
    ?c3 <- (comida (nombre ?comida3)(calorias ?calorias3))
    ?c4 <- (comida (nombre ?comida4)(calorias ?calorias4))
    ?c5 <- (comida (nombre ?comida5)(calorias ?calorias5))
    (test (or (> ?calorias1 ?calorias2) (> ?calorias2 ?calorias3) (> ?calorias5 ?calorias1)))
    =>
    (retract ?d)
)
; Para evitar picos de insulina, la comida1 debe tener un indice glucemico bajo
(defrule eliminar-dieta-xl-indice-glucemico
    (declare (salience 7))
    ?d <- (dieta-xl (comida1 ?comida1) (comida2 ?comida2) (comida3 ?comida3) (comida4 ?comida4) (comida5 ?comida5))
    ?c1 <- (comida (nombre ?comida1)(indice-glucemico ?indice-glucemico))
    (test (or (eq ?indice-glucemico "Alto") (eq ?indice-glucemico "Medio")))
    =>
    (retract ?d)
)
; Para evitar picos de insulina, la comida2 debe tener un indice glucemico bajo o medio
(defrule eliminar-dieta-xl-indice-glucemico2
    (declare (salience 7))
    ?d <- (dieta-xl (comida1 ?comida1) (comida2 ?comida2) (comida3 ?comida3) (comida4 ?comida4) (comida5 ?comida5))
    ?c2 <- (comida (nombre ?comida2)(indice-glucemico ?indice-glucemico))
    (test (eq ?indice-glucemico "Alto"))
    =>
    (retract ?d)
)
; Para evitar picos de insulina, la comida4 debe tener un indice glucemico bajo o medio
(defrule eliminar-dieta-xl-indice-glucemico3
    (declare (salience 7))
    ?d <- (dieta-xl (comida1 ?comida1) (comida2 ?comida2) (comida3 ?comida3) (comida4 ?comida4) (comida5 ?comida5))
    ?c4 <- (comida (nombre ?comida4)(indice-glucemico ?indice-glucemico))
    (test (eq ?indice-glucemico "Alto"))
    =>
    (retract ?d)
)

; Eliminar dietas que no cumplan con el requisito calorico
(defrule eliminar-dieta-xl-calorias
    (declare (salience 7))
    ?d <- (dieta-xl (comida1 ?comida1) (comida2 ?comida2) (comida3 ?comida3) (comida4 ?comida4) (comida5 ?comida5) (calorias-totales ?calorias-totales-dieta))
    (calorias-totales ?valor)
    (test 
        (or 
            (> ?calorias-totales-dieta (+ ?valor 300))
            (< ?calorias-totales-dieta (- ?valor 300))
        )
    )
    =>
    (retract ?d)
)
; Para evitar todos picos de insulina posibles, todas las comidas deben tener un indice glucemico igual o menor
; que la comida3. (Ya que la comida3 es la comida con más calorias)
; indice-glucemico-comida1 <= indice-glucemico-comida3
; indice-glucemico-comida2 <= indice-glucemico-comida3
; indice-glucemico-comida4 <= indice-glucemico-comida3
; indice-glucemico-comida5 <= indice-glucemico-comida3
(defrule eliminar-dieta-xl-indice-glucemico4
    (declare (salience 7))
    ?d <- (dieta-xl (comida1 ?comida1) (comida2 ?comida2) (comida3 ?comida3) (comida4 ?comida4) (comida5 ?comida5))
    ?c3 <- (comida (nombre ?comida3)(indice-glucemico ?indice-glucemico3))
    ?c1 <- (comida (nombre ?comida1)(indice-glucemico ?indice-glucemico1))
    ?c2 <- (comida (nombre ?comida2)(indice-glucemico ?indice-glucemico2))
    ?c4 <- (comida (nombre ?comida4)(indice-glucemico ?indice-glucemico4))
    ?c5 <- (comida (nombre ?comida5)(indice-glucemico ?indice-glucemico5))
    (test
        (or
            (and (eq ?indice-glucemico1 "Alto") (not (eq ?indice-glucemico3 "Alto")))
            (and (eq ?indice-glucemico2 "Alto") (not (eq ?indice-glucemico3 "Alto")))
            (and (eq ?indice-glucemico4 "Alto") (not (eq ?indice-glucemico3 "Alto")))
            (and (eq ?indice-glucemico5 "Alto") (not (eq ?indice-glucemico3 "Alto")))
            (and (eq ?indice-glucemico1 "Medio") (eq ?indice-glucemico3 "Bajo"))
            (and (eq ?indice-glucemico2 "Medio") (eq ?indice-glucemico3 "Bajo"))
            (and (eq ?indice-glucemico4 "Medio") (eq ?indice-glucemico3 "Bajo"))
            (and (eq ?indice-glucemico5 "Medio") (eq ?indice-glucemico3 "Bajo"))
        )
    )
    =>
    (retract ?d)
)

; Mostrar la dieta xl
(defrule mostrar-dieta-xl
    (declare (salience 0))
    ?d <- (dieta-xl (comida1 ?comida1) (comida2 ?comida2) (comida3 ?comida3) (comida4 ?comida4) (comida5 ?comida5) (calorias-totales ?calorias-totales))
    =>
    (printout t "Desayuno: " ?comida1 crlf)
    (printout t "PosDesayuno: " ?comida2 crlf)
    (printout t "Almuerzo: " ?comida3 crlf)
    (printout t "PosAlmuerzo: " ?comida4 crlf)
    (printout t "Cena: " ?comida5 crlf)
    (printout t "Calorias totales: " ?calorias-totales crlf)
    (printout t "--------------------------------------" crlf)
)