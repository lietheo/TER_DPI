(defun c:MOBILIER_URBAIN (/ csvfile layername ss cnt ent entname pos outstr file)
  (setq layername "T_Mobilier Urbain_Symboles_ADRÉ")  ; nom de la couche à traiter
  (setq csvfile "C:\\Users\\liege\\Downloads\\MOBILIER_URBAIN_point.csv") ; chemin du fichier CSV

  ;; Ouvre le fichier en écriture
  (setq file (open csvfile "w"))
  (if (not file)
    (progn
      (princ "\nErreur ouverture fichier.")
      (exit)
    )
  )

  ;; Écriture de l'entête CSV
  (write-line "NomBloc;X;Y;Z" file)

  ;; Sélectionne toutes les entités de la couche demandée
  (setq ss (ssget "X" (list (cons 8 layername))))
  (if (not ss)
    (progn
      (princ (strcat "\nPas d'entités trouvées sur la couche " layername))
      (close file)
      (exit)
    )
  )

  ;; Parcours des entités
  (setq cnt 0)
  (repeat (sslength ss)
    (setq ent (ssname ss cnt))
    (setq entname (cdr (assoc 2 (entget ent)))) ;; nom du bloc
    (setq pos (cdr (assoc 10 (entget ent)))) ;; coordonnées insertion
    (setq outstr (strcat
                  entname ";"
                  (rtos (car pos) 2 3) ";"  ; X
                  (rtos (cadr pos) 2 3) ";" ; Y
                  (rtos (caddr pos) 2 3)    ; Z
                ))
    (write-line outstr file)
    (setq cnt (1+ cnt))
  )
  (close file)
  (princ (strcat "\nExport terminé dans " csvfile))
  (princ)
)


(defun c:BATI_LINEAIRE (/ csvfile layername ss cnt ent entname pos outstr file)
  (setq layername "T_Bâti_Linéaires_ADRÉ")  ; nom de la couche à traiter
  (setq csvfile "C:\\Users\\liege\\Downloads\\BATIS_LINEAIRE_point.csv") ; chemin du fichier CSV

  ;; Ouvre le fichier en écriture
  (setq file (open csvfile "w"))
  (if (not file)
    (progn
      (princ "\nErreur ouverture fichier.")
      (exit)
    )
  )

  ;; Écriture de l'entête CSV
  (write-line "NomBloc;X;Y;Z" file)

  ;; Sélectionne toutes les entités de la couche demandée
  (setq ss (ssget "X" (list (cons 8 layername))))
  (if (not ss)
    (progn
      (princ (strcat "\nPas d'entités trouvées sur la couche " layername))
      (close file)
      (exit)
    )
  )

  ;; Parcours des entités
  (setq cnt 0)
  (repeat (sslength ss)
    (setq ent (ssname ss cnt))
    (setq entname (cdr (assoc 2 (entget ent)))) ;; nom du bloc
    (setq pos (cdr (assoc 10 (entget ent)))) ;; coordonnées insertion
    (setq outstr (strcat
                  entname ";"
                  (rtos (car pos) 2 3) ";"  ; X
                  (rtos (cadr pos) 2 3) ";" ; Y
                  (rtos (caddr pos) 2 3)    ; Z
                ))
    (write-line outstr file)
    (setq cnt (1+ cnt))
  )
  (close file)
  (princ (strcat "\nExport terminé dans " csvfile))
  (princ)
)