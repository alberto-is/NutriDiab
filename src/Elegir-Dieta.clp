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
(deftemplate dieta-seleccionada
    (slot comida1) ;Desayuno
    (slot comida2) ;Almuerzo
    (slot comida3) ;Cena
    (slot restricciones); Suma de restricciones
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
    (if (<= ?carbohidratos 20)
        then
        (modify ?c (carbohidratos "Bajo"))
    else
        (if (<= ?carbohidratos 50)
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
    ?c <- (calorias-totales  ?valor)
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
; Eliminar dietas que no cumplan con el requisito calorico
(defrule eliminar-dieta-calorias
    (declare (salience 8))
    ?d <- (dieta (comida1 ?comida1) (comida2 ?comida2) (comida3 ?comida3) (calorias-totales ?calorias-totales-dieta))
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

(deffunction parse-restricciones (?restricciones)
    (switch ?restricciones
        (case "Alto" then (return 3))
        (case "Medio" then (return 2))
        (case "Bajo" then (return 1))
    )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Seleccionar la dieta más sostenible a largo plazo (con la menor suma de ;;;
;;; restricciones)                                                          ;;;
;;;       -> Personas con dificultad para aderirse a dietas. Por defecto    ;;;
;;;          personas con actividad física baja y peso bajo o sobrepeso     ;;;
;;; Selección de la dieta con menor cantidad de carbohidratos               ;;;
;;;       -> Personas con cualquier grado de obesidad independientemente    ;;;
;;;          de la actividad física                                         ;;;
;;; Selección de la dieta más equilibrada en cuanto a carbohidratos         ;;;
;;;       -> Personas con actividad física alta que no tenga obesidad       ;;;
;;; Selección de la dieta más variada                                       ;;;
;;;       -> Personas con dificultad para aderirse a dietas.                ;;;
;;;          Por defecto personas con actividad física baja y peso normal   ;;;
;;;          o actividad física media y peso bajo, sobrepeso o normal       ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; FIXME: uso la diferencia de salice para poder usar la variabel global
;;; NOTE: Seleccionar en base al peso
;; Seleccionar la dieta más sostenible a largo plazo (con la menor suma de restricciones)
(defrule seleccionar-dieta-menos-restricciones
    (declare (salience 3))
    (not (dieta-seleccionada))
    (persona (actividad ?actividad-fisica))
    (imc-et ?imc)
    (test (and (eq ?actividad-fisica "Baja") (or (eq ?imc "IMC-bajo") (eq ?imc "IMC-sobrepeso"))))
    (dieta (comida1 ?comida1) (comida2 ?comida2) (comida3 ?comida3))
    (comida (nombre ?comida1)(restricciones ?restricciones1))
    (comida (nombre ?comida2)(restricciones ?restricciones2))
    (comida (nombre ?comida3)(restricciones ?restricciones3))
    =>
    (assert (dieta-seleccionada (comida1 ?comida1) (comida2 ?comida2) (comida3 ?comida3)
                                (restricciones (+ (parse-restricciones ?restricciones1) (parse-restricciones ?restricciones2) 
                                                  (parse-restricciones ?restricciones3)))
            )
    )
    ; (printout t "--------------------------------------" crlf)
    ; (printout t "Desayuno: " ?comida1 crlf)
    ; (printout t "Almuerzo: " ?comida2 crlf)
    ; (printout t "Cena: " ?comida3 crlf)
    ; (printout t "Restricciones Totales num: " (+ (parse-restricciones ?restricciones1) (parse-restricciones ?restricciones2) 
    ;                                               (parse-restricciones ?restricciones3)) crlf)
    ; (printout t "--------------------------------------" crlf)
)

(defrule seleccionar-dieta-menos-restrictiva
    (declare (salience 2))
    (persona (actividad ?actividad-fisica))
    (imc-et ?imc)
    (test (and (eq ?actividad-fisica "Baja") (or (eq ?imc "IMC-bajo") (eq ?imc "IMC-sobrepeso"))))
    (dieta (comida1 ?comida1) (comida2 ?comida2) (comida3 ?comida3))
    (comida (nombre ?comida1)(restricciones ?restricciones1))
    (comida (nombre ?comida2)(restricciones ?restricciones2))
    (comida (nombre ?comida3)(restricciones ?restricciones3))
    ?d <- (dieta-seleccionada (restricciones ?restricciones-seleccionada))
    (test (< (+ (parse-restricciones ?restricciones1) 
                (parse-restricciones ?restricciones2) 
                (parse-restricciones ?restricciones3)) 
                ?restricciones-seleccionada)
    )
    =>
    (modify ?d (comida1 ?comida1) (comida2 ?comida2) (comida3 ?comida3) 
               (restricciones (+ (parse-restricciones ?restricciones1) 
                                (parse-restricciones ?restricciones2) 
                                (parse-restricciones ?restricciones3)))
    )
    ; (printout t "--------------------------------------" crlf)
    ; (printout t "Desayuno: " ?comida1 crlf)
    ; (printout t "Almuerzo: " ?comida2 crlf)
    ; (printout t "Cena: " ?comida3 crlf)
    ; (printout t "Restricciones Totales num: " (+ (parse-restricciones ?restricciones1) (parse-restricciones ?restricciones2) 
    ;                                               (parse-restricciones ?restricciones3)) crlf)
    ; (printout t "--------------------------------------" crlf)
)

;; Dieta baja en carbohidratos
(defrule seleccionar-dieta-baja-carbohidratos
    (declare (salience 3))
    (not (dieta-seleccionada))
    (persona (actividad ?actividad-fisica))
    (imc-et ?imc)
    (test  (or (eq ?imc "IMC-obesidad-tipo-1") (eq ?imc "IMC-obesidad-tipo-2") (eq ?imc "IMC-obesidad-tipo-3")))
    (dieta (comida1 ?comida1) (comida2 ?comida2) (comida3 ?comida3))
    (comida (nombre ?comida1)(carbohidratos ?carbohidratos1))
    (comida (nombre ?comida2)(carbohidratos ?carbohidratos2))
    (comida (nombre ?comida3)(carbohidratos ?carbohidratos3))
    (test (and (eq ?carbohidratos1 "Bajo") (eq ?carbohidratos2 "Bajo") (eq ?carbohidratos3 "Bajo")))
    =>    
    (assert (dieta-seleccionada (comida1 ?comida1) (comida2 ?comida2) (comida3 ?comida3)))
)
; Si no encuentra ninguna amplia un poco la busqueda sin ser tan restrictiva en el almuerzo
(defrule seleccionar-dieta-baja-carbohidratos
    (declare (salience 2))
    (not (dieta-seleccionada))
    (persona (actividad ?actividad-fisica))
    (imc-et ?imc)
    (test  (or (eq ?imc "IMC-obesidad-tipo-1") (eq ?imc "IMC-obesidad-tipo-2") (eq ?imc "IMC-obesidad-tipo-3")))
    (dieta (comida1 ?comida1) (comida2 ?comida2) (comida3 ?comida3))
    (comida (nombre ?comida1)(carbohidratos ?carbohidratos1))
    (comida (nombre ?comida2)(carbohidratos ?carbohidratos2))
    (comida (nombre ?comida3)(carbohidratos ?carbohidratos3))
    (test (and (eq ?carbohidratos1 "Bajo") (eq ?carbohidratos2 "Medio") (eq ?carbohidratos3 "Bajo")))
    =>
    (assert (dieta-seleccionada (comida1 ?comida1) (comida2 ?comida2) (comida3 ?comida3)))
)
;; La más equilibrada en cuanto a carbohidratos (Personas deportistas)
(defrule seleccionar-dieta-equilibrada-carbohidratos
    (declare (salience 3))
    (not (dieta-seleccionada))
    (persona (actividad ?actividad-fisica))
    (imc-et ?imc)
    (test (and (eq ?actividad-fisica "Alta") 
               (not(or(eq ?imc "IMC-obesidad-tipo-1") (eq ?imc "IMC-obesidad-tipo-2") (eq ?imc "IMC-obesidad-tipo-3")))))
    (dieta (comida1 ?comida1) (comida2 ?comida2) (comida3 ?comida3))
    (comida (nombre ?comida1)(carbohidratos ?carbohidratos1))
    (comida (nombre ?comida2)(carbohidratos ?carbohidratos2))
    (comida (nombre ?comida3)(carbohidratos ?carbohidratos3))
    (test  (not (eq ?carbohidratos2 "Bajo")))
    =>    
    (assert (dieta-seleccionada (comida1 ?comida1) (comida2 ?comida2) (comida3 ?comida3)))
)
;; La más variada (Se repiten el menor número de ingredientes)


;;;Mostar dieta;;;
; Mostrar la dieta 
(defrule mostrar-dieta
    (declare (salience 0))
    ?d <- (dieta (comida1 ?comida1) (comida2 ?comida2) (comida3 ?comida3) (calorias-totales ?calorias-totales))
    (dieta-seleccionada (comida1 ?comida1) (comida2 ?comida2) (comida3 ?comida3))
    =>
    (printout t "--------------------------------------" crlf)
    (printout t "Desayuno: " ?comida1 crlf)
    (printout t "Almuerzo: " ?comida2 crlf)
    (printout t "Cena: " ?comida3 crlf)
    (printout t "Calorias totales: " ?calorias-totales crlf)
    (printout t "--------------------------------------" crlf)
)

(defrule mostrar-dieta-no-seleccionada
    (declare (salience 0))
    (not (dieta))
    =>
    (printout t "--------------------------------------" crlf)
    (printout t "No se encontraron dietas" crlf)
    (printout t "--------------------------------------" crlf)
)