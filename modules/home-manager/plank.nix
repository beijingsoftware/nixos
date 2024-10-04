{ config, lib, pkgs, ... }: 

with lib; let
     cfg = config.plank;
     dir = ".config/plank/dock1/launchers";
in {

   options.plank = {
   		 enable = mkEnableOption "Enables Plank Config";

		 iconSize = mkOption {
		 	  type = types.int;
			  default = 50;
		 };

		 theme = mkOption {
		       type = types.str;
		       default = "Nix OS";
		 };

		 dockItems = mkOption {
		 	   type = types.listOf types.str;
			   default = [
			     "finder.dockitem"
			     "terminal.dockitem"
			     "nyxt.dockitem"
			     "emacs.dockitem"
			     "thunderbird.dockitem"
			     "webcord.dockitem"
			     "blender.dockitem"
			     "preview.dockitem"
			     "vlc.dockitem"
			     "screenshot.dockitem"
			     "trashcan.dockitem"
		     ];
		 };
   };

   config = mkIf cfg.enable {
   	 home.packages = with pkgs; [
	     plank
	 ];

	 dconf.settings = {
	     "net/launchpad/plank/docks/dock1" = {
		     alignment = "center";
		     icon-size = cfg.iconSize;
		     theme = cfg.theme;
		     dock-items = cfg.dockItems;
	     };
	 };

	 home.file."${dir}/trashcan.dockitem".text = ''
	     [PlankDockItemPreferences]
	     Launcher=docklet://trash
	 '';

	 home.file."${dir}/finder.dockitem".text = ''
	     [PlankDockItemPreferences]
	     Launcher=file:///home/user/.share/applications/Finder.desktop
	 '';

	 home.file."${dir}/emacs.dockitem".text = ''
	     [PlankDockItemPreferences]
	     Launcher=file:///home/user/.share/applications/emacs.desktop
	 '';

	 home.file."${dir}/terminal.dockitem".text = ''
	     [PlankDockItemPreferences]
	     Launcher=file:///home/user/.share/applications/Terminal.desktop
	 '';

	 home.file."${dir}/nyxt.dockitem".text = ''
	     [PlankDockItemPreferences]
	     Launcher=file:///home/user/.share/applications/Nyxt.desktop
	 '';

	 home.file."${dir}/thunderbird.dockitem".text = ''
	     [PlankDockItemPreferences]
	     Launcher=file:///home/user/.share/applications/thunderbird.desktop
	 '';

	 home.file."${dir}/webcord.dockitem".text = ''
	     [PlankDockItemPreferences]
	     Launcher=file:///home/user/.share/applications/webcord.desktop
	 '';

	 home.file."${dir}/blender.dockitem".text = ''
	     [PlankDockItemPreferences]
	     Launcher=file:///home/user/.share/applications/blender.desktop
	 '';

	 home.file."${dir}/preview.dockitem".text = ''
	     [PlankDockItemPreferences]
	     Launcher=file:///home/user/.share/applications/Preview.desktop
	 '';

	 home.file."${dir}/vlc.dockitem".text = ''
	     [PlankDockItemPreferences]
	     Launcher=file:///home/user/.share/applications/vlc.desktop
	 '';

	 home.file."${dir}/screenshot.dockitem".text = ''
	     [PlankDockItemPreferences]
	     Launcher=file:///home/user/.share/applications/xfce4-screenshooter.desktop
	 '';


	 home.file.".local/share/plank/themes/Nix OS/dock.theme".text = ''
	     [PlankTheme]
	     #The roundness of the top corners.
	     TopRoundness=15
	     #The roundness of the bottom corners.
	     BottomRoundness=15
	     #The thickness (in pixels) of lines drawn.
	     LineWidth=1
	     #The color (RGBA) of the outer stroke.
	     OuterStrokeColor=0;;0;;0;;200
	     #The starting color (RGBA) of the fill gradient.
	     FillStartColor=0;;0;;0;;190
	     #The ending color (RGBA) of the fill gradient.
	     FillEndColor=0;;0;;0;;190
	     #The color (RGBA) of the inner stroke.
	     InnerStrokeColor=0;;0;;0;;0

	     [PlankDockTheme]
	     #The padding on the left/right dock edges, in tenths of a percent of IconSize.
	     HorizPadding=0.5
	     #The padding on the top dock edge, in tenths of a percent of IconSize.
	     TopPadding=0.5
	     #The padding on the bottom dock edge, in tenths of a percent of IconSize.
	     BottomPadding=0.5
	     #The padding between items on the dock, in tenths of a percent of IconSize.
	     ItemPadding=1
	     #The size of item indicators, in tenths of a percent of IconSize.
	     IndicatorSize=8
	     #The size of the icon-shadow behind every item, in tenths of a percent of IconSize.
	     IconShadowSize=9.9999999999999998e-17
	     #The height (in percent of IconSize) to bounce an icon when the application sets urgent.
	     UrgentBounceHeight=0
	     #The height (in percent of IconSize) to bounce an icon when launching an application.
	     LaunchBounceHeight=0
	     #The opacity value (0 to 1) to fade the dock to when hiding it.
	     FadeOpacity=0
	     #The amount of time (in ms) for click animations.
	     ClickTime=450
	     #The amount of time (in ms) to bounce an urgent icon.
	     UrgentBounceTime=600
	     #The amount of time (in ms) to bounce an icon when launching an application.
	     LaunchBounceTime=600
	     #The amount of time (in ms) for active window indicator animations.
	     ActiveTime=300
	     #The amount of time (in ms) to slide icons into/out of the dock.
	     SlideTime=300
	     #The time (in ms) to fade the dock in/out on a hide (if FadeOpacity is < 1).
	     FadeTime=550
	     #The time (in ms) to slide the dock in/out on a hide (if FadeOpacity is 1).
	     HideTime=150
	     #The size of the urgent glow (shown when dock is hidden), in tenths of a percent of IconSize.
	     GlowSize=30
	     #The total time (in ms) to show the hidden-dock urgent glow.
	     GlowTime=10000
	     #The time (in ms) of each pulse of the hidden-dock urgent glow.
	     GlowPulseTime=800
	     #The hue-shift (-180 to 180) of the urgent indicator color.
	     UrgentHueShift=0
	     #The time (in ms) to move an item to its new position or its addition/removal to/from the dock.
	     ItemMoveTime=150
	     #Whether background and icons will unhide/hide with different speeds. The top-border of both will leave/hit the screen-edge at the same time.
	     CascadeHide=true
	     #The color (RGBA) of the badge displaying urgent count
	     BadgeColor=0;;0;;0;;0
	     IndicatorColor=0;;0;;0;;255
	 '';   	  
	};
}
