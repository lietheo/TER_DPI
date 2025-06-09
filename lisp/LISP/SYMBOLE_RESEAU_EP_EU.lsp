(defun c:SYMBOLE_RESEAU_EP (/ doc layers layerCount i layerName file f ent inspt ptX ptY ptZ name type validLayers)
  (setq doc (vla-get-ActiveDocument (vlax-get-Acad-Object)))
  (setq layers (vla-get-Layers doc))
  (setq layerCount (vla-get-Count layers))
  (setq file "C:/Users/liege/Downloads/Symboles_reseau_EP.csv")
  (setq f (open file "w"))
  (write-line "X,Y,Z,NomBloc,Type" f)

  ;; Collecte des couches valides (contenant _EP_)
  (setq validLayers '())
  (setq i 0)
  (while (< i layerCount)
    (setq layerName (vla-get-Name (vla-Item layers i)))
    (if (and
          (wcmatch (strcase layerName) "R_*SYMBOL*") ; calque commence par R_ et contient Symboles
          (wcmatch (strcase layerName) "*_EP_*")     ; contient _EP_
        )
      (setq validLayers (cons layerName validLayers))
    )
    (setq i (1+ i))
  )

  ;; Parcours du ModelSpace
  (vlax-for ent (vla-get-ModelSpace doc)
    (if (and
          (= (vla-get-ObjectName ent) "AcDbBlockReference")
          (member (vla-get-Layer ent) validLayers)
        )
      (progn
        (setq layerName (vla-get-Layer ent))
        (setq name (vla-get-EffectiveName ent))
        (setq inspt (vlax-get ent 'InsertionPoint))
        (setq ptX (rtos (car inspt) 2 3))
        (setq ptY (rtos (cadr inspt) 2 3))
        (setq ptZ (rtos (caddr inspt) 2 3))
        ;; extraire le type après R_ et avant _Symboles
        (setq type (vl-string-left-trim "R_" 
                     (vl-string-right-trim "_Symboles_ADRÉ" layerName)
                   )
        )
        (write-line (strcat ptX "," ptY "," ptZ "," name "," type) f)
      )
    )
  )

  (close f)
  (princ)
)

(defun c:SYMBOLE_RESEAU_EU (/ doc layers layerCount i layerName file f ent inspt ptX ptY ptZ name type validLayers)
  (setq doc (vla-get-ActiveDocument (vlax-get-Acad-Object)))
  (setq layers (vla-get-Layers doc))
  (setq layerCount (vla-get-Count layers))
  (setq file "C:/Users/liege/Downloads/Symboles_reseau_EU.csv")
  (setq f (open file "w"))
  (write-line "X,Y,Z,NomBloc,Type" f)

  ;; Collecte des couches valides (contenant _EU_)
  (setq validLayers '())
  (setq i 0)
  (while (< i layerCount)
    (setq layerName (vla-get-Name (vla-Item layers i)))
    (if (and
          (wcmatch (strcase layerName) "R_*SYMBOL*") ; calque commence par R_ et contient Symboles
          (wcmatch (strcase layerName) "*_EU_*")     ; contient _EU_
        )
      (setq validLayers (cons layerName validLayers))
    )
    (setq i (1+ i))
  )

  ;; Parcours du ModelSpace
  (vlax-for ent (vla-get-ModelSpace doc)
    (if (and
          (= (vla-get-ObjectName ent) "AcDbBlockReference")
          (member (vla-get-Layer ent) validLayers)
        )
      (progn
        (setq layerName (vla-get-Layer ent))
        (setq name (vla-get-EffectiveName ent))
        (setq inspt (vlax-get ent 'InsertionPoint))
        (setq ptX (rtos (car inspt) 2 3))
        (setq ptY (rtos (cadr inspt) 2 3))
        (setq ptZ (rtos (caddr inspt) 2 3))
        ;; extraire le type après R_ et avant _Symboles
        (setq type (vl-string-left-trim "R_" 
                     (vl-string-right-trim "_Symboles_ADRÉ" layerName)
                   )
        )
        (write-line (strcat ptX "," ptY "," ptZ "," name "," type) f)
      )
    )
  )

  (close f)
  (princ)
)
