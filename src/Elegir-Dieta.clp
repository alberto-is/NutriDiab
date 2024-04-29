(deftemplate comida
    (slot nombre)
    (slot calorias)
)
(deftemplate dieta
    (slot comida1)
    (slot comida2)
    (slot comida3)
    (slot calorias-totales)
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
        (bind ?comida (explode$ ?line))
        (assert (comida (nombre (nth$ 1 ?comida)) (calorias (integer(string-to-field(str-cat(nth$ 2 ?comida)))))))
        (bind ?line (readline data))
    )
   (close data)
)

; (deffunction random-sample$ (?list ?n)
;     (bind ?result (create$))
;     (bind ?indices (create$))
;     (loop-for-count (?i 1 ?n)
;         (bind ?index (random (length$ ?list)))
;         (if (not (member$ ?index ?indices)) then
;             (bind ?indices (insert$ ?indices 1 ?index))
;             (bind ?result (insert$ ?result 1 (nth$ ?index ?list)))
;         )
;     )
;     return ?result
; )

(defrule seleccionar-dieta
    ?c <- (calorias-base (valor ?valor))
    =>
    (bind ?comidas-posibles (find-all-facts ((?c comida)) TRUE)) ; NOTE: Cambiar true a que la comida no este en la lista de intoleracias
    (if (> (length$ ?comidas-posibles) 2)
        then
        (bind ?bucle 1)
        ( while (eq ?bucle 1)
            (printout t "Comidas seleccionadas para la dieta: " crlf)
            (bind ?roll1 (random 1 (length$ ?comidas-posibles)))
            (bind ?comida1 (nth$ ?roll1 ?comidas-posibles))
                (printout t (fact-slot-value ?comida1 nombre) ", " (fact-slot-value ?comida1 calorias) " calorías" crlf)
            (bind ?roll2 (random 1 (length$ ?comidas-posibles)))
            (bind ?comida2 (nth$ ?roll2 ?comidas-posibles))
                (printout t (fact-slot-value ?comida2 nombre) ", " (fact-slot-value ?comida2 calorias) " calorías" crlf)
            (bind ?roll3 (random 1 (length$ ?comidas-posibles)))
            (bind ?comida3 (nth$ ?roll3 ?comidas-posibles))
                (printout t (fact-slot-value ?comida3 nombre) ", " (fact-slot-value ?comida3 calorias) " calorías" crlf)
            (bind ?calorias-totales (+ (fact-slot-value ?comida1 calorias) (fact-slot-value ?comida2 calorias) (fact-slot-value ?comida3 calorias)))
            (if (>= ?calorias-totales (+ ?valor 100) )
                then
                (bind ?bucle 0)
                (printout t "Calorías totales: " ?calorias-totales crlf)
                (assert (dieta (comida1 (fact-slot-value ?comida1 nombre)) 
                                (comida2 (fact-slot-value ?comida2 nombre)) 
                                (comida3 (fact-slot-value ?comida3 nombre)) 
                                (calorias-totales ?calorias-totales)))
            )
        )
        
    else
        (printout t "No se encontraron suficientes comidas con ese rango calórico." crlf)
        ; imprimir la lista de comidas posible
        (printout t "Comidas posibles: " crlf)
    (loop-for-count (?i 1 (length$ ?comidas-posibles))
        (bind ?comida (nth$ ?i ?comidas-posibles))
        (printout t (fact-slot-value ?comida nombre) ", " (fact-slot-value ?comida calorias) " calorías" crlf))
    )
)

(defrule main
    (declare (salience 10))
    => 
    (assert (calorias-base (valor 800)))  ; Suponemos un valor de calorías base
    (run)
)