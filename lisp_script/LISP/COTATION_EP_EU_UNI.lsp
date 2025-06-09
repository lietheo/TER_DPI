(defun c:COTATION_EP_EU_UNI ( / layers layer ss i ent txt pt type outputfile mleaderObj)
  (vl-load-com)

  ;; Liste des calques + leur type
  (setq layers '(("R_EP_Cotations_ADRÉ" . "EP")
                 ("R_EU_Cotations_ADRÉ" . "EU")
                 ("R_UNI_Cotations_ADRÉ" . "UNI")))

  ;; Fichier de sortie
  (setq outputfile (open "C:\\Users\\liege\\Downloads\\COTATION_EP_EU_UNI.csv" "w"))
  (write-line "Type;Calque;Texte;X;Y" outputfile)

  ;; Pour chaque calque/type
  (foreach pair layers
    (setq layer (car pair))
    (setq type (cdr pair))

    ;; Sélection des MLEADERs sur ce calque
    (setq ss (ssget "X" (list (cons 0 "MULTILEADER") (cons 8 layer))))

    (if ss
      (progn
        (setq i 0)
        (while (< i (sslength ss))
          (setq ent (ssname ss i))
          (setq mleaderObj (vlax-ename->vla-object ent))

          ;; Texte du MLEADER
          (setq txt (vla-get-TextString mleaderObj))

          ;; Cette fois : inclure SEULEMENT les textes contenant Ø
          (if (and txt (wcmatch (strcase txt) "*Ø*"))
            (progn
              ;; Coordonnées de la flèche (leader)
              (setq pt (vlax-safearray->list
                         (vlax-variant-value
                           (vla-GetLeaderLineVertices mleaderObj 0))))

              ;; Prend le 1er point (ancrage sur symbole)
              (if pt
                (write-line
                  (strcat type ";" layer ";" "\"" txt "\";"
                          (rtos (car pt) 2 2) ";" (rtos (cadr pt) 2 2))
                  outputfile)
              )
            )
          )
          (setq i (1+ i))
        )
      )
    )
  )

  (close outputfile)
  (prompt "\n✅ Export des MLEADERs contenant Ø terminé. Fichier : COTATION_EP_EU_UNI.csv")
  (princ)
)
