{ config, lib, pkgs,  ... }:

with lib; let cfg = config.nyxt;
in {
	options.nyxt = {
		     enable = mkEnableOption "Enables Nyxt Config";
	};

	config = mkIf cfg.enable {
	       home.packages = with pkgs; [
	       		     nyxt
	       ];

	       home.file.".local/share/nyxt/extensions/invader".source = ./nyxt/invader;
	       home.file.".local/share/nyxt/extensions/nx-search-engines".source = ./nyxt/nx-search-engines;

	       home.file.".config/nyxt/config.lisp".text = ''
			(setf (uiop/os:getenv "WEBKIT_DISABLE_COMPOSITING_MODE") "1")

			(define-configuration browser
			    ((session-restore-prompt :always-restore)))
		
			(define-configuration browser
				((external-editor-program "${pkgs.emacs}/bin/emacs")))

			(define-configuration buffer
			    ((default-modes
				 (pushnew 'nyxt/mode/emacs:emacs-mode %slot-value%))))

			(nyxt:define-nyxt-user-system-and-load "nyxt-user/search-engines"
			  :depends-on (:nx-search-engines))

			(define-configuration (buffer web-buffer)
				((search-engines (list

							(engines:searchmysite :shortcut  "np"
									      :base-search-url "https://search.nixos.org/packages?channel=unstable&query=~a")

							(engines:searchmysite :shortcut "no"
									      :base-search-url "https://search.nixos.org/options?channel=unstable&query=~a")

							(engines:searchmysite :shortcut "nh"
									      :base-search-url "https://home-manager-options.extranix.com/?release=master&query=~a")

							(engines:google :shortcut "g"
									:safe-search nil)
									
							(engines:google :shortcut "img"
									:object :image)

							(engines:wikipedia :shortcut "wiki")

							(engines:libgen :shortcut "lib")

							(engines:reddit :shortcut "r")

							(engines:invidious :shortcut "yt"
									   :base-search-url "https://invidious.perennialte.ch/search?q=~a")
							
							(engines:github :shortcut "gh")

							(engines:duckduckgo :shortcut "ddg"
									    :theme :light
									    :video-playback :always-ddg
									    :safe-search :moderate
									    :infinite-scroll t
									    :advertisements nil
									    
									    :help-improve-duckduckgo nil
									    :homepage-privacy-tips nil
									    :privacy-newsletter nil
									    :newsletter-reminders nil
									    :install-reminders nil
									    :install-duckduckgo nil)

							(engines:searx :shortcut "s"
								       :base-search-url "https://search.atlas.engineer/searxng/search?q=~a"
								       :style :light
								       :safe-search :moderate
								       :infinite-scroll t)
								       
									    ))))


			(define-configuration buffer
			    ((override-map (let ((map (make-keymap "global")))
				(define-key map
				    "C-x C-b" 'switch-buffer
				    "C-x b" 'list-buffers
				    "C-s" 'search-buffer
				    "C-c r" 'load-config-file
				    "C-w" 'make-window
				    "C-x C-f" 'edit-file
				    "C-return" 'open-in-mpv
				    )
				map))))

			(nyxt:define-nyxt-user-system-and-load "nyxt-user/invader-proxy"
				:depends-on ("invader"))

			(define-configuration status-buffer (
				(glyph-mode-presentation-p t)

				(height 20)

				(style (str:concat %slot-value%
				       (theme:themed-css (theme *browser*)
							 '("#tabs" :display "none")
							 '("#url"
								:background-color "#303240"
								:color "F7FBFC")
							 '("#modes"
								:background-color "#44475A"
								:color "#F7FBFC")
					)))

				))

			(defmethod format-status-load-status ((status status-buffer))
			"A fancier load status."
			(spinneret:with-html-string
			 (:span (if (and (current-buffer)
					 (web-buffer-p (current-buffer)))
				    (case (slot-value (current-buffer) 'nyxt::status)
					  (:unloaded "∅")
					  (:loading "∞")
					  (:finished ""))
				  ""))))

			(define-configuration user-script-mode
					      (
					      (glyph "ψ")
					      ))


			(define-configuration web-buffer
			  ((default-modes
			    (pushnew 'nyxt/mode/user-script:user-script-mode %slot-value%))))

			(define-configuration nyxt/mode/user-script:user-script-mode
			  ((nyxt/mode/user-script:user-scripts
			    (list
				(make-instance 'nyxt/mode/user-script:user-script :base-path #p "/home/user/nixos/modules/home-manager/nyxt/darkmode.js" )
				(make-instance 'nyxt/mode/user-script:user-script :base-path #p "/home/user/nixos/modules/home-manager/nyxt/adblock.js" )
				  ))))

(define-command open-in-mpv ()
  "Open the current buffer's URL in MPV player if it's a YouTube link."
  (let ((current-url (render-url (url (current-buffer)))))
    (if (search "youtube.com" current-url)
        (mpv-play current-url)
        (log:info "Not a YouTube URL: ~s" current-url))))

(define-command mpv-play (url)
  "Play a URL in MPV player asynchronously."
  (uiop:run-program (list "mpv" url) :background t))

;; (defun youtube-handler (request-data)
;;   (let ((url (url request-data)))
;;     (when (and (search "youtube.com" (quri.uri:uri-host url))
;;                (search "watch" (quri.uri:uri-path url)))
;;       (open-in-mpv)
;;       (render-url url))
;;     request-data))

;; (defun youtube-handler (request-data)
;;   (let ((url (url request-data)))
;;     (setf (url request-data)
;;             (if (search "youtube.com/watch" (quri.uri:uri-host url))
;;                 (progn
;; 		(mpv-play url)
;;                 (log:info "rendering"
;;                 (render-url url))
;;                  url)
;;                 url)))
;;   request-data)


;; (define-configuration web-buffer
;;   ((request-resource-hook
;;     (serapeum:add-hook %slot-default% 'youtube-handler))))


	'';
	};
}
