(defun formula-mode ()
  (interactive)
  (kill-all-local-variables)
  (setq mode-name "Formula")
  (setq major-mode 'formula-mode)
  (run-hooks 'formula-mode-hook))

;; Use formula-mode when a .4ml file is loaded
(add-to-list 'auto-mode-alist '("\\.4ml\\'" . formula-mode))

(defun formula-tree-sitter-setup ()
  (interactive)
  (setq tree-sitter-hl-default-patterns
        "[
 \"domain\"
 \"model\"
 \"transform\"
 \"system\"
 \"machine\"
 \"partial\"
 \"ensures\"
 \"requires\"
 \"conforms\"
 \"includes\"
 \"extends\"
 \"of\"
 \"returns\"
 \"at\"
 \"some\"
 \"atleast\"
 \"atmost\"
 \"initially\"
 \"next\"
 \"property\"
 \"boot\"
 \"no\"
 \"is\"
 \"new\"
 \"inj\"
 \"bij\"
 \"sur\"
 \"fun\"
 \"any\"
 ] @keyword

(comment) @comment

[
 (digits)
 (real)
 (frac)
 ] @number

(string) @string

(type_decl type: _ @type)
(typeid) @type
(func_term name: (_) @function.call)

[ \"+\" \"-\" \"*\" \"/\" \":-\" \"::=\" \"::\" \"=>\" \"->\" \"=\" ] @operator

[ \".\" \"|\" \",\" ] @punctuation.delimiter

[ \"(\" \")\" \"{\" \"}\" \"[\" \"]\" ] @punctuation.bracket

(id) @variable.builtin

(enum_cnst) @constant.builtin

(field name: _ @property.definition)
(val_or_model_program name: _ @property)

(domain_sig name: _ @type)
(mod_ref_rename name: _ @property (bareid) @type)
(mod_ref_no_rename (bareid) @type)

(transform name: (bareid) @function)

(model_intro (bareid) @constructor)
(model_fact (bareid) @variable)

(constraint (id) (func_term (atom (id))) @type)
")
  (tree-sitter-require 'formula)
)
