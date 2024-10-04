(defun load-assets-directory (directory read-function)
  (mapcar (lambda (i)
            (setf (gethash (file-namestring i) *static-data*)
                  (funcall read-function i)))
          (uiop:directory-files directory)))

(load-assets-directory
 (asdf:system-relative-pathname :invader "")
 #'alexandria:read-file-into-string)

(defvar invader-theme
  (make-instance 'theme:theme
		 :font-family "MartianMono Nerd Font Mono"
		 :monospace-font-family "MartianMono Nerd Font Mono"
                 :dark-p t
                 :background-color- "#303240"
                 :background-color "#282A36"
                 :background-color+ "#1E2029"
                 :on-background-color "#F7FBFC"

                 :primary-color- "#679BCF"
                 :primary-color "#789FE8"
                 :primary-color+ "#7FABD7"
                 :on-primary-color "#0C0C0D"

                 :secondary-color- "#44475A"
                 :secondary-color "#44475A"
                 :secondary-color+ "#535A6E"
                 :on-secondary-color "#F7FBFC"

                 :action-color- "#6BE194"
                 :action-color "#4FDB71"
                 :action-color+ "#27BF4C"
                 :on-action-color "#0C0C0D"

                 :success-color- "#86D58E"
                 :success-color "#8AEA92"
                 :success-color+ "#71FE7D"
                 :on-success-color "#0C0C0D"

                 :highlight-color- "#EA43DD"
                 :highlight-color "#F45DE8"
                 :highlight-color+ "#FC83F2"
                 :on-highlight-color "#0C0C0D"

                 :warning-color- "#FCA904"
                 :warning-color "#FCBA04"
                 :warning-color+ "#FFD152"
                 :on-warning-color "#0C0C0D"

                 :codeblock-color- "#3C5FAA"
                 :codeblock-color "#355496"
                 :codeblock-color+ "#2D4880"
                 :on-codeblock-color "#F7FBFC"))

(define-configuration browser
    ((theme invader-theme)))

(define-configuration status-buffer
    ((style (str:concat %slot-value%
                        (theme:themed-css (theme *browser*))))))

(in-package :nyxt)

(define-internal-page-command-global new ()
    (buffer "*New buffer*")
  "Display a page suitable as `default-new-buffer-url'."
  (spinneret:with-html-string
    (:nstyle
      `(body
        :min-height "100vh"
        :background ,(format nil "url('data:image/svg+xml;base64,~a')"
                             (cl-base64:string-to-base64-string (gethash "tiling-frame.svg" *static-data*)))
        :background-size "cover"
        :overflow "hidden"
        :padding "0"
        :margin "0")
      `(nav
        :text-align "center")
      `(.container
        :padding-top "32px"
        :display "flex"
        :flex-direction "row"
        :justify-content "center")
      `(.button
        :background-color ,theme:secondary
        :border-color ,theme:secondary
        :color ,theme:on-secondary
        :min-width "144px")
      `(.copyright
        :position "absolute"
        :bottom "12px"
        :right "48px")
      `(.program-name
        :color ,theme:action
        :font-size "24px"
        :font-weight "bold")
      `(.main
        :margin-top "35vh"
        :display "flex"
        :flex-direction "row"
        :width "900px")
      `(.logo
        :margin-top "-35px"
        :margin-right "10px")
      `(.set-url
        :min-width "180px"
        :height "40px"
        :color ,theme:on-action
        :background-color ,theme:action
        :border "none"
        :border-width "2px"
        :border-radius "3px"
        :margin-bottom "17px")
      `(.execute-command
        :min-width "180px"
        :line-height "12px"
        :height "40px"
        :border "none"
        :background-color ,theme:primary
        :border-color ,theme:primary
        :color ,theme:on-primary)
      `(.binding
        :margin-left "12px"
        :font-weight "bold"
        :color ,theme:secondary)
      `(".tentacle svg"
        :display "inline-block"
        :height "48px"
        :padding-top "4px"
        :padding-left "10px"
        :margin-bottom "-16px"))
    (:div
     :class "container"
     (:main
      (:nav
       (:nbutton :text "Quick-Start"
         '(quick-start))
       (:a :class "button" :href (nyxt-url 'describe-bindings)
           :title "List all bindings for the current buffer."
           "Describe-Bindings")
       (:a :class "button" :href (nyxt-url 'manual)
           :title "Full documentation about Nyxt, how it works and how to configure it."
           "Manual")
       (:a :class "button" :href (nyxt-url 'common-settings)
           :title "Switch between Emacs/vi/CUA key bindings, set home page URL, and zoom level."
           "Settings"))
      (:div :class "main"
            (:div :class "logo" (:raw (gethash "squid-head.svg" *static-data*)))
            (:div
             (:div (:nbutton :class "set-url" :text "Set-URL"
                     '(set-url :prefill-current-url-p nil))
                   (:span :class "binding"
                          (format nil "(~a)" (nyxt::binding-keys 'set-url)))
                   (:span :class "tentacle"
                          (:raw (gethash "upper-tentacle.svg" *static-data*))))
             (:div (:nbutton :class "execute-command" :text "Execute-Command"
                     '(execute-command))
                   (:span :class "binding"
                          (format nil "(~a)" (nyxt::binding-keys 'execute-command)))
                   (:span :class "tentacle"
                          (:raw (gethash "lower-tentacle.svg" *static-data*)))))))
     (:p :class "copyright"
         (:span :class "program-name" "Nyxt")
         (format nil " ~a (~a)" +version+ (name *renderer*))
         (:br)
         (format nil "Atlas Engineer, 2018-~a" (time:timestamp-year (time:now)))))))
