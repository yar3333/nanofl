package components.nanofl.others.allpopups;

import nanofl.ide.ui.Popups;

class Code extends wquery.Component
{
	static var imports =
	{
		"prompt-popup": components.nanofl.popups.promptpopup.Code,
		"document-properties-popup": components.nanofl.popups.documentpropertiespopup.Code,
		"font-properties-popup": components.nanofl.popups.fontpropertiespopup.Code,
		"font-import-popup": components.nanofl.popups.fontimportpopup.Code,
		"symbol-add-popup": components.nanofl.popups.symboladdpopup.Code,
		"symbol-properties-popup": components.nanofl.popups.symbolpropertiespopup.Code,
		"sound-properties-popup": components.nanofl.popups.soundpropertiespopup.Code,
		"about-application-popup": components.nanofl.popups.aboutapplicationpopup.Code,
		"texture-atlases-popup": components.nanofl.popups.textureatlasespopup.Code,
		"custom-properties-popup": components.nanofl.popups.custompropertiespopup.Code,
		"texture-atlas-properties-popup": components.nanofl.popups.textureatlaspropertiespopup.Code,
		"preferences-popup": components.nanofl.popups.preferencespopup.Code,
		"hotkeys-help-popup": components.nanofl.popups.hotkeyshelppopup.Code,
		"publish-settings-popup": components.nanofl.popups.publishsettingspopup.Code,
		"share-for-devices-popup": components.nanofl.popups.sharefordevicespopup.Code,
		"register-popup": components.nanofl.popups.registerpopup.Code,
	};
	
	public function getPopups() return template();
}
