(deftemplate comida
    (slot nombre)
    (slot calorias)
    (slot carbohidratos)
    (slot restricciones)       ; Alto, Bajo, Medio (se refiere a lo "bueno" que está no a nada nutricional)
    (slot indice-glucemico)    ; Alto, Bajo, Medio
    (multislot ingredientes)   ; Lista de ingredientes
)

(deftemplate dieta
    (slot comida1) ;Desayuno
    (slot comida2) ;Almuerzo
    (slot comida3) ;Cena
    (slot calorias-totales)
    (slot carbohidratos)
    (slot restricciones)
)

;NOTE: Eliminar en el futurio, al igual que el main
(deftemplate calorias-base
    (slot valor)
)  

(defrule leer_archivo_comidas
    (declare (salience 10))
  =>
   (open "C:\\Users\\alber\\OneDrive\\Escritorio\\Gallego Sistema Experto\\NutriDiab\\data\\comidas.txt" data "r")
   (bind ?line (readline data))
    (while (neq ?line EOF)
        (bind ?nombre  ?line)
        (bind ?line (readline data))
        (bind ?calorias (integer(string-to-field(str-cat ?line))))
        (bind ?line (readline data))
        (bind ?carbohidratos (integer(string-to-field(str-cat ?line))))
        (bind ?line (readline data))
        (bind ?restricciones (str-cat (string-to-field ?line)))
        (bind ?line (readline data))
        (bind ?indice-glucemico (str-cat (string-to-field ?line)))
        (bind ?line (readline data))
        (bind ?ingredientes (explode$ (str-cat ?line)))
        (assert (comida (nombre ?nombre) (calorias ?calorias) 
                (carbohidratos ?carbohidratos) (restricciones ?restricciones) 
                (indice-glucemico ?indice-glucemico) (ingredientes ?ingredientes)))
        (bind ?line (readline data))
    )
   (close data)
)


(defrule etiquetar-carbohidratos
    (declare (salience 10))
    ?c <- (comida (nombre ?nombre)(carbohidratos ?carbohidratos))
    (test (numberp ?carbohidratos))
    =>
    (if (<= ?carbohidratos 10)
        then
        (modify ?c (carbohidratos "Bajo"))
    else
        (if (<= ?carbohidratos 20)
            then
            (modify ?c (carbohidratos "Medio"))
        else
            (modify ?c (carbohidratos "Alto"))
        )
    )
)

; Comprueba que al menos un elemento de otra lista esté en la lista actual
(deffunction comparten-elemento (?lista1 ?lista2)
    (foreach ?elemento ?lista1
        (if (member$ ?elemento ?lista2) then (return TRUE))
    )
    (return FALSE)
)

; NOTE: Probar 
; Eliminamos cómidas que no cumplan con los requisitos
(defrule eliminar-intoleracias
    (declare (salience 10))
    ?c <- (comida (nombre ?nombre)( ingredientes $?ingredientes))
    (persona (intolerancia $?intolerancia))  ; Corregido aquí
    (test (comparten-elemento ?intolerancia ?ingredientes))
    =>
    (retract ?c)
)
; Eliminar, en caso de persona diabetica, comidas con alto indice glucemico
(defrule eliminar-indice-glucemico
    (declare (salience 10))
    ?c <- (comida (nombre ?nombre)(indice-glucemico ?indice-glucemico))
    (persona (diabetes "Si"))
    (test (eq ?indice-glucemico "Alto"))
    =>
    (retract ?c)
)

; NOTE: Genera todas las dietas posibles sin tener en cuenta las calorias
(defrule seleccionar-dieta
    (declare (salience 8))
    ?c <- (calorias-base (valor ?valor))
    =>
    (bind ?comidas-posibles (find-all-facts ((?c comida)) TRUE)) ; NOTE: Cambiar true a que la comida no este en la lista de intoleracias
    (if (> (length$ ?comidas-posibles) 2)
        then
        (loop-for-count (?i 1 (length$ ?comidas-posibles))
            (loop-for-count (?j 1 (length$ ?comidas-posibles))
                (if (neq ?i ?j) then
                    (loop-for-count (?k 1 (length$ ?comidas-posibles))
                        (if (and (neq ?i ?k) (neq ?j ?k)) then
                            (bind ?comida1 (nth$ ?i ?comidas-posibles))
                            (bind ?comida2 (nth$ ?j ?comidas-posibles))
                            (bind ?comida3 (nth$ ?k ?comidas-posibles))
                            (bind ?calorias-totales (+ (fact-slot-value ?comida1 calorias) (fact-slot-value ?comida2 calorias) (fact-slot-value ?comida3 calorias)))
                            (assert (dieta (comida1 (fact-slot-value ?comida1 nombre)) 
                                            (comida2 (fact-slot-value ?comida2 nombre)) 
                                            (comida3 (fact-slot-value ?comida3 nombre)) 
                                            (calorias-totales ?calorias-totales)))
                        )
                    )
                )
            )
        )
    else
        (printout t "No se encontraron suficientes comidas con ese rango calórico." crlf)
    )
)

; Eliminar dietas que no cumplan con los requisitos
; La comida2 debe ser mayor que la comida1 y la comida1 mayor que la comida3 en calorias
; Por lo tanto, eliminaremos las dietas que no cumplan con esta regla
(defrule eliminar-dieta
    (declare (salience 8))
    ?d <- (dieta (comida1 ?comida1) (comida2 ?comida2) (comida3 ?comida3))
    ?c1 <- (comida (nombre ?comida1)(calorias ?calorias1))
    ?c2 <- (comida (nombre ?comida2)(calorias ?calorias2))
    ?c3 <- (comida (nombre ?comida3)(calorias ?calorias3))
    (test (or (> ?calorias1 ?calorias2) (> ?calorias3 ?calorias1)))
    =>
    (retract ?d)
)
; Para evitar picos de insulina, la comida1 debe tener un indice glucemico bajo
(defrule eliminar-dieta-indice-glucemico
    (declare (salience 8))
    ?d <- (dieta (comida1 ?comida1) (comida2 ?comida2) (comida3 ?comida3) (calorias-totales ?calorias-totales))
    ?c1 <- (comida (nombre ?comida1)(indice-glucemico ?indice-glucemico))
    (test (or (eq ?indice-glucemico "Alto") (eq ?indice-glucemico "Medio")))
    =>
    (retract ?d)
)
; Para evitar picos de insulina, la comida3 debe tener un indice glucemico igual o menor que la comida2
; (Ya que el consumo de calorias por la noche es menor)
(defrule eliminar-dieta-indice-glucemico2
    (declare (salience 8))
    ?d <- (dieta (comida1 ?comida1) (comida2 ?comida2) (comida3 ?comida3) (calorias-totales ?calorias-totales))
    ?c2 <- (comida (nombre ?comida2)(indice-glucemico ?indice-glucemico2))
    ?c3 <- (comida (nombre ?comida3)(indice-glucemico ?indice-glucemico3))
    (test
        (or
            (and (eq ?indice-glucemico3 "Alto")(not (eq ?indice-glucemico2 "Alto")))
            (and (eq ?indice-glucemico3 "Medio")(eq ?indice-glucemico2 "Bajo"))
        )
    )
    =>
    (retract ?d)
)
; NOTE: Eliminar en el futuro
(defrule main
    (declare (salience 10))
    => 
    (assert (calorias-base (valor 800)))  ; Suponemos un valor de calorías base
    (run)
)