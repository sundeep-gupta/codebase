#include-once

#include <Date.au3>
#include "Func-AutomatedPerformance.au3"
#include <Array.au3>
#include <File.au3>
#include <inet.au3>

#region --- Support Client Field Control Names & Control Variables --- 
;Field Title and control Names
Global Const $defectid          = "TSLEdit2"
Global Const $status            = "TSLPickList16"
Global Const $type              = "TSLPickList9"
Global Const $project           = "TSLPickList12"
Global Const $area              = "TSLPickList15"
Global Const $category          = "TSLPickList14"
Global Const $issue             = "TSLPickList13"
Global Const $severity          = "TSLPickList17" 
Global Const $priority          = "TSLPickList18"
Global Const $verfound          = "TSLPickList8"
Global Const $vertbf            = "TSLPickList7"
Global Const $fixedbuild        = "TSLPickList11"
Global Const $resolution        = "TSLPickList10"
Global Const $subject           = "TSLEdit3"
Global Const $assignedto        = "TSLLinkEdit1"
Global Const $reportedby		= "TSLLinkEdit3"
Global Const $detailtab         = "TTabControl1" ;and then press home
Global Const $defectdescription = "TSLMemo2"
Global Const $defectresolution  = "TSLMemo1"
Global Const $language          = "TSLPickList6"
Global Const $source            = "TSLPickList5"
Global Const $vendor            = "TSLPickList4"
Global Const $regression        = "TSLPickList3"
Global Const $changecontrol     = "TSLCheckbox3"
Global Const $knownissue        = "TSLCheckbox4"
Global Const $kbarticle         = "TSLCheckbox2"
Global Const $milestone 		= "TSLPickList2"
Global Const $localizationready = "TSLCheckbox1"
Global Const $product           = "TSLPickList1"

;Support Client Variables
Global Const $status_variables       = "<None>|Open|Pending|Closed|Unit Testing|Deferred"
Global Const $type_variables         = "Defect|Task|Feature Request|Personal Task|Feedback|Code Review|Research|Specification"
Global Const $project_variables      = "6.0 Loco-Disco|6.0 OEM Branding|6.0.3 Localization|6.02 - PUNK|7.0.4 L10N|8.0.1 L10N|ACT Accounting 2.0|ACT!|ACT! - 10|ACT! - 6.0 Dutch|ACT! - 6.0 French|ACT! - 6.0 German|ACT! - 7.0.1|ACT! - 7.0.2|ACT! - 7.0.3|ACT! - 7.0.4|ACT! - 8.0|ACT! - 8.0- PDA Links|ACT! - 8.0.1|ACT! - 8.0.2|ACT! - 9.0|ACT! - AFW1.2.5|ACT! - Database Generator|ACT! - Inca|ACT! - Office 11|ACT! - Redstone|ACT! - Webster|ACT! 6.01|ACT! for Palm - Next Release|ACT! for Palm 2.0.1|ACT! for Palm 3.0|ACT! for Web - Next Release|ACT! for Windows - Next Release|ACT! German 5.03|ACT! Link for Peachtree |ACT! Mercury|ACT! Mini-Me|ACT! Next - Non Windows|ACT! Peru|ACT! Slimfast|ACT! Spec Template|ACT!-5.04Patch|ACT!-6.03|ACT!-6.0Disco|ACT!-Dutch|ACT!-French|ACT!-French 5.04|ACT!-Gagarin|ACT!-German|ACT!-German 5.04|ACT!-Linkin|ACT!-Portuguese|ACT!-Spanish|ACT!MIRAGE|ACTLink for Peachtree|Barney - Palm Link|Betty - PPC Link|Ciel|Commerce Logix eConfigurator|Configuration Engine 4.0|Cresco|CrossLogix|Customer Care|Disco Deferred|Ewok|Ewok - 7.0.2|Ewok Next|Framework - 3.1.1 |Framework 1.1|Framework 1.2|Framework 1.3|Framework 1.5|Framework 2.0|Framework 2.5|Framework 3.0|Framework 3.0.1|Framework 3.0.2|Framework 3.1.2|Framework 3.1.3|Fred & Wilma|Gilligan|Gollum|Hot Fix #1 for Hopi|Hot Fix #1 for Phoenix|Interact|Interact May 2000|Interact Phase 1|Interact Phase 1A|Interact Phase 2|International|IQ Issues|KHK 6.02 OEM|KHK OEM|KSync Event Packs|Line50 OEM|Logo 7.0|Lumberjack|Mail Link|Market Metrix|Mercurius|Mercury LDK|MiniMe 2|Monarch-phase1|Monarch-Phase2|Munchkin|PCT Link|Peachtree OEM|PUMA|QB - 2.0.1|QB Link|Quickbooks Driver 2.0|Quickbooks Driver 2.0 - Hot Fix|Quickbooks Driver 2.5|Quickbooks Driver 3.0|Quickbooks Driver Next Release|R2D2|R2D2 - 7.0.2|R2D2 Next|Rebox|Redstone 8.0.1|Redstone 8.0.2|Redstone inline|Sage Contact France|Sage Framework|Sage France 6.02 OEM|Sage OEM - Ciel|Sage OEM - Portugal|Sage OEM - Spain|Service Pack after Cottonwood|Solution Selling|SPX to SLX Link|Support Client|SupportExpress|Tattoo|Time Entry System|Titanic3|Utilities|WEB - ASSP|Web Link|Yoda"
Global Const $area_variables         = 'About Box|Accounting Link|Accounting Menu|Accounting Tab|ACT!|ACT! 7.0 SDK|ACT! Update|ACT! Word Processor|Actdiag|Activities Scheduling (incl Rollover)|Activities-Calendar (incl Pop-ups)|Activities-Series|Admin Tool|Alarms|App Scalability & Perform|Application Shell|Backup/Restore|Branding|CD Browser|Citrix/Terminal Server|Companies|Conduit|Conflict Resolution|Contact Management|Conversion (3.x-6.x)|Copy DB/Save As|Correspondence/WP (incl Word Integration)|Create Link|Customization|Data Exchange (import/export database)|Data Store/File Mgmt|Database Maintenance |Database Update (Schema Updates)|Database/MS SQL|Define Fields|Dialer|Documentation|Drag/Drop|Duplicate Checking|Edit Link|E-mail|Excel integration|Faxing|Getting Started Wizard|Groups|Import Link|Installation/Uninstall|International English|Internet Links/Maps and Driving Directions|Internet Services|Layout Designer|List View|Login|Lookup-Contact Activity|Lookups|Lookups Advanced Query|Lookups Keyword Search|Lookups Quick Search|Mail Merge|Mass Link|Menu/ToolBar/NavBar-Custom|Multi-User Behavior|Name Parsing|Name Resolution|OLE DB Provider|Online Help|Opportunities|Outlook Integration|Outlook Integration-Activity Sync|Outlook Integration-Address Books|Palm-Activities|Palm-Conduit Config|Palm-Conflict Resolution|Palm-Contacts|Palm-Documentation|Palm-Help|Palm-Installation/Uninstall|Palm-Outlook Integration|Palm-Performance|Palm-Preferences|Palm-Registration/Licensing|Palm-Sync|Phone Format|PickList|Plugins|PPC-Activities|PPC-Conduit Config|PPC-Conflict Resolution|PPC-Contacts|PPC-Documentation|PPC-Help|PPC-Installation/Uninstall|PPC-Outlook Integration|PPC-Performance|PPC-Preferences|PPC-Registration/Licensing|PPC-Sync|Preferences|Printing|Printing-Address Book |Printing-Calendar|Printing-Envelopes & Labels|Printing-Quick Printing|Printing-Reporting|Quotes|Refresh|Registration/Licensing|Replace/Swap/Copy|Report Designer|Scan for Dupes|Scheduler|SDK|Secondary Contact|Security|Serialization/Activation|Setup Link|Spellchecker (3rd party)|Sync API|Synchronization|Task List (incl Pop-ups)|Templates-ACT! WP|Templates-Layout (Contact/Group/Company)|Templates-MS WP|Templates-Reporting|Tiering|Trial Version|UI|Unicode|Update Link|User/Team Management|View Summary|Window/View (MDI Mode)'
Global Const $area_variables_2       = ''
Global Const $area_variables_3       = ''
Global Const $severity_variables     = "Severity 1|Severity 2|Severity 3|N/A"
Global Const $priority_variables     = "N/A|1-High|2-Medium|3-Low|0-Red Alert|IT|ET|ET2|RC|Tier 1|Tier 2|Tier 3|1-Hit List"
Global Const $resolution_variables   = "<None>|Doc Correction for Next Rev|Duplicate|Functions As Designed|Feature Request|Fixed|Fixed Indirectly|Hardware Limitation|Need More Information|Not Applicable|No Change Expected|Not Reproducible|No Plan To Fix|Postponed|Rejected by QA|Software Limitation|User Error|Scrub|In Work|Review|Change Control|Fixed by Dev|QA - Fixed|QA - Verified|3rd party limitation"
Global Const $source_variables       = "ACC|Accounting|ACT! for Palm|APAC|BETA|EMEA|Handhelds|Legal|Redstone|SWAT|Tech Support"
;~ Global Const $user_areas_variables   = ""
Global Const $vendor_variables       = "Best Software - ACT! 6.0|ComponentOne - FlexGrid|ComponentOne - Report Designer|ComponentOne - SpellChecker|ComponentOne - Zip|DevComponent - DotnetBar|Genghis Group - Genghis|HotWind Software -TapiEx|ImageSource - Tx Text Control|Infragistics|InstallShield|Janus|Microsoft - .NET|Microsoft - Excel|Microsoft - Outlook|Microsoft - win32|Microsoft - Windows|Microsoft - Word"
Global Const $regression_variables   = "ACT! 7.0.2 x58|6.0.3 L10N x001pt|6.0.3 L10N x002pt|6.0.3 L10N x003pt|6.0.3 L10N x004pt|6.0.3 L10N x005pt|6.0.3 L10N x006pt|6.0.3 L10N x007pt|6.0.3 L10N x008pt|6.0.3 L10N x979de|6.0.3 L10N x979deB|6.0.3 L10N x979deC|6.0.3 L10N x980de|6.0.3 L10N x981de|6.0.3 L10N x982de|6.0.3 L10N x983de|6.0.3 L10N x983deB|6.0.3 L10N x984de|6.0.3 L10N x984deB|6.0.3 L10N x985de|6.0.3 L10N x985deB|6.0.3 L10N x986nl|6.0.3 L10N x987nl|6.0.3 L10N x988laes|6.0.3 L10N x988laes_PSEUDO|6.0.3 L10N x988nl|6.0.3 L10N x988nlB|6.0.3 L10N x989fr|6.0.3 L10N x989nl|6.0.3 L10N x990laes|6.0.3 L10N x991fr|6.0.3 L10N x992fr|6.0.3 L10N x992frB|6.0.3 L10N x992frB_CIEL|6.0.3 L10N x992frC|6.0.3 L10N x992frD|6.0.3 L10N x992frD_CIEL|6.0.3 L10N x992frE|6.0.3 L10N x992frE_CIEL|6.0.3 L10N x992frF|6.0.3 L10N x992frF_CIEL|6.0.3 L10N x992frG|6.0.3 L10N x992frG_CIEL|6.0.3 L10N x993es|6.0.3 L10N x994de|6.0.3 L10N x994laes|6.0.3 L10N x994nl|6.0.3 L10N x995laes|6.0.3 L10N x996laes|6.0.3 L10N x996laesB|6.0.3 L10N x996laesC|6.0.3 L10N x996laesC2|6.0.3 L10N x996laesD|6.0.3 L10N x996laesE|6.0.3 L10N x996laesF|6.0.3 L10N x996laesG|6.0.3 L10N x996laesH|6.0.3 L10N x996laesI|6.0.3 L10N x997es|6.0.3 L10N x997esB|6.0.3 L10N x997esC|6.0.3 L10N x997esD|ACT! - 7.0.2|ACT! 7.0.1 x400|ACT! 7.0.1 x401|ACT! 7.0.1 x402|ACT! 7.0.1 x403|ACT! 7.0.1 x404|ACT! 7.0.1 x405|ACT! 7.0.1 x406|ACT! 7.0.1 x407|ACT! 7.0.1 x408|ACT! 7.0.1 x409|ACT! 7.0.1 x410|ACT! 7.0.1 x411|ACT! 7.0.1 x412|ACT! 7.0.1 x413|ACT! 7.0.1 x414|ACT! 7.0.1 x415|ACT! 7.0.1 x416|ACT! 7.0.1 x417|ACT! 7.0.1 x418|ACT! 7.0.1 x419|ACT! 7.0.1 x420|ACT! 7.0.1 x421|ACT! 7.0.1 x422|ACT! 7.0.1 x423|ACT! 7.0.1 x424|ACT! 7.0.1 x425|ACT! 7.0.1 x426|ACT! 7.0.1 x427|ACT! 7.0.1 x428|ACT! 7.0.1 x429|ACT! 7.0.1 x430|ACT! 7.0.1 x431|ACT! 7.0.1 x432|ACT! 7.0.1 x433|ACT! 7.0.1 x434|ACT! 7.0.1 x435|ACT! 7.0.1 x436|ACT! 7.0.1 x437|ACT! 7.0.1 x438|ACT! 7.0.1 x439|ACT! 7.0.1 x440|ACT! 7.0.1 x441|ACT! 7.0.1 x442|ACT! 7.0.1 x443|ACT! 7.0.1 x444|ACT! 7.0.1 x445|ACT! 7.0.1 x446|ACT! 7.0.1 x447|ACT! 7.0.1 x448|ACT! 7.0.1 x449|ACT! 7.0.1 x450|ACT! 7.0.1 x451|ACT! 7.0.1 x452|ACT! 7.0.1 x453|ACT! 7.0.1 x454|ACT! 7.0.1 x455|ACT! 7.0.1 x456|ACT! 7.0.1 x457|ACT! 7.0.1 x458|ACT! 7.0.1 x459|ACT! 7.0.1 x460|ACT! 7.0.1 x461|ACT! 7.0.1 x462|ACT! 7.0.1 x463|ACT! 7.0.1 x464|ACT! 7.0.1 x465|ACT! 7.0.1 x466|ACT! 7.0.1 x467|ACT! 7.0.1 x468|ACT! 7.0.1 x469|ACT! 7.0.1 x470|ACT! 7.0.1 x471|ACT! 7.0.1 x472|ACT! 7.0.1 x473|ACT! 7.0.1 x474|ACT! 7.0.1 x475|ACT! 7.0.1 x476|ACT! 7.0.1 x477|ACT! 7.0.1 x478|ACT! 7.0.1 x479|ACT! 7.0.1 x480|ACT! 7.0.1 x481|ACT! 7.0.1 x482|ACT! 7.0.1 x483|ACT! 7.0.1 x484|ACT! 7.0.1 x485|ACT! 7.0.1 x486|ACT! 7.0.1 x487|ACT! 7.0.2 x05|ACT! 7.0.2 x06|ACT! 7.0.2 x07|ACT! 7.0.2 x08|ACT! 7.0.2 x09|ACT! 7.0.2 x10|ACT! 7.0.2 x11|ACT! 7.0.2 x12|ACT! 7.0.2 x13|ACT! 7.0.2 x14|ACT! 7.0.2 x15|ACT! 7.0.2 x16|ACT! 7.0.2 x17|ACT! 7.0.2 x18|ACT! 7.0.2 x19|ACT! 7.0.2 x20|ACT! 7.0.2 x21|ACT! 7.0.2 x22|ACT! 7.0.2 x23|ACT! 7.0.2 x24|ACT! 7.0.2 x25|ACT! 7.0.2 x26|ACT! 7.0.2 x27|ACT! 7.0.2 x28|ACT! 7.0.2 x29|ACT! 7.0.2 x30|ACT! 7.0.2 x31|ACT! 7.0.2 x32|ACT! 7.0.2 x33|ACT! 7.0.2 x34|ACT! 7.0.2 x35|ACT! 7.0.2 x36|ACT! 7.0.2 x37|ACT! 7.0.2 x38|ACT! 7.0.2 x39|ACT! 7.0.2 x40|ACT! 7.0.2 x41|ACT! 7.0.2 x42|ACT! 7.0.2 x43|ACT! 7.0.2 x44|ACT! 7.0.2 x45|ACT! 7.0.2 x46|ACT! 7.0.2 x47|ACT! 7.0.2 x48|ACT! 7.0.2 x49|ACT! 7.0.2 x50|ACT! 7.0.2 x51|ACT! 7.0.2 x52|ACT! 7.0.2 x53|ACT! 7.0.2 x54|ACT! 7.0.2 x55|ACT! 7.0.2 x56|ACT! 7.0.2 x57|ACT! 7.0.2 x58|ACT! 7.0.2 x59|ACT! 7.0.2 x60|ACT! 7.0.2 x61|ACT! 7.0.2 x62|ACT! 7.0.2 x63|ACT! 7.0.2 x64|ACT! 7.0.2 x65|ACT! 7.0.2 x66|ACT! 7.0.2 x67|ACT! 7.0.2 x68|ACT! 7.0.2 x69|ACT! 7.0.2 x70|ACT! 7.0.2 x71|ACT! 7.0.2 x72|ACT! 7.0.2 x73|ACT! 7.0.2 x74|ACT! 7.0.2 x75|ACT! 7.0.2 x76|ACT! 7.0.2 x77|ACT! 7.0.2 x78|ACT! 7.0.2 x79|ACT! 7.0.2 x80|ACT! 7.0.2 x81|ACT! 7.0.3 x0|ACT! 7.0.3 x1|ACT! 7.0.3 x10|ACT! 7.0.3 x100|ACT! 7.0.3 x101|ACT! 7.0.3 x102|ACT! 7.0.3 x103|ACT! 7.0.3 x104|ACT! 7.0.3 x105|ACT! 7.0.3 x106|ACT! 7.0.3 x107|ACT! 7.0.3 x108|ACT! 7.0.3 x109|ACT! 7.0.3 x11|ACT! 7.0.3 x110|ACT! 7.0.3 x111|ACT! 7.0.3 x112"
Global Const $regression_variables_2 = "ACT! 7.0.3 x113|ACT! 7.0.3 x114|ACT! 7.0.3 x115|ACT! 7.0.3 x116|ACT! 7.0.3 x117|ACT! 7.0.3 x118|ACT! 7.0.3 x119|ACT! 7.0.3 x12|ACT! 7.0.3 x120|ACT! 7.0.3 x121|ACT! 7.0.3 x122|ACT! 7.0.3 x123|ACT! 7.0.3 x124|ACT! 7.0.3 x125|ACT! 7.0.3 x126|ACT! 7.0.3 x127|ACT! 7.0.3 x128|ACT! 7.0.3 x129|ACT! 7.0.3 x13|ACT! 7.0.3 x130|ACT! 7.0.3 x131|ACT! 7.0.3 x132|ACT! 7.0.3 x133|ACT! 7.0.3 x134|ACT! 7.0.3 x135|ACT! 7.0.3 x136|ACT! 7.0.3 x137|ACT! 7.0.3 x138|ACT! 7.0.3 x139|ACT! 7.0.3 x14|ACT! 7.0.3 x140|ACT! 7.0.3 x141|ACT! 7.0.3 x142|ACT! 7.0.3 x143|ACT! 7.0.3 x144|ACT! 7.0.3 x145|ACT! 7.0.3 x146|ACT! 7.0.3 x147|ACT! 7.0.3 x148|ACT! 7.0.3 x149|ACT! 7.0.3 x15|ACT! 7.0.3 x150|ACT! 7.0.3 x151|ACT! 7.0.3 x152|ACT! 7.0.3 x153|ACT! 7.0.3 x154|ACT! 7.0.3 x155|ACT! 7.0.3 x156|ACT! 7.0.3 x157|ACT! 7.0.3 x158|ACT! 7.0.3 x159|ACT! 7.0.3 x16|ACT! 7.0.3 x160|ACT! 7.0.3 x161|ACT! 7.0.3 x162|ACT! 7.0.3 x163|ACT! 7.0.3 x164|ACT! 7.0.3 x165|ACT! 7.0.3 x166|ACT! 7.0.3 x167|ACT! 7.0.3 x168|ACT! 7.0.3 x169|ACT! 7.0.3 x17|ACT! 7.0.3 x170|ACT! 7.0.3 x171|ACT! 7.0.3 x172|ACT! 7.0.3 x173|ACT! 7.0.3 x174|ACT! 7.0.3 x175|ACT! 7.0.3 x176|ACT! 7.0.3 x177|ACT! 7.0.3 x178|ACT! 7.0.3 x179|ACT! 7.0.3 x18|ACT! 7.0.3 x180|ACT! 7.0.3 x181|ACT! 7.0.3 x182|ACT! 7.0.3 x183|ACT! 7.0.3 x184|ACT! 7.0.3 x185|ACT! 7.0.3 x186|ACT! 7.0.3 x187|ACT! 7.0.3 x188|ACT! 7.0.3 x189|ACT! 7.0.3 x19|ACT! 7.0.3 x190|ACT! 7.0.3 x191|ACT! 7.0.3 x193|ACT! 7.0.3 x194|ACT! 7.0.3 x195|ACT! 7.0.3 x196|ACT! 7.0.3 x197|ACT! 7.0.3 x198|ACT! 7.0.3 x199|ACT! 7.0.3 x2|ACT! 7.0.3 x20|ACT! 7.0.3 x200|ACT! 7.0.3 x201|ACT! 7.0.3 x202|ACT! 7.0.3 x203|ACT! 7.0.3 x204|ACT! 7.0.3 x205|ACT! 7.0.3 x206|ACT! 7.0.3 x207|ACT! 7.0.3 x208|ACT! 7.0.3 x209|ACT! 7.0.3 x21|ACT! 7.0.3 x210|ACT! 7.0.3 x211|ACT! 7.0.3 x212|ACT! 7.0.3 x213|ACT! 7.0.3 x214|ACT! 7.0.3 x215|ACT! 7.0.3 x216|ACT! 7.0.3 x217|ACT! 7.0.3 x218|ACT! 7.0.3 x219|ACT! 7.0.3 x22|ACT! 7.0.3 x220|ACT! 7.0.3 x23|ACT! 7.0.3 x24|ACT! 7.0.3 x25|ACT! 7.0.3 x26|ACT! 7.0.3 x27|ACT! 7.0.3 x28|ACT! 7.0.3 x29|ACT! 7.0.3 x3|ACT! 7.0.3 x30|ACT! 7.0.3 x31|ACT! 7.0.3 x32|ACT! 7.0.3 x33|ACT! 7.0.3 x34|ACT! 7.0.3 x35|ACT! 7.0.3 x36|ACT! 7.0.3 x37|ACT! 7.0.3 x38|ACT! 7.0.3 x39|ACT! 7.0.3 x4|ACT! 7.0.3 x40|ACT! 7.0.3 x41|ACT! 7.0.3 x42|ACT! 7.0.3 x43|ACT! 7.0.3 x44|ACT! 7.0.3 x45|ACT! 7.0.3 x46|ACT! 7.0.3 x47|ACT! 7.0.3 x48|ACT! 7.0.3 x49|ACT! 7.0.3 x5|ACT! 7.0.3 x50|ACT! 7.0.3 x51|ACT! 7.0.3 x52|ACT! 7.0.3 x53|ACT! 7.0.3 x54|ACT! 7.0.3 x55|ACT! 7.0.3 x56|ACT! 7.0.3 x57|ACT! 7.0.3 x58|ACT! 7.0.3 x59|ACT! 7.0.3 x6|ACT! 7.0.3 x60|ACT! 7.0.3 x61|ACT! 7.0.3 x62|ACT! 7.0.3 x63|ACT! 7.0.3 x64|ACT! 7.0.3 x65|ACT! 7.0.3 x66|ACT! 7.0.3 x67|ACT! 7.0.3 x68|ACT! 7.0.3 x69|ACT! 7.0.3 x7|ACT! 7.0.3 x70|ACT! 7.0.3 x72|ACT! 7.0.3 x73|ACT! 7.0.3 x74|ACT! 7.0.3 x75|ACT! 7.0.3 x76|ACT! 7.0.3 x77|ACT! 7.0.3 x78|ACT! 7.0.3 x79|ACT! 7.0.3 x8|ACT! 7.0.3 x80|ACT! 7.0.3 x81|ACT! 7.0.3 x82|ACT! 7.0.3 x83|ACT! 7.0.3 x84|ACT! 7.0.3 x85|ACT! 7.0.3 x86|ACT! 7.0.3 x87|ACT! 7.0.3 x88|ACT! 7.0.3 x89|ACT! 7.0.3 x9|ACT! 7.0.3 x90|ACT! 7.0.3 x91|ACT! 7.0.3 x92|ACT! 7.0.3 x93|ACT! 7.0.3 x94|ACT! 7.0.3 x95|ACT! 7.0.3 x96|ACT! 7.0.3 x97|ACT! 7.0.3 x98|ACT! 7.0.3 x99|ACT! 7.0.4 x01|ACT! 7.0.4 x02|ACT! 7.0.4 x03|ACT! 7.0.4 x04|ACT! 7.0.4 x05|ACT! 7.0.4 x06|ACT! 7.0.4 x07|ACT! 7.0.4 x08|ACT! 7.0.4 x09|ACT! 7.0.4 x10|ACT! 7.0.4 x11|ACT! 7.0.4 x12|ACT! 7.0.4 x13|ACT! 7.0.4 x14|ACT! 7.0.4 x15|ACT! 7.0.4 x16|ACT! 7.0.4 x17|ACT! 7.0.4 x18|ACT! 7.0.4 x19|ACT! 7.0.4 x20|ACT! 7.0.4 x21|ACT! 7.0.4 x22|ACT! 7.0.4 x23|ACT! 7.0.4 x24|ACT! 7.0.4 x25|ACT! 7.0.4 x26|ACT! 7.0.4 x27|ACT! 7.0.4 x28|ACT! 7.0.4 x29|ACT! 7.0.4 x30|ACT! 8.0 x01|ACT! 8.0 x02|ACT! 8.0 x03|ACT! 8.0 x04|ACT! 8.0 x05|ACT! 8.0 x06|ACT! 8.0 x07|ACT! 8.0 x08|ACT! 8.0 x09|ACT! 8.0 x10|ACT! 8.0 x11|ACT! 8.0 x12|ACT! 8.0 x13|ACT! 8.0 x14|ACT! 8.0 x15|ACT! 8.0 x16|ACT! 8.0 x17|ACT! 8.0 x18|ACT! 8.0 x19|ACT! 8.0 x20|ACT! 8.0 x21|ACT! 8.0 x22|ACT! 8.0 x23|ACT! 8.0 x24|ACT! 8.0 x25|ACT! 8.0 x26|ACT! 8.0 x27|ACT! 8.0 x28|ACT! 8.0 x29|ACT! 8.0 x30|ACT! 8.0 x31|ACT! 8.0 x32|ACT! 8.0 x33|ACT! 8.0 x34|ACT! 8.0 x35|ACT!INTL"
Global Const $regression_variables_3 = "ACT!TechPubs|ACTLink for Peach 1016|ACTLink for Peach 1029|CE - 4.0|Ciel x423A|Ciel x423B|Ciel x423C|Ciel x423D|Ciel x423E|Ciel x423F|Ciel x423G|Ciel x423H|Ciel x423I|Ciel x423J|Ciel x423K|Devweb1|Devweb6|Disco 535|Disco 536|Disco 537|Disco 538|Disco 539|Disco 540|Disco 541|Disco 542|Disco 543|Disco 544|Disco 545|Disco 546|Disco 547|Disco 548|Disco 549|Disco 550|Disco 551|Disco 552|Disco 553|Disco 554|Disco 555|Disco 556|Disco 557|Disco 558|Disco 559|Disco 560|Disco 561|Disco 562|Disco 563|Disco 564|Disco 565|Disco 566|Disco 567|Disco 568|Disco 569|Disco 570|Disco 571|Disco 572|Disco 573|Disco 574|Disco 575|Disco 576|Disco 577|Disco 578|Disco 579|Disco 580|Disco 581|Disco 582|Disco 583|Disco 584|Disco 585|Disco 586|Disco 587|Disco 588|Disco 589|Disco 590|Disco 591|Disco 592|Disco 593|Disco 594|Disco 595|Disco 596|Disco 597|Disco 598|Disco 599|Disco 600|Disco 601|Disco 602|Disco 603|Disco 604|Disco 605|Disco 606|Disco 607|Disco 608|Disco 609|Disco 610|Disco 611|Disco 612|Disco 613|Disco 614|Disco 615|Disco 616|Disco 617|Disco 618|Disco 619|Disco 620|Disco 621|Disco 622|Disco 623|Disco 624|Disco 625|Disco 626|Disco 627|Disco 628|Disco 629|Disco 630|Disco 631|Disco 632|Disco 633|Disco 634|Disco 635|Disco 636|Disco 637|Disco 638|Disco 639|Disco 640|Disco 641|Disco 642|Disco 643|Disco 644|Disco 645|Disco 646|Disco 647|Disco 648|Disco 649|Disco 650|Disco 651|Disco 652|Disco 653|Disco 654|Disco 655|Disco 656|Disco 657|Disco 658|Disco 659|Disco 660|Disco 661|Disco 662|Disco 663|Disco 664|Disco 665|Disco 666|Disco 667|Disco 668|Disco 669|Disco 670|Disco 671|Disco 672|Disco 673|Disco 674|Disco 675|Disco 676|Disco 677|Disco 678|Disco 679|Disco 680|Disco 681|Disco 682|Disco 683|Disco 684|Disco 685|Disco 686|Disco 687|Disco 688|Disco 689|Disco 690|Disco 691|Disco 692|Disco 693|Disco 694|Disco 695|Disco 696|Disco 697|Disco 698|Disco 699|Disco 700|Disco 701|Disco 702|Disco 703|Disco 704|Disco 705|Disco 706|Disco 707|Disco 708|Disco 709|Disco 710|Disco 711|Disco 712|Disco 713|Disco 714|Disco 715|Disco 716|Disco 717|Disco 718|Disco 719|Disco 720|Ewok 2004.5.12|Ewok 2004.5.28|Ewok 2004.6.04|Ewok 2004.6.09|Ewok 2004.6.15|Ewok 2004.6.23|Ewok 2004.6.24|Ewok 2004.6.25|Ewok 2004.7.07|Ewok 2004.7.09|Ewok 2004.7.19|Ewok 2004.7.23|Ewok 2004.7.28|Ewok 2004.7.29|Ewok 2004.7.29a|Ewok 2004.7.30|Ewok 2004.8.03|Ewok x2550|Ewok x2551|Ewok x2552|Ewok x2553|Ewok x2554|Ewok x2555|Ewok x2556|Ewok x2557|Ewok x2558|Ewok x2559|Framework 1.1|Framework v 1.0|Framework v 1.01|Framework v 1.02|Framework v 1.03|Framework v1.04|Framework v1.06|Framework x216|Framework x217|Framework x218|Framework x219|Framework x220|Framework x221|Framework x222|Framework x223|Framework x224|Framework x225|Framework x226|Framework x227|Framework x228|Framework x229|Framework x230|Framework x231|Framework x232|Framework x233|Framework x234|Framework x235|Framework x236|Framework x237|Framework x238|Framework x239|Framework x240|Framework x241|Framework x242|Framework x243|Framework x244|Framework x245|Framework x246|Framework x247|Framework x248|Framework x249|Framework x250|Framework x257|Framework x276|Framework x291|Framework x292|Framework x293|Framework x294|Framework x295|Framework x296|Framework x297|Framework x298|Framework x299|Framework x29a|Framework x29b|Framework x29c|Framework x29d|Framework x300|Framework x301|Framework x302|Framework x303|Framework x304|Framework x305|Framework x306|Framework x307|Framework x308|Framework x309|Framework x310|Framework x311|Framework x312|Framework x313|Framework x34|Framework x340|Framework x341|Framework x342|Framework x343|Framework x344|Framework x345|Framework x346|Framework x347|Framework x348|Framework x349|Framework x35|Framework x350|Framework x351|Framework x352|Framework x353|Framework x354|Framework x355|Framework x356|Framework x357|Framework x358|Framework x359|Framework x36|Framework x360|Framework x361|Framework x362|Framework x363|Framework x364|Framework x365|Framework x366|Framework x367|Framework x368|Framework x369|Framework x37|Framework x370|Framework x371"
Global Const $regression_variables_4 = "Framework x372|Framework x373|Framework x374|Framework x375|Framework x376|Framework x377|Framework x378|Framework x379|Framework x380|Framework x381|Framework x382|Framework x383|Framework x384|Framework x385|Framework x386|Framework x387|Framework x388|Framework x389|Framework x390|Framework x391|Framework x392|Framework x393|Framework x394|Framework x395|Framework x396|Framework x397|Framework x398|Framework x399|Framework x400|Framework x41|Framework x42|Framework x43|Framework x44|Framework x45|Framework x46|Framework x47|Framework x48|Framework x49|Framework x50|Framework x51|Framework x52|Framework x53|Framework x54|Framework x55|Framework x56|Framework x57|Framework x58|Framework x59|Framework x60|Framework x61|Framework x62|Framework x63|Framework x64|Framework x65|Framework x66|Framework x67|Framework x68|Framework x69|Framework x70|Framework x71|Framework x72|Framework x80|Framework x81|Framework x82|Framework x83|Framework x84|Framework x85|Framework x86|Framework x87|Framework x88|Framework x89|Framework x90|Fred x100|Fred x101|Fred x102|Fred x103|Fred x104|Fred x105|Fred x106|Fred x107|Fred x108|Fred x109|Fred x110|Fred x111|Fred x112|Fred x113|Fred x114|Fred x115|Fred x116|Fred x117|Fred x118|Fred x119|Fred x120|Fred x121|Fred x122|Fred x123|Fred x124|Fred x125|Fred x126|Fred x127|Fred x128|Fred x129|Fred x130|Fred x131|Fred x132|Fred x133|Fred x134|Fred x135|Fred x136|Fred x137|Fred x138|Fred x139|Fred x140|Fred x141|Fred x142|Fred x143|Fred x144|Fred x145|Fred x146|Fred x147|Fred x148|Fred x149|Fred x150|Fred x151|Fred x152|Fred x153|Fred x154|Fred x155|Fred x156|Fred x157|Fred x158|Fred x159|Fred x160|Fred x161|Fred x162|Fred x163|Fred x164|Fred x165|Fred x166|Fred x167|Fred x168|Fred x169|Fred x170|Fred x171|Fred x172|Fred x173|Fred x174|Fred x175|Fred x176|Fred x177|Fred x178|Fred x179|Fred x180|Fred x181|Fred x182|Fred x183|Fred x184|Fred x185|Fred x186|Fred x187|Fred x188|Fred x189|Fred x190|Fred x191|Fred x192|Fred x193|Fred x194|Fred x195|Fred x196|Fred x197|Fred x198|Fred x199|Fred x200|Fred x201|Fred x202|Fred x203|Fred x204|Fred x205|Fred x206|Fred x207|Fred x208|Fred x209|Fred x210|Fred x50|Fred x51|Fred x52|Fred x53|Fred x54|Fred x55|Fred x56|Fred x57|Fred x58|Fred x59|Fred x60|Fred x61|Fred x62|Fred x63|Fred x64|Fred x65|Fred x66|Fred x67|Fred x68|Fred x69|Fred x70|Fred x71|Fred x72|Fred x73|Fred x74|Fred x75|Fred x76|Fred x77|Fred x78|Fred x79|Fred x80|Fred x81|Fred x82|Fred x83|Fred x84|Fred x85|Fred x86|Fred x87|Fred x88|Fred x89|Fred x90|Fred x91|Fred x92|Fred x93|Fred x94|Fred x95|Fred x96|Fred x97|Fred x98|Fred x99|Gilligan x541|Gilligan x542|Gollum x211|Gollum x212|Gollum x213|Gollum x214|Gollum x215|Gollum x216|Gollum x217|Gollum x218|Gollum x219|Gollum x220|Gollum x221|Gollum x222|Gollum x223|Gollum x224|Gollum x225|Gollum x226|Gollum x227|Gollum x228|Gollum x229|Gollum x230|Inca - 1.0.309|Inca - x431|Inca - x432|Inca - x433|Inca - x434|Inca - x435|KHK 6.02 x20|KHK 6.02 x21|KHK 6.02 x22|KHK 6.02 x23|KHK x423A|KHK x423B|KHK x423C|KHK x423D|KHK x423E|KHK x423F|KHK x423G|KHK x423H|KHK x423I|KHK x423J|KHK x423K|KHK x423L|KHK x423M|KHK x423N|KHK x423O|KHK x423P|KSync Event Packs|Mercurius 7.0.3.035FR|Mercurius 7.0.3.044FR|Mercurius 7.0.3.045FR|Mercurius 7.0.3.056FR|Mercurius 7.0.3.059FR|Mercurius 7.0.3.060FR|Mercurius 7.0.3.065FR|Mercurius 7.0.3.066FR|Mercurius 7.0.3.070FR|Mercurius 7.0.3.071FR|Mercurius 7.0.3.072FR|Mercurius 7.0.3.078FR|Mercurius 7.0.3.084FR|Mercurius 7.0.3.085FR|Mercurius 7.0.3.086FR|Mercurius 7.0.3.087FR|Mercurius 7.0.3.100FR|Mercurius 7.0.3.101FR|Mercurius 7.0.3.102FR|Mercurius 7.0.3.103FR|Mercurius 7.0.3.117FR|Mercurius 7.0.3.118FR|Mercurius 7.0.3.124FR|Mercurius 7.0.3.125FR|Mercurius 7.0.3.128FR|Mercurius 7.0.3.130FR|Mercurius 7.0.3.145FR|Mercurius 7.0.3.147FR|Mercurius 7.0.3.152DE|Mercurius 7.0.3.153DE|Mercurius 7.0.3.154DE|Mercurius 7.0.3.154FR|Mercurius 7.0.3.155DE|Mercurius 7.0.3.155FR|Mercurius 7.0.3.160DE|Mercurius 7.0.3.160FR|Mercurius 7.0.3.160NL|Mercurius 7.0.3.161DE|Mercurius 7.0.3.161FR|Mercurius 7.0.3.161NL"
Global Const $regression_variables_5 = "Mercurius 7.0.3.162DE|Mercurius 7.0.3.162FR|Mercurius 7.0.3.162NL|Mercurius 7.0.3.163DE|Mercurius 7.0.3.163FR|Mercurius 7.0.3.163NL|Mercurius 7.0.3.164DE|Mercurius 7.0.3.164FR|Mercurius 7.0.3.164NL|Mercurius 7.0.3.165DE|Mercurius 7.0.3.165FR|Mercurius 7.0.3.165NL|Mercurius 7.0.3.166DE|Mercurius 7.0.3.166FR|Mercurius 7.0.3.166NL|Mercurius 7.0.3.167DE|Mercurius 7.0.3.167FR|Mercurius 7.0.3.167NL|Mercurius 7.0.3.168DE|Mercurius 7.0.3.168FR|Mercurius 7.0.3.168NL|Mercurius 7.0.3.169DE|Mercurius 7.0.3.169FR|Mercurius 7.0.3.169NL|Mercurius 7.0.3.170DE|Mercurius 7.0.3.170FR|Mercurius 7.0.3.170NL|Mercurius 7.0.3.171DE|Mercurius 7.0.3.171FR|Mercurius 7.0.3.171NL|Mercurius 7.0.3.172DE|Mercurius 7.0.3.172FR|Mercurius 7.0.3.172NL|Mercurius 7.0.3.173DE|Mercurius 7.0.3.173FR|Mercurius 7.0.3.173NL|Mercurius 7.0.3.174DE|Mercurius 7.0.3.174FR|Mercurius 7.0.3.174NL|Mercurius 7.0.3.175DE|Mercurius 7.0.3.175FR|Mercurius 7.0.3.175NL|Mercurius 7.0.3.176DE|Mercurius 7.0.3.176FR|Mercurius 7.0.3.176NL|Mercurius 7.0.3.177DE|Mercurius 7.0.3.177FR|Mercurius 7.0.3.177NL|Mercurius 7.0.3.178DE|Mercurius 7.0.3.178FR|Mercurius 7.0.3.178NL|Mercurius 7.0.3.179DE|Mercurius 7.0.3.179DEB|Mercurius 7.0.3.179FR|Mercurius 7.0.3.179NL|Mercurius 7.0.3.180DE|Mercurius 7.0.3.180FR|Mercurius 7.0.3.180NL|Mercurius 7.0.3.183DE|Mercurius 7.0.3.183FR|Mercurius 7.0.3.183NL|Mercurius 7.0.3.188DE|Mercurius 7.0.3.188FR|Mercurius 7.0.3.188NL|Mercurius 7.0.3.189DE|Mercurius 7.0.3.189FR|Mercurius 7.0.3.189NL|Mercurius 7.0.3.190DE|Mercurius 7.0.3.190FR|Mercurius 7.0.3.190NL|Mercurius 7.0.3.191DE|Mercurius 7.0.3.191FR|Mercurius 7.0.3.191NL|Mercurius 7.0.3.192DE|Mercurius 7.0.3.192FR|Mercurius 7.0.3.192NL|Mercurius 7.0.3.193DE|Mercurius 7.0.3.193FR|Mercurius 7.0.3.193NL|Mercurius 7.0.3.194DE|Mercurius 7.0.3.194FR|Mercurius 7.0.3.194NL|Mercurius 7.0.3.195DE|Mercurius 7.0.3.195FR|Mercurius 7.0.3.195NL|Mercurius 7.0.3.196DE|Mercurius 7.0.3.196FR|Mercurius 7.0.3.196NL|Mercurius 7.0.3.197DE|Mercurius 7.0.3.197FR|Mercurius 7.0.3.197NL|Mercurius 7.0.3.198DE|Mercurius 7.0.3.198FR|Mercurius 7.0.3.198NL|Mercurius 7.0.3.199DE|Mercurius 7.0.3.199FR|Mercurius 7.0.3.199NL|Mercurius 7.0.3.200DE|Mercurius 7.0.3.200FR|Mercurius 7.0.3.200NL|Mercurius 7.0.3.201DE|Mercurius 7.0.3.201FR|Mercurius 7.0.3.201NL|Mercurius 7.0.3.202DE|Mercurius 7.0.3.202FR|Mercurius 7.0.3.202NL|Mercurius 7.0.3.203DE|Mercurius 7.0.3.203FR|Mercurius 7.0.3.203NL|Mercurius 7.0.3.204DE|Mercurius 7.0.3.204FR|Mercurius 7.0.3.204NL|Mercurius 7.0.3.205DE|Mercurius 7.0.3.205FR|Mercurius 7.0.3.205NL|Mercurius 7.0.3.206DE|Mercurius 7.0.3.207DE|Mercurius 7.0.3.208DE|Mercurius 7.0.3.209DE|Mercurius 7.0.3.211DE|Mercurius 7.3.023.0FR|Mercurius 7.3.035.0FR|Mercurius 703.027FR|Mercurius FRA x439|Mercurius FRA x439b|Mercurius FRA x439c|Mercury L10N Dry Run x001_x274PDE|Mercury L10N Dry Run x291PDE|Mercury L10N Dry Run x319PDE|Mercury L10N Dry Run x349PDE|Mercury x003|Mercury x004|Mercury x005|Mercury x006|Mercury x007|Mercury x008|Mercury x009|Mercury x010|Mercury x011|Mercury x012|Mercury x013|Mercury x014|Mercury x015|Mercury x016|Mercury x017|Mercury x018|Mercury x019|Mercury x020|Mercury x021|Mercury x022|Mercury x023|Mercury x024|Mercury x025|Mercury x026|Mercury x027|Mercury x028|Mercury x029|Mercury x030|Mercury x031|Mercury x032|Mercury x033|Mercury x034|Mercury x035|Mercury x036|Mercury x037|Mercury x038|Mercury x039|Mercury x040|Mercury x041|Mercury x042|Mercury x043|Mercury x044|Mercury x045|Mercury x046|Mercury x047|Mercury x048|Mercury x049|Mercury x050|Mercury x051|Mercury x052|Mercury x053|Mercury x053a|Mercury x053b|Mercury x053c|Mercury x053d|Mercury x053e|Mercury x053f|Mercury x053g|Mercury x053h|Mercury x053i|Mercury x053j|Mercury x054|Mercury x055|Mercury x056|Mercury x057|Mercury x058|Mercury x058a|Mercury x059|Mercury x060|Mercury x061|Mercury x062|Mercury x063|Mercury x064|Mercury x065|Mercury x066|Mercury x067|Mercury x068|Mercury x069|Mercury x070|Mercury x071|Mercury x072|Mercury x073|Mercury x074|Mercury x075|Mercury x076|Mercury x077|Mercury x078|Mercury x079|Mercury x080"
Global Const $regression_variables_6 = "Mercury x081|Mercury x082|Mercury x083|Mercury x084|Mercury x085|Mercury x086|Mercury x087|Mercury x088|Mercury x089|Mercury x090|Mercury x091|Mercury x092|Mercury x093|Mercury x094|Mercury x095|Mercury x096|Mercury x097|Mercury x098|Mercury x099|Mercury x100|Mercury x101|Mercury x102|Mercury x103|Mercury x104|Mercury x105|Mercury x106|Mercury x107|Mercury x108|Mercury x109|Mercury x110|Mercury x111|Mercury x112|Mercury x113|Mercury x114|Mercury x115|Mercury x116|Mercury x117|Mercury x118|Mercury x119|Mercury x120|Mercury x121|Mercury x122|Mercury x123|Mercury x124|Mercury x125|Mercury x126|Mercury x127|Mercury x128|Mercury x129|Mercury x130|Mercury x131|Mercury x132|Mercury x133|Mercury x134|Mercury x135|Mercury x136|Mercury x137|Mercury x138|Mercury x139|Mercury x140|Mercury x141|Mercury x142|Mercury x143|Mercury x144|Mercury x145|Mercury x146|Mercury x147|Mercury x148|Mercury x149|Mercury x150|Mercury x151|Mercury x152|Mercury x153|Mercury x154|Mercury x155|Mercury x156|Mercury x156a|Mercury x156b|Mercury x156c|Mercury x156d|Mercury x156e|Mercury x156f|Mercury x156g|Mercury x156h|Mercury x157|Mercury x158|Mercury x159|Mercury x160|Mercury x161|Mercury x162|Mercury x163|Mercury x164|Mercury x165|Mercury x166|Mercury x167|Mercury x168|Mercury x169|Mercury x170|Mercury x171|Mercury x172|Mercury x173|Mercury x174|Mercury x175|Mercury x176|Mercury x177|Mercury x178|Mercury x179|Mercury x180|Mercury x181|Mercury x182|Mercury x183|Mercury x184|Mercury x185|Mercury x186|Mercury x187|Mercury x188|Mercury x189|Mercury x190|Mercury x191|Mercury x192|Mercury x193|Mercury x194|Mercury x195|Mercury x196|Mercury x197|Mercury x198|Mercury x199|Mercury x200|Mercury x201|Mercury x202|Mercury x203|Mercury x204|Mercury x205|Mercury x206|Mercury x207|Mercury x208|Mercury x209|Mercury x210|Mercury x211|Mercury x212|Mercury x213|Mercury x214|Mercury x215|Mercury x216|Mercury x217|Mercury x218|Mercury x219|Mercury x220|Mercury x221|Mercury x222|Mercury x223|Mercury x224|Mercury x225|Mercury x226|Mercury x227|Mercury x228|Mercury x229|Mercury x230|Mercury x231|Mercury x232|Mercury x233|Mercury x234|Mercury x235|Mercury x236|Mercury x237|Mercury x238|Mercury x239|Mercury x240|Mercury x241|Mercury x242|Mercury x243|Mercury x244|Mercury x245|Mercury x246|Mercury x247|Mercury x248|Mercury x249|Mercury x250|Mercury x251|Mercury x252|Mercury x254|Mercury x255|Mercury x256|Mercury x257|Mercury x258|Mercury x259|Mercury x260|Mercury x261|Mercury x262|Mercury x263|Mercury x264|Mercury x265|Mercury x266|Mercury x267|Mercury x268|Mercury x269|Mercury x270|Mercury x271|Mercury x272|Mercury x273|Mercury x274|Mercury x275|Mercury x276|Mercury x277|Mercury x278|Mercury x279|Mercury x280|Mercury x281|Mercury x282|Mercury x283|Mercury x284|Mercury x285|Mercury x286|Mercury x287|Mercury x288|Mercury x289|Mercury x290|Mercury x291|Mercury x292|Mercury x293|Mercury x294|Mercury x295|Mercury x296|Mercury x297|Mercury x298|Mercury x299|Mercury x300|Mercury x301|Mercury x302|Mercury x303|Mercury x304|Mercury x305|Mercury x306|Mercury x307|Mercury x308|Mercury x309|Mercury x310|Mercury x311|Mercury x312|Mercury x313|Mercury x314|Mercury x315|Mercury x316|Mercury x317|Mercury x318|Mercury x319|Mercury x320|Mercury x321|Mercury x322|Mercury x323|Mercury x324|Mercury x325|Mercury x326|Mercury x327|Mercury x328|Mercury x329|Mercury x330|Mercury x331|Mercury x332|Mercury x333|Mercury x334|Mercury x335|Mercury x336|Mercury x337|Mercury x338|Mercury x339|Mercury x340|Mercury x341|Mercury x342|Mercury x343|Mercury x344|Mercury x345|Mercury x346|Mercury x347|Mercury x348|Mercury x349|Mercury x350|Mercury x351|Mercury x352|Mercury x353|Mercury x354|Mercury x355|Mercury x356|Mercury x357|Mercury x358|Mercury x359|Mercury x360|Mercury x361|Mercury x362|Mercury x363|Mercury x364|Mercury x365|Mercury x366|Mercury x367|Mercury x368|Mercury x369|Mercury x370|Mercury x371|Mercury x372|Mercury x373|Mercury x374|Mercury x375|Mercury x376|Mercury x377|Mercury x378|Mercury x379|Mercury x380|Mercury x381|Mercury x382|Mercury x383|Mercury x384"
Global Const $regression_variables_7 = "Mercury x385|Mercury x386|Mercury x387|Mercury x388|Mercury x389|Mercury x390|Mercury x391|Mercury x392|Mercury x393|Mercury x394|Mercury x395|Mercury x396|Mercury x397|Mercury x398|Mercury x399|Mini-Me Build 200|Mini-Me Build 201|Mini-Me Build 202|Mini-Me Build 203|Mini-Me Build 204|Mini-Me Build 205|Mini-Me Build 207|Mini-Me Build 208|Mini-Me Build 209|Monarch-phase1|Newport|OEM x501|OEM x502|OEM x502A|OEM x502B|OEM x502C|OEM x502D|OEM x502E|OEM x502F|OEM x502G|OEM x503|OEM x503B|OEM x503C|OEM x503D|Peachtree OEM 498|Peachtree x502 Q|Peachtree x502 R|Peachtree x502 S|Peachtree x502 T|Peachtree x502 U|Peru x001|Peru x002|Peru x003|Peru x004|Peru x005|Peru x006|Production|Punk - 800|Punk - 801|Punk - 802|Punk - 803|Punk - 804|Punk - 805|Punk - 806|Punk - 807|Punk - 808|Punk - 809|Punk - 810|Punk - 811|Punk - 812|Punk - 813|Punk - 814|Punk - 815|Punk - 816|Punk - 817|Punk - 818|Punk - 819|Punk - 820|Punk - 821|Punk - 822|Punk - 823|Punk - 824|Punk - 825|Punk - 826|Punk - 827|Punk - 828|Punk - 829|Punk - 830|Punk - 831|Punk - 832|Punk - 833|Punk - 834|Punk - 835|Punk - 836|Punk - 837|Punk - 838|Punk - 839|Punk - 840|Punk - 841|Punk - 842|Punk - 843|Punk - 844|Punk - 845|Punk - 846|Punk - 847|Punk - 848|Punk - 849|Punk - 850|Punk - 851|Punk - 852|Punk - 853|Punk - 854|Punk - 855|Punk - 856|Punk - 857|Punk - 858|Punk - 859|Punk - 860|Punk - 861|Punk - 862|Punk - 863|Punk - 864|Punk - 865|Punk - 866|Punk - 867|Punk - 868|Punk - 869|Punk - 870|Punk - 871|Punk - 872|Punk - 873|Punk - 874|Punk - 875|Punk - 876|Punk - 877|Punk - 878|Punk - 879|Punk - 880|Punk - 881|Punk - 882|Punk - 883|Punk - 884|Punk - 885|Punk - 886|Punk - 887|Punk - 888|Punk - 889|Punk - 890|Punk - 891|Punk - 892|Punk - 893|Punk - 894|Punk - 895|Punk - 896|Punk - 897|Punk - 898|Punk - 899|Punk - 900|Punk - 901|Punk - 902|Punk - 903|Punk - 904|Punk - 905|Punk - 906|Punk - 907|Punk - 908|Punk - 909|Punk - 910|Punk - 911|Punk - 912|Punk - 913|Punk - 914|Punk - 915|Punk - 916|Punk - 917|Punk - 918|Punk - 919|Punk - 920|Punk - 921|Punk - 922|Punk - 923|Punk - 924|Punk - 925|Punk - 926|Punk - 927|Punk - 928|Punk - 929|Punk - 930|Punk - 931|Punk - 932|Punk - 933|Punk - 934|Punk - 935|Punk - 936|Punk - 937|Punk - 938|Punk - 939|Punk - 940|Punk - 941|Punk - 942|Punk - 943|Punk - 944|Punk - 945|Punk - 946|Punk - 947|Punk - 948|Punk - 949|Punk - 950|Punk - 951|Punk - 952|Punk - 953|Punk - 954|Punk - 955|Punk - 956|Punk - 957|Punk - 958|Punk - 959|Punk - 960|Punk - 961|Punk - 962|Punk - 963|Punk - 964|Punk - 965|Punk - 966|Punk - 967|Punk - 968|Punk - 969|Punk - 970|Punk - 971|Punk - 972|Punk - 973|Punk - 974|Punk - 975|Punk - 976|Punk - 977|Punk - 978|Punk - 979|Punk - 980|QB Driver x1|QB Driver x10|QB Driver x11|QB Driver x12|QB Driver x13|QB Driver x14|QB Driver x15|QB Driver x15|QB Driver x16|QB Driver x17|QB Driver x18|QB Driver x19|QB Driver x2|QB Driver x20|QB Driver x21|QB Driver x22|QB Driver x3|QB Driver x4|QB Driver x5|QB Driver x6|QB Driver x7|QB Driver x8|QB Driver x9|R2D2 x10|R2D2 x11|R2D2 x12|R2D2 x13|R2D2 x218|R2D2 x222|R2D2 x223|R2D2 x227|R2D2 x228|R2D2 x238|R2D2 x239|R2D2 x249|R2D2 x250|R2D2 x255|R2D2 x266|R2D2 x267|R2D2 x270|R2D2 x274|R2D2 x283|R2D2 x284|R2D2 x285|R2D2 x289|R2D2 x291|R2D2 x292|R2D2 x293|R2D2 x294|R2D2 x296|R2D2 x297|R2D2 x298|R2D2 x299|R2D2 x300|R2D2 x301|R2D2 x302|R2D2 x303|R2D2 x306|R2D2 x307|R2D2 x308|R2D2 x309|R2D2 x310|R2D2 x311|R2D2 x320|R2D2 x321|R2D2 x322|R2D2 x323|R2D2 x324|R2D2 x325|R2D2 x326|R2D2 x327|R2D2 x328|R2D2 x329|R2D2 x330|R2D2 x331|R2D2 x332|R2D2 x333|R2D2 x334|R2D2 x335|R2D2 x336|R2D2 x337|R2D2 x338|R2D2 x339|R2D2 x340|R2D2 x341|R2D2 x342|R2D2 x343|R2D2 x344|R2D2 x345|R2D2 x346|R2D2 x347|R2D2 x348|R2D2 x349|R2D2 x350|R2D2 x351|R2D2 x352|R2D2 x353|R2D2 x354|R2D2 x355|R2D2 x356|R2D2 x357|R2D2 x358|R2D2 x359|R2D2 x360|R2D2 x361|R2D2 x362|R2D2 x363|R2D2 x364|R2D2 x365|R2D2 x366|R2D2 x367|R2D2 x368|R2D2 x369|R2D2 x370|R2D2 x371|R2D2 x372|R2D2 x373|R2D2 x374|R2D2 x375|R2D2 x376|R2D2 x377|R2D2 x378|R2D2 x379|R2D2 x380|R2D2 x381|R2D2 x382|R2D2 x383|R2D2 x384|R2D2 x385|R2D2 x386"
Global Const $regression_variables_8 = "R2D2 x387|R2D2 x388|R2D2 x389|R2D2 x390|R2D2 x391|R2D2 x391a|R2D2 x392|R2D2 x393|R2D2 x394|R2D2 x395|R2D2 x396|R2D2 x397|R2D2 x398|R2D2 x399|Redstone x439|Redstone x449|Redstone x450|Redstone x451|Redstone x454|Redstone x460|Redstone x461|Redstone x463|Redstone x464|Redstone x465|Redstone x466|Redstone x468|Redstone x472|Redstone x475|Redstone x478|Redstone x479|Redstone x480|Redstone x482|Redstone x483|Redstone x484|Redstone x485|Redstone x491|Redstone x492|Redstone x496|Redstone x500|Redstone x501|Redstone x502|Redstone x503|Redstone x505|Redstone x506|Redstone x510|Redstone x511|Redstone x512|Redstone x513|Redstone x516|Redstone x517|Redstone x518|Redstone x526|Redstone x528|Redstone x530|Redstone x532|Redstone x533|Redstone x534|Redstone x536|Redstone x537|Redstone x543|Redstone x544|Redstone x545|Redstone x546|Redstone x547|Redstone x548|Redstone x550|Redstone x551|Redstone x554|Redstone x555|Redstone x556|Redstone x557|Redstone x558|Redstone x559|Redstone x560|Redstone x565|Redstone x566|Redstone x567|Redstone x568|Redstone x569|Redstone x570|Redstone x575|Redstone x580|Redstone x586|Redstone x590|Redstone x591|Redstone x592|Redstone x596|Redstone x597|Redstone x598|Redstone x600|Redstone x601|Redstone x602|Redstone x607|Redstone x608|Redstone x609|Redstone x610|Redstone x614|Redstone x615|Redstone x616|Redstone x617|Redstone x618|Redstone x619|Redstone x620|Redstone x622|Redstone x623|Redstone x624|Redstone x625|Redstone x626|Redstone x627|Redstone x628|Redstone x629|Redstone x630|Redstone x632|Redstone x633|Redstone x634|Redstone x635|Redstone x636|Redstone x637|Redstone x639|Redstone x640|Redstone x641|Redstone x642|Redstone x643|Redstone x644|Redstone x645|Redstone x646|Redstone x647|Redstone x648|Redstone x650|Redstone x651|Redstone x652|Redstone x653|Redstone x654|Redstone x655|Redstone x656|Redstone x657|Redstone x658|Redstone x659|Redstone x660|Redstone x661|Redstone x662|Redstone x663|Redstone x664|Redstone x665|Redstone x666|Redstone x667|Redstone x668|Redstone x669|Redstone x670|Redstone x671|Redstone x672|Redstone x673|Redstone x674|Redstone x675|Redstone x676|Redstone x677|Redstone x678|Redstone x679|Redstone x680|Redstone x681|Redstone x682|Redstone x683|Redstone x684|Redstone x685|Redstone x686|Redstone x687|Redstone x688|Redstone x689|Redstone x690|Redstone x691|Redstone x692|Redstone x693|Redstone x694|Redstone x695|Redstone x696|Redstone x697|Redstone x698|Redstone x699|Redstone x700|Redstone x701|Redstone x702|Redstone x703|Redstone x704|Redstone x705|Redstone x706|Redstone x707|Redstone x708|Redstone x709|Redstone x710|Redstone x711|Redstone x712|Redstone x713|Redstone x714|Redstone x715|Redstone x716|Redstone x717|Redstone x718|Redstone x719|Redstone x720|Redstone x721|Redstone x722|Redstone x723|Redstone x724|Redstone x725|Sage France x423C|Sage France x423D|Sage France x423E|Sage France x423F|Sage France x423G|Sage OEM Ciel x001|Sage OEM Ciel x002|Sage OEM Ciel x003|Sage OEM Ciel x004|Sage OEM Ciel x005|Sage OEM Ciel x006|Sage OEM Ciel x007|Sage OEM Ciel x008|Sage OEM Ciel x009|Sage OEM Ciel x010|Tattoo|Testweb1|TimeTracker|Titanic3|Webster x500|Webster x501|Webster x502|Webster x503|Webster x504|Webster x505|Webster x506|Webster x507|Webster x508|Webster x509|Webster x510|Webster x511|Webster x512|Webster x513|Webster x514|Webster x515|Webster x516|Webster x517|Webster x518|Webster x519|Wilma 01-04|Wilma 01-17|Wilma 01-18|Wilma 01-19|Wilma 01-20|Wilma 01-21|Wilma 02-02|Wilma 02-04|Wilma 02-07|Wilma 02-08|Wilma 02-10|Wilma 02-11|Wilma 02-17|Wilma 02-21|Wilma 02-22|Wilma 02-25|Wilma 03-02|Wilma 03-04|Wilma 03-04-2|Wilma 03-08|Wilma 11-17|Wilma 12-02|Wilma 12-08|Wilma 12-10|Wilma 12-14|Wilma 12-30|Yoda x143|Yoda x144|Yoda x145|Yoda x146|Yoda x147|Yoda x148|Yoda x149|Yoda x150|Yoda x218|Yoda x222|Yoda x223|Yoda x227|Yoda x236|Yoda x238|Yoda x239|Yoda x242|Yoda x249|Yoda x250|Yoda x255|Yoda x256|Yoda x257|Yoda x266|Yoda x270|Yoda x271|Yoda x274|Yoda x275|Yoda x282|Yoda x283|Yoda x286|Yoda x289|Yoda x292|Yoda x293|Yoda x294|Yoda x295|Yoda x296|Yoda x297"
Global Const $regression_variables_9 = "Yoda x298|Yoda x299|Yoda x300|Yoda x301|Yoda x302|Yoda x303|Yoda x306|Yoda x307|Yoda x308|Yoda x309|Yoda x310|Yoda x311|Yoda x4|Yoda x5|Yoda x50|Yoda x51|Yoda x52|Yoda x53|Yoda x54|Yoda x55|Yoda x56|Yoda x57|Yoda x58|Yoda x59|Yoda x6|Yoda x60|Yoda x61|Yoda x62|Yoda x63|Yoda x64|Yoda x65|Yoda x66|Yoda x67|Yoda x68|Yoda x69|Yoda x7|Yoda x70|Yoda x71|Yoda x72|Yoda x73|Yoda x74|Yoda x75|Yoda x76|Yoda x77|Yoda x78|Yoda x79|Yoda x8|Yoda x80|Yoda x81|Yoda x82|Yoda x83|Yoda x84|Yoda x85|Yoda x86|Yoda x87|Yoda x88|Yoda x89|Yoda x9|Yoda x90"
Global Const $language_variables     = "Brazilian Portuguese|Dutch|English|French|German|International French|Latin American Spanish|Spanish|Pseudo-Translation"
Global Const $product_variables      = "ACT! for Windows|ACT! for Web|ACT! for Palm|Accounting Framework|ACT! - Localization"
Global Const $milestone_variables    = "ET|ET2|RC|N/A"

#endregion --- Support Client Field Control Names & Control Variables --- 


Func SelfDelete()
;---------------------------
;Delete current running file
;From user 'MHz'
;---------------------------
	Local $cmdfile
	FileDelete(@TempDir & "\scratch.cmd")
	$cmdfile = ':loop' & @CRLF _
			& 'del "' & @ScriptFullPath & '"' & @CRLF _
			& 'if exist "' & @ScriptFullPath & '" goto loop' & @CRLF _
			& 'del ' & @TempDir & '\scratch.cmd'
	FileWrite(@TempDir & "\scratch.cmd", $cmdfile)
	Run(@TempDir & "\scratch.cmd", @TempDir, @SW_HIDE)
EndFunc


Func _ImageGetSize($sFile)
;===============================================================================
; Description:      Return JPEG, TIFF, BMP, PNG and GIF image size.
; Parameter(s):     File name
; Requirement(s):   None special
; Return Value(s):  On Success - array with width and height
;                   On Failure empty string and sets @ERROR:
;                       1 - Not valid image or info not found
; Author(s):        YDY (Lazycat)
; Version:          1.1.00
; Date:             15.03.2005
;
;===============================================================================
    Local $sHeader = _FileReadAtOffsetHEX($sFile, 1, 24); Get header bytes
    Local $asIdent = StringSplit( "FFD8 424D 89504E470D0A1A 4749463839 4749463837 4949 4D4D", " " )
    Local $anSize = ""
    For $i = 1 To $asIdent[0]
        If StringInStr($sHeader, $asIdent[$i]) = 1 Then
            Select
                Case $i = 1; JPEG
                    $anSize = _ImageGetSizeJPG($sFile)
                    Exitloop
                Case $i = 2; BMP
                    $anSize = _ImageGetSizeSimple($sHeader, 19, 23, 0)
                    Exitloop
                Case $i = 3; PNG
                    $anSize = _ImageGetSizeSimple($sHeader, 19, 23, 1)
                    Exitloop
                Case ($i = 4) or ($i = 5); GIF
                    $anSize = _ImageGetSizeSimple($sHeader, 7, 9, 0)
                    Exitloop
                Case $i = 6; TIFF MM
                    $anSize = _ImageGetSizeTIF($sFile, 0)
                    Exitloop
                Case $i = 7; TIFF II
                    $anSize = _ImageGetSizeTIF($sFile, 1)
                    Exitloop
            EndSelect
        Endif
    Next
    If not IsArray ( $anSize ) Then SetError(1)
    Return( $anSize )
EndFunc

Func _ImageGetSizeSimple($sHeader, $nXoff, $nYoff, $nByteOrder)
;===============================================================================
; Description:      Get image size at given bytes
; Parameter(s):     File header 
; Return Value(s):  Array with dimension
; Author(s):        YDY (Lazycat)
;===============================================================================
    Local $anSize[2]
    $anSize[0] = _Dec(StringMid($sHeader, $nXoff*2-1, 4), $nByteOrder)
    $anSize[1] = _Dec(StringMid($sHeader, $nYoff*2-1, 4), $nByteOrder)
    Return ($anSize)
EndFunc


Func _ImageGetSizeJPG($sFile)
;===============================================================================
; Description:      Get JPG image size (may be used standalone with checking)
; Parameter(s):     File name
; Return Value(s):  On Success - array with dimension
; Author(s):        YDY (Lazycat)
;===============================================================================
    Local $anSize[2], $sData, $sSeg, $nFileSize, $nPos = 3
    $nFileSize = FileGetSize($sFile)
    While $nPos < $nFileSize
        $sData = _FileReadAtOffsetHEX ($sFile, $nPos, 4)
        If StringLeft($sData, 2) = "FF" then; Valid segment start
            If StringInStr("C0 C2 CA C1 C3 C5 C6 C7 C9 CB CD CE CF", StringMid($sData, 3, 2)) Then; Segment with size data
               $sSeg = _FileReadAtOffsetHEX ($sFile, $nPos + 5, 4)
               $anSize[1] = Dec(StringLeft($sSeg, 4))
               $anSize[0] = Dec(StringRight($sSeg, 4))
               Return($anSize)
            Else
               $nPos= $nPos + Dec(StringRight($sData, 4)) + 2
            Endif
        Else
            ExitLoop
        Endif
    Wend
    Return("")
EndFunc


Func _ImageGetSizeTIF($sFile, $nByteOrder)
;===============================================================================
;
; Description:      Get TIFF image size (may be used standalone with checking)
; Parameter(s):     File name
; Return Value(s):  On Success - array with dimension
; Author(s):        YDY (Lazycat)
;===============================================================================
    Local $anSize[2], $pos = 3
    $nTagsOffset = _Dec(_FileReadAtOffsetHEX($sFile, 5, 4), $nByteOrder) + 1
    $nFieldCount = _Dec(_FileReadAtOffsetHEX($sFile, $nTagsOffset, 2), $nByteOrder)
    For $i = 0 To $nFieldCount - 1
        $sField = _FileReadAtOffsetHEX($sFile, $nTagsOffset + 2 + 12 * $i, 12)
        $sTag = StringLeft($sField, 4)
        If $nByteOrder Then $sTag = StringRight($sTag, 2) & StringLeft($sTag, 2)
        Select
            Case $sTag = "0001"
                $anSize[0] = _Dec(StringRight($sField, 8), $nByteOrder)
            Case $sTag = "0101"
                $anSize[1] = _Dec(StringRight($sField, 8), $nByteOrder)
        EndSelect
    Next
    If ($anSize[0] = 0) or ($anSize[1] = 0) Then Return("")
    Return($anSize)
Endfunc


Func _FileReadAtOffsetHEX ($sFile, $nOffset, $nBytes)
;===============================================================================
;
; Description:      Basic function that read binary data into HEX-string
; Parameter(s):     File name, Start offset, Number bytes to read
; Return Value(s):  Hex string
; Author(s):        YDY (Lazycat)
;===============================================================================
    Local $hFile = FileOpen($sFile, 0)
    Local $sTempStr = ""
    FileRead($hFile, $nOffset - 1)
    For $i = $nOffset To $nOffset + $nBytes - 1
        $sTempStr = $sTempStr & Hex(Asc(FileRead($hFile, 1)), 2)
    Next
    FileClose($hFile)
    Return ($sTempStr)
Endfunc


Func _Dec($sHexStr, $nByteOrder)
;===============================================================================
; Description:      Basic function, similar Dec, but take in account byte order
; Parameter(s):     Hex string, Byte order
; Return Value(s):  Decimal value
; Author(s):        YDY (Lazycat)
;===============================================================================
	If $nByteOrder Then Return(Dec($sHexStr))
    Local $sTempStr = ""
    While StringLen($sHexStr) > 0
        $sTempStr = $sTempStr & StringRight($sHexStr, 2)
        $sHexStr = StringTrimRight($sHexStr, 2)
    WEnd
    Return (Dec($sTempStr))
EndFunc


Func EnableAV_fcn()
;-----------------------------
;Enable the Mcafee AV services
;-----------------------------

    RunWait("CMD /C Net Start McShield" )
   
    RunWait("CMD /C Net Start McTaskManager" )

    RunWait("CMD /C Net Start McAfeeFramework" )
    
EndFunc


Func DisableAV_fcn()
;------------------------------
;Disable the Mcafee AV services
;------------------------------

    RunWait("CMD /C Net Stop McShield" )
    
    RunWait("CMD /C Net Stop McTaskManager" )
    
    RunWait("CMD /C Net Stop McAfeeFramework" )

EndFunc


Func cleanfilename( $name )
;-------------------------------------------------------
;Remove from a text string, invalid file name chatacters
;-------------------------------------------------------
	Local $name
	$name = StringReplace ( $name, "\", "_" )
	$name = StringReplace ( $name, "/", "_" )
	$name = StringReplace ( $name, ":", "_" )
	$name = StringReplace ( $name, "*", "_" )
	$name = StringReplace ( $name, "?", "_" )
	$name = StringReplace ( $name, "<", "_" )
	$name = StringReplace ( $name, ">", "_" )
	$name = StringReplace ( $name, "|", "_" )
Return $name

EndFunc


Func winspecifiedCapture( $window, $path, $add_time_stamp )
;----------------------------------------------------------------------------------------------
;Creates an image of the specified window, the window name and time stamp is the image name, 0 for no time stamp
;----------------------------------------------------------------------------------------------
	Local $window, $add_time_stamp, $extension, $name_timestamped, $image_name, $path, 
	If FileExists( "captdll.dll" ) Then
		$size = WinGetPos( $window, "" )
		If $add_time_stamp = 1 Then
			;Remove the extension
			$extension = StringRight( $window, 4 )
			;Add the time stamp
			$name_timestamped = StringReplace( $window, $extension, " - " &_now() &$extension )
			$image_name = cleanfilename( $name_timestamped )
		Else
			$image_name = cleanfilename( $window )
		EndIf
		;Fist parameter -                                      filename,                        left,           top,              width,            height. Last one - jpeg quality.
		DllCall( "captdll.dll", "int", "CaptureRegion", "str", $path &"\" &$image_name, "int", $size[0]+  1, "int", $size[1] + 1, "int", $size[2] - 2, "int", $size[3] - 2, "int", 85 )
	Else
		MsgBox(262144, "ERROR",  "The captdll.dll was not found." )
	EndIf

EndFunc


Func winCapture( )
;----------------------------------------------------------------------------------------------
;Creates an image of the current active window, the window name and time stamp is the image name
;----------------------------------------------------------------------------------------------
	Local $window, $image_name
	If FileExists( "captdll.dll" ) Then
		$window = WinGetTitle ( "" )
		$size = WinGetPos( $window,"" )
		$image_name = cleanfilename( $window &" " &_Now() &".jpg" )
		DllCall( "captdll.dll", "int", "CaptureRegion", "str", $image_name, "int", $size[0], "int", $size[1], "int", $size[2], "int", $size[3], "int", 85 )
	Else
		MsgBox(262144, "ERROR",  "The captdll.dll was not found." )
	EndIf

EndFunc


Func areaCapture( $left, $top, $width, $height, $image_name )
;-------------------------------------------------------------------------------------------------
;Creates an image of the the entire screen, the active window and time stamp is the image name
;-------------------------------------------------------------------------------------------------
	Local $left, $top, $width, $height, $image_name
	
	If FileExists( "captdll.dll" ) Then
		DllCall( "captdll.dll", "int", "CaptureRegion", "str", $image_name, "int", $left, "int", $top, "int", $width, "int", $height, "int", 85 )
	Else
		MsgBox( 262144, "ERROR",  "The 'captdll.dll' was not found." )
	EndIf

EndFunc


Func screenCapture( )
;-------------------------------------------------------------------------------------------------
;Creates an image of the the entire screen, the active window and time stamp is the image name
;-------------------------------------------------------------------------------------------------
	Local $window, $image_name
	
	If FileExists( "captdll.dll" ) Then
		$window = WinGetTitle ( "" )
		$image_name = cleanfilename( $window &" " &_Now() &".jpg" )
		DllCall( "captdll.dll", "int", "CaptureRegion", "str", $image_name, "int", 0, "int", 0, "int", @DesktopWidth, "int", @DesktopHeight, "int", 85 )
	Else
		MsgBox(262144, "ERROR",  "The captdll.dll was not found." )
	EndIf

EndFunc


Func printer_default()
;--------------------------------
;Get default printer, & return it
;--------------------------------
    $printer_default = RegRead( "HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Windows", "Device" )
    If @Error Then Exit
    ;strip off everything after first comma
    $count = StringInStr ( $printer_default, "," )
    $printer_default = StringLeft ( $printer_default, $count - 1 )
	Return $printer_default
EndFunc


Func printer_set_default( $printer_default_new )
;-------------------------
;Set a new default printer
;-------------------------
	Local $printer_default_value, $count, $printer_default_new, $printer_default_string, $er
	;Read value data
	$printer_default_value = RegRead( "HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\PrinterPorts", $printer_default_new )
	
	;Strip off the last two sets of numbers
	$count = StringInStr ( $printer_default_value, ",", 0, 2 )
	$printer_default_string = StringLeft ( $printer_default_value, $count - 1 )
	$printer_default_string = $printer_default_new &","&$printer_default_string
	
	;String needed for default printer: Microsoft Office Document Image Writer,winspool,Ne01:
	$er = RegWrite( "HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Windows", "Device", "REG_SZ", $printer_default_string )
	IF $er = 0 Then 
		MsgBox(262160,"Error","Unable to set new default printer.")
		Return
	EndIf
EndFunc


Func printer_all()
	;------------------------------------------------------------------------------
	;Show all printers installed on current pc, returned in a list seperated by '|'
	;------------------------------------------------------------------------------
    Local $cnt = 1
    Local $printers_list = ""
    Local $printer
    
    While 4
		;increment count and store # of printers found
		$printer = RegEnumVal( "HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\PrinterPorts", $cnt )
		If @Error Then 
   			ExitLoop
   		Else
			If $cnt = 1 Then
				$printers_list = $printer
			Else
				$printers_list = $printers_list &"|" &$printer
			EndIf
			$cnt = $cnt + 1
   		EndIf
		
   	WEnd

   	Return $printers_list
EndFunc
   

Func network( $path )
;-------------------------------------------------------------------------------------
;Tests network connectivity to the specified path. Returns 1 if sucessfull, 0 if fails **LATER ADD PROMPT IF CONNECTION FAILS***
;-------------------------------------------------------------------------------------
	Local $s, $path
	$s = RunWait(@ComSpec & " /c " & "dir "& $path ,"", @SW_HIDE )
	#cs
	If $s = 1 Then
		;Show the network connection prompt
		
		
		
		;Then try:
		RunAsSet ( ["user", "domain", "password" [, options]] )
		
		;Reset permissions
		RunAsSet()
	EndIf
	#ce
	Select 
		Case $s = 0
			$s = 1
		Case $s = 1
			$s = 0
	EndSelect
	
	Return $s 	
EndFunc


Func linestrip( $str )
;---------------------------------------------------------------------------------------
;Strip or replace the @CRLF in a variable, which will be stored as a single line of text
;---------------------------------------------------------------------------------------
	Local $str, $string
	
    If StringInStr( $str, "**UsedToSeperateLines**" ) Then
        $string = StringReplace( $str, "**UsedToSeperateLines**", @CRLF, 0 )
    Else
        $string = StringReplace( $str, @CRLF, "**UsedToSeperateLines**", 0 )
    EndIF
    
    Return $string 

EndFunc


Func frompath( $file_path, $type )
;-------------------------------------------------------------
;If type = 1 return the directory, if = 0 return the file name
;-------------------------------------------------------------
	Local $type, $name_location, $file_path, $name
	
	Select
		Case $type = 1 ;Return the directory
			;Determine where the file name begins
			$name_location = StringInStr( $file_path, "\", 0, -1 )
			$name = StringLeft( $file_path, $name_location )
		Case $type = 0 ;Return the file name
			;Determine where the file name begins
			$name_location= StringInStr( $file_path, "\", 0, -1 )
			$name = StringMid($file_path, $name_location + 1 ) 
		Case Else
			MsgBox(262160,"Error", "An invalid type was selected." &@CRLF &@CRLF &"Please check the code." )
	EndSelect


	Return $name

EndFunc


#CS Func pathdialog( $ini_path, $parent )
   ;-----------------------------------
   ;GUI to prompt user for build path sections
   ;-----------------------------------
    ;Script Title
    $script_title = "Build Paths"
    
    $ok_style = $BS_DEFPUSHBUTTON
    
    ;disable parent window
    GUISetState ( @SW_DISABLE )
    
    
    GuiCreate( $script_title, 431, 320,(@DesktopWidth-431)/2, (@DesktopHeight-320)/2 , $WS_OVERLAPPEDWINDOW + $WS_VISIBLE + $WS_CLIPSIBLINGS, -1, $parent)
   
    $Label_1 = GuiCtrlCreateLabel("Professional Prefix", 10, 130, 90, 20)
    $Label_2 = GuiCtrlCreateLabel("Professional Suffix", 10, 160, 90, 20)
    $Label_3 = GuiCtrlCreateLabel("Standard Prefix", 10, 210, 90, 20)
    $Label_4 = GuiCtrlCreateLabel("Standard Suffix", 10, 240, 90, 20)
    $Label_5 = GuiCtrlCreateLabel("Example Path:", 10, 40, 370, 25)
    $label_9 = GuiCtrlCreateLabel("'\\logixdata\Mercury Builds\REL_x123_TAG_BRANCH_703\Professional\setup.exe'", 10, 55, 410, 25)
    $Label_6 = GuiCtrlCreateLabel("Please enter the Professional and Standard Build Paths to the setup.exe file (not the CD Browser).", 10, 10, 370, 30)
    $Label_7 = GuiCtrlCreateLabel("The profesional prefix would be: '\\logixdata\Mercury Builds\REL_x'", 10, 75, 380, 25)
    $Label_8 = GuiCtrlCreateLabel("The professional suffix would be: '_TAG_BRANCH_703\Professional\setup.exe'", 10, 95, 380, 25)
    $pro_prefix = GuiCtrlCreateInput("", 110, 130, 300, 20)
    $pro_suffix = GuiCtrlCreateInput("", 110, 160, 300, 20)
    $std_prefix = GuiCtrlCreateInput("", 110, 210, 300, 20)
    $std_suffix = GuiCtrlCreateInput("", 110, 240, 300, 20)
    $ok_button_2 = GuiCtrlCreateButton("OK", 250, 280, 60, 30)
    $cancel_button_2 = GuiCtrlCreateButton("Cancel", 320, 280, 60, 30)
   
    ;set initial focus 
    GUICtrlSetState ( $pro_prefix, $GUI_FOCUS )
            
    GuiSetState()
    While 1
            $msg = GuiGetMsg()
        Select
            Case $msg = $GUI_EVENT_CLOSE
                ExitLoop
            Case $msg = $ok_button_2
            
                ;disable parent window
                ;GUISetState ( @SW_DISABLE, $parent )
        
                    
                ;retrieve data from inputs
                $pro_prefix_data = GUICtrlRead ( $pro_prefix )
                $pro_suffix_data = GUICtrlRead ( $pro_suffix )
                $std_prefix_data = GUICtrlRead ( $std_prefix )
                $std_suffix_data = GUICtrlRead ( $std_suffix )
                
                ;verify both have data
                If $pro_prefix_data = "" OR $pro_suffix_data = "" OR  $std_prefix_data = "" OR $std_suffix_data = ""Then
                    ;if not prompt user to correct
                    MsgBox(262144, "ERROR", "One of the inputs was blank, please verify the path and press ok." )
                Else
                    ;otherwise save to ini file
                    IniWrite( $ini_path, "location", "proprefix", $pro_prefix_data )
                    IniWrite( $ini_path, "location", "prosuffix", $pro_suffix_data ) 
                    IniWrite( $ini_path, "location", "stdprefix", $std_prefix_data )
                    IniWrite( $ini_path, "location", "stdsuffix", $std_suffix_data ) 
                                        
                    ;Get handle of current window
                    $win_handle = WinGetHandle ( $script_title )
                    
                    ;Close child window
                    GUIDelete ( $win_handle )
                    
                    ;Enable parent window
                    GUISetState ( @SW_ENABLE, $parent )
                    ;ExitLoop -required
                    Exitloop
                EndIf
                            
            Case $msg = $cancel_button_2
                Exit
            Case Else
                ;;;
        EndSelect
    WEnd
   
   EndFunc
 #CE


Func actinstallpath()
;---------------------------------------------------
;Return the act install path, read from the registry
;---------------------------------------------------
	Local $path
	
    $path = RegRead( "HKEY_LOCAL_MACHINE\SOFTWARE\ACT\Install", "InstallPath")

    Return $path 
    
EndFunc


Func excel()
;------------------------------------------
;Copy defect info to excel Defects.xls file
;------------------------------------------
	Local $defectiddata, $status_data, $areadata, $subjectdata, $build, $length, $cnt, $char
    ;Copy Info to Excel
    ;get defect data
    $defectiddata = ControlGetText( "Support", "", $defectid )
    $status_data = ControlGetText( "Support", "", $status )
	$areadata = ControlGetText( "Support", "", $area )
	$subjectdata = ControlGetText( "Support", "", $subject )
	
	;Retrieve build
	$build = ControlGetText( "Support", "", $fixedbuild )
	If $build = "" Then
		$build = ControlGetText( "Support", "", $verfound )
		If $build <> "" Then
			;Keep only the build number
			$length = StringLen( $build )
			$cnt = $length
			Do
				$char = StringMid( $build, $cnt, 1 )
				$cnt = $cnt - 1
			Until Not StringIsDigit( $char )
			$cnt = $cnt + 1
			
			$build = StringMid( $build, $cnt + 1, $length - $cnt )
		EndIf
	Else
		;Keep only the build number
		$length = StringLen( $build )
		$cnt = $length
		Do
			$char = StringMid( $build, $cnt, 1 )
			$cnt = $cnt - 1
		Until Not StringIsDigit( $char )
		$cnt = $cnt + 1
		
		$build = StringMid( $build, $cnt + 1, $length - $cnt )
	EndIf
	
    ;Focus to Excel
    window( "Microsoft Excel - Defects","" )
    Sleep( 200 )
   
    ;Enter in current time for tracking purposes
    Send( "{SCROLLLOCK OFF}{HOME}"&@Hour&":"&@Min&"{Tab}" )
   
    ;Set the Defect Number
    Send( $defectiddata&"{TAB}" )
    Sleep( 200 )
   
    ;Enter Defect staus and the build number
    
    Send( $status_data&"{TAB}" )
    Sleep( 100 )
    Send( "{TAB}" )
    Sleep( 100 )
    Send( "{TAB}" )
    Sleep( 100 )
    Send( "{TAB}" ) 
    Sleep( 100 )
    Send( "x" &$build &"{TAB}" )
    Sleep( 100 )
    
    ;Set Area 
    Send( $areadata, 1 )
	Send( "{TAB}", 0 )
    Sleep( 150 )
    
    ;Set Subject
    
    Send( $subjectdata, 1 )
    Sleep( 150 )
    
    ;Put focus under last defect number
    Send( "{ENTER}{HOME}", 0 )
;~     Sleep( 100 )
;~     Send(  )
    Sleep( 100 )
    
    ;SAVE THE Excel DEFECT FILE
    Send( "{CtrlDown}s{CtrlUp}" )
    Sleep( 200 )
    
    window( "Support", "" )
EndFunc


Func testpopacct()
;-------------------------------------------
;Test Pop E-mail acct and check for errrors.
;-------------------------------------------
    Local $q
    ;Test Account settings
    ;Press Test Connection button
    MouseClick( "left", 101, 151, 2 )

    ;Focus to Test Account Settings Window
    window( "Test Account Settings", "" )
    Do
        $q = WinGetText( "Test Account Settings", "" )
        $r = StringSplit( $q, @LF)
        Sleep(200)
    Until $r[16] <> "Attempting to connect..."


    Select
        Case $r[16] = "You have connected successfully."
        
            ;close test acct settings dialog
            window( "Test Account Settings", "" )
            MouseClick( "left", 417, 73, 1, 2 )
            
            ;close Internet Mail setup window
            window("Internet Mail", "" )
            MouseClick( "left", 341, 344, 1, 2 )
            
            ;Announce completion
            msgbox( 262144, "Script Complete", "E-mail acct. info has been entered." )
            Exit
        Case $r[16] = "The test was not successful. Click the Errors tab for details."
            MsgBox(262192, "E-mail", "Test E-mail account failed, please check e-mail settings." )

        Case Else 
            MsgBox(262192, "ERROR", "Unknown E-mail Test Results!!" )
    EndSelect

EndFunc


Func verifypdf995( $correct )
;------------------------------------------------
;Verify PDF995 prints to correct network location
;------------------------------------------------
	Local $saveto
	 
	;Correct location
	;$correct = "\\822jtaylordell\Printing Test"
	
	
	;verify file exists
	If FileExists("C:\pdf995\res\pdf995.ini") Then
	
		;Read Setting for print to location
		$saveto = IniRead( "C:\pdf995\res\pdf995.ini", "Parameters", "Fixed Dir", "default" )
		
		;verify setting is correct
		If $saveto <> $correct Then IniWrite( "C:\pdf995\res\pdf995.ini", "Parameters", "Fixed Dir", $correct )
		
	Else
	
		MsgBox( 262144, "Error", "PDF995 may not be installed!" )
		
	EndIf
	
	;msgbox(262144, "Location", $saveto )

EndFunc


Func capturedefect( $file )
;----------------------------------------------------------------
;Capture defect settings, log it to the file, do NOT Close defect
;----------------------------------------------------------------
	Local $a, $file
	$a = "Defect:|" &ControlGetText("Support", "", $defectid ) &"|"
	$a = $a &"Project:|" &ControlGetText("Support", "", $project ) &"|"
	$a = $a &"Area:|" &ControlGetText("Support", "", $area ) &"|"
	$a = $a &"Status:|" &ControlGetText("Support", "", $status ) &"|"
	$a = $a &"Severity:|" &ControlGetText("Support", "", $severity ) &"|"
	$a = $a &"Resolution:|" &ControlGetText("Support", "", $resolution ) &"|"
	$a = $a &"Priority:|" &ControlGetText("Support", "", $priority ) &"|"
	$a = $a &"Assigned to:|" &ControlGetText("Support", "", $assignedto ) &"|"
	$a = $a &"Source:|" &ControlGetText("Support", "", $source )
	
	;Write the defect info to a file
	FileWriteLine( $file, $a )

EndFunc


Func capturedefectprompt( $file )
;-----------------------------------------------------------------------
;Capture defect settings, log it to the file, Prompt to close the defect
;-----------------------------------------------------------------------
	Local $a, $file, $button
	$a = "Defect:|" &ControlGetText("Support", "", $defectid ) &"|"
	$a = $a &"Project:|" &ControlGetText("Support", "", $project ) &"|"
	$a = $a &"Area:|" &ControlGetText("Support", "", $area ) &"|"
	$a = $a &"Status:|" &ControlGetText("Support", "", $status ) &"|"
	$a = $a &"Severity:|" &ControlGetText("Support", "", $severity ) &"|"
	$a = $a &"Resolution:|" &ControlGetText("Support", "", $resolution ) &"|"
	$a = $a &"Priority:|" &ControlGetText("Support", "", $priority ) &"|"
	$a = $a &"Assigned to:|" &ControlGetText("Support", "", $assignedto ) &"|"
	$a = $a &"Source:|" &ControlGetText("Support", "", $source )
	
	;Write the defect info to a file
	FileWriteLine( $file, $a )
	
	;Prompt to close the defect
	$button = MsgBox( 262145, "Close Defect", "Close the defect?" )
	
	If $button = 1 Then
		closedefect( )
	Else
		;Do nothing
	EndIf
	
EndFunc


Func capturedefectclose_no_area( $file )
;-------------------------------------------------------------
;Capture defect settings, log it to the file, close the defect
;-------------------------------------------------------------
	Local $a, $file
	
	$a = "Defect:|" &ControlGetText("Support", "", $defectid ) &"|"
	$a = $a &"Project:|" &ControlGetText("Support", "", $project ) &"|"
	$a = $a &"Status:|" &ControlGetText("Support", "", $status ) &"|"
	$a = $a &"Severity:|" &ControlGetText("Support", "", $severity ) &"|"
	$a = $a &"Resolution:|" &ControlGetText("Support", "", $resolution ) &"|"
	$a = $a &"Priority:|" &ControlGetText("Support", "", $priority ) &"|"
	$a = $a &"Assigned to:|" &ControlGetText("Support", "", $assignedto ) &"|"
	$a = $a &"Source:|" &ControlGetText("Support", "", $source )
	
	;Write the defect info to a file
	FileWriteLine( $file, $a )
	
	
	;Close the defect, and open the next
	closedefect( )
	
EndFunc


Func capturedefectclose( $file )
;-------------------------------------------------------------
;Capture defect settings, log it to the file, close the defect
;-------------------------------------------------------------
	Local $a, $file
	
	$a = "Defect:|" &ControlGetText("Support", "", $defectid ) &"|"
	$a = $a &"Project:|" &ControlGetText("Support", "", $project ) &"|"
	$a = $a &"Area:|" &ControlGetText("Support", "", $area ) &"|"
	$a = $a &"Status:|" &ControlGetText("Support", "", $status ) &"|"
	$a = $a &"Severity:|" &ControlGetText("Support", "", $severity ) &"|"
	$a = $a &"Resolution:|" &ControlGetText("Support", "", $resolution ) &"|"
	$a = $a &"Priority:|" &ControlGetText("Support", "", $priority ) &"|"
	$a = $a &"Assigned to:|" &ControlGetText("Support", "", $assignedto ) &"|"
	$a = $a &"Source:|" &ControlGetText("Support", "", $source )
	
	;Write the defect info to a file
	FileWriteLine( $file, $a )
	
	
	;Close the defect, and open the next
	closedefect( )
	
EndFunc


Func checkstring( $str )
;-------------------------------------------------------------------------------------------------------------------------
;Check the string for AutoIt quick keys, and modifies the string to send them as characters ('!', '+', '^', '#', '{', '}') 
;-------------------------------------------------------------------------------------------------------------------------
	Local $str2 = "", $str
	
	;Replace ! with {!}
    If StringInStr( $str, "!" ) Then
        If StringLen( $str2 ) = 0 Then 
			$str2 = StringReplace( $str, "!", "{!}" )
		Else
			$str2 = StringReplace( $str2, "!", "{!}" )
		EndIf
    EndIf
    
	;Replace + with {+}
    If StringInStr( $str, "+" ) Then
        If StringLen( $str2 ) = 0 Then 
			$str2 = StringReplace( $str, "+", "{+}" )
		Else
			$str2 = StringReplace( $str2, "+", "{+}" )
		EndIf       
    EndIf
    
	;Replace ^ with {^}
    If StringInStr( $str, "^" ) Then
        If StringLen( $str2 ) = 0 Then 
			$str2 = StringReplace( $str, "^", "{^}" )
		Else
			$str2 = StringReplace( $str2, "^", "{^}" )
		EndIf       
    EndIf
    
	;Replace # with {#}
    If StringInStr( $str, "#" ) Then
        If StringLen( $str2 ) = 0 Then 
			$str2 = StringReplace( $str, "#", "{#}" )   
		Else
			$str2 = StringReplace( $str2, "#", "{#}" )   
		EndIf       
    EndIf
    
	;If no changes were made return the original string
    If StringLen( $str2 ) = 0 Then $str2 = $str
    
	Return $str2

EndFunc


#CS Func relaunch( )
   ;-----------------------------------------------------
   ;If option is set, show completion verification dialog
   ;-----------------------------------------------------
   
    ;Read ini file for preference
    $opt = IniRead( $inifile, "Completion", "End", "0" )
    
    If $opt = 1 Then 
        $programname = @ScriptName
        $z = MsgBox(262148, $programname&" Complete", "Enter in a new defect?"&@CRLF&"Before continuing, ensure that a new defect is open." )
    
        If $z = 6 Then ;6 = yes
            ;Launch program again!
            ;may need to change name of this script inorder for lauch to be sucessful
            ;AutoItWinSetTitle("OldDefectEntry")
            ;msgbox(262144, "", "Program will run again" )
            
            $locationdir = @ScriptDir
            $locationfile = @ScriptName
            
            ;Run the program again, NOTE THIS WILL FAIL FOR SCRIPTS BUT WILL WORK ONCE COMPILED
            Run( $locationfile, $locationdir )
            
        Else
            ;msgbox(262144, "", "Program will NOT run again" )
        EndIf
    Else
        ;msgbox(262144, "", "Program will NOT run again, config file prohibits it." )
    EndIf
    
   EndFunc
 #CE


#CS Func iniareadialog( )
   ;---------------------------------------------------------------------------------------------------------------------------------------------------------
   ;Prompt user for area, and set steps according to area, reading the areas and steps from an ini file, if file is missing show dialogs to create a new file
   ;---------------------------------------------------------------------------------------------------------------------------------------------------------
   
   ;Setup path for ini file, uses script name & location
   $inifile = @ScriptFullPath
   $inifile = StringTrimRight( $inifile, 4 )
   $inifile = $inifile&".ini"
   
   ;Setup path for ini file, uses script name, and places script into My Documents folder
   ;$inifile = @ScriptName
   ;$inifile = StringTrimRight( $inifile, 4 )
   ;$inifile = @MyDocumentsDir&"\"&$inifile&".ini"
   
   ;Does file exist
   If FileExists( $inifile ) Then
    ;Declare variables
    $cnt = 1
    $list = 1
    
    ;Read in the areas from the ini file
    $areadata = IniRead( $inifile, "Area&Steps", $cnt, "Blank Area Data!!!" )
       
    
    Do
        
        $arealst = $arealst&$list&" -"&$areadata&"~"
        
        ;Increment area count
    $cnt = $cnt + 2
        $list = $list + 1
        
        ;Read next value preparing for Loop test
        $areadata = IniRead( $inifile, "Area&Steps", $cnt, "Blank Area Data!!!" )
        
        ;Remove '+', '!', '^', "#", so user doesn't see it
        $areadata = StringReplace ( $areadata, "{", "" )
        $areadata = StringReplace ( $areadata, "}", "" )       
    
    
    Until $areadata = "Blank Area Data!!!"
   
   Else
    ;Notify the user that the file does not exist and 
    ;That it will be created and populated with example data
    MsgBox( 262192, "Error", "The config file does not exist."&@CRLF&"Please enter the required information in the following prompts."&@CRLF&"Once the information has been entered, the app will automatically restart." )
    If @error Then Exit
    
    ;Create the user config file
    FileWriteLine( $inifile, '[USER]' ) 
    ;FileWriteLine( $inifile, 'Name=Chris Huffman' ) 
    $name = Inputbox( "User Name", "Please enter the users name." )
    If @error Then 
        FileWriteLine( $inifile, 'Name=Example - Chris Huffman' ) 
        If @error = 1 Then Exit
    Else
        FileWriteLine( $inifile, 'Name='&$name )
    EndIf
    
    FileWriteLine( $inifile, '[PROJECT]' )     
    ;FileWriteLine( $inifile, 'Proj=ACT!' )    
    $project_input = Inputbox( "Project", "Please enter the project, as it appears in the Support Client."&@CRLF&@CRLF&"Example: ACT!" )
    If @error Then 
        FileWriteLine( $inifile, 'Proj=Example - ACT!' )   
        If @error = 1 Then Exit
    Else
        FileWriteLine( $inifile, 'Proj='&$project_input )
    EndIf
    
    FileWriteLine( $inifile, '[SEVERITY]' )     
    ;FileWriteLine( $inifile, 'Sev=Severity 2' )     
    $sever = Inputbox( "Severity", "Please enter the default severity, as it appears in the Support Client."&@CRLF&@CRLF&"Example: Severity 2" )
    If @error Then 
        FileWriteLine( $inifile, 'Sev=Example - Severity 2' ) 
        If @error = 1 Then Exit
    Else
        FileWriteLine( $inifile, 'Sev='&$sever )
    EndIf
        
    FileWriteLine( $inifile, '[RESOLUTION]' )     
    ;FileWriteLine( $inifile, 'Res=Scrub' ) 
    $resol = Inputbox( "Resolution", "Please enter the default resolution, as it appears in the Support Client."&@CRLF&@CRLF&"Example: Scrub" )
    If @error Then 
        FileWriteLine( $inifile, 'Res=Example - Scrub' )
        If @error = 1 Then Exit
    Else
        FileWriteLine( $inifile, 'Res='&$resol )
    EndIf
    
    FileWriteLine( $inifile, '[ASSIGNMENT]' )     
    ;FileWriteLine( $inifile, 'Assign=Scrub Team' ) 
    $assignment = Inputbox( "Assignment", "Please enter the default assignment, as it appears in the Support Client."&@CRLF&@CRLF&"Example: Scrub Team" )
    If @error Then 
        FileWriteLine( $inifile, 'Assign=Example - Scrub Team' ) 
        If @error = 1 Then Exit
    Else
        FileWriteLine( $inifile, 'Assign='&$assignment )
    EndIf
    
    FileWriteLine( $inifile, '[VERSION]' )     
    ;FileWriteLine( $inifile, 'Ver=Version Found minus build number' ) 
    $version = Inputbox( "Version", "Please enter the version, as it appears in the Support Client, minus the build number."&@CRLF&@CRLF&"Example: ACT! 7.0.1 x445 would be entered: ACT! 7.0.1 x" )
    If @error Then 
        FileWriteLine( $inifile, "Ver=Version Found minus build number. Example: ACT! 7.0.1 x445 would be entered: ACT! 7.0.1 x" ) 
        If @error = 1 Then Exit
    Else        
        FileWriteLine( $inifile, 'Ver='&$version )
    EndIf    
    
    FileWriteLine( $inifile, '[AREA&STEPS]' ) 
    ;FileWriteLine( $inifile, '1=Report Designer' ) 
    ;FileWriteLine( $inifile, '2=1. Open Mercury {ENTER}2. Open the Report Designer {ENTER 2}' ) 
    ;FileWriteLine( $inifile, '3=Printing' ) 
    ;FileWriteLine( $inifile, '4=1. Open Mercury {ENTER}2. Press Ctrl + P  {ENTER 2}' )
    
    
    $c = 1
    MsgBox( 262144, "Areas and Steps", "A series of prompts will follow."&@CRLF&"Please enter the Area and Steps as the dialogs prompt."&@CRLF&@CRLF&"After the last set of steps has been entered press cancel." )
    While 1
        ;prompt for an area
        $a1 = Inputbox( "Areas", "Please enter the area as it appears in the Support Client."&@CRLF&@CRLF&"Example: Report Designer."&@CRLF&"Press cancel after the last area has been entered." )
        If @error Then ExitLoop
        
        ;Check String for '+', '!', '^', "#" and change to appropriate values  
        $a1 = checkstring( $a1 )
        
        FileWriteLine( $inifile, $c&"="&$a1 )
        $c = $c + 1
        
        ;prompt for steps
        $s1 = Inputbox( "Areas and Steps", "Please enter the steps to be entered in the Defect Description."&@CRLF&@CRLF&"Type '{ENTER}' for one blank line, and '{ENTER 2}' for two."&@CRLF&@CRLF&"Example: 1. Open Mercury {ENTER}2. Open the Report Designer {ENTER 2}", "", "", 450, 208 )
        If @error Then ExitLoop
        FileWriteLine( $inifile, $c&"="&$s1 )
        $c = $c + 1
        
    WEnd
    
    ;Prompt user for a completion dialog
    $y = MsgBox( 262148, "Completion Dialog", "When the defect has been entered,"&@CRLF&"should a dialog appear giving the"&@CRLF&"option to enter an additional defect?" )
    FileWriteLine( $inifile, '[Completion]' )
    If $y = 6 Then ;6 = yes
        FileWriteLine( $inifile, "End=1" )
        
    Else
        FileWriteLine( $inifile, "End=0" )
        
    EndIf
    
    $ex = @ScriptName
    $ex2 = StringTrimRight( $ex, 4 )
    $ex2 = $ex2&".ini"
    
    MsgBox (262144, "Config Complete", "The config file has been setup."&@CRLF&"To make any changes to the config file, simply edit the *.ini file "&@CRLF&"that has the same name as this program."&@CRLF&@CRLF&"Program Name: "&$ex&@CRLF&"Ini File: "&$ex2 )
    
    ;Run the program again, NOTE THIS WILL FAIL FOR SCRIPTS BUT WILL WORK ONCE COMPILED TO AN EXE   
    If StringInStr(@ScriptName, ".exe" ) Then
        $locationdir = @ScriptDir
        $locationfile = @ScriptName
        Run( $locationfile, $locationdir )
    Else
        MsgBox(262144, "Notice", "This is an uncompiled script and can not automatically relaunch.")
    
    EndIf
    
    ;Exit the script
    Exit
    
   EndIf
   
   
   $arealst = StringReplace($arealst, "~", @CRLF )
   
   ;Show Dialog until a valid number was entered
   $check = 0
   
   Do
    $areavar = InputBox( "Enter Area", "Enter the number that corresponds to the desired area: "&$arealst,"","","301","335","400","250" )
    ;Check for errors or cancel
    IF @error Then Exit
    
    ;Check number in string
    If StringIsDigit( $areavar ) Then
        ;check for correct value
        If $areavar <> 0 AND $areavar < $list Then
            $check = 1
        Else
            ;String was not a number, re-prompt user 
        EndIf 
   
    Else
        ;String was not a number, re-prompt user 
   
    EndIf
    
   Until $check = 1
   
   $num = $areavar + $areavar - 1
    
   ;Set the area depending on the selected area 
   $areadata = IniRead( $inifile, "Area&Steps", $num, "ACT!" )
    
   
   ;Add Different Steps Depending on Area
   $sl = IniRead( $inifile, "Area&Steps", $num+1, "1. {ENTER}2. {ENTER 2}" )
   
   ;Check String for '+', '!', '^', "#" and change to appropriate values  
   $stepslist = checkstring( $sl )
   
   
   
   EndFunc
 #CE


Func promptbuild()
;------------------------------------------------------------------
;Get the current build number: 1. from the ini file, 2. prompt user 
;------------------------------------------------------------------
    Local $buildinifile, $num, $bld, $today, $yesterday, $version
	Local $name = @ScriptName
	
    $name = StringTrimRight( $name, 4 )
    
    ;Use the Build.ini file
    ;Setup path for ini file, uses script location
    $buildinifile = @ScriptDir&"\"&"Build.ini"

    $num = IniRead( $buildinifile, "Build "&$name, @MDAY, "xxx" )

    If $num = "xxx" Then 
                      
        ;Check for valid build number (check that string is only numbers)
        Do           
            $bld = InputBox( "Build Number", "Please enter the current build number. "&@CRLF&"Do not add the 'x'."&@CRLF&@CRLF&"To enter in a different build number later today delete the file: "&@CRLF&@ScriptDir&"\Build.ini"&@CRLF&@CRLF&"This prompt will appear once a day.", "", "",400, 200  )
            ;Exit Script if an error occurred
            IF @error Then Exit
            
            $result = StringIsDigit( $bld )     
        Until $result = 1
             
        ;Get current date
        $today = @MDAY    
        $yesterday = $today-1
        
        ;Delete old data, delete the end of last month, or just yesterday
        If $today < 5 Then 
            IniDelete( $buildinifile, "Build "&$name, 27 )
            IniDelete( $buildinifile, "Build "&$name, 28 )
            IniDelete( $buildinifile, "Build "&$name, 29 )
            IniDelete( $buildinifile, "Build "&$name, 30 )
            IniDelete( $buildinifile, "Build "&$name, 31 )
            IniDelete( $buildinifile, "Build "&$name, $yesterday )
        Else
            IniDelete( $buildinifile, "Build "&$name, $yesterday )
        EndIf
        
        ;Save the build number
        IniWrite( $buildinifile, "Build "&$name, $today, $bld )   
           
        ;Prepare to return the build number
        $version = $bld
       
    Else
        ;Prepare to return the build number
        $version = $num
    
    EndIf
        
	Return $version

EndFunc


Func inibuild()
;----------------------------------------------------------------------------------------------------
;Get the current build number: 1. look for reg number; 2. then from the ini file, finally prompt user 
;----------------------------------------------------------------------------------------------------
    Local $version, $buildinifile, $num, $bld, $today, $yesterday
	Local $name = @ScriptName
    
	$name = StringTrimRight( $name, 4 )
    
    
    ;Read the registry for a build value
    $version = RegRead( "HKEY_LOCAL_MACHINE\SOFTWARE\ACT\Act7Updater",  "LastAppliedUpdateVersion" )
	$version = RegRead( "HKEY_LOCAL_MACHINE\SOFTWARE\ACT\ActUpdater",  "LastAppliedUpdateVersion" )
    
    IF @error Then 
        
        ;If not found then use the Build.ini file
        ;Setup path for ini file, uses script location
        $buildinifile = @ScriptDir&"\"&"Build.ini"

        $num = IniRead( $buildinifile, "Build "&$name, @MDAY, "xxx" )

        If $num = "xxx" Then 
                      
            ;Check for valid build number (check that string is only numbers)
            Do           
                $bld = InputBox( "Build Number", "Please enter the current build number. "&@CRLF&"Do not add the 'x'."&@CRLF&@CRLF&"To enter in a different build number later today delete the file: "&@CRLF&@ScriptDir&"\Build.ini"&@CRLF&@CRLF&"This prompt will appear once a day.", "", "",400, 200  )
                ;Exit Script if an error occurred
                IF @error Then Exit
            
                $result = StringIsDigit( $bld )
             Until $result = 1
             
            ;Get current date
            $today = @MDAY    
            $yesterday = $today-1
        
            ;Delete old data, delete the end of last month, or just yesterday
            If $today < 5 Then 
                IniDelete( $buildinifile, "Build "&$name, 27 )
                IniDelete( $buildinifile, "Build "&$name, 28 )
                IniDelete( $buildinifile, "Build "&$name, 29 )
                IniDelete( $buildinifile, "Build "&$name, 30 )
                IniDelete( $buildinifile, "Build "&$name, 31 )
                IniDelete( $buildinifile, "Build "&$name, $yesterday )
            Else
                IniDelete( $buildinifile, "Build "&$name, $yesterday )
            EndIf
        
            ;Save the build number
            IniWrite( $buildinifile, "Build "&$name, $today, $bld )   
            
            ;Prepare to return the build number
            $version = $bld
        
        Else
            ;Prepare to return the build number
            $version = $num
    
        EndIF            
        
    Else
        ;Remove extra data from registry entry
        $version = StringTrimLeft( $version, 4 )
        $version = StringTrimRight( $version, 2 )
    EndIf
    
    Return $version

EndFunc


Func guipromptbuild()
;------------------------------------------------------------------
;Get the current build number: 1. from the ini file, 2. prompt user 
;------------------------------------------------------------------
#cs    
    $name = @ScriptName
    $name = StringTrimRight( $name, 4 )
    
    ;Use the Build.ini file
    ;Setup path for ini file, uses script location
    $buildinifile = @ScriptDir&"\"&"Build.ini"

    $num = IniRead( $buildinifile, "Build "&$name, @YDAY, "xxx" )

    If $num = "xxx" Then 
                      
        ;Check for valid build number (check that string is only numbers)
        Do           
            $bld = InputBox( "Build Number", "Please enter the current build number. "&@CRLF&"Do not add the 'x'."&@CRLF&@CRLF&"To enter in a different build number later today delete the file: "&@CRLF&@ScriptDir&"\Build.ini"&@CRLF&@CRLF&"This prompt will appear once a day.", "", "",400, 200  )
            ;Exit Script if an error occurred
            IF @error Then Exit
            
            $result = StringIsDigit( $bld )     
        Until $result = 1
             
        ;Get current date
        $today = @YDAY    
        $yesterday = $today-1
        
        ;Delete old data, delete the end of last month, or just yesterday
        If $today < 5 Then 
            IniDelete( $buildinifile, "Build "&$name, 27 )
            IniDelete( $buildinifile, "Build "&$name, 28 )
            IniDelete( $buildinifile, "Build "&$name, 29 )
            IniDelete( $buildinifile, "Build "&$name, 30 )
            IniDelete( $buildinifile, "Build "&$name, 31 )
            IniDelete( $buildinifile, "Build "&$name, $yesterday )
        Else
            IniDelete( $buildinifile, "Build "&$name, $yesterday )
        EndIf
        
        ;Save the build number
        IniWrite( $buildinifile, "Build "&$name, $today, $bld )   
           
        ;Prepare to return the build number
        $version = $bld
       
    Else
        ;Prepare to return the build number
        $version = $num
    
    EndIF     
        
Return $version
#CE
EndFunc


Func guiinibuild()
;----------------------------------------------------------------------------------------------------
;Get the current build number: 1. look for reg number; 2. then from the ini file, finally prompt user 
;----------------------------------------------------------------------------------------------------
 #CS   $name = @ScriptName
    $name = StringTrimRight( $name, 4 )
    
    
    ;Read the registry for a build value
    $version = RegRead( "HKEY_LOCAL_MACHINE\SOFTWARE\ACT\Act7Updater",  "LastAppliedUpdateVersion" )
    $version = RegRead( "HKEY_LOCAL_MACHINE\SOFTWARE\ACT\ActUpdater",  "LastAppliedUpdateVersion" )
    IF @error Then 
        
        ;If not found then use the Build.ini file
        ;Setup path for ini file, uses script location
        $buildinifile = @ScriptDir&"\"&"Build.ini"

        $num = IniRead( $buildinifile, "Build "&$name, @MDAY, "xxx" )

        If $num = "xxx" Then 
                      
            ;Check for valid build number (check that string is only numbers)
            Do           
                $bld = InputBox( "Build Number", "Please enter the current build number. "&@CRLF&"Do not add the 'x'."&@CRLF&@CRLF&"To enter in a different build number later today delete the file: "&@CRLF&@ScriptDir&"\Build.ini"&@CRLF&@CRLF&"This prompt will appear once a day.", "", "",400, 200  )
                ;Exit Script if an error occurred
                IF @error Then Exit
            
                $result = StringIsDigit( $bld )
             Until $result = 1
             
            ;Get current date
            $today = @MDAY    
            $yesterday = $today-1
        
            ;Delete old data, delete the end of last month, or just yesterday
            If $today < 5 Then 
                IniDelete( $buildinifile, "Build "&$name, 27 )
                IniDelete( $buildinifile, "Build "&$name, 28 )
                IniDelete( $buildinifile, "Build "&$name, 29 )
                IniDelete( $buildinifile, "Build "&$name, 30 )
                IniDelete( $buildinifile, "Build "&$name, 31 )
                IniDelete( $buildinifile, "Build "&$name, $yesterday )
            Else
                IniDelete( $buildinifile, "Build "&$name, $yesterday )
            EndIf
        
            ;Save the build number
            IniWrite( $buildinifile, "Build "&$name, $today, $bld )   
            
            ;Prepare to return the build number
            $version = $bld
        
        Else
            ;Prepare to return the build number
            $version = $num
    
        EndIF            
        
    Else
        ;Remove extra data from registry entry
        $version = StringTrimLeft( $version, 4 )
        $version = StringTrimRight( $version, 2 )
    EndIf
    
    Return $version
#CE
EndFunc


Func onescript( )
;-------------------------------------------------
;Allow only one instance of script, by script name
;-------------------------------------------------
    Local $fullname, $name
	
	;Get script name
    $fullname = @ScriptName
    ;remove the '.au3'
    $name = StringTrimRight( $fullname, 4 ) 
    ;Is a script by the same name already running, if so exit the script
    If WinExists($name) Then 
		Msgbox( 262144, "Error", "Only one script can run at a time." )
		Exit 
	EndIf
	
    ;Set the title to the script name
    AutoItWinSetTitle($name)
    
EndFunc


Func filteroptions( $file )
   ;-----------------------------------------------------------
   ;Read and Save calendar filter options from ACT Print Dialog
   ;-----------------------------------------------------------
   Local $optionbutton, $filter, $today, $timeless, $cleared, $daterange, $datestartval, $datendval, $clearedval1
   Local $timeless, $statetimeless, $clearedval, $clearedtimeless, $text, $typeval
   
   ;Field Names
   $optionbutton = "WindowsForms10.BUTTON.app35" ;Print option button
   
   ;calendar filter button
   $filter = "WindowsForms10.BUTTON.app33"
   
   ;date range radio buttons
   $today = "WindowsForms10.BUTTON.app33"
   
   $daterange = "WindowsForms10.BUTTON.app32"
   ;$datestart = "WindowsForms10.EDIT.app31"
   ;$datend = "WindowsForms10.EDIT.app32"
   
   
   $timeless = "WindowsForms10.BUTTON.app39"
   $cleared = "WindowsForms10.BUTTON.app38"
   
   ;-------------------
   ;save filter options
   ;-------------------
   
   ;Open FilterDialog
   ;ControlClick ( "Options", "", $filter, "left", 1 )
   window( "Options", "" )
   Send( "{ALTDOWN}f{ALTUP}" )
   Sleep( 150 )
   
   ;wait for dialog to appear
   waitwindow( "Filter Calendar Printout", "Activity dates" )
   Sleep( 200 )
   ;see which activity dates radio button was selected
   
   Select
    Case ControlCommand( "Filter Calendar Printout", "Activity dates", $today, "IsChecked", "" ) = 1
        ;Today Button is checked
        $todayval = @Mon&"-"&@MDAY&"-"&@YEAR
        $datestartval = ""
        $datendval = ""
    Case ControlCommand( "Filter Calendar Printout", "Activity dates", $daterange, "IsChecked", "" ) = 1
        ;Date range is checked, determine the range
        $todayval = ""
        window( "Filter Calendar Printout", "" )
    ;First Date
    MouseClick( "button", 340, 125, 1, 1 )
    $datestartval = ControlCommand( "Filter Calendar Printout", "", "WindowsForms10.EDIT.app31","GetSelected", "" )
    $datestartval = $datestartval&" - "
            
    ;End Date
    MouseClick( "button", 490, 125, 1, 1 )
        $datendval = ControlCommand( "Filter Calendar Printout", "", "WindowsForms10.EDIT.app32","GetSelected", "" )
        
   EndSelect
   
   
   ;Check to see if timeless and cleared are checked
   $timelessval = ControlCommand ( "Filter Calendar Printout", "Activity dates", $timeless, "IsChecked", "" )
   Sleep( 200 )
   $clearedval = ControlCommand ( "Filter Calendar Printout", "Activity dates", $cleared, "IsChecked", "" )
   
   ;make value usable
   If $timeless = 1 Then
    $statetimeless = "Checked"
   Else
    $statetimeless = "Un-checked"
   EndIf
   If $clearedval = 1 Then
    $statecleared = "Checked"
   Else
    $statecleared = "Un-checked"
   EndIf
   
   
   ;Get window text to look for types and priorities
   $text = WinGetText( "Filter Calendar Printout", "" )
   If @error = 1 Then 
    ;msgbox ( 0, "Error", "An error occured.")
    FileWriteLine( $filehandle2, "!!!!!" )
    FileWriteLine( $filehandle2, "The window text was not readable." )
    FileWriteLine( $filehandle2, "!!!!!" )
    $text = "blank text"
   EndIf
   
   ;make each entry a different line by adding a carridge return, and split into an array
   $array = StringSplit( $text, @LF)
   
   ;look for activity types and activity priorities and return the setting
   If StringInStr( $array[14], "Activit&y types" ) <> 0 Then
    $typeval = $array[13]
   Else
    $typeval = $array[14]
   EndIf
   
   If StringInStr( $array[12], "Activity &priorities" ) <> 0 Then
    $priorityval = $array[11]
   Else
    $priorityval = $array[12]
   EndIf
   
   
   ;Write to a file 
   FileWriteLine( $filehandle2, "------------------------" )
   FileWriteLine( $filehandle2, "|Filter Dialog Settings|" )
   FileWriteLine( $filehandle2, "------------------------" )
   FileWriteLine( $filehandle2, "Activity Dates:" )
   FileWriteLine( $filehandle2, $todayval &$datestartval &$datendval )
   FileWriteLine( $filehandle2, "" )
   FileWriteLine( $filehandle2, "Activity Options:" )
   FileWriteLine( $filehandle2, "Only Timeless: " &$statetimeless )
   FileWriteLine( $filehandle2, "IncludeCleared: " &$statecleared )
   FileWriteLine( $filehandle2, "" )
   FileWriteLine( $filehandle2, "Activity Types: " &$typeval )
   FileWriteLine( $filehandle2, "Activity Priorities: " &$priorityval )
   FileWriteLine( $filehandle2, "" )
   
   ;Close filters dialog
   window( "Filter Calendar Printout", "Activity dates" )
   Send( "{ALTDOWN}o{ALTUP}" )
   Sleep( 200 )
   
EndFunc


Func defectopen()
;--------------------------------------------------------------
;verify that a defect is open and the list view is not in focus
;--------------------------------------------------------------
;Names I need to check for "Support", "Support - [Defect List View]", 
;Names that are ok "Support - [New Defect]", "Support - []", "Support - [2-46544]"
;If window doesn't exist, show msgbox
	Local $e
	
	While WinExists( "Support - [Defect List View]", "" )
	
		Sleep(500)
		
		;$e = waitwindowshorterror( "Support - [Defect - [", "" ) 
		;If $e = 1 Then 
		$e = MsgBox( 262145, "Error", "An open defect was not found." &@CRLF &"Please open a defect and press ok." )
		IF @error OR $e = 2 Then Exit
		
	WEnd
	
	;Would a Select work better?????????????
	
	
	#cs
	If WinExists( "Support - [Defect - [", "" ) Then
		;Defect is open do nothin
	Else
		;Wait for the defect to open
		$e = waitwindowshorterror( "Support - [Defect - [", "" ) 
		If $e = 1 Then MsgBox( 262144, "Error", "An open defect was not found."&@CRLF&"Please open a defect and press ok." )
		iF @error Then Exit
	EndIf
	#ce

EndFunc


Func closeticket()
;-----------------------------------------------------
;Close the currently open ticket and open the next one
;-----------------------------------------------------
	
	Send( "{CTRLDOWN}{F4}{CTRLUP}" )
	
	Sleep(350)
	
	If WinExists( "Confirm", "" ) Then
		;Press Enter to save changes
		window( "Confirm", "" )  
		Sleep( 100 )
		Send( "{ENTER}" )
	
		;Wait 1/2 a sec to see if an error appears
		Sleep( 500 )
	
		;Check for SalesLogix Error
		If WinExists ( "SalesLogix Error", "") Then
			window( "SalesLogix Error", "") 
			Send ( "{ENTER}")
		EndIf
	
	EndIf
	
	;Wait till the defect list view is active again
	waitwindow( "Support - [Ticket List View", "" ) 
	
	
	Send( "{DOWN}{ENTER}" ) ;Open the next defect
	;Sleep( 500 )

EndFunc


Func ticketopen()
;--------------------------------------------------------------
;verify that a ticket is open and the list view is not in focus
;--------------------------------------------------------------
;Names I need to check for "Support", "Support - [Defect List View]", 
;Names that are ok "Support - [New Defect]", "Support - []", "Support - [2-46544]"
;If window doesn't exist, show msgbox
	Local $e
	
	While WinExists( "Support - [Ticket List View]", "" )
	
		Sleep(500)
		
		;$e = waitwindowshorterror( "Support - [Defect - [", "" ) 
		;If $e = 1 Then 
		$e = MsgBox( 262145, "Error", "An open ticket was not found."&@CRLF&"Please open a ticket and press ok." )
		IF @error OR $e = 2 Then Exit
		
	WEnd
	
	;Would a Select work better?????????????
	
	
	#cs
	If WinExists( "Support - [Defect - [", "" ) Then
		;Defect is open do nothin
	Else
		;Wait for the defect to open
		$e = waitwindowshorterror( "Support - [Defect - [", "" ) 
		If $e = 1 Then MsgBox( 262144, "Error", "An open defect was not found."&@CRLF&"Please open a defect and press ok." )
		iF @error Then Exit
	EndIf
	#ce

EndFunc


Func reportfolder()
;--------------------------------------------------------------------------------
;Creates a path to the last/current db report folder, does not add '\' at the end
;--------------------------------------------------------------------------------
	Local $pad_file, $line_4, $database_location, $database_directory, $report_path
	
	#include <Array.au3>
	
	;Host is the machine name if it is anything but a . it probably needs to be added to the filename
	$pad_file = RegRead( "HKEY_CURRENT_USER\Software\ACT", "LastDBFileUsed" )
	$line_4 = FileReadLine( $pad_file, 4 )
	
	;Break String apart into usable sections
	$line_array = StringSplit( $line_4, "=" )
	
	;~ _ArrayDisplay( $line_array, "After String Split" )
	
	$line_array[2] = StringReplace( $line_array[2], '" host', '' )
	$database_name = StringReplace( $line_array[2], '"', '' )
	
	$line_array[3] = StringReplace( $line_array[3], '" location', '' )
	$database_location = StringReplace( $line_array[3], '"', '' )
	
	$line_array[4] = StringReplace( $line_array[4], '" type', '' )
	$database_directory = StringReplace( $line_array[4], '"', '' )
	
	;Create the path to the reports folder and count the # of reports and save the names
	$report_path = $database_directory &"\" &$database_name &"-database files\Reports"
	
	Return $report_path

EndFunc 


Func address_calendar_folder()
;--------------------------------------------------------------------------------
;Creates a path to the print templates folder, does not add '\' at the end
;--------------------------------------------------------------------------------
	Local $install_path, $template_path
	
	;Retrieve install path from registry and add the print templates to the end
	$install_path = RegRead( "HKEY_LOCAL_MACHINE\SOFTWARE\ACT\Install", "InstallPath" )
	If @Error Then
		MsgBox( 262160, "Error", "ACT Install path could not be read from the registry." )
		Exit
	EndIf
	
	$template_path = $install_path &"\Print Templates"
	
	Return $template_path

EndFunc 


Func print($parent, $name, $x, $y)
;--------------------------------------
;Print to pdf995 and save the file name
;--------------------------------------
	Local $parent, $name, $x, $y, $e, $build, $s, $print_type, $msg
    ;clear error
    $e = 0

    ;Get build from registry
    $build = build()

    ;Show a tray tip indicating which parent is currently printing
    TrayTip ( "", $parent, 20 )
    
    ;wait for print selection dialog to appear, don't show an error if it doesn't appear
    $e = waitwindowerror ( "Print", "Printer" )
    
    ;If unable to find print, printer. Click the layout again
    If $e = 1 Then
        window( "Print", "Preview :" )
        Mouseclick( "left", $x, $y, 2, 2 )
        waitwindow ( "Print", "Printer" )
    EndIf

    ;----------------------
    ;Select correct printer
    ;----------------------
    
    ;Press ok
    ControlClick ( "Print", "Printer", "Button10")
    
    ;Pause script till Printing Act window appears
    $s = WinWaitActive ( "Printing", "ACT!", 60 )
    If $s = 0 Then MsgBox( 262144, "Window not found" ,"Printing - ACT!", 30 )
    
    ;Wait for Save As Dialog to appear
    waitwindow( "Pdf995 Save As", "")
    
    ;Send Name to dialog
    ControlFocus( "Pdf995 Save As", "", "Edit1")
    Send( ""&$print_type&" - x"&$build&" - "&$name&" - Parent #"&$parent&"")
    Sleep( 500 )
    ;Press enter to save the file
    ControlClick("Pdf995 Save As", "", "Button2", "Left", 1)
    
    ;Wait for printing dialog to disappear
    $msg = WinWaitClose( "Printing","ACT!", 150)
    If $msg = 0 Then Msgbox( 0, "Error", "ACT! Printing window has not closed."&@CRLF&"Script will not cancel."&@CRLF&"Press ok to continue after the ACT! printing window has closed.", 15)
    
    
    ;Wait for computer to finish
    Sleep( 3000 )
    
    ;Verify that the IE window is minimized
    If WinExists( "Microsoft Internet Explorer", "" ) Then
        winsetstate( "Microsoft Internet Explorer", "", @SW_MINIMIZE)
        Sleep(200)
    EndIf
    
    ;Verify focus is on ACT! print window
    waitwindow( "Print", "Preview :" )
    
    ;Verify that enable preview is not checked
    If ControlCommand ( "Print", "Preview :", "WindowsForms10.BUTTON.app42", "IsChecked", "" ) Then ControlCommand ( "Print", "Preview :", "WindowsForms10.BUTTON.app42", "UnCheck", "" )
    
    Sleep( 200 )
    
EndFunc


Func printall($parent, $name)
;--------------------------------------------------------------
;Print to pdf995 and save the file name, Layout # and File Name
;--------------------------------------------------------------
	Local $parent, $name, $e, $build, $s, $type, $msg
    ;clear error
    $e = 0

    ;Get build from registry
    $build = build()

    ;Show a tray tip indicating which parent is currently printing
    TrayTip ( "", $parent, 20 )

    ;wait for print selection dialog to appear
    window ( "Print", "Printer" )


    ;----------------------
    ;Select correct printer
    ;----------------------

    ;Press ok
    ControlClick ( "Print", "Printer", "Button10")

    ;Pause script till Printing Act window appears
    $s = WinWaitActive ( "Printing", "ACT!", 60 )
    If $s = 0 Then MsgBox( 262144, "Window not found" ,"Printing - ACT!", 30 )

    ;Wait for Save As Dialog to appear
    waitwindow( "Pdf995 Save As", "")

    ;Send Name to dialog
    ControlFocus( "Pdf995 Save As", "", "Edit1")
    Send( ""&$type&" - x"&$build&" - "&$name&" - Template #"&$parent&"")
    Sleep( 500 )
    ;Press enter to save the file
    ControlClick("Pdf995 Save As", "", "Button2", "Left", 1)

    ;Wait for printing dialog to disappear
    $msg = WinWaitClose( "Printing","ACT!", 150)
    If $msg = 0 Then Msgbox( 0, "Error", "ACT! Printing window has not closed."&@CRLF&"Script will not cancel."&@CRLF&"Press ok to continue after the ACT! printing window has closed.", 15)


    ;Wait for computer to finish
    Sleep( 3000 )

    ;Verify that the IE window is minimized
    If WinExists( "Microsoft Internet Explorer", "" ) Then
        winsetstate( "Microsoft Internet Explorer", "", @SW_MINIMIZE )
        Sleep(200)
    EndIf

    Sleep( 200 )
    
    

EndFunc


Func address_all( $name, $cnt )
;-----------------------------------------------------
;Open print dialog, select a report, print and name it
;-----------------------------------------------------
    Local $name, $cnt, $print_type. $build, $locale
    ;Type of printout
    $print_type = "Address"

    ;Display a Tool tip in the center-top of the screen indicating current report
;~ 	ToolTip( "Printing Report: " &$name, @DesktopWidth/2, 1 )
;~     TrayTip( "", $name, 29 )

    ;get build from registry
    $build = build()

    ;Focus to mercury
    window( "ACT!", "" )

    ;Open Print Dialog
    Send( "{CTRLDOWN}p{CTRLUP}" )

    ;Wait for print window to open (75 seconds)
    waittimewindow( "Print", "Preview :", 100 )

    ;Select reports and move to list
    Send( "a{TAB}" )
	Sleep( 500 )
	
    ;If this is the first report printed ensure that the first report is selected
	If $cnt = 1 Then 
		Send( "{HOME}" )
		Send( "{TAB 3}" )
		Send( "{Space}" )
	Else
		Send( "{DOWN}" )
		Send( "{TAB 3}" )
		Send( "{Space}" )
	EndIf
	Sleep(500)
	
    ;Wait for printer selection to appear
    waitwindow( "Print", "Printer" )

    ;Press ok
    ControlClick( "Print", "Printer", "Button10" )

	;TEST Wait till processor drops below 40%
	processor_usage( 35, 500 )

    ;Wait for Save As Dialog to appear
    WinWait( "Pdf995 Save As", "" )
	window( "Pdf995 Save As", "" )

    $locale = RegRead( "HKEY_LOCAL_MACHINE\SOFTWARE\ACT\Install",  "Language" )

    ;Send Name to dialog
    ControlFocus( "Pdf995 Save As", "", "Edit1" )
    Send( $print_type&" - x"&$build&" - "&$locale&" - "&$name )
    Sleep( 500 )

    ;Press enter to save the file
    ControlClick( "Pdf995 Save As", "", "Button2", "Left", 2 )
    Sleep( 200 )

    ;Wait for printing dialog to disappear
    $msg = WinWaitClose( "Printing","ACT!", 150 )
    If $msg = 0 Then Msgbox( 0, "Error", "ACT! Printing window has not closed, Script will not Cancel.", 15 )

    ;Give pc some time to finish
    Sleep( 3000 )

EndFunc


Func daycalendar_all( $name, $cnt )
;-----------------------------------------------------
;Open print dialog, select a report, print and name it
;-----------------------------------------------------
;~ #include "Func-AutomatedPerformance.au3"
	Local $name, $cnt, $print_type, $build, $locale, $msg
	
    ;Type of printout
    $print_type = "Day Calendar"

    ;Display a Tool tip in the center-top of the screen indicating current report
;~ 	ToolTip( "Printing Report: " &$name, @DesktopWidth/2, 1 )
;~     TrayTip( "", $name, 29 )

    ;get build from registry
    $build = build()

    ;Focus to mercury
    window( "ACT!", "" )

    ;Open Print Dialog
    Send( "{CTRLDOWN}p{CTRLUP}" )

    ;Wait for print window to open (75 seconds)
    waittimewindow( "Print", "Preview :", 100 )

    ;Select reports and move to list
    Send( "d{TAB}" )
	Sleep( 250 )
	
    ;If this is the first report printed ensure that the first report is selected
	If $cnt = 1 Then 
		Send( "{HOME}{TAB 3}{Space}" )
	Else
		Send( "{DOWN}{TAB 3}{Space}" )
	EndIf
	Sleep(500)
	
    ;Wait for printer selection to appear
    waitwindow( "Print", "Printer" )
	
    ;Press ok
    ControlClick( "Print", "Printer", "Button10" )
	
;TEST Wait till processor drops below 35%
processor_usage( 35, 500 )
	
    ;Wait for Save As Dialog to appear
    WinWait( "Pdf995 Save As", "" )
	window( "Pdf995 Save As", "" )

    $locale = RegRead( "HKEY_LOCAL_MACHINE\SOFTWARE\ACT\Install", "Language" )

    ;Send Name to dialog
    ControlFocus( "Pdf995 Save As", "", "Edit1" )
    Send( $print_type&" - x"&$build&" - "&$locale&" - "&$name )
    Sleep( 500 )

    ;Press enter to save the file
    ControlClick( "Pdf995 Save As", "", "Button2", "Left", 2 )
    Sleep( 200 )

    ;Wait for printing dialog to disappear
    $msg = WinWaitClose( "Printing","ACT!", 150 )
    If $msg = 0 Then Msgbox( 0, "Error", "ACT! Printing window has not closed, Script will not Cancel.", 15 )

    ;Give pc some time to finish
    Sleep( 3000 )

EndFunc


Func weekcalendar_all( $name, $cnt )
;-----------------------------------------------------
;Open print dialog, select a report, print and name it
;-----------------------------------------------------
;~ #include "Func-AutomatedPerformance.au3"
    Local $name, $cnt, $print_type, $build, $locale, $msg
	
    ;Type of printout
    $print_type = "Day Calendar"

    ;Display a Tool tip in the center-top of the screen indicating current report
;~ 	ToolTip( "Printing Report: " &$name, @DesktopWidth/2, 1 )
;~     TrayTip( "", $name, 29 )

    ;get build from registry
    $build = build()

    ;Focus to mercury
    window( "ACT!", "" )

    ;Open Print Dialog
    Send( "{CTRLDOWN}p{CTRLUP}" )

    ;Wait for print window to open (75 seconds)
    waittimewindow( "Print", "Preview :", 100 )

    ;Select reports and move to list
    Send( "w{TAB}" )
	Sleep( 250 )
	
    ;If this is the first report printed ensure that the first report is selected
	If $cnt = 1 Then 
		Send( "{HOME}{TAB 3}{Space}" )
	Else
		Send( "{DOWN}{TAB 3}{Space}" )
	EndIf
	Sleep(500)
	
    ;Wait for printer selection to appear
    waitwindow( "Print", "Printer" )
	
    ;Press ok
    ControlClick( "Print", "Printer", "Button10" )
	
;TEST Wait till processor drops below 35%
processor_usage( 35, 500 )
	
    ;Wait for Save As Dialog to appear
    WinWait( "Pdf995 Save As", "" )
	window( "Pdf995 Save As", "" )

    $locale = RegRead( "HKEY_LOCAL_MACHINE\SOFTWARE\ACT\Install", "Language" )

    ;Send Name to dialog
    ControlFocus( "Pdf995 Save As", "", "Edit1" )
    Send( $print_type&" - x"&$build&" - "&$locale&" - "&$name )
    Sleep( 500 )

    ;Press enter to save the file
    ControlClick( "Pdf995 Save As", "", "Button2", "Left", 2 )
    Sleep( 200 )

    ;Wait for printing dialog to disappear
    $msg = WinWaitClose( "Printing","ACT!", 150 )
    If $msg = 0 Then Msgbox( 0, "Error", "ACT! Printing window has not closed, Script will not Cancel.", 15 )

    ;Give pc some time to finish
    Sleep( 3000 )

EndFunc


Func monthcalendar_all( $name, $cnt )
;-----------------------------------------------------
;Open print dialog, select a report, print and name it
;-----------------------------------------------------
;~ #include "Func-AutomatedPerformance.au3"
	Local $name, $cnt, $print_type, $build, $locale, $msg
	
    ;Type of printout
    $print_type = "Day Calendar"

    ;Display a Tool tip in the center-top of the screen indicating current report
;~ 	ToolTip( "Printing Report: " &$name, @DesktopWidth/2, 1 )
;~     TrayTip( "", $name, 29 )

    ;get build from registry
    $build = build()

    ;Focus to mercury
    window( "ACT!", "" )

    ;Open Print Dialog
    Send( "{CTRLDOWN}p{CTRLUP}" )

    ;Wait for print window to open (75 seconds)
    waittimewindow( "Print", "Preview :", 100 )

    ;Select reports and move to list
    Send( "m{TAB}" )
	Sleep( 250 )
	
    ;If this is the first report printed ensure that the first report is selected
	If $cnt = 1 Then 
		Send( "{HOME}{TAB 3}{Space}" )
	Else
		Send( "{DOWN}{TAB 3}{Space}" )
	EndIf
	Sleep(500)
	
    ;Wait for printer selection to appear
    waitwindow( "Print", "Printer" )
	
    ;Press ok
    ControlClick( "Print", "Printer", "Button10" )
	
;TEST Wait till processor drops below 35%
processor_usage( 35, 500 )
	
    ;Wait for Save As Dialog to appear
    WinWait( "Pdf995 Save As", "" )
	window( "Pdf995 Save As", "" )
	
    $locale = RegRead( "HKEY_LOCAL_MACHINE\SOFTWARE\ACT\Install", "Language" )
	
    ;Send Name to dialog
    ControlFocus( "Pdf995 Save As", "", "Edit1" )
    Send( $print_type&" - x"&$build&" - "&$locale&" - "&$name )
    Sleep( 500 )
	
    ;Press enter to save the file
    ControlClick( "Pdf995 Save As", "", "Button2", "Left", 2 )
    Sleep( 200 )

    ;Wait for printing dialog to disappear
    $msg = WinWaitClose( "Printing","ACT!", 150 )
    If $msg = 0 Then Msgbox( 0, "Error", "ACT! Printing window has not closed, Script will not Cancel.", 15 )

    ;Give pc some time to finish
    Sleep( 3000 )

EndFunc


Func report_all( $name, $cnt )
;-----------------------------------------------------
;Open print dialog, select a report, print and name it
;-----------------------------------------------------
	Local $name, $cnt, $print_type, $build, $locale, $msg
	
    ;Type of printout
    $print_type = "Report"

    ;Display a Tool tip in the center-top of the screen indicating current report
;~ 	ToolTip( "Printing Report: " &$name, @DesktopWidth/2, 1 )
;~     TrayTip( "", $name, 29 )

    ;get build from registry
    $build = build()

    ;Focus to mercury
    window( "ACT!", "" )

    ;Open Print Dialog
    Send( "{CTRLDOWN}p{CTRLUP}" )

    ;Wait for print window to open (75 seconds)
    waittimewindow( "Print", "Preview :", 100 )

    ;Select reports and move to list
    Send( "r{TAB}" )
	Sleep( 250 )
	
    ;If this is the first report printed ensure that the first report is selected
	If $cnt = 1 Then 
		Send( "{HOME}{TAB}{ENTER}" )
	Else
		Send( "{DOWN}{TAB}{ENTER}" )
	EndIf
	Sleep(500)
	
    ;Wait for define filters dialog
    waitwindow( "Define Filters", "General" )
    Sleep(200)

    ;set focus to output selection combo box
    ;ControlFocus( "Define Filters", "General", "WindowsForms10.COMBOBOX.app51" )
    Send( "{TAB}" )

    ;set output to printer
	If ControlGetText( "Define Filters", "General", "WindowsForms10.COMBOBOX." &$sApp &"1" ) <> "Printer" Then
		window( "Define Filters", "General" )
		Do
			Send("{DOWN}" )
		Until ControlGetText( "Define Filters", "General", "WindowsForms10.COMBOBOX." &$sApp &"1" ) = "Printer"
	EndIf
	
    Sleep( 250 )

    ;Press Ok in define filters dialog
    waitwindow( "Define Filters", "General" )
    MouseClick( "left", 462, 410 , 1, 2 )

    ;wait for printer selection to appear
    waitwindow( "Print", "Printer" )

    ;Press ok
    ControlClick( "Print", "Printer", "Button10" )

;TEST Wait till processor drops below 40%

    ;Wait for Save As Dialog to appear
    WinWait( "Pdf995 Save As", "" )
	window( "Pdf995 Save As", "" )

    $locale = RegRead( "HKEY_LOCAL_MACHINE\SOFTWARE\ACT\Install",  "Language" )

    ;Send Name to dialog
    ControlFocus( "Pdf995 Save As", "", "Edit1" )
    Send( $print_type&" - x"&$build&" - "&$locale&" - "&$name )
    Sleep( 500 )

    ;Press enter to save the file
    ControlClick( "Pdf995 Save As", "", "Button2", "Left", 2 )
    Sleep( 200 )

    ;Wait for printing dialog to disappear
    $msg = WinWaitClose( "Printing","ACT!", 150 )
    If $msg = 0 Then Msgbox( 0, "Error", "ACT! Printing window has not closed, Script will not Cancel.", 15 )

    ;Give pc some time to finish
    Sleep( 3000 )

EndFunc


Func report( $name, $x, $y, $end )
;-----------------------------------------------------
;Open print dialog, select a report, print and name it
;-----------------------------------------------------
	Local $name, $x, $y, $end, $cnt, $print_type, $build, $locale, $msg
	
    ;Type of printout
    $print_type = "Report"

    ;Display a traytip indicating current report
    TrayTip( "", $name, 29 )

    ;get build from registry
    $build = build()

    ;Focus to mercury
    window( "ACT!", "" )

    ;Open Print Dialog
    Send( "{CTRLDOWN}p{CTRLUP}" )

    ;Wait for print window to open (75 seconds)
    waittimewindow( "Print", "Preview :", 75 )

    ;Select reports and move to list
    Send( "r{TAB}" )
    Send( "{HOME}" )
    Sleep(500)

    ;Press end if necessary to select correct report, by scrolling down list
    If $end = 1 Then Send(" {END} ")

    ;Select correct report
    MouseClick( "left", $x, $y, 2, 2 )

    ;wait for define filters dialog
    waitwindow( "Define Filters", "General" )
    Sleep(200)

    ;set focus to output selection combo box
    ;ControlFocus( "Define Filters", "General", "WindowsForms10.COMBOBOX.app51" )
    Send( "{TAB}" )

    ;set output to printer
    Send( "{END}{UP}" )
    Sleep(100)

    ;Select 'create report for' depending on input from user
    ;Select
    ;    Case $output = 1
    ;        ;Set output to Current Contact
    ;        Send( "{ALTDOWN}c{ALTUP}" )
    ;
    ;    Case $output = 2
    ;        ;Set output to Current Lookup
    ;        Send( "{ALTDOWN}l{ALTUP}" )        
    ;
    ;    Case $output = 3
    ;        ;Set output to All Contacts 
    ;        Send( "{ALTDOWN}a{ALTUP}" )
    ;
    ;    Case Else
    ;            ;Do nothing, leave as currently set
    ;EndSelect
    ;Sleep(200)

    ;Set exclude current user "WindowsForms10.BUTTON.app35" to:
    ;Always on
    ;ControlCommand( "Define Filters", "General", "WindowsForms10.BUTTON.app35", "Check", "" )

    ;Always off
    ;ControlCommand( "Define Filters", "General", "WindowsForms10.BUTTON.app35", "UnCheck", "" )


    ;Press Ok in define filters dialog
    waitwindow( "Define Filters", "General" )
    MouseClick( "left", 462, 410 , 1, 2 )

    ;wait for printer selection to appear
    waitwindow( "Print", "Printer" )

    ;Press ok
    ControlClick( "Print", "Printer", "Button10" )

    ;Wait till Printing Act window appears
    ;$s = WinWaitActive ( "Printing", "ACT!", 60 )
    ;If $s = 0 Then MsgBox(262144, "Window not found" ,"Printing - ACT!", 15 )

    ;ask user to press ok when save as dialog appeared
    ;msgbox( 262144, "Printing Reports", "Press Ok when the PDF Save As dialog has appeared." )

    ;Wait for Save As Dialog to appear
    waitwindow( "Pdf995 Save As", "" )

    $locale = RegRead( "HKEY_LOCAL_MACHINE\SOFTWARE\ACT\Install",  "Language" )

    ;Send Name to dialog
    ControlFocus( "Pdf995 Save As", "", "Edit1" )
    Send( $print_type&" - x"&$build&" - "&$locale&" - "&$name )
    Sleep( 500 )

    ;Press enter to save the file
    ControlClick( "Pdf995 Save As", "", "Button2", "Left", 2 )
    Sleep( 200 )

    ;If dialog still exists press ok again
    ;If WinExists( "Pdf995 Save As", "") ThenControlClick( "Pdf995 Save As", "Save", "Button2", "Left", 1)


    ;ask user when it is ok to continue
    ;msgbox( 262144, "Printing Reports", "Press Ok to print the next report." )

    ;Wait for printing dialog to disappear
    $msg = WinWaitClose( "Printing","ACT!", 150 )
    If $msg = 0 Then Msgbox( 0, "Error", "ACT! Printing window has not closed, Script will not Cancel.", 15 )

    ;Give pc some time to finish
    Sleep( 3000 )

EndFunc


Func frenchreport( $name, $x, $y, $end )
;-----------------------------------------------------
;Open print dialog, select a report, print and name it
;-----------------------------------------------------
	Local $name, $x, $y, $end, $cnt, $print_type, $build, $locale, $msg
	
    ;Type of printout
    $type_value = "Report"

    ;Display a traytip indicating current report
    TrayTip( "", $name, 29 )

    ;get build from registry
    $build = build()

    ;Focus to mercury
    window( "ACT!", "" )

    ;Open Print Dialog
    Send( "{CTRLDOWN}p{CTRLUP}" )

    ;Wait for print window to open (75 seconds)
    waittimewindow( "Print", "Preview :", 75 )

    ;Select reports and move to list
    Send( "r{TAB}" )
    Send( "{HOME}" )
    Sleep(500)

    ;Press end if necessary to select correct report, by scrolling down list
    If $end = 1 Then Send(" {END} ")

    ;Select correct report
    MouseClick( "left", $x, $y, 2, 2 )

    ;wait for define filters dialog
    waitwindow( "Define Filters", "General" )
    Sleep(200)

    ;set focus to output selection combo box
    ;ControlFocus( "Define Filters", "General", "WindowsForms10.COMBOBOX.app51" )
    Send( "{TAB}" )

    ;set output to printer
    Send( "{END}{UP}" )
    Sleep(100)

    ;Select 'create report for' depending on input from user
    ;Select
    ;    Case $output = 1
    ;        ;Set output to Current Contact
    ;        Send( "{ALTDOWN}c{ALTUP}" )
    ;
    ;    Case $output = 2
    ;        ;Set output to Current Lookup
    ;        Send( "{ALTDOWN}l{ALTUP}" )        
    ;
    ;    Case $output = 3
    ;        ;Set output to All Contacts 
    ;        Send( "{ALTDOWN}a{ALTUP}" )
    ;
    ;    Case Else
    ;            ;Do nothing, leave as currently set
    ;EndSelect
    ;Sleep(200)

    ;Set exclude current user "WindowsForms10.BUTTON.app35" to:
    ;Always on
    ;ControlCommand( "Define Filters", "General", "WindowsForms10.BUTTON.app35", "Check", "" )

    ;Always off
    ;ControlCommand( "Define Filters", "General", "WindowsForms10.BUTTON.app35", "UnCheck", "" )


    ;Press Ok in define filters dialog
    waitwindow( "Define Filters", "General" )
    MouseClick( "left", 462, 410 , 1, 2 )

    ;wait for printer selection to appear
    waitwindow( "Print", "Printer" )

    ;Press ok
    ControlClick( "Print", "Printer", "Button10" )

    ;Wait till Printing Act window appears
    ;$s = WinWaitActive ( "Printing", "ACT!", 60 )
    ;If $s = 0 Then MsgBox(262144, "Window not found" ,"Printing - ACT!", 15 )

    ;ask user to press ok when save as dialog appeared
    ;msgbox( 262144, "Printing Reports", "Press Ok when the PDF Save As dialog has appeared." )

    ;Wait for Save As Dialog to appear
    waitwindow( "Pdf995 Save As", "" )

    $locale = RegRead( "HKEY_LOCAL_MACHINE\SOFTWARE\ACT\Install",  "Language" )

    ;Send Name to dialog
    ControlFocus( "Pdf995 Save As", "", "Edit1" )
    Send( $type_value&" - x"&$build&" - "&$locale&" - "&$name )
    Sleep( 500 )

    ;Press enter to save the file
    ControlClick( "Pdf995 Save As", "", "Button2", "Left", 2 )
    Sleep( 200 )

    ;If dialog still exists press ok again
    ;If WinExists( "Pdf995 Save As", "") ThenControlClick( "Pdf995 Save As", "Save", "Button2", "Left", 1)


    ;ask user when it is ok to continue
    ;msgbox( 262144, "Printing Reports", "Press Ok to print the next report." )

    ;Wait for printing dialog to disappear
    $msg = WinWaitClose( "Printing","ACT!", 150 )
    If $msg = 0 Then Msgbox( 0, "Error", "ACT! Printing window has not closed, Script will not Cancel.", 15 )

    ;Give pc some time to finish
    Sleep( 3000 )

EndFunc


Func time( $time1, $time2 )
;---------------------------------------------------------------------------------------------------------------------------
;Compare time values from FileGetTime and returns, 1 if first one is newer, 2 if second is newer and 0 if they are identical 
;---------------------------------------------------------------------------------------------------------------------------
;The array is a single dimension array containing six elements:
;$array[0] = year (four digits)
;$array[1] = month (range 01 - 12)
;$array[2] = day (range 01 - 31)
;$array[3] = hour (range 00 - 23)
;$array[4] = min (range 00 - 59)
;$array[5] = sec (range 00 - 59)
;Notice: the return values are zero-padded.
Local $result

;compare year
If $time1[0] = $time2[0] Then
    
    ;compare month
    If $time1[1] = $time2[1] Then

        ;compare day
        If $time1[2] = $time2[2] Then
            
            ;compare hour
            If $time1[3] = $time2[3] Then
         
                ;compare min
                If $time1[4] = $time2[4] Then        
            
                    ;compare sec       
                    If $time1[5] = $time2[5] Then   
                        ;files are identical
                        $result = 0
                    Else
                        If $time1[5] > $time2[5] Then   
                            $result = 1
                        Else
                            $result = 2
                        EndIf 
                    EndIf ;End compare sec
                Else
                    If $time1[4] > $time2[4] Then   
                        $result = 1
                    Else
                        $result = 2
                    EndIf 
                EndIf ;End compare min
            Else
                If $time1[3] > $time2[3] Then   
                    $result = 1
                Else
                    $result = 2
                EndIf 
            EndIf ;End compare hour
        Else
            If $time1[2] > $time2[2] Then   
                $result = 1
            Else
                $result = 2
            EndIf
        EndIf ;End compare day
    Else
        If $time1[1] > $time2[1] Then   
            $result = 1
        Else
            $result = 2
        EndIf
    EndIf ;End compare month
Else
    ;Determine which is newer
    If $time1[0] > $time2[0] Then
        $result = 1
    Else
        $result = 2
    EndIf
EndIF ;End compare year

Return $result

EndFunc


Func closepdf ()
;--------------------------------------
;Is Close PDF995 Running? If not run it
;--------------------------------------
;~ 	Opt("WinTitleMatchMode", 1)
	
	If WinExists( "Close PDF995" ) Then
	;    msgbox(0, "Does exist", "ClosePDF exists.")
	Else 
	;    msgbox(0, "Does not exist", "ClosePDF does not exist.")
		Run( "ClosePDF995.exe", @ScriptDir, @SW_MINIMIZE )
	EndIf

EndFunc


#cs commented out 2-11-05 Func area()
;-----------------------------------------------------
;Prompt user for area, and set steps according to area
;-----------------------------------------------------

$areavar = InputBox( "Enter Area", "Enter the number that corresponds to the desired area: "&@CRLF&" 1  -E-mail "&@CRLF&" 2  -Installation "&@CRLF&" 3  -Printing-Calendars "&@CRLF&" 4  -Printing-Centralized UI "&@CRLF&" 5  -Printing-Envelopes & Labels "&@CRLF&" 6  -Printing-Quick Printing Calendars "&@CRLF&" 7  -Printing-Quick Printing Company View "&@CRLF&" 8  -Printing-Quick Printing Contact Detail "&@CRLF&" 9  -Printing-Quick Printing Contact List View "&@CRLF&"10  -Printing-Quick Printing Group Views "&@CRLF&"11  -Printing-Quick Printing Task List View "&@CRLF&"12  -Printing-Reporting "&@CRLF&"13  -Report Designer "&@CRLF&"14  -Reporting Component (3rd Party) "&@CRLF&"15  -Reports, Templates, Layouts, etc. "&@CRLF&"16  -International English","","","301","335","300","300" )

;Check for errors or cancel
IF @error Then Exit
    
;set the area depending on the selected area 
Select
    Case $areavar = 1
        ;Set the area to E-mail
        $areadata = "E-mail"
    Case $areavar = 2
        ;Set the area to Printing - Address Book
        $areadata = "Installation"
    Case $areavar = 3
        ;Set the area to Printing - Calendars
        $areadata = "Printing-Calendars"
    Case $areavar = 4
        ;Set the area to Printing - Centralized UI
        $areadata = "Printing-Centralized UI"
    Case $areavar = 5
        ;Set the area to Printing - Envelopes/Labels
        $areadata = "Printing-Envelopes & Labels"
    Case $areavar = 6
        ;Set the area to Printing-Quick Printing Calendars
        $areadata = "Printing-Quick Printing Calendars"
    Case $areavar = 7
        ;Set the area to Printing-Quick Printing Company View 
        $areadata = "Printing-Quick Printing Company View"                           
    Case $areavar = 8
        ;Set the area to Printing-Quick Printing Contact Detail
        $areadata = "Printing-Quick Printing Contact Detail"  
    Case $areavar = 9
        ;Set the area to Printing-Quick Printing Contact List View
        $areadata = "Printing-Quick Printing Contact List View"  
    Case $areavar = 10
        ;Set the area to Printing-Quick Printing Group Views
        $areadata = "Printing-Quick Printing Group Views"  
    Case $areavar = 11
        ;Set the area to Printing-Quick Printing Task List View
        $areadata = "Printing-Quick Printing Task List View"    
    Case $areavar = 12
        ;Set the area to Printing-Reporting
        $areadata = "Printing-Reporting"   
    Case $areavar = 13
        ;Set the area to Report Designer
        $areadata = "Report Designer" 
    Case $areavar = 14
        ;Set the area to Reporting Component (3rd party)
        $areadata = "Reporting Component (3rd party)" 
    Case $areavar = 15
        ;Set the area to Reports
        $areadata = "Reports" 
    Case $areavar = 16
        ;Set the area to International English
        $areadata = "International English" 
    Case Else
        MsgBox( 0, "", "Invalid area was selected" )
    $areadata = "INVALIDAREA"
    EXIT
EndSelect

;Add Different Steps Depending on Area
Select
    Case $areavar = 1
        ;Set the area to E-mail
        $stepslist = "1. Open Mercury {ENTER}2. Setup E-mail {ENTER}"
    Case $areavar = 2
        ;Set the area to Install
        $stepslist = "1. Setup Mercury {ENTER}"       
    Case $areavar = 3
        ;Set the area to Printing - Calendars
        $stepslist = "1. Open Mercury {ENTER}2. Press Ctrl {+} P {ENTER}3. Click {ENTER}4. {ENTER}"
    Case $areavar = 4
        ;Set the area to Printing - Centralized UI
        $stepslist = "1. Open Mercury {ENTER}2. Press Ctrl {+} P {ENTER}3. {ENTER}" 
    Case $areavar = 5
        ;Set the area to Printing - Envelopes/Labels
        $stepslist = "1. Open Mercury {ENTER}2. Press Ctrl {+} P {ENTER}3. Click {ENTER}4. {ENTER}" 
    Case $areavar = 6
        ;Set the area to Printing-Quick Printing Calendars
        $stepslist = "1. Open Mercury {ENTER}2. {ENTER}" 
    Case $areavar = 7
        ;Set the area to Printing-Quick Printing Company View 
        $stepslist = "1. Open Mercury {ENTER}2. Click {ENTER}"               
    Case $areavar = 8
        ;Set the area to Printing-Quick Printing Contact Detail
        $stepslist = "1. Open Mercury {ENTER}2. Click Contact Detail {ENTER} 3. {ENTER}"        
    Case $areavar = 9
        ;Set the area to Printing-Quick Printing Contact List View
        $stepslist = "1. Open Mercury {ENTER}2. Click Contact List View {ENTER}3. {ENTER}"        
    Case $areavar = 10
        ;Set the area to Printing-Quick Printing Group Views
        $stepslist = "1. Open Mercury {ENTER}2. Click {ENTER}"         
    Case $areavar = 11
        ;Set the area to Printing-Quick Printing Task List View
        $stepslist = "1. Open Mercury {ENTER}2. Click Task List View {ENTER}3. {ENTER}"            
    Case $areavar = 12
        ;Set the area to Printing-Reporting
        $stepslist = "1. Open Mercury {ENTER}2. Press Ctrl {+} P {ENTER}3. Click Reports {ENTER}4. {ENTER}" 
    Case $areavar = 13
        ;Set the area to Report Designer
        $stepslist = "1. Open Mercury {ENTER}2. Open Report Designer{ENTER}" 
    Case $areavar = 14
        ;Set the area to Reporting Component (3rd party)
        $stepslist = "1. Open Mercury {ENTER}2. {ENTER}" 
    Case $areavar = 15
        ;Set the area to Reports
        $stepslist = "1. Open Mercury {ENTER}2. Press Ctrl {+} P {ENTER}3. Click Reports {ENTER}4. Press " 
    Case $areavar = 16
        ;Set the area to International English
        $stepslist = "1. Open Mercury {ENTER}2. Press Ctrl {+} P {ENTER}" 
    Case Else
        MsgBox( 262144, "ERROR", "Area was not valid" )
EndSelect

EndFunc

#CE


#cs
Func iniarea( )
;---------------------------------------------------------------------------------------------------
;Prompt user for area, and set steps according to area, reading the areas and steps from an ini file
;---------------------------------------------------------------------------------------------------

;Setup path for ini file, uses script name
$inifile = @ScriptFullPath
$inifile = StringTrimRight( $inifile, 4 )
$inifile = $inifile&".ini"

;Setup path for ini file, uses script name, and places script into My Documents folder
;$inifile = @ScriptName
;$inifile = StringTrimRight( $inifile, 4 )
;$inifile = @MyDocumentsDir&"\"&$inifile&".ini"

;Does file exist
If FileExists( $inifile ) Then
    ;Declare variables
    $cnt = 1
    $list = 1
    
    ;Read in the areas from the ini file
    $areadata = IniRead( $inifile, "Area&Steps", $cnt, "0" )
    
    Do
        
        $arealst = $arealst&$list&" -"&$areadata&"~"
        
        ;Increment area count
    $cnt = $cnt + 2
        $list = $list + 1
        
        ;Read next value preparing for Loop test
        $areadata = IniRead( $inifile, "Area&Steps", $cnt, "0" )
        
    Until $areadata = "0"

Else
    ;Notify the user that the file does not exist and 
    ;That it will be created and populated with example data
    MsgBox( 262144, "ERROR", "The config file does not exist."&@CRLF& "It will be created and populated with example info."&@CRLF&"The file will be created in the same location as this program."&@CRLF&@CRLF&"Please open it and make any necessary changes." )
    If @Error Then Exit
    
    ;Create the user config file
    FileWriteLine( $inifile, '[USER]' ) 
    FileWriteLine( $inifile, 'Name=Justin Taylor' ) 
    FileWriteLine( $inifile, '[PROJECT]' )     
    FileWriteLine( $inifile, 'Proj=ACT!' )    
    FileWriteLine( $inifile, '[SEVERITY]' )     
    FileWriteLine( $inifile, 'Sev=Severity 2' )     
    FileWriteLine( $inifile, '[RESOLUTION]' )     
    FileWriteLine( $inifile, 'Res=Scrub' ) 
    FileWriteLine( $inifile, '[ASSIGNMENT]' )     
    FileWriteLine( $inifile, 'Assign=Scrub Team' ) 
    FileWriteLine( $inifile, '[VERSION]' )     
    FileWriteLine( $inifile, 'Ver=Version Found minus build number' ) 
    FileWriteLine( $inifile, '[AREA&STEPS]' ) 
    FileWriteLine( $inifile, '1=Report Designer' ) 
    FileWriteLine( $inifile, '2=1. Open Mercury {ENTER}2. Open the Report Designer {ENTER 2}' ) 
    FileWriteLine( $inifile, '3=Printing' ) 
    FileWriteLine( $inifile, '4=1. Open Mercury {ENTER}2. Press Ctrl + P  {ENTER 2}' )
    
    ;Exit the script
    Exit
    
EndIf

$arealst = StringReplace($arealst, "~", @CRLF )

$areavar = InputBox( "Enter Area", "Enter the number that corresponds to the desired area: "&$arealst,"","","301","335","400","250" )
;Check for errors or cancel
IF @error Then Exit


$num = $areavar + $areavar - 1
    
;Set the area depending on the selected area 
$areadata = IniRead( $inifile, "Area&Steps", $num, "Help" )
    

;Add Different Steps Depending on Area
$sl = IniRead( $inifile, "Area&Steps", $num+1, "1. {ENTER}2. {ENTER 2}" )

$stepslist = checkstring( $sl )

EndFunc
#ce


Func closedefect()
;-----------------------------------------------------
;Close the currently open defect and open the next one
;-----------------------------------------------------
	window( "Support", "" )
	
	Send( "{CTRLDOWN}{F4}{CTRLUP}" )
	
	While 4
		
		Select
			Case WinExists( "Confirm", "" )
				;Press Enter to save changes
				window( "Confirm", "" )  
				Sleep( 100 )
				Send( "{ENTER}" )
				
				;Wait to see if an error appears
				Sleep( 750 )
				
				;Check for SalesLogix Error
				If WinExists ( "SalesLogix Error", "" ) Then
					window( "SalesLogix Error", "" ) 
					Send ( "{ENTER}" )
				EndIf
				
				ExitLoop
			Case WinExists( "Support - [Defect List View", "" ) 
				
				ExitLoop	
		EndSelect
		Sleep( 100 )
	WEnd

	
	;Wait till the defect list view is active again
	waitwindow( "Support - [Defect List View", "" ) 
	
	
	Send( "{DOWN}{ENTER}" ) ;Open the next defect
	;Sleep( 500 )

EndFunc


Func closedefectoption( $option )
;---------------------------------------------------------------------
;Close the currently open defect and If $option = 1, open the next one
;---------------------------------------------------------------------
	Local $option 
	
	Send( "{CTRLDOWN}{F4}{CTRLUP}" )
	
	Sleep(350)
	
	If WinExists( "Confirm", "" ) Then
		;Press Enter to save changes
		window( "Confirm", "" )  
		Sleep( 100 )
		Send( "{ENTER}" )
		
		;Wait 1/2 a sec to see if an error appears
		Sleep( 600 )
		
		;Check for SalesLogix Error
		If WinExists ( "SalesLogix Error", "") Then
			window( "SalesLogix Error", "") 
			Send ( "{ENTER}")
		EndIf
		
	Else
	
	EndIf
	
	
	If $option = 1 Then
		;Wait till the defect list view is active again
		waitwindow( "Support - [Defect List View", "" ) 
		
		Send( "{DOWN}{ENTER}" ) ;Open the next defect
		
	EndIf

EndFunc

#cs
Func priority()
;----------------------------------------------------------------------
;Verify that the priority is correct, focus should be in priority field
;----------------------------------------------------------------------
	Local $def_priority 
	
	;Default priority
	$def_priority = "RC" 
	
	;send generic value to clipboard, to overwrite what may already be there
	Clipput( "z" )
	Sleep( 200 )
	
	
	;Copy to the clipboard the current contents of the priority field
	Send( "{CTRLDOWN}c{CTRLUP}" ) 
	SLEEP( 200 )
	
	
	;Copy the clipboard to clip variable
	$clip = ClipGet()
		
	
	;Set the priority according to currently allowable priorities
	Select
		Case $clip = "N/A"         ;Not currently being used
				;Send( ""& $def_priority& "" )
				MsgBox(262192,"Priority Error","The Priority is not correctly set. " & @CRLF & "" & @CRLF & "Press ok when it has been set.")
		Case $clip = "1-High"      ;Set correctly leave alone
		Case $clip = "2-Medium"    ;Set correctly leave alone
		Case $clip = "3-Low"       ;Set correctly leave alone
		Case $clip = "0-Red Alert" ;Set correctly leave alone
		Case $clip = "IT"          ;Not currently being used
				;Send( ""& $def_priority& "" )
				MsgBox(262192,"Priority Error","The Priority is not correctly set. " & @CRLF & "" & @CRLF & "Press ok when it has been set.")
		Case $clip = "ET"          ;Not currently being used
				;Send( ""& $def_priority& "" )
				MsgBox(262192,"Priority Error","The Priority is not correctly set. " & @CRLF & "" & @CRLF & "Press ok when it has been set.")
		Case $clip = "ET2"         ;Not currently being used
				;Send( ""& $def_priority& "" )  
				MsgBox(262192,"Priority Error","The Priority is not correctly set. " & @CRLF & "" & @CRLF & "Press ok when it has been set.")
		Case $clip = "RC"          ;Not currently being used
				MsgBox(262192,"Priority Error","The Priority is not correctly set. " & @CRLF & "" & @CRLF & "Press ok when it has been set.")
		Case $clip = "Tier 1"      ;Not currently being used
				;Send( ""& $def_priority& "" )    
				MsgBox(262192,"Priority Error","The Priority is not correctly set. " & @CRLF & "" & @CRLF & "Press ok when it has been set.")
		Case $clip = "Tier 2"      ;Not currently being used
				;Send( ""& $def_priority& "" )
				MsgBox(262192,"Priority Error","The Priority is not correctly set. " & @CRLF & "" & @CRLF & "Press ok when it has been set.")
		Case $clip = "Tier 3"      ;Not currently being used
				;Send( ""& $def_priority& "" )
				MsgBox(262192,"Priority Error","The Priority is not correctly set. " & @CRLF & "" & @CRLF & "Press ok when it has been set.")
		Case $clip = "1-Hit List"  ;Not currently being used
				MsgBox(262192,"Priority Error","The Priority is not correctly set. " & @CRLF & "" & @CRLF & "Press ok when it has been set.")
		Case $clip = "z"           ;priority was blank
				;Send( ""& $def_priority& "" )
				MsgBox(262192,"Priority Error","The Priority is not correctly set. " & @CRLF & "" & @CRLF & "Press ok when it has been set.")
		Case Else 
				;Leave alone if priority doesn't fall into one of these categories
	EndSelect

EndFunc
#ce

Func defectupdate( $scrubdate, $scrubtime )
;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
; Verifies if the defect has been updated since the scrub report was run ;returns, 1 if defect hasn't been updated, 2 if defect has been updated, and 0 if they are identical 
;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    Local $scrubdate, $scrubtime, $text, $loop, $location, $update, $defectdate, $defecttime, $defectAMPM, $scrubAMPM
	
	;ALSO CHECK THE ASSIGNED DATE??????????
	
	;Define array variables
	DIM $defectarray[6], $scrubarray[6]
	
	;DATE AND TIME OF SCRUB COME FROM PARENT SCRIPT, VARIABLES MAY NEED TO BE PASSED.
;~ 	$scrubdate = "4/25/2005"
;~ 	$scrubtime = "1:50:31 PM"

	#region ---Use Copy Command---
;~ 		;Clear any existing data in the clipboard
;~ 		ClipPut( "" )
;~ 		Sleep( 250 )
;~ 		
;~ 		;Focus to Defect Resolution field
;~ 		ControlFocus( "Support", "", $defectresolution )
;~ 		
;~ 		;Select and copy the entire line
;~ 		Send( "{CTRLDOWN}{HOME}{CTRLUP}{END}{SHIFTDOWN}{CTRLDOWN}{LEFT 3}{SHIFTUP}c{CTRLUP}" )
;~ 		Sleep( 250 )
;~ 		
;~ 		;Copy the line out of the clipboard
;~ 		$defectline = ClipGet()
;~ 		Sleep( 250 ) 
	#endregion ---Use Copy Command---

	#region ---Use ControlGetText---
		$text = ControlGetText( "Support", "", $defectresolution )
		$text_2 = StringSplit( $text, @CR )
		$defectline = $text_2[1]
		
	#endregion ---Use ControlGetText---
	;Parse line for date and time, break into seperate variables breaking on space
	$defectdatetimearray = StringSplit ( $defectLine, " " )

	;Prepare loop variable
	$loop = 1
	
	;Find out which array element contains the AM or PM
	While $loop <= $defectdatetimearray[0]
		;Search for AM and PM, and setup a variable if it's not found
		Select
			Case $defectdatetimearray[$loop] = "AM" 
				$location = $loop
				;msgbox( 262144, "Contents of array # "&$loop, "'"&$defectarray[$loop]&"'" )
				;Exit the loop on sucess
				ExitLoop
			Case $defectdatetimearray[$loop] = "PM"
				$location = $loop
				;msgbox( 262144, "Contents of array # "&$loop, "'"&$defectarray[$loop]&"'" )
				;Exit the loop on sucess
				ExitLoop
			Case Else
				$location = -1
		EndSelect
		$loop = $loop + 1
	WEnd
	
	If $location = -1 Then 
		;Skip the testing section, NO DATA EXISTED IN THE DEFECT RESOLUTION FIELD
		;msgbox(262144, "Notice", "AM or PM not found in defect." )
		$update = 1
	Else
		;Setup the date time and am/pm variables 
		$defectdate = $defectdatetimearray[$location-2]
		$defecttime = $defectdatetimearray[$location-1]
		$defectAMPM = $defectdatetimearray[$location]
		
		;Break date elements into sections
		$Ddate = StringSplit( $defectdate, "/" )
		If @Error Then $Ddate = StringSplit( $defectdate, "." )
		$Sdate = StringSplit( $scrubdate, "/" )
		If @Error Then $Sdate = StringSplit( $scrubdate, "." )
		
		
		;Break time elements into sections
		$Dtime = StringSplit( $defecttime, ":" )
		$Stime = StringSplit( $scrubtime, ":" )
		$Sbreak = StringSplit( $Stime[3], " " );break off the am/pm from the last array variable
		$scrubAMPM = $Sbreak[2] 
		$Stime[3] = $Sbreak[1]
		
		;Convert hour to 24 hour value and load it
		;Convert PM values that aren't 12, by adding 12 to current value
		;Convert AM values that are 12 to 0
		Select
			Case $defectAMPM = "PM" AND $Dtime[1] <> 12 
				$defectarray[3] = $Dtime[1] + 12
				;msgbox( 262144, $defectarray[3], "1" )
				
			Case $defectAMPM = "AM" AND $Dtime[1] = 12 
				$defectarray[3] = $Dtime[1] - 12
				;msgbox( 262144, $defectarray[3], "2" )
				
			Case Else    
				$defectarray[3] = $Dtime[1]
				;msgbox( 262144, $defectarray[3], "3" )
		EndSelect
		
		Select
			Case $scrubAMPM = "PM" AND $Stime[1] <> 12 
				$scrubarray[3] = $Stime[1] + 12
				;msgbox( 262144, $scrubarray[3], "4" )
			
			Case $scrubAMPM = "AM" AND $Stime[1] = 12 
				$scrubarray[3] = $Stime[1] - 12
				;msgbox( 262144, $scrubarray[3], "5" )
		
			Case Else
				$scrubarray[3] = $Stime[1]
				;msgbox( 262144, $scrubarray[3], "6" )
		EndSelect
		
		;populate the arrays that will be sent to the time fcn with appropriate data
		;load year
		$defectarray[0] = $Ddate[3]
		$scrubarray[0] = $Sdate[3]
		
		;load month
		$defectarray[1] = $Ddate[1]
		$scrubarray[1] = $Sdate[1]
		
		;load day
		$defectarray[2] = $Ddate[2]
		$scrubarray[2] = $Sdate[2]
		
		;load minute
		$defectarray[4] = $Dtime[2]
		$scrubarray[4] = $Stime[2]
		
		;load second
		$defectarray[5] = $Dtime[3]
		$scrubarray[5] = $Stime[3]
		
		;Convert all values to  numbers
		$defectarray[0] = Number( $defectarray[0] )
		$defectarray[1] = Number( $defectarray[1] )
		$defectarray[2] = Number( $defectarray[2] )
		$defectarray[3] = Number( $defectarray[3] )
		$defectarray[4] = Number( $defectarray[4] )
		$defectarray[5] = Number( $defectarray[5] )
		
		$scrubarray[0] = Number( $scrubarray[0] )
		$scrubarray[1] = Number( $scrubarray[1] )
		$scrubarray[2] = Number( $scrubarray[2] )
		$scrubarray[3] = Number( $scrubarray[3] )
		$scrubarray[4] = Number( $scrubarray[4] )
		$scrubarray[5] = Number( $scrubarray[5] )
		
		
		;Test Date, if defect has been updated set $update to 1
		$update = Time( $scrubarray, $defectarray )
		;returns, 1 if defect hasn't been updated, 2 if defect has been updated, and 0 if they are identical 
		
	EndIf
	
;Return update variable
;Returns, 1 if defect hasn't been updated, 2 if defect has been updated, and 0 if they are identical 
Return $update

EndFunc


Func build()
;--------------------------------------------------------------------------
;Get the current build number from the registry, if unable, prompt the user
;--------------------------------------------------------------------------
	Local $version
	
	$version = RegRead( "HKEY_LOCAL_MACHINE\SOFTWARE\ACT\Act7Updater",  "LastAppliedUpdateVersion" )
	If @error Then $version = RegRead( "HKEY_LOCAL_MACHINE\SOFTWARE\ACT\ActUpdater",  "LastAppliedUpdateVersion" )
	IF @error Then 
		;MSGBOX(4096, "Error", "Unable to read the specified registry key.") 
		$version = InputBox( "Build Number", "Please enter the current build number, the registry was blank. Do not add the 'x'." )
	Else
		;Remove extra data from registry entry
		$version = StringTrimLeft( $version, 4 )
		$version = StringTrimRight( $version, 2 )
	EndIf
	
	Return $version

EndFunc


Func build_noprompt()
;--------------------------------------------------------------------------------------
;Get the current build number from the registry, if it doesn't exist returns 0 if fails
;--------------------------------------------------------------------------------------
	Local $version 
	$version = RegRead( "HKEY_LOCAL_MACHINE\SOFTWARE\ACT\Act7Updater",  "LastAppliedUpdateVersion" )
	IF @Error Then
		$version = RegRead( "HKEY_LOCAL_MACHINE\SOFTWARE\ACT\ActUpdater",  "LastAppliedUpdateVersion" )
		IF @error Then 
			;MSGBOX(4096, "Error", "Unable to read the specified registry key.") 
			Return 0
		Else
			;Remove extra data from registry entry
			$version = StringTrimLeft( $version, 4 )
			$version = StringTrimRight( $version, 2 )
			
			Return $version
		EndIf
	Else
		;Remove extra data from registry entry
			$version = StringTrimLeft( $version, 4 )
			$version = StringTrimRight( $version, 2 )
			
			Return $version
	EndIf

EndFunc


Func buildINI( $locale )
;------------------------------------------------------------------------
;Get the current build from the ini file, pass desired locale: US, French
;------------------------------------------------------------------------
	Local $locale, $val
	
	$val = IniRead("\\Jet-shuttle\work\JETSData.ini", $locale, "Build", "default")
		
	Return $val

EndFunc


Func oslocale()
;----------------------------------------------------------
;Retrieve Operating System Locale and convert value to text
;----------------------------------------------------------
	Local $os_lang, $os_lang_text
    ;Credits: Locale Data retrieved from: http://msdn.microsoft.com/library/default.asp?url=/library/en-us/script56/html/vtorioperators.asp

    $os_lang = @OSLang

    Select
        Case $os_lang = "0436"
            ;Afrikaans
            $os_lang_text = "Afrikaans - af"
        Case $os_lang = "041C"
            ;Albanian
            $os_lang_text = "Albanian - sq"
        Case $os_lang = "3801"
            ;Arabic - United Arab Emirates
            $os_lang_text = "Arabic - United Arab Emirates - ar-ae"
        Case $os_lang = "3C01"
            ;Arabic - Bahrain
            $os_lang_text = "Arabic - Bahrain - ar-bh"
        Case $os_lang = "1401"
            ;Arabic - Algeria
            $os_lang_text = "Arabic - Algeria - ar-dz"
        Case $os_lang = "0C01"
            ;Arabic - Egypt
            $os_lang_text = "Arabic - Egypt - ar-eg"
        Case $os_lang = "0801"
            ;Arabic - Iraq
            $os_lang_text = "Arabic - Iraq - ar-iq"
        Case $os_lang = "2C01"
            ;Arabic - Jordan
            $os_lang_text = "Arabic - Jordan - ar-jo"
        Case $os_lang = "3401"
            ;Arabic - Kuwait
            $os_lang_text = "Arabic - Kuwait - ar-kw"
        Case $os_lang = "3001"
            ;Arabic - Lebanon
            $os_lang_text = "Arabic - Lebanon - ar-lb"
        Case $os_lang = "1001"
            ;Arabic - Libya
            $os_lang_text = "Arabic - Libya - ar-ly"
        Case $os_lang = "1801"
            ;Arabic - Morocco
            $os_lang_text = "Arabic - Morocco - ar-ma"
        Case $os_lang = "2001"
            ;Arabic - Oman
            $os_lang_text = "Arabic - Oman - ar-om"
        Case $os_lang = "4001"
            ;Arabic - Qatar
            $os_lang_text = "Arabic - Qatar - ar-qa"
        Case $os_lang = "0401"
            ;Arabic - Saudi Arabia
            $os_lang_text = "Arabic - Saudi Arabia - ar-sa"
        Case $os_lang = "2801"
            ;Arabic - Syria
            $os_lang_text = "Arabic - Syria - ar-sy"
        Case $os_lang = "1C01"
            ;Arabic - Tunisia
            $os_lang_text = "Arabic - Tunisia - ar-tn"
        Case $os_lang = "2401"
            ;Arabic - Yemen
            $os_lang_text = "Arabic - Yemen - ar-ye"
        Case $os_lang = "042B"
            ;Armenian
            $os_lang_text = "Armenian - hy"
        Case $os_lang = "042C"
            ;Azeri - Latin
            $os_lang_text = "Azeri - Latin - az-az"
        Case $os_lang = "082C"
            ;Azeri - Cyrillic
            $os_lang_text = "Azeri - Cyrillic - az-az"
        Case $os_lang = "042D"
            ;Basque
            $os_lang_text = "Basque - eu"
        Case $os_lang = "0423"
            ;Belarusian
            $os_lang_text = "Belarusian - be"
        Case $os_lang = "0402"
            ;Bulgarian
            $os_lang_text = "Bulgarian - bg"
        Case $os_lang = "0403"
            ;Catalan
            $os_lang_text = "Catalan - ca"
        Case $os_lang = "0804"
            ;Chinese - China
            $os_lang_text = "Chinese - China - zh-cn"
        Case $os_lang = "0C04"
            ;Chinese - Hong Kong SAR
            $os_lang_text = "Chinese - Hong Kong SAR - zh-hk"
        Case $os_lang = "1404"
            ;Chinese - Macau SAR
            $os_lang_text = "Chinese - Macau SAR - zh-mo"
        Case $os_lang = "1004"
            ;Chinese - Singapore
            $os_lang_text = "Chinese - Singapore - zh-sg"
        Case $os_lang = "0404"
            ;Chinese - Taiwan
            $os_lang_text = "Chinese - Taiwan - zh-tw"
        Case $os_lang = "041A"
            ;Croatian
            $os_lang_text = "Croatian - hr"
        Case $os_lang = "0405"
            ;Czech
            $os_lang_text = "Czech - cs"
        Case $os_lang = "0406"
            ;Danish
            $os_lang_text = "Danish - da"
        Case $os_lang = "0413"
            ;Dutch - The Netherlands
            $os_lang_text = "Dutch - The Netherlands - nl-nl"
        Case $os_lang = "0813"
            ;Dutch - Belgium
            $os_lang_text = "Dutch - Belgium - nl-be"
        Case $os_lang = "0C09"
            ;English - Australia
            $os_lang_text = "English - Australia - en-au"
        Case $os_lang = "2809"
            ;English - Belize
            $os_lang_text = "English - Belize - en-bz"
        Case $os_lang = "1009"
            ;English - Canada
            $os_lang_text = "English - Canada - en-ca"
        Case $os_lang = "2409"
            ;English - Caribbean
            $os_lang_text = "English - Caribbean - en-cb"
        Case $os_lang = "1809"
            ;English - Ireland
            $os_lang_text = "English - Ireland - en-ie"
        Case $os_lang = "2009"
            ;English - Jamaica
            $os_lang_text = "English - Jamaica - en-jm"
        Case $os_lang = "1409"
            ;English - New Zealand
            $os_lang_text = "English - New Zealand - en-nz"
        Case $os_lang = "3409"
            ;English - Phillippines
            $os_lang_text = "English - Phillippines - en-ph"
        Case $os_lang = "1C09"
            ;English - South Africa
            $os_lang_text = "English - South Africa - en-za"
        Case $os_lang = "2C09"
            ;English - Trinidad
            $os_lang_text = "English - Trinidad - en-tt"
        Case $os_lang = "0809"
            ;English - United Kingdom
            $os_lang_text = "English - United Kingdom - en-gb"
        Case $os_lang = "0409"
            ;English - United States
            $os_lang_text = "English - United States - en-us"
        Case $os_lang = "0425"
            ;Estonian
            $os_lang_text = "Estonian - et"
        Case $os_lang = "0429"
            ;Farsi
            $os_lang_text = "Farsi - fa"
        Case $os_lang = "040B"
            ;Finnish
            $os_lang_text = "Finnish - fi"
        Case $os_lang = "0438"
            ;Faroese
            $os_lang_text = "Faroese - fo"
        Case $os_lang = "040C"
            ;French - France
            $os_lang_text = "French - France - fr-fr"
        Case $os_lang = "080C"
            ;French - Belgium
            $os_lang_text = "French - Belgium - fr-be"
        Case $os_lang = "0C0C"
            ;French - Canada
            $os_lang_text = "French - Canada - fr-ca"
        Case $os_lang = "140C"
            ;French - Luxembourg
            $os_lang_text = "French - Luxembourg - fr-lu"
        Case $os_lang = "100C"
            ;French - Switzerland
            $os_lang_text = "French - Switzerland - fr-ch"
        Case $os_lang = "083C"
            ;Gaelic - Ireland
            $os_lang_text = "Gaelic - Ireland - gd-ie"
        Case $os_lang = "043C"
            ;Gaelic - Scotland
            $os_lang_text = "Gaelic - Scotland - gd"
        Case $os_lang = "0407"
            ;German - Germany
            $os_lang_text = "German - Germany - de-de"
        Case $os_lang = "0C07"
            ;German - Austria
            $os_lang_text = "German - Austria - de-at"
        Case $os_lang = "1407"
            ;German - Liechtenstein
            $os_lang_text = "German - Liechtenstein - de-li"
        Case $os_lang = "1007"
            ;German - Luxembourg
            $os_lang_text = "German - Luxembourg - de-lu"
        Case $os_lang = "0807"
            ;German - Switzerland
            $os_lang_text = "German - Switzerland - de-ch"
        Case $os_lang = "0408"
            ;Greek
            $os_lang_text = "Greek - el"
        Case $os_lang = "040D"
            ;Hebrew
            $os_lang_text = "Hebrew - he"
        Case $os_lang = "0439"
            ;Hindi
            $os_lang_text = "Hindi - hi"
        Case $os_lang = "040E"
            ;Hungarian
            $os_lang_text = "Hungarian - hu"
        Case $os_lang = "040F"
            ;Icelandic
            $os_lang_text = "Icelandic - is"
        Case $os_lang = "0421"
            ;Indonesian
            $os_lang_text = "Indonesian - id"
        Case $os_lang = "0410"
            ;Italian - Italy
            $os_lang_text = "Italian - Italy - it-it"
        Case $os_lang = "0810"
            ;Italian - Switzerland
            $os_lang_text = "Italian - Switzerland - it-ch"
        Case $os_lang = "0411"
            ;Japanese
            $os_lang_text = "Japanese - ja"
        Case $os_lang = "0412"
            ;Korean
            $os_lang_text = "Korean - ko"
        Case $os_lang = "0426"
            ;Latvian
            $os_lang_text = "Latvian - lv"
        Case $os_lang = "0427"
            ;Lithuanian
            $os_lang_text = "Lithuanian - lt"
        Case $os_lang = "042F"
            ;FYRO Macedonian
            $os_lang_text = "FYRO Macedonian - mk"
        Case $os_lang = "043E"
            ;Malay - Malaysia
            $os_lang_text = "Malay - Malaysia - ms-my"
        Case $os_lang = "083E"
            ;Malay - Brunei
            $os_lang_text = "Malay - Brunei - ms-bn"
        Case $os_lang = "043A"
            ;Maltese
            $os_lang_text = "Maltese - mt"
        Case $os_lang = "044E"
            ;Marathi
            $os_lang_text = "Marathi - mr"
        Case $os_lang = "0414"
            ;Norwegian - Bokmål
            $os_lang_text = "Norwegian - Bokmål - no-no"
        Case $os_lang = "0814"
            ;Norwegian - Nynorsk
            $os_lang_text = "Norwegian - Nynorsk - no-no"
        Case $os_lang = "0415"
            ;Polish
            $os_lang_text = "Polish - pl"
        Case $os_lang = "0816"
            ;Portuguese - Portugal
            $os_lang_text = "Portuguese - Portugal - pt-pt"
        Case $os_lang = "0416"
            ;Portuguese - Brazil
            $os_lang_text = "Portuguese - Brazil - pt-br"
        Case $os_lang = "0417"
            ;Raeto-Romance
            $os_lang_text = "Raeto-Romance - rm"
        Case $os_lang = "0418"
            ;Romanian - Romania
            $os_lang_text = "Romanian - Romania - ro"
        Case $os_lang = "0818"
            ;Romanian - Moldova
            $os_lang_text = "Romanian - Moldova - ro-mo"
        Case $os_lang = "0419"
            ;Russian
            $os_lang_text = "Russian - ru"
        Case $os_lang = "0819"
            ;Russian - Moldova
            $os_lang_text = "Russian - Moldova - ru-mo"
        Case $os_lang = "044F"
            ;Sanskrit
            $os_lang_text = "Sanskrit - sa"
        Case $os_lang = "0C1A"
            ;Serbian - Cyrillic
            $os_lang_text = "Serbian - Cyrillic - sr-sp"
        Case $os_lang = "081A"
            ;Serbian - Latin
            $os_lang_text = "Serbian - Latin - sr-sp"
        Case $os_lang = "0432"
            ;Setsuana
            $os_lang_text = "Setsuana - tn"
        Case $os_lang = "0424"
            ;Slovenian
            $os_lang_text = "Slovenian - sl"
        Case $os_lang = "041B"
            ;Slovak
            $os_lang_text = "Slovak - sk"
        Case $os_lang = "042E"
            ;Sorbian
            $os_lang_text = "Sorbian - sb"
        Case $os_lang = "0C0A"
            ;Spanish - Spain
            $os_lang_text = "Spanish - Spain - es-es"
        Case $os_lang = "2C0A"
            ;Spanish - Argentina
            $os_lang_text = "Spanish - Argentina - es-ar"
        Case $os_lang = "400A"
            ;Spanish - Bolivia
            $os_lang_text = "Spanish - Bolivia - es-bo"
        Case $os_lang = "340A"
            ;Spanish - Chile
            $os_lang_text = "Spanish - Chile - es-cl"
        Case $os_lang = "240A"
            ;Spanish - Colombia
            $os_lang_text = "Spanish - Colombia - es-co"
        Case $os_lang = "140A"
            ;Spanish - Costa Rica
            $os_lang_text = "Spanish - Costa Rica - es-cr"
        Case $os_lang = "1C0A"
            ;Spanish - Dominican Republic
            $os_lang_text = "Spanish - Dominican Republic - es-do"
        Case $os_lang = "300A"
            ;Spanish - Ecuador
            $os_lang_text = "Spanish - Ecuador - es-ec"
        Case $os_lang = "100A"
            ;Spanish - Guatemala
            $os_lang_text = "Spanish - Guatemala - es-gt"
        Case $os_lang = "480A"
            ;Spanish - Honduras
            $os_lang_text = "Spanish - Honduras - es-hn"
        Case $os_lang = "080A"
            ;Spanish - Mexico
            $os_lang_text = "Spanish - Mexico - es-mx"
        Case $os_lang = "4C0A"
            ;Spanish - Nicaragua
            $os_lang_text = "Spanish - Nicaragua - es-ni"
        Case $os_lang = "180A"
            ;Spanish - Panama
            $os_lang_text = "Spanish - Panama - es-pa"
        Case $os_lang = "280A"
            ;Spanish - Peru
            $os_lang_text = "Spanish - Peru - es-pe"
        Case $os_lang = "500A"
            ;Spanish - Puerto Rico
            $os_lang_text = "Spanish - Puerto Rico - es-pr"
        Case $os_lang = "3C0A"
            ;Spanish - Paraguay
            $os_lang_text = "Spanish - Paraguay - es-py"
        Case $os_lang = "440A"
            ;Spanish - El Salvador
            $os_lang_text = "Spanish - El Salvador - es-sv"
        Case $os_lang = "380A"
            ;Spanish - Uruguay
            $os_lang_text = "Spanish - Uruguay - es-uy"
        Case $os_lang = "200A"
            ;Spanish - Venezuela
            $os_lang_text = "Spanish - Venezuela - es-ve"
        Case $os_lang = "0430"
            ;Sutu
            $os_lang_text = "Sutu - sx"
        Case $os_lang = "0441"
            ;Swahili
            $os_lang_text = "Swahili - sw"
        Case $os_lang = "041D"
            ;Swedish - Sweden
            $os_lang_text = "Swedish - Sweden - sv-se"
        Case $os_lang = "081D"
            ;Swedish - Finland
            $os_lang_text = "Swedish - Finland - sv-fi"
        Case $os_lang = "0449"
            ;Tamil
            $os_lang_text = "Tamil - ta"
        Case $os_lang = "0444"
            ;Tatar
            $os_lang_text = "Tatar - tt"
        Case $os_lang = "041E"
            ;Thai
            $os_lang_text = "Thai - th"
        Case $os_lang = "041F"
            ;Turkish
            $os_lang_text = "Turkish - tr"
        Case $os_lang = "0431"
            ;Tsonga
            $os_lang_text = "Tsonga - ts"
        Case $os_lang = "0422"
            ;Ukrainian
            $os_lang_text = "Ukrainian - uk"
        Case $os_lang = "0420"
            ;Urdu
            $os_lang_text = "Urdu - ur"
        Case $os_lang = "0843"
            ;Uzbek - Cyrillic
            $os_lang_text = "Uzbek - Cyrillic - uz-uz"
        Case $os_lang = "0443"
            ;Uzbek - Latin
            $os_lang_text = "Uzbek - Latin - uz-uz"
        Case $os_lang = "042A"
            ;Vietnamese
            $os_lang_text = "Vietnamese - vi"
        Case $os_lang = "0434"
            ;Xhosa
            $os_lang_text = "Xhosa - xh"
        Case $os_lang = "043D"
            ;Yiddish
            $os_lang_text = "Yiddish - yi"
        Case $os_lang = "0435"
            ;Zulu
            $os_lang_text = "Zulu - zu"

        Case Else
            $os_lang_text = "Unknown Region"  
    EndSelect  
    
    ;Return $os_lang_text
    Return $os_lang_text
    
EndFunc


Func officever()
;---------------------------------------------
;Retrieve and return installed office versions, works for 2003, .........
;---------------------------------------------
    Local $officemodules, $install, $cnt_ll, $cnt_10, $cnt_9, $cnt_8, $access, $excel, $frontpage, $outlook, $publisher, $pwrpnt, $word
	
	$officemodules = ""
    $install = ""
    
    $cnt_11 = 0
    Do 
        $cnt_11 = $cnt_11 + 1
        $val = RegEnumKey("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\11.0", $cnt_11)
    Until $val = ""
    

    $cnt_10 = 0
    Do 
        $cnt_10 = $cnt_10 + 1
        $val = RegEnumKey("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\10.0", $cnt_10)
    Until $val = ""
    

    $cnt_9 = 0
    Do 
        $cnt_9 = $cnt_11 + 1
        $val = RegEnumKey("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\9.0", $cnt_9)
    Until @error
   

    $cnt_8 = 0
    Do 
        $cnt_8 = $cnt_8 + 1
        $val = RegEnumKey("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\8.0", $cnt_8)
    Until @error
    
    
    Select
        Case $cnt_11 > 3
            $install = "11.0"
            $officemodules = $officemodules & " 2003 - "
        Case $cnt_10 > 4
            $install = "10.0"
            $officemodules = $officemodules & " XP - "
        Case $cnt_9 > 3
            $install = "9.0"
            $officemodules = $officemodules & " 2000 - "
        Case $cnt_8 > 1
            $install = "8.0"
            $officemodules = $officemodules & " 97 - "
        
    EndSelect
    
    
    ;msgbox(262144, "TEST", "11 - " & $cnt_11 & @CRLF & "10 - " & $cnt_10 & @CRLF & "9 - " & $cnt_9 & @CRLF & "8 - " & $cnt_8 )

    ;Idea for testing individual modules may be able to use a variable!!!

    If $install <> "" Then
        $access = RegRead( "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\" & $install & "\Access\InstallRoot", "Path" )
        $excel = RegRead( "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\" & $install & "\Excel\InstallRoot", "Path" )
        $frontpage = RegRead( "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\" & $install & "\Frontpage\InstallRoot", "Path" )
        $outlook = RegRead( "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\" & $install & "\Outlook\InstallRoot", "Path" )
        $publisher = RegRead( "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\" & $install & "\Publisher\InstallRoot", "Path" )
        $pwrpnt = RegRead( "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\" & $install & "\Powerpoint\InstallRoot", "Path" )
        $word = RegRead( "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\" & $install & "\Word\InstallRoot", "Path" )

        If $access <> "" Then $officemodules = $officemodules & " Access,"
        If $excel <> "" Then $officemodules = $officemodules & " Excel,"
        If $frontpage <> "" Then $officemodules = $officemodules & " Frontpage,"
        If $outlook <> "" Then $officemodules = $officemodules & " Outlook,"
        If $publisher <> "" Then $officemodules = $officemodules & " Publisher,"
        If $pwrpnt <> "" Then $officemodules = $officemodules & " Powerpoint,"
        If $word <> "" Then $officemodules = $officemodules & " Word"

        ;Remove any extra ', ,'
        $officemodules = StringReplace ( $officemodules, ", ,", ", " )
        
    Else
        $officemodules = "Not installed"
    EndIf
    
    Return $officemodules

EndFunc


Func processor_data()
;------------------------------------------------
;Retrieve and return processor data from registry
;------------------------------------------------
	Local $proc
	
    $proc = RegRead( "HKEY_LOCAL_MACHINE\HARDWARE\DESCRIPTION\System\CentralProcessor\0", "ProcessorNameString" )
    If @Error Then 
        $proc = "~" & RegRead("HKEY_LOCAL_MACHINE\HARDWARE\DESCRIPTION\System\CentralProcessor\0", "~MHz")&"MHz"
        If @Error Then $proc = "Unknown"
    Else
        $proc = StringStripWS( $proc, 1 )
    EndIf

    Return $proc

EndFunc


Func memory( $type )
;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;Retrieve system memory and return specified type: 0-Returns memory load, 1-Returns Total RAM, 2-Returns available RAM, 3-Returns Total Pagefile Size, 4-Returns Available Pagefile Size, 5-Returns Total Virtual, 6-Returns Available Virtual
;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	Local $type
    #cs
        $mem[0] = Memory Load (Percentage of memory in use)
        $mem[1] = Total physical RAM
        $mem[2] = Available physical RAM
        $mem[3] = Total Pagefile
        $mem[4] = Available Pagefile
        $mem[5] = Total virtual
        $mem[6] = Available virtual
    #ce
    
    If $type < 0 OR $type > 7 Then MsgBox(262144, "Error", "Invalid type entered for memory function." )
    
    $mem = MemGetStats()
    If @Error Then $mem[$type] = "Unknown"
    
    Return $mem[$type] 

EndFunc


Func mdacver()
;--------------------------------------------------
;Retrieve and return MDAC version from the registry
;--------------------------------------------------
    Local $mdac
	
    $mdac = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\DataAccess", "FullInstallVer")
    If @Error Then $mdac = "Unknown"
    
    Return $mdac

EndFunc


Func ieversion()
;---------------------------------------------
;Retrieve and return Internet Explorer Version
;---------------------------------------------
	Local $ie
	
    $ie = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer", "Version")
    If @Error Then $ie = "Unknown"
    
    Return $ie
    
EndFunc


Func window( $name, $text = "" )
;--------------------------------------------------
;Window selection and focus with a 10 second timeout
;--------------------------------------------------
    Local $name, $text
	
	;Is the $name empty?
	IF StringLen ( $name ) = 0 Then 
		msgbox( 262192, "Error", "Window variable was blank." )
		Exit
	EndIF

	$window = $name

	;Select, bring to focus and maximize specified window, if not show an error
	If Not WinActive( $window,$text ) Then WinActivate( $window,$text )
	WinSetState( $window, $text, @SW_SHOW )
	If Not WinWaitActive( $window,$text, 10 ) Then 
		MsgBox( 262192, "Failed", "Could not find "&$window&", "&$text&"" )
		;Exit
	EndIf

EndFunc 


Func waitwindow( $name, $text = "" )
;--------------------------------------------------
;Window selection and focus with a 55 second timeout
;--------------------------------------------------
	Local $name, $text
	
	;Is the $name empty?
	IF StringLen ( $name ) = 0 Then 
		MsgBOX( 262192, "Error", "Window variable was blank." )
		Exit
	EndIF
	
	$window = $name
	
	;Select, bring to focus and maximize specified window, if not show an error
	If Not WinActive( $window,$text ) Then WinActivate( $window,$text )
	WinSetState( $window, $text, @SW_SHOW )
	If Not WinWaitActive( $window,$text, 55 ) Then 
		MsgBox( 262192, "Failed", "Could not find "&$window&", "&$text&"" )
		;Exit
	EndIf

EndFunc


Func waittimewindow( $name, $text = "", $time = 5 )
;----------------------------------------------------------------------------------
;Window selection and focus with a variable timeout (seconds), default is 5 seconds
;----------------------------------------------------------------------------------
	Local $name, $text, $time
	
	;Is the $name empty?
	IF StringLen ( $name ) = 0 Then 
		MsgBOX( 262192, "Error", "Window variable was blank." )
		Exit
	EndIF
	
	$window = $name
	
	;Select, bring to focus and maximize specified window, if not show an error
	If Not WinActive( $window,$text ) Then WinActivate( $window,$text )
	WinSetState( $window, $text, @SW_SHOW )
	If Not WinWaitActive( $window,$text, $time ) Then 
		MsgBox( 262192, "Failed", "Could not find "&$window&", "&$text&"" )
		;Exit
	EndIf
	
EndFunc


Func waitwindowerror( $name, $text = "" )
;---------------------------------------------------------------------------------------
;Window selection and focus with a 45 second timeout, sets $e = to 1 if window not found
;---------------------------------------------------------------------------------------
	Local $name, $text
	;Is the $name empty?
	IF StringLen ( $name ) = 0 Then 
		MsgBOX( 262192, "Error", "Window variable was blank." )
		Exit
	EndIF
	
	$window = $name
	
	;Select, bring to focus and maximize specified window, if not show an error
	If Not WinActive( $window,$text ) Then WinActivate( $window,$text )
	WinSetState( $window, $text, @SW_SHOW )
	If Not WinWaitActive( $window,$text, 45 ) Then 
		;MsgBox(262192, "Failed", "Could not find "&$window&", "&$text&"")
		$e = 1
		;Exit
	Else
		$e = 0
	EndIf
	
	;return the result
	Return $e

EndFunc 


Func waitwindowshorterror( $name, $text = "" )
;---------------------------------------------------------------------------------------
;Window selection and focus with a 2 second timeout, sets $e = to 1 if window not found
;---------------------------------------------------------------------------------------
	Local $name, $text, $e
	
	;Is the $name empty?
	IF StringLen ( $name ) = 0 Then 
		MsgBOX( 262192, "Error", "Window variable was blank." )
		Exit
	EndIF
	
	$window = $name
	
	;Select, bring to focus and maximize specified window, if not show an error
	If Not WinActive( $window,$text ) Then WinActivate( $window,$text )
	WinSetState( $window, $text, @SW_SHOW )
	If Not WinWaitActive( $window,$text, 2 ) Then 
		;MsgBox(262192, "Failed", "Could not find "&$window&", "&$text&"")
		$e = 1
		;Exit
	Else
		$e = 0
	EndIf
	
	;return the result
	Return $e

EndFunc 


Func windowclose( $name, $text = "" )
;----------------------------------------------------------------------------------
;Closes the specified window
;----------------------------------------------------------------------------------
	Local $name, $text
	
	;Is the $name empty?
	IF StringLen ( $name ) = 0 Then 
		MsgBOX( 262192, "Error", "Window variable was blank." )
		Exit
	EndIF
	
	;Select, bring to focus and maximize specified window, if not show an error
	If WinExists ( $name, $text ) Then 
		WinClose ( $name, $text )
	Else
		MsgBox( 262192, "Failed", "Could not close "&$name&", "&$text&"" )
		;Exit
	EndIf
	
EndFunc 


Func windowreturn( $name, $text = "" )
;----------------------------------------------------------------------------------------------
;Window selection and focus with a 3 second timeout, returns 1 if window not found, 0 if found
;----------------------------------------------------------------------------------------------
	Local $name, $text, $r
	
	;Is the $name empty?
	IF StringLen ( $name ) = 0 Then 
		MsgBOX( 262192, "Error", "Window variable was blank." )
		Exit
	EndIF
	
	$window = $name
	
	;Select, bring to focus and maximize specified window, if not show an error
	If Not WinActive( $window,$text ) Then WinActivate( $window,$text )
	WinSetState( $window, $text, @SW_SHOW )
	If Not WinWaitActive( $window,$text, 3 ) Then 
		;MsgBox(262192, "Failed", "Could not find "&$window&", "&$text&"")
		$r = 1
	Else
		$r = 0
	EndIf
	
	Return $r

EndFunc 


Func WorkingGui()
;---------------------------------------------------
;Show the working gui until function is called again
;---------------------------------------------------
	If ProcessExists ( "Working.exe" ) Then
		ProcessClose ( "Working.exe" )
	Else
		Run( @ScriptDir &"\Working.exe", @ScriptDir )
	EndIf
	
EndFunc

#cs
Func verfound()
;--------------------------------------------------
;   FOCUS SHOULD ALREADY BE IN THE VER FIELD!!!
;--------------------------------------------------
;   Check to see if the Ver found field is blank

;Later, may be easier to just check for an error window before proceeding. (Only in Support Client this may work)

ClipPut( "Garbage" ) ;Ensure that the clipboard is not blank

Send( "{CTRLDOWN}c{CTRLUP}" )
Sleep( 300 )

;msgbox ( 262144, "Focus", "")
$ver = ClipGet()
Sleep( 300 )

If $ver = "Garbage" Then
    MsgBox( 262192, "ERROR", "Ver Found was empty. Please resolve before continuing." )
    Else
EndIF

;msgbox(262144, "Resolved", "was blank ver found resolved")

EndFunc
#ce

Func terminate()
;--------------------------------------------------
;Terminate current script when "esc" pressed 
;Requires the next line in the originating script
;HotKeySet("{ESC}", "terminate")
;
;actual function code
    Exit 0
EndFunc


Func TogglePause()
;------------------
;Toggle Pause state
;------------------
Global $Paused
    $Paused = NOT $Paused
    While $Paused
        sleep( 200 )
    WEnd

EndFunc


Func ip_list_all()
;-------------------------------------------------
;Return all IP Addresses in a '|' delimeted string
;-------------------------------------------------
    Local $ip_public, $location, $length, $ip_1, $ip_2, $ip_3, $ip_4, $ip_list
	
	;Retrieve Addresses
	$ip_public = _GetIP()
	$location = StringInStr( $ip_public, '>', 0, -1 )
	$length = StringLen( $ip_public )
	$ip_public = StringRight( $ip_public, $length - $location )
	$ip_public = StringReplace( $ip_public, 'Your IP Is ', '' )
	
	    If $ip_public = "0.0.0.0" Then $ip_public = ""
	$ip_1 = @IPAddress1
		If $ip_1 = "0.0.0.0" Then $ip_1 = ""
	$ip_2 = @IPAddress2
		If $ip_2 = "0.0.0.0" Then $ip_2 = ""
	$ip_3 = @IPAddress3
		If $ip_3 = "0.0.0.0" Then $ip_3 = ""
	$ip_4 = @IPAddress4
		If $ip_4 = "0.0.0.0" Then $ip_4 = ""
	
	;Format Return String
	$ip_list = ""
		If Not $ip_public = "" Then $ip_list = $ip_list &"|" &$ip_public
		If Not $ip_1 = "" Then $ip_list = $ip_list &"|" &$ip_1
		If Not $ip_2 = "" Then $ip_list = $ip_list &"|" &$ip_2
		If Not $ip_3 = "" Then $ip_list = $ip_list &"|" &$ip_3
		If Not $ip_4 = "" Then $ip_list = $ip_list &"|" &$ip_4
	
	Return $ip_list
EndFunc

;~ Func MercuryInstall( $prompt )
;------------------------------------------------------------
;Prompt for locale if variable exists, install .net if needed
;------------------------------------------------------------
#cs 

Dim $locale = "" ;Desired locale to be installed

    ;check for locale prompt
    If $prompt = 1 Then
        ;if user desires to be prompted show message box
        Do           
        $locale_val = inputbox( "Select Locale:", "1 -United States"&@CRLF&"2 -Australia/Asia"&@CRLF&"3 -Canada"&@CRLF&"4 -Europe"&@CRLF&"5 -Latin America"&@CRLF&"6 -United Kingdom" )
        ;Check for errors
        If @Error Then Exit
            
            $result = StringIsDigit( $locale_val )
    Until $result = 1
    
    ;set locale to selected value  
    Select
        Case $locale_val = 1 
            $locale = "United States"
        Case $locale_val = 2
            $locale = "Australia/Asia"
        Case $locale_val = 3
            $locale = "Canada"
            Case $locale_val = 4
                $locale = "Europe"
            Case $locale_val = 5
                $locale = "Latin America"
            Case $locale_val = 6
                $locale = "United Kingdom"
            Case Else
                Exit
        EndSelect  

    EndIf
    
    ;check if .net is installed
    ;run .net install section as needed
    $reg = RegRead( "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework", "InstallRoot" )
    
    If $reg = "" Then 
        ;.net install prompt
        Do
            Sleep( 500 )
        Until WinExists( "InstallShield", "" )
        
        ;Press Yes
        window( "InstallShield", "ACT! optionally uses the Microsoft (R) .NET 1.1 Framework.  Would you like to install it now?" )
        Send( "{ENTER}" )
        
        ;.net license
        Do
            Sleep( 500 )
        Until WinExists( "Microsoft .NET Framework 1.1 Setup", "" )
        
        ;.net license agreement
        window( "Microsoft .NET Framework 1.1 Setup", "" )
        Send( "!a" )
        Send( "!i" )
        
        
        ;wait till the window appears
        Do
            Sleep( 500 )
        Until WinExists( "Microsoft .NET Framework 1.1 Setup", "Installation of" )
        
        window( "Microsoft .NET Framework 1.1 Setup", "Installation of" )
        Send( "{ENTER}" )
        
    EndIF
    
    ;run mercury install
        ;"ACT!" Firewall notice
        Do
            Sleep( 500 )
            TrayTip ( "", "Waiting for firewall notice", 30, 16 )
        Until WinExists( "ACT", "Some anti" )
    
        ;Press enter
        window( "ACT", "Some anti" )
        Send( "{ENTER}" )
    
        
        Do
            Sleep( 500 )
            TrayTip ( "", "First Dialog of Setup Program", 30, 16 )
        Until WinExists( "ACT!", "This program" )
        
        ;Press Next
        window( "ACT! ® Setup Program", "This program" )
        Send( "!n" )
    
        ;check for the previous version is installed dialog
        Sleep(1000)
        If WinExists( "Information", "A previous" ) Then 
            window( "Information", "A previous" )
            Send( "{ENTER}" )
        EndIF
    
    If $locale = "" Then
        ;default locale
        Do
            Sleep( 500 )
            TrayTip ( "", "Choose Country Version", 30, 16 )
        Until WinExists( "ACT! ® Setup Program", "Choose Country Version" ) 
        
        window("ACT! ® Setup Program", "Choose Country Version" )  
        Send( "!n" )
        
    Else
        ;User selected locale
        ;Check the window text for the correct locale, press down to change the locale value
        $l = 0
    Do
        ;Press down until the window text equals the desired locale value
        ;Only press down after testing for australia/asia
        If $l <> 0 Then Send( "{DOWN}" )
        
        ;Get the window text
        $text = WinGetText ( "ACT! Setup Program", "Choose Country Version" )    
    
        ;Increment count
        $l = $l + 1  
        Until StringInStr ( $text, $locale ) <> 0
        
        window("ACT! ® Setup Program", "Choose Country Version" )  
        Send( "!n" ) 
        
    EndIf
    
        Do
            Sleep( 500 )
            TrayTip ( "", "Choose Destination Location", 30, 16 )
        Until WinExists( "ACT!", "Choose Destination Location" )
        
        window( "ACT!", "Choose Destination Location" )
        Send( "!n" )
        
        Do
            Sleep( 500 )
            TrayTip ( "", "License Agreement", 30, 16 )
        Until WinExists( "ACT!", "License Agreement" )
        
                ;select accept and press next
        ;MouseClick( "left", 63, 283, 1, 2 ) 
        window( "ACT!", "License Agreement" )
        Send("+{TAB}{SPACE}" )
        Send( "!n" )
        
        Do
            Sleep( 500 )
            TrayTip ( "", "User Info.", 30, 16 )
        Until WinExists( "ACT!", "User" )
        
        window( "ACT!", "User" )
        Send( @username&"{TAB}best software" )
        ;Click Next
        Send( "!n" )
        
        Do
            Sleep( 500 )
            TrayTip ( "", "Select Program Folder", 30, 16 )
        Until WinExists( "ACT!", "Select Program Folder" )
    
        window( "ACT!", "Select Program Folder" )
        Send( "!n" )
    
        Do
            Sleep( 500 )
            TrayTip ( "", "Place ACT! Icons", 30, 16 )
        Until WinExists( "ACT!", "Place ACT! Icons" )
    
        window( "ACT!", "Place ACT! Icons" )
        Send( "!n" )
    
        Do
            Sleep( 500 )
            TrayTip ( "", "Start Copying Files", 30, 16 )
        Until WinExists( "ACT!", "Start Copying Files" )
    
        window( "ACT!", "Start Copying Files" )
        Send( "!n" )
    
    
        ;install runs
        Do
            Sleep( 1000 )
            ;check for errors and attempt to continue
            If WinExists( "Error", "" ) Then Send("{ENTER}")
        
            TrayTip ( "", "Launch ACT!", 30, 16 )
        Until WinExists( "ACT!", "Launch ACT!" )
        
        window( "ACT!", "Launch ACT!" )
        Send( "{ENTER}" )
    
    
        msgbox( 262144, "Install", "Install complete." )
    
    
    

EndFunc
#ce

Func FindBuildNumber( $snetwork_path, $stag, $slog_file )
;---------------------
;Find the newest build
;---------------------
	Local $snetwork_path, $stag, $slog_file, $iMsgBoxAnswer, $icurrent_build, $build_number, $icnt, $sfull_path, $snetwork_path, $inew_build
	;Example variables
;~ $snetwork_path  = "\\azsbuilds2\Builds\AZSBUILDS1_Data\ACT!_Devo\AutoBld"
;~ $stag = "_TAG_DEVO"
;~ $slog_file  = "DEVO_80.build.output.txt"

	;Verify build folder is accessable
	While Not FileExists( $snetwork_path ) 
		$iMsgBoxAnswer = MsgBox( 262148, "Error", "Unable to access build folder." &@CRLF &"Close script?", 1000 )
		Select
		   Case $iMsgBoxAnswer = 6 ;Yes
				Exit
		   Case $iMsgBoxAnswer = 7 ;No
				
		EndSelect
	WEnd
	
	;Determine current build number
	$icurrent_build = build_noprompt()
	
	;Verify a build was retrieved from the registry
	If $icurrent_build = 0 Then
;~ 		MsgBox( 262208, "Error", "Unable to determine the last build, the script will now close." )
		$build_number = ""
;~ 		Exit
	EndIf
		
	$icnt = 750
	While 1 ;Loop until all tests pass
		
		;Starting from $cnt, search down until a folder exists, this may be the newest build
		Do
			$icnt = $icnt - 1
			$sfull_path = $snetwork_path &"\REL_" &$icnt &$stag
;~ 			If $icnt = 0 Then 
;~ 				ExitLoop
;~ 			EndIf
		Until FileExists( $sfull_path ) <> 0
		
		;Save build number
		$inew_build = $icnt
		
		;Notify if the two build numbers are the same
		If $inew_build = $icurrent_build Then 
			MsgBox( 262208, "Notice", "The latest build is already installed. " &"Build #: " &$inew_build, 500 )
			$build_number = ""
			ExitLoop
		Else
		
			;Verify setup.exe exists, incase folder was created but build didn't complete
			If Not FileExists( $sfull_path &"\WG_MEDIA\ACTWG\setup.exe" ) Then 
	;~ MsgBox( 262208, "Notice", "The build folder exists but the 'setup.exe' file is missing." &@CRLF &"The build failed." &"Build #: " &$inew_build)
;~ 				$build_number = ""
;~ 				ExitLoop
			Else
				$build_number = $inew_build
				ExitLoop
			EndIf
		EndIf
	WEnd
	
	Return $build_number
	
EndFunc


Func local_script()
;----------------------------------------------------------------------------------------------------
; Purpose:  Determine if script is running on a local machine, returns 1 if script is running locally
; Author:       Justin Taylor
;----------------------------------------------------------------------------------------------------
	Local $script_dir, $drive_type
	
	;Retrieve Script Directory
	$script_dir = @ScriptDir

	;Retrieve drive type
	$drive_type = DriveGetType( $script_dir )
	
	;Determine drive type and return result
	If $drive_type = "Network" Then
		Return 0 ;Script is not running locally
	Else
		Return 1 ;Script is probably running locally
	EndIf
	
EndFunc


Func ACTLastUsedDBRead()
;----------------------------------------------------------------------------
;Read the last used db from the registry, returns a blank string if not found
;----------------------------------------------------------------------------
	Local $last_used
	
	;Read Registry
	$last_used = RegRead( "HKEY_CURRENT_USER\Software\Act", "LastDBFileUsed" )
	
	Return $last_used
	
EndFunc


Func ACTLastUSedDBWrite( $db_path )
;-------------------------------------------------------------------------------------------------------
;Writes the specified path to the 'LastDBFileUsed' Registry location, Sets @Error and returns 0 if fails
;-------------------------------------------------------------------------------------------------------
	Local $result
	
	$result = RegWrite( "HKEY_CURRENT_USER\Software\Act", "LastDBFileUsed", "REG_SZ", $db_path )
	If $result = 0 Then SetError( 1 )
	
	Return 
EndFunc


Func AutomatedMercuryInstall( $config )
;------------------------------------------------------------
;Install specified locale if variable exists, install .net if needed
;------------------------------------------------------------
;~ $config[0] ;Locale selection text				
;~ $config[1] ;Alternate Install Path 
;~ $config[2] = ;User install option, 0 for all users, 1 for current user
;~ $config[3] = ;Create a desktop shortcut, 1 = yes, 0 = no
;~ $config[4] = ;Create a quick launch toolbar shortcut, 1 = yes, 0 = no

Opt( "WinTitleMatchMode", 2 )
Local $locale = $config[0]
Local $alternate_path_text = $config[1]
Local $user_install = $config[2]
Local $desktop_shortcut = $config[3]
Local $quick_shortcut = $config[4]
Local $reg, $l, $text

    #region --- .NET Test/Install ---
    ;check if .net is installed
    ;run .net install section as needed
    $reg = RegRead( "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework", "InstallRoot" )
    
    If $reg = "" Then 
        ;.net install prompt
        Do
            Sleep( 500 )
        Until WinExists( "InstallShield", "" )
        
        ;Press Yes
		
		WinWait( "InstallShield", ".Net 1.1 Framework" )
        window( "InstallShield", ".Net 1.1 Framework" )
        Send( "{ENTER}" )
        
        ;.net license
        Do
            Sleep( 500 )
        Until WinExists( "Microsoft .NET Framework 1.1 Setup", "" )
        
        ;.net license agreement
        window( "Microsoft .NET Framework 1.1 Setup", "" )
        Send( "!a" )
        Send( "!i" )
        
        
        ;wait till the window appears
        Do
            Sleep( 500 )
        Until WinExists( "Microsoft .NET Framework 1.1 Setup", "Installation of" )
        
        window( "Microsoft .NET Framework 1.1 Setup", "Installation of" )
        Send( "{ENTER}" )
        
    EndIF
	#endregion --- .NET Test/Install ---


	#region --- Run mercury install ---
	;Look for firewall notice or Welcome to ACT!
	While 4
		TrayTip( "Automated Mercury Install", "Waiting for installer to launch.", 30, 16 )
		Select
			Case WinExists( "ACT", "Some anti" ) ; Looking for Firewall Notice
				;Press enter
				window( "ACT", "Some anti" )
				Send( "{ENTER}" )
				
				;Wait for Welcome to ACT!
				Do
					Sleep( 500 )
					TrayTip( "Automated Mercury Install", "First Dialog of Setup Program", 30, 16 )
				Until WinExists( "ACT!", "This program" )
				;Press Next
				window( "ACT!", "This program" )
				Send( "!n" )
;~ Send( "^n" )	
				
				ExitLoop
				
			Case WinExists( "ACT!", "This program" )
				;Press Next
				window( "ACT!", "This program" )
				Send( "!n" )
;~ Send( "^n" )	
				
				ExitLoop
				
		EndSelect
			Sleep( 500 )
	WEnd
		
        ;Check for the previous version is installed dialog
        Sleep(1000)
        If WinExists( "Information", "A previous" ) Then 
            window( "Information", "A previous" )
            Send( "{ENTER}" )
        EndIF
		
    If $locale = "" Then
        ;default locale
        Do
            Sleep( 500 )
            TrayTip ( "Automated Mercury Install", "Choose Country Version", 30, 16 )
        Until WinExists( "ACT!", "Choose " ) 
        
        window("ACT!", "Choose " )  
        Send( "!n" )
;~ Send( "^n" )		
        
    Else
        ;User selected locale
        ;Check the window text for the correct locale, press down to change the locale value
        $l = 0
        
        ;Focus to country version combo box
        Send("{TAB 3}{HOME}")
        
        Do
            ;Press down until the window text equals the desired locale value
            ;Only press down after testing for australia/asia
            If $l <> 0 Then Send( "{DOWN}" )
			
            ;Get the window text
            $text = WinGetText ( "ACT!", "Choose " )    
			
            ;Increment count
            $l = $l + 1  
        Until StringInStr ( $text, $locale ) <> 0
		
        window("ACT!", "Choose " )  
        Send( "!n" ) 
;~ Send( "^n" )	
        
    EndIf
     
        Do
            Sleep( 500 )
            TrayTip ( "Automated Mercury Install", "Choose Destination Location", 30, 16 )
        Until WinExists( "ACT!", "Choose Destination Location" )
        
        If $alternate_path_text = "" Then 
            window( "ACT!", "Choose Destination Location" )
            Send( "!n" )
;~ Send( "^n" )	
        Else
            ;Enter user specified path
            window( "ACT!", "Choose Destination Location" )
            Send("!r")
;~ Send( "^r" )	
            window( "Choose Folder", "" )
            Send( "!p{DELETE}" )
            Sleep(200)
            Send($alternate_path_text )
            Sleep(200)
            Send("{ENTER}" )
            
            Sleep(200)
            If WinExists( "InstallShield Wizard", "The specified folder:" ) Then 
                window( "InstallShield Wizard", "The specified folder:" )
                Send( "{ENTER}" )
                window( "Choose Folder", "" )
                Send( "!p{DELETE}" )
				Send( "^p{DELETE}" )
                Sleep(400)
                Send($alternate_path_text )
                Sleep(400)
                Send("{ENTER}" )
            EndIf
                        
            window( "ACT!", "Choose Destination Location" )
            Send( "!n" )
;~ Send( "^n" )	
        EndIf
		
		
        Do
            Sleep( 500 )
            TrayTip ( "Automated Mercury Install", "License Agreement", 30, 16 )
        Until WinExists( "ACT!", "License Agreement" )
        
        ;select accept and press next
        
        window( "ACT!", "License Agreement" )
        Send( "+{TAB}{SPACE}" )
        Send( "!n" )
;~ Send( "^n" )	
        
        Do
            Sleep( 500 )
            TrayTip ( "Automated Mercury Install", "User Info.", 30, 16 )
        Until WinExists( "ACT!", "User" )
        
        window( "ACT!", "User" )
        Send( @username&"{TAB}best software" )
		
		;Determine which users to install for
		Select 
			Case $user_install = 0 
				window( "ACT!", "User Information" )
				ControlCommand( "ACT!", "User Information", "Button1", "Check", "" )
			Case $user_install = 1
				window( "ACT!", "User Information" )
				ControlCommand( "ACT!", "User Information", "Button2", "Check", "" )
		EndSelect			
		
        ;Click Next
        Send( "!n" )
;~ Send( "^n" )			
        
        Do
            Sleep( 500 )
            TrayTip ( "Automated Mercury Install", "Select Program Folder", 30, 16 )
        Until WinExists( "ACT!", "Select Program Folder" )
		
        window( "ACT!", "Select Program Folder" )
        Send( "!n" )
;~ Send( "^n" )	
		
        Do
            Sleep( 500 )
            TrayTip ( "Automated Mercury Install", "Place ACT! Icons", 30, 16 )
        Until WinExists( "ACT!", "Place ACT! Icons" )
		
        window( "ACT!", "Place ACT! Icons" )
		
		;Setup Desktop Icon
		Select
			Case $config[3] = 1
				ControlCommand( "ACT!", "Place", "Button1", "Check", "" )
			Case $config[3] = 0
				ControlCommand( "ACT!", "Place", "Button1", "UnCheck", "" )
		EndSelect
		
		;Set Quick Launch Icon
		Select
			Case $config[4] = 1
				ControlCommand( "ACT!", "Place", "Button2", "Check", "" )
			Case $config[4] = 0
				ControlCommand( "ACT!", "Place", "Button2", "UnCheck", "" )
		EndSelect
        Send( "!n" )
;~ Send( "^n" )	
		
        Do
            Sleep( 500 )
            TrayTip ( "Automated Mercury Install", "Start Copying Files", 30, 16 )
        Until WinExists( "ACT!", "Start Copying Files" )
		
        window( "ACT!", "Start Copying Files" )
        Send( "!n" )
;~ Send( "^n" )	
		
        ;install runs
        Do
            Sleep( 1000 )
            ;check for errors and attempt to continue
            If WinExists( "Error", "" ) Then Send("{ENTER}")
			
            TrayTip ( "Automated Mercury Install", "Launch ACT!", 30, 16 )
        Until WinExists( "ACT!", "Launch ACT!" )
        
;~         window( "ACT!", "Launch ACT!" )
;~         Send( "{ENTER}" )
		TrayTip("", 30, 16 )
		
        msgbox( 262144, "Install", "Automated Install complete.", 240 )
	#endregion --- Run mercury install ---
        
Opt( "WinTitleMatchMode", 1 )
	
EndFunc


Func AutomatedDevoInstall( $config )
;------------------------------------------------------------
;Install specified locale if variable exists, install .net if needed
;------------------------------------------------------------
;~ $config[0] ;Locale selection text				
;~ $config[1] ;Alternate Install Path 
;~ $config[2] = ;User install option, 0 for all users, 1 for current user
;~ $config[3] = ;Create a desktop shortcut, 1 = yes, 0 = no
;~ $config[4] = ;Create a quick launch toolbar shortcut, 1 = yes, 0 = no

Opt( "WinTitleMatchMode", 2 )
Opt( "WinTitleMatchMode", 2 )

Local $locale = $config[0]
Local $alternate_path_text = $config[1]
Local $user_install = $config[2]
Local $desktop_shortcut = $config[3]
Local $quick_shortcut = $config[4]
Local $reg, $l, $text

    #region --- .NET Test/Install ---
    ;check if .net is installed
    ;run .net install section as needed
    $reg = RegRead( "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework", "InstallRoot" )
    
    If $reg = "" Then 
        ;.net install prompt
        Do
			TrayTip( "Automated Devo Install", "Waiting for .NET installer to launch.", 30, 16 )
            Sleep( 500 )
        Until WinExists( "InstallShield", "" )
        
        ;Press Yes
		While 1
			Select 
				Case WinExists( "InstallShield", "ACT! optionally" )
					window( "InstallShield", "ACT! optionally" )
					Send( "{ENTER}" )
					ExitLoop
				Case WinExists( "InstallShield", "ACT! requires" )
					window( "InstallShield", "ACT! requires" )
					Send( "{ENTER}" )
					ExitLoop
			EndSelect
			TrayTip( "Automated Devo Install", "Waiting for .NET installer dialog.", 30, 16 )	
			Sleep( 500 )
		WEnd
		
		;Clear the traytip
		TrayTip("clears the tray tip","",0)
        
        
        ;.net license
        Do
			TrayTip( "Automated Devo Install", "Waiting for .NET License Dialog.", 30, 16 )
            Sleep( 500 )
        Until WinExists( "Microsoft .NET Framework 1.1 Setup", "" )
        
		;Clear the traytip
		TrayTip("clears the tray tip","",0)
		
		
        ;.net license agreement
        window( "Microsoft .NET Framework 1.1 Setup", "" )
        Send( "!a" )
        Send( "!i" )
        
        
        ;wait till the window appears
        Do
            TrayTip( "Automated Devo Install", "Waiting for .NET Install Dialog.", 30, 16 )
            Sleep( 500 )
        Until WinExists( "Microsoft .NET Framework 1.1 Setup", "Installation of" )
        
		;Clear the traytip
		TrayTip("clears the tray tip","",0)
		
        window( "Microsoft .NET Framework 1.1 Setup", "Installation of" )
        Send( "{ENTER}" )
        
    EndIF
	#endregion --- .NET Test/Install ---


	#region --- Run Devo install ---
	;Look for firewall notice or Welcome to ACT!
	While 4
		TrayTip( "Automated Devo Install", "Waiting for installer to launch.", 30, 16 )
		Select
			Case WinExists( "ACT", "Some anti" ) ; Looking for Firewall Notice
				;Press enter
				window( "ACT", "Some anti" )
				Send( "{ENTER}" )
				
				;Wait for Welcome to ACT!
				Do
					Sleep( 500 )
					TrayTip( "Automated Devo Install", "First Dialog of Setup Program", 30, 16 )
				Until WinExists( "ACT!", "This program" )
				;Press Next
				window( "ACT!", "This program" )
				Send( "!n" )
				
				ExitLoop
				
			Case WinExists( "ACT!", "This program" )
				;Press Next
				window( "ACT!", "This program" )
				Send( "!n" )
				
				ExitLoop
				
		EndSelect
			Sleep( 500 )
	WEnd
		
        ;Check for the previous version is installed dialog
        Sleep(1000)
        If WinExists( "Information", "A previous" ) Then 
            window( "Information", "A previous" )
            Send( "{ENTER}" )
        EndIF
		
    If $locale = "" Then
        ;default locale
        Do
            Sleep( 500 )
            TrayTip( "Automated Devo Install", "Choose Country Version", 30, 16 )
        Until WinExists( "ACT!", "Choose " ) 
        
        window( "ACT!", "Choose " )  
        Send( "!n" )
        
    Else
        ;User selected locale
        ;Check the window text for the correct locale, press down to change the locale value
        $l = 0
        
        ;Focus to country version combo box
        Send( "{TAB 3}{HOME}" )
        
        Do
            ;Press down until the window text equals the desired locale value
            ;Only press down after testing for australia/asia
            If $l <> 0 Then Send( "{DOWN}" )
			
            ;Get the window text
            $text = WinGetText ( "ACT!", "Choose " )    
			
            ;Increment count
            $l = $l + 1  
        Until StringInStr ( $text, $locale ) <> 0
		
        window("ACT!", "Choose " )  
        Send( "!n" ) 
        
    EndIf
     
	Do
		Sleep( 500 )
		TrayTip ( "Automated Devo Install", "Licence Agreement", 30, 16 )
	Until WinExists( "ACT!", "Please read the" )
	
	window( "ACT!", "Please read the" )
	Send( "+{TAB 2}{SPACE}" )
	Send( "!n" )
	 
        Do
            Sleep( 500 )
            TrayTip ( "Automated Devo Install", "Choose Destination Location", 30, 16 )
        Until WinExists( "ACT!", "Choose Destination Location" )
        
        If $alternate_path_text = "" Then 
            window( "ACT!", "Choose Destination Location" )
            Send( "!n" )
			
        Else
            ;Enter user specified path
            window( "ACT!", "Choose Destination Location" )
            Send("!r")
			
            window( "Choose Folder", "" )
            Send( "!p{DELETE}" )
            Sleep( 200 )
            Send( $alternate_path_text )
            Sleep( 200 )
            Send( "{ENTER}" )
            
            Sleep(200)
            If WinExists( "InstallShield Wizard", "The specified folder:" ) Then 
                window( "InstallShield Wizard", "The specified folder:" )
                Send( "{ENTER}" )
                window( "Choose Folder", "" )
                Send( "!p{DELETE}" )
				Send( "^p{DELETE}" )
                Sleep(400)
                Send($alternate_path_text )
                Sleep(400)
                Send("{ENTER}" )
            EndIf
                        
            window( "ACT!", "Choose Destination Location" )
            Send( "!n" )
			
        EndIf
		
		#cs
        Do
            Sleep( 500 )
            TrayTip ( "Automated Devo Install", "License Agreement", 30, 16 )
        Until WinExists( "ACT!", "License Agreement" )
        
        ;select accept and press next
        
        window( "ACT!", "License Agreement" )
        Send( "+{TAB 2}{SPACE}" )
        Send( "!n" )
		#ce
		
		Do 
			Sleep( 500 )
            TrayTip ( "Automated Devo Install", "Specify Users", 30, 16 )
        Until WinExists( "ACT!", "Specify" )
		
		;Determine which users to install for
		Select 
			Case $user_install = 0 
				window( "ACT!", "Specify" )
				ControlCommand( "ACT!", "Specify", "Button4", "Check", "" )
			Case $user_install = 1
				window( "ACT!", "Specify" )
				ControlCommand( "ACT!", "Specify", "Button5", "Check", "" )
		EndSelect	
		
		;Click Next
        Send( "!n" )
		
		#cs
        Do
            Sleep( 500 )
            TrayTip ( "Automated Mercury Install", "User Info.", 30, 16 )
        Until WinExists( "ACT!", "User" )
        
        window( "ACT!", "User" )
        Send( @username&"{TAB}best software" )
		
        ;Click Next
        Send( "!n" )	
		#ce
		
        Do
            Sleep( 500 )
            TrayTip ( "Automated Devo Install", "Select Program Folder", 30, 16 )
        Until WinExists( "ACT!", "Select Program Folder" )
		
        window( "ACT!", "Select Program Folder" )
        Send( "!n" )
		
        Do
            Sleep( 500 )
            TrayTip ( "Automated Devo Install", "Place ACT! Icons", 30, 16 )
        Until WinExists( "ACT!", "Place ACT! Icons" )
		
        window( "ACT!", "Place ACT! Icons" )
		
		;Setup Desktop Icon
		Select
			Case $config[3] = 1
				ControlCommand( "ACT!", "Place", "Button1", "Check", "" )
			Case $config[3] = 0
				ControlCommand( "ACT!", "Place", "Button1", "UnCheck", "" )
		EndSelect
		
		;Set Quick Launch Icon
		Select
			Case $config[4] = 1
				ControlCommand( "ACT!", "Place", "Button2", "Check", "" )
			Case $config[4] = 0
				ControlCommand( "ACT!", "Place", "Button2", "UnCheck", "" )
		EndSelect
        Send( "!n" )
		
        Do
            Sleep( 500 )
            TrayTip ( "Automated Devo Install", "Start Copying Files", 30, 16 )
        Until WinExists( "ACT!", "Start Copying Files" )
		
        window( "ACT!", "Start Copying Files" )
        Send( "!n" )
;~ Send( "^n" )	
		
        ;install runs
        Do
            Sleep( 1000 )
            ;check for errors and attempt to continue
            If WinExists( "Error", "" ) Then Send( "{ENTER}" )
			If WinExists( "Microsoft Outlook", "Either there is" ) Then Send( "{ENTER}" )
            TrayTip ( "Automated Devo Install", "Launch ACT!", 30, 16 )
        Until WinExists( "ACT!", "Launch ACT!" )
        
        window( "ACT!", "Launch ACT!" )
		ControlCommand( "ACT!", "Launch ACT!", "Button1", "UnCheck", "")
		ControlCommand( "ACT!", "Launch ACT!", "Button2", "UnCheck", "")
		
        Send( "{ENTER}" )
		
		TrayTip( "clears any tray tip", "", 0)
		
        msgbox( 262144, "Install", "Automated Devo Install complete.", 240 )
	#endregion --- Run Devo install ---
        
Opt( "WinTitleMatchMode", 1 )
	
EndFunc


Func MercuryUninstall()
;--------------------------------------------------------
;Automated Mercury Uninstall, with ACT7.exe process check
;--------------------------------------------------------

Opt( "WinTitleMatchMode", 2 )

Local $window_question, $process_question, $guid, $partialpath, $path

    ;Verify ACT isn't running
    If WinExists( "ACT! 2005","" ) Then
        $window_question = MsgBox(262179,"Question","ACT! is still running." & @CRLF & "" & @CRLF & "Wait for it to close? (Pressing no will close ACT!")
        Select
            Case $window_question = 6 ;Yes
                ;Wait for the window to close
                WinWaitClose( "ACT","" )
                
            Case $window_question = 7 ;No
                ;Close the window
                WinKill ( "ACT","" )
                ;Wait for the window to close
                WinWaitClose( "ACT","" )
                
            Case $window_question = 2 ;Cancel
                Exit
        EndSelect
    Else
        ;Verify the act process is not open if it is give the user the option to kill it
        If ProcessExists("Act7.exe") Then
            $process_question = MsgBox(262195,"ACT7 Running","The Act7 process is still running." & @CRLF & "" & @CRLF & "Wait for the process to close? (Pressing no will end the process)")
            Select
                Case $process_question = 6 ;Yes
                    ;Wait for the process to close
                    ProcessWaitClose ( "Act7.exe" )
                    
                Case $process_question = 7 ;No
                    ;Close the process
                    ProcessClose ( "Act7.exe" )
                    ;Wait for the process to close
                    ProcessWaitClose ( "Act7.exe" )
                    
                Case $process_question = 2 ;Cancel
                    Exit
            EndSelect
        EndIf
    EndIf
    ;Run the mercury uninstaller
    $guid = RegRead( "HKEY_LOCAL_MACHINE\SOFTWARE\ACT\Install", "ProdGUID" )
    $partialpath = @CommonFilesDir &"\InstallShield\Driver\8\Intel 32\IDriver.exe"
    $path = '"' &@CommonFilesDir &'\InstallShield\Driver\8\Intel 32\IDriver.exe" /M'&$guid	
    If FileExists($partialpath) Then
        Run( $path, @CommonFilesDir &'\InstallShield\Driver\8\Intel 32\' )
    Else
        MsgBox(262144, "Error", "There is no Mercury build to uninstall, or the install is corrupt." )
        Exit
    EndIf

    ;Prompt user to start uninstall manually
    ;MsgBox( 262144, "Mercury Uninstall", "Please start the Mercury Uninstall." )
    ;If @Error Then Exit

    ;Wait till install shield window exists
    Do
       Sleep( 500 )
       TrayTip ( "InstallShield Wizard", "Welcome to the ACT", 20 )

    Until WinExists( "InstallShield Wizard", "Welcome to the ACT" )

    ;click uninstall button
    ControlClick("InstallShield Wizard", "Welcome to the ACT", "Button2" )

    ;click next
    ControlClick("InstallShield Wizard", "Welcome to the ACT", "Button3" )

    ;Wait till confirm uninstall window exists
    Do
       Sleep( 500 )
       TrayTip ( "Confirm Uninstall", "Do you want to", 20 )
    Until WinExists( "Confirm Uninstall", "Do you want to" )

    ;confirm the uninstall
    ControlClick( "Confirm Uninstall", "Do you want to", "Button1" )

    ;wait for uninstall to complete
    Do
       Sleep( 500 )
       TrayTip ( "ACT Uninstalling", "", 20 )

    Until WinExists( "InstallShield Wizard", "Maintenance Complete" )

    ;click finish button
    ControlClick( "InstallShield Wizard", "Maintenance Complete", "Button4" )

    ;notify of script completion
;    MsgBox( 262144, "Uninstall Complete", "ACT has been uninstalled." )

	Opt( "WinTitleMatchMode", 1 )

EndFunc

Func DevoUninstall()
;--------------------------------------------------------
;Automated Mercury Uninstall, with ACT7.exe process check
;--------------------------------------------------------

Opt( "WinTitleMatchMode", 2 )

Local $window_question, $process_question, $guid, $partialpath, $path, $window_type, $window_title, $window_text

    ;Verify ACT isn't running
    If WinExists( "ACT! by Sage","" ) Then
        $window_question = MsgBox( 262179, "Question", "ACT! is still running." & @CRLF & "" & @CRLF & "Wait for it to close? (Pressing no will close ACT!")
        Select
            Case $window_question = 6 ;Yes
                ;Wait for the window to close
                WinWaitClose( "ACT! by Sage","" )
                
            Case $window_question = 7 ;No
                ;Close the window
                WinKill ( "ACT! by Sage","" )
                ;Wait for the window to close
                WinWaitClose( "ACT! by Sage","" )
                
            Case $window_question = 2 ;Cancel
                Exit
        EndSelect
    Else
        ;Verify the act process is not open if it is give the user the option to kill it
        If ProcessExists("Act8.exe") Then
            $process_question = MsgBox(262195,"ACT Running","The Act process is still running." & @CRLF & "" & @CRLF & "Wait for the process to close? (Pressing no will end the process)")
            Select
                Case $process_question = 6 ;Yes
                    ;Wait for the process to close
                    ProcessWaitClose ( "Act8.exe" )
                    
                Case $process_question = 7 ;No
                    ;Close the process
                    ProcessClose ( "Act8.exe" )
					
                    ;Wait for the process to close
                    ProcessWaitClose ( "Act8.exe" )
                    
                Case $process_question = 2 ;Cancel
                    Exit
            EndSelect
        EndIf
    EndIf
    ;Run the uninstaller
    $guid = RegRead( "HKEY_LOCAL_MACHINE\SOFTWARE\ACT\Install", "ProdGUID" )
    $partialpath = @CommonFilesDir &"\InstallShield\Driver\8\Intel 32\IDriver.exe"
    $path = '"' &@CommonFilesDir &'\InstallShield\Driver\8\Intel 32\IDriver.exe" /M' &$guid	
    If FileExists( $partialpath ) Then
        Run( $path, @CommonFilesDir &'\InstallShield\Driver\8\Intel 32\' )
    Else
        MsgBox( 262144, "Error", "There is no ACT! build to uninstall, or the install is corrupt." )
        Exit
    EndIf

	;Look for the two types of uninstaller dialogs and set variables accordingly
	While 1
		Select
			Case WinExists( "InstallShield Wizard", "Welcome to the ACT" )
				$window_type = 0
				ExitLoop
			Case WinExists( "ACT!", "Welcome" )
				$window_type = 1
				ExitLoop
		EndSelect
		Sleep( 500 )
	WEnd
	
	
	If $window_type = 1 Then
		$window_title = "ACT!"
		$window_text = "Welcome"
	Else
		$window_title = "InstallShield Wizard"
		$window_text = "Welcome to the ACT"
	EndIf
	
    ;Wait till install shield window exists
    Do
       Sleep( 500 )
       TrayTip ( "Automated Uninstall", "Waiting for Uninstaller to launch", 20, 1 )
    Until WinExists( $window_title, $window_text )

    ;click uninstall button
    ControlClick( $window_title, $window_text, "Button2" )

    ;click next
    ControlClick( $window_title, $window_text, "Button3" )

    ;Wait till confirm uninstall window exists
    Do
       Sleep( 500 )
       TrayTip ( "Automated Uninstall", "Waiting for uninstall confirmation dialog.", 20 )
    Until WinExists( "Confirm Uninstall", "Do you want to" )

    ;Confirm the uninstall
    ControlClick( "Confirm Uninstall", "Do you want to", "Button1" )


	If $window_type = 1 Then
		$window_title = "ACT!"
		$window_text = "Complete"
	Else
		$window_title = "InstallShield Wizard"
		$window_text = "Maintenance Complete"
	EndIf
	
    ;wait for uninstall to complete
    Do
       Sleep( 500 )
       TrayTip ( "Automated Uninstall", "Uninstalling ACT!...", 20 )
    Until WinExists( $window_title, $window_text )
	
	
    ;click finish button
    ControlClick( $window_title, $window_text, "Button4" )

    ;notify of script completion
;    MsgBox( 262144, "Uninstall Complete", "ACT has been uninstalled." )

Opt( "WinTitleMatchMode", 1 )

EndFunc


Func ACTPPCFTPBuildCheck()
;--------------------------------------------------------------------------
;Checks the FTP Site for a new PPC Build, returns file name of newest build
;--------------------------------------------------------------------------
Local $ACTFTP = "ftp.saleslogix.com"
Local $ACTFTP_username = "senscode"
Local $ACTFTP_password = "sugcream"
Local $status_bar, $selected, $cnt, $ppc, $ppc_handle, $ppc_folder

	;Check FTP Site for new build
		;Open Explorer to 'ftp.saleslogix.com'
		
		Run ( "explorer.exe ftp://ftp.saleslogix.com/" )
;~ 		Send( "{LWIN}d" )
		window( "ftp://ftp.saleslogix.com/", "" )
;~ 		Sleep( 3000 )
		While 1
			$status_bar = StatusbarGetText( "ftp://ftp.saleslogix.com/", "", 2 )
			Select
				Case WinExists( "Log", "FTP server" ) ;Connection needs password
					window( "Log", "FTP server" )
					
					;Enter user credentials, and 'save password'
					ControlFocus( "Log", "FTP server", "Edit3" )
						Send( $ACTFTP_username ) ;&"{TAB}" )
					ControlFocus( "Log", "FTP server", "Edit4" )
						Send( $ACTFTP_password )
					ControlCommand( "Log", "FTP server", "Button2", "Check", "" )
					
					;Click Log On
					ControlClick( "Log", "FTP server", "Button3" )
					
					ExitLoop
					;
				Case WinExists( "ftp://ftp.saleslogix.com/", "" ) AND $status_bar = "User: senscode" ;Connection sucessfull
					Sleep( 1000 )
					ExitLoop
					
			EndSelect
				
			Sleep( 500 )
		WEnd
	
	;Search for newest file
	;Read all file names in control
	Sleep( 3000 )
	ControlListView( "ftp://ftp.saleslogix.com/", "", 1, "SelectAll" )
	Sleep( 3000 )
;~ 	msgbox(262144, "", "" )
	
	$selected = ControlListView( "ftp://ftp.saleslogix.com/", "", 1, "GetSelected", 1 )
	
	$selected_array = StringSplit( $selected, "|" )
	
	;Replace array with file names
	For $cnt = 1 To $selected_array[0]
		$selected_array[$cnt] = ControlListView( "ftp://ftp.saleslogix.com/", "", 1, "GetText", $selected_array[$cnt]  )
		
	Next
	
	
	
	;Sort the array to find the newest file (newest is last)
	_ArraySort( $selected_array, 0, 1 )
	
;~ 	_ArrayDisplay( $selected_array, "Sorted" )


	;Find newest build on the network server
	$ppc = newPPCbuild()
	
	If $ppc = $selected_array[$selected_array[0]] Then
		;No new build on FTP Server
		MsgBox( 262208, "Notice", "No new FTP Build was found.", 60 )

	Else
		;Copy new build to local network server
	;Doesn't work $state = InetGet( "ftp://sugcream:senscode@ftp.saleslogix.com/" &$newest_FTP_build, $ppc_folder &"\" &$newest_FTP_build )
	
		;Select the newest file
		window( "ftp://ftp.saleslogix.com/", "" )
		ControlListView( "ftp://ftp.saleslogix.com/", "", 1, "SelectClear" )
		$ppc_handle = ControlListView( "ftp://ftp.saleslogix.com/", "", 1, "FindItem", $selected_array[$selected_array[0]] )
		ControlListView( "ftp://ftp.saleslogix.com/", "", 1, "Select", $ppc_handle )
		
		;Press windows application button and f to copy the file
;~ 		window( "ftp://ftp.saleslogix.com/", "" )
		Send( "{APPSKEY}" )		
		Send( "f" )
		
		;Enter in the path
		WinWait( "Browse For Folder", "Copy the" )
		ControlFocus( "Browse For Folder", "Copy the", "Edit1" )
		Send( "{SHIFTDOWN}{END}{SHIFTUP}{DEL}" )
		Send( $ppc_folder, 1 ) 
		Send( "{ENTER}" )
		
		;Wait for copy to finish
		Winwait( "Copying...", $selected_array[$selected_array[0]] )
		WinWaitClose( "Copying...", $selected_array[$selected_array[0]] )
		
		If FileExists( $ppc_folder &"\" &$selected_array[$selected_array[0]] ) Then
			
			MsgBox( 262208, "Notice", "A new build is posted on the FTP site." &@CRLF &@CRLF &"And was copied to the network location: " &@CRLF &$ppc_folder , 60 )
			
		Else
			
			MsgBox( 262192, "Error", "Unable to copy the newest PocketPC build from FTP Server.", 60 )
			
		EndIf
		
		
	EndIf
	
	;Close the Explorer window
	WinClose( "ftp://ftp.saleslogix.com/", "" ) 

	Return $selected_array[$selected_array[0]]

EndFunc


Func ACTPPCInstall( $db_fullpath, $db_username, $db_password )
;-------------------------------------------------------------------
;Automated ACT PocketPC Link Install, returns 1 on sucessful install
;-------------------------------------------------------------------
	;Note - Installer should have already been launched
	Local $db_fullpath, $db_username, $db_password
	
	While 1
		Select
			Case WinExists( "ACT! Link for Pocket PC", "Welcome to ACT! Link for Pocket PC" ) ;1st Dialog - Welcome Dialog
				window( "ACT! Link for Pocket PC", "Welcome to ACT! Link for Pocket PC" )
				;Click Next
				ControlClick( "ACT! Link for Pocket PC", "Welcome to ACT! Link for Pocket PC", "Button1", -1, 1 )
				
			Case WinExists( "ACT! Link for Pocket PC", "WARNING: Product Conflicts" ) ;2nd Dialog - Warning: Product Conflicts
				window( "ACT! Link for Pocket PC", "WARNING: Product Conflicts" )
				;Click "I have uninstalled..."
				ControlCommand( "ACT! Link for Pocket PC", "WARNING: Product Conflicts", "Button5", "Check", "")
				Sleep( 150 )
				;Click Next
				ControlClick( "ACT! Link for Pocket PC", "WARNING: Product Conflicts", "Button2", -1, 1 )
				
			Case WinExists( "ACT! Link for Pocket PC", "If any changes have been made" ) ;3rd Dialog - Sync prompt
				window( "ACT! Link for Pocket PC", "If any changes have been made" )
				;Click "I have completed..."
				ControlCommand( "ACT! Link for Pocket PC", "If any changes have been made", "Button4", "Check", "")
				Sleep( 150 )
				;Click Next
				ControlClick( "ACT! Link for Pocket PC", "If any changes have been made", "Button2", -1, 1 )
				
			Case WinExists( "ACT! Link for Pocket PC", "License Agreement" ) ;4th Dialog - License Agreement
				window( "ACT! Link for Pocket PC", "License Agreement" )
				;Click "I accept..."
				ControlCommand( "ACT! Link for Pocket PC", "License Agreement", "Button4", "Check", "")
				Sleep( 150 )
				;Click Next
				ControlClick( "ACT! Link for Pocket PC", "License Agreement", "Button2", -1, 1 )
				
			Case WinExists( "ACT! Link for Pocket PC", "Select Program Folder" ) ;5th Dialog - Select Program Folder
				window( "ACT! Link for Pocket PC", "Select Program Folder" )
				;Click Next
				ControlClick( "ACT! Link for Pocket PC", "Select Program Folder", "Button2", -1, 1 )
				
			Case WinExists( "ACT! Link for Pocket PC", "Select Database" ) ;6th Dialog - Select Database
				window( "ACT! Link for Pocket PC", "Select Database" )
				
				;If the user field has data don't do anything
				If ControlGetText( "ACT! Link for Pocket PC", "Select Database", "Edit1" ) = "" Then
					
					;Click Browse
					ControlClick( "ACT! Link for Pocket PC", "Select Database", "Button1", -1, 1 )
					
					;Enter DB name 
					window( "Select File", "ACT! Database" )
	;~ 				ControlFocus( "Select File", "ACT! Database", "ComboBox2" )
					Send( $db_fullpath, 1 )
					Send("{ENTER}" )
					
					;Enter username
					window( "ACT! Link for Pocket PC", "Select Database" )
					ControlFocus( "ACT! Link for Pocket PC", "Select Database", "Edit1" )
					Send( $db_username, 1 )
					Send( "{TAB}" )
					
					;Enter password
					ControlFocus( "ACT! Link for Pocket PC", "Select Database", "Edit2" )
					Send( $db_password, 1 )
					
					;Click Next
					ControlClick( "ACT! Link for Pocket PC", "Select Database", "Button3", -1, 1 )
				Else
					;Do nothing
				EndIf
				
				
			Case WinExists( "ACT! Link for Pocket PC", "Manage Data" ) ;7th Dialog - Manage Data
				window("ACT! Link for Pocket PC", "Manage Data" )
				;Click Next
				ControlClick( "ACT! Link for Pocket PC", "Manage Data", "Button1", -1, 1 )
				
			Case WinExists( "ACT! Link for Pocket PC", "Enter Your Information" ) ;8th Dialog - Enter User Info
				window( "ACT! Link for Pocket PC", "Enter Your Information" )
				;Enter User Information
				ControlFocus( "ACT! Link for Pocket PC", "Enter Your Information", "Edit1" ) ;First Name
				Send( "ACT" )
				ControlFocus( "ACT! Link for Pocket PC", "Enter Your Information", "Edit2" ) ;Last Name
				Send( "QATesting" )
				ControlFocus( "ACT! Link for Pocket PC", "Enter Your Information", "Edit3" ) ;Company
				Send( "Sage Software" )
				ControlFocus( "ACT! Link for Pocket PC", "Enter Your Information", "Edit4" ) ;Title
				Send( "" )
				ControlFocus( "ACT! Link for Pocket PC", "Enter Your Information", "Edit5" ) ;Address #1
				Send( "8800 N Gainey Center Drive" )
				ControlFocus( "ACT! Link for Pocket PC", "Enter Your Information", "Edit6" ) ;Address #2
				Send( "Suite 200" )
				ControlFocus( "ACT! Link for Pocket PC", "Enter Your Information", "Edit7" ) ;City
				Send( "Scottsdale" )
				ControlFocus( "ACT! Link for Pocket PC", "Enter Your Information", "Edit8" ) ;State
				Send( "AZ" )
				ControlFocus( "ACT! Link for Pocket PC", "Enter Your Information", "Edit9" ) ;Country
				Send( "USA" )
				ControlFocus( "ACT! Link for Pocket PC", "Enter Your Information", "Edit10" ) ;ZIP
				Send( "85258" )
				ControlFocus( "ACT! Link for Pocket PC", "Enter Your Information", "Edit11" ) ;Phone
				Send( "480-627-3505" )
				ControlFocus( "ACT! Link for Pocket PC", "Enter Your Information", "Edit12" ) ;E-mail
				Send( "actqa@sage.com" )
				
				;Click Next
				ControlClick( "ACT! Link for Pocket PC", "Enter Your Information", "Button3", -1, 1 )
				
			Case WinExists( "ACT! Link for Pocket PC", "Setup Complete" ) ;9th Dialog - Setup Complete
				window( "ACT! Link for Pocket PC", "Setup Complete" )
				;Uncheck view users guide
				ControlCommand( "ACT! Link for Pocket PC", "Setup Complete", "Button1", "UnCheck", "" )
				
				;Uncheck view readme
				ControlCommand( "ACT! Link for Pocket PC", "Setup Complete", "Button2", "UnCheck", "" )
				
				;Click Finish
				ControlClick( "ACT! Link for Pocket PC", "Setup Complete", "Button4", -1, 1 )
				
				Return 1
;~ 			Case WinExists( "", "" ) ;10th Dialog - 
				
				
		EndSelect
		Sleep( 500 )	
	WEnd
	
	
EndFunc


Func ACTPPCUninstall()
;--------------------------------------------------------
;Automated ACT PocketPC Link Uninstall
;--------------------------------------------------------
	;Launch uninstaller
	Run( 'C:\WINNT\system32\RunDll32.exe C:\PROGRA~1\COMMON~1\INSTAL~1\engine\6\INTEL3~1\Ctor.dll,LaunchSetup "C:\Program Files\InstallShield Installation Information\{2917EE3E-64B2-4D62-BAD4-28544DA9AC6C}\Setup.exe" -l0x9 UNINSTALL', 'C:\WINNT\system32\' )
	
	;Wait for the confirmation dialog
	WinWait( "Confirm File Deletion", "Are you sure", 500 )
	
	;Click yes
	window( "Confirm File Deletion", "Are you sure" )
	ControlClick( "Confirm File Deletion", "Are you sure", "Button1", -1, 1 )
	
	;Wait for install to close
	WinWait( "ACT! Link for Pocket PC", "ACT! Link for Pocket PC has been successfully uninstalled from your machine." )
	ControlClick( "ACT! Link for Pocket PC", "ACT! Link for Pocket PC has been successfully uninstalled from your machine.", "Button1", -1, 1 )
	
EndFunc


Func newPPCbuild()
;-----------------------------------------------------------------------------------------------
;Determine if a new build of PPC Link is available, returns file name if a new build exists
;-----------------------------------------------------------------------------------------------
		
		;Create an array to use to determine newest setup file
		RunWait( @ComSpec &" /c " &"net use " &$snetwork_path &" /user:testlogix\testadmin 2l84luv", "", @SW_HIDE )
		$dir_info = DirGetSize( $ppc_folder, 1 )
		
		IF @Error Then 
			MsgBox( 262160, "Error - Build Directory", "Error - The PPC Build directory was not found." )
			$dir_files = ""
		Else
			$dir_files = $dir_info[2]
			Dim $file_array[$dir_files][2]
		EndIf
		
		
		;Look in the $ppc_folder for the newest file
		;search for *.exe files
		$search = FileFindFirstFile( $ppc_folder &"\*.exe")  
		
		; Check if the search was successful
		If $search = -1 Then
			MsgBox( 262144, "Error", "No Pocket PC build files were found in the '" &$ppc_folder &"' folder." )
			Exit
		EndIf
		
		;Add files to the array
		$file_cnt = 0
		While 1
			$file = FileFindNextFile( $search ) 
			If @error Then ExitLoop
			$file_array[$file_cnt][0] = $file
			
	;~ 		MsgBox(4096, "File:", $file  )
			
			$file_cnt = $file_cnt + 1
		WEnd
		
		;Close the search handle
		FileClose( $search )
		
		;Retrieve file date attribute
		For $file_time_cnt = 0 To $file_cnt
			If $file_array[$file_time_cnt][0] = "0" Then 
				;No file don't read
				
			Else
				$file_time = FileGetTime( $ppc_folder &"\" &$file_array[$file_time_cnt][0], 0, 1 )
				If @Error Then
					MsgBox( 262160, "Error", "Unable to retrieve the modification date of '" &$file_array[$file_time_cnt][0] &"'." )
				Else
					;Save the value to the array
					$file_array[$file_time_cnt][1] = $file_time
				EndIf
				
	;~ 			MsgBox(4096, "File:", $file_array[$file_time_cnt][0] &@CRLF &$file_array[$file_time_cnt][1])
			EndIf
		Next
		
		;Sort the array to determine which file is the newest
		_ArraySort( $file_array, 1, 0, 0, 2, 1 )
	
		;TEST - Display the sorted array
	;~ 		msgbox(262144, "TEST", $file_array[0][0] &@CRLF &$file_array[0][1] &@CRLF &"--------------" &@CRLF &$file_array[1][0] &@CRLF &$file_array[1][1] &@CRLF &"--------------" &@CRLF &$file_array[2][0] &@CRLF &$file_array[2][1] &@CRLF &"--------------" &@CRLF &$file_array[3][0] &@CRLF &$file_array[3][1] &@CRLF &"--------------" &@CRLF &$file_array[4][0] &@CRLF &$file_array[4][1] &@CRLF &"--------------" &@CRLF &$file_array[5][0] &@CRLF &$file_array[5][1])
		
		;If top position in the array (the newest file) contains 'French' use the second as long as it doesn't say 'French'
		If StringInStr( $file_array[0][0], "French" ) Then
			If StringInStr( $file_array[1][0], "French" ) Then
;~ 				MsgBox( 262160, "Error - Build Executable", "Unable to determine newest build. " & @CRLF & "Script will now close.")
				Return ""
			Else
				$ppc_build = $file_array[1][0]
			EndIf
			
		Else
			$ppc_build = $file_array[0][0]
		EndIf
	    
		Return $ppc_build
		
EndFunc
	

Func disablePPCSYNC()
;--------------------------
;Disable PocketPC Sync (USB)
;--------------------------
	Local $active_sync_dir
	
	;Open ActiveSync
	$active_sync_dir = RegRead( "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Pegasus", "InstalledDir" )
	Run( $active_sync_dir &"\WCESMgr.exe", "C:\Program Files\Microsoft ActiveSync" )
	
	winwait( "Microsoft ActiveSync", "" )
	
	
	;Open Settings Dialog
	window( "Microsoft ActiveSync", "" )
	Send( "!fc" )
	
	;Uncheck 'Allow USB connection with'
	ControlCommand( "Connection Settings", "Status", "Button3", "UnCheck", "" )
	
	;Click ok
	ControlClick( "Connection Settings", "Status", "Button7" )
	
	WinWaitClose( "Connection Settings", "Status" )
	
	;Close Active Sync Dialog
	WinSetState ( "Microsoft ActiveSync", "", @SW_MINIMIZE )
	
	
EndFunc


Func enablePPCSYNC()
;--------------------------
;Enable PocketPC Sync (USB)	
;--------------------------
	Local $active_sync_dir 
	
	;Open ActiveSync
	$active_sync_dir = RegRead( "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Pegasus", "InstalledDir" )
	Run( $active_sync_dir &"\WCESMgr.exe", "C:\Program Files\Microsoft ActiveSync" )
	
	winwait( "Microsoft ActiveSync", "" )
	
	
	;Open Settings Dialog
	window( "Microsoft ActiveSync", "" )
	Send( "!fc" )
	
	;Check 'Allow USB connection with'
	ControlCommand( "Connection Settings", "Status", "Button3", "Check", "" )
	
	;Click ok
	ControlClick( "Connection Settings", "Status", "Button7" )
	
	WinWaitClose( "Connection Settings", "Status" )
	
	;Close Active Sync Dialog
	WinSetState ( "Microsoft ActiveSync", "", @SW_MINIMIZE )
	
EndFunc


Func ACTPALMInstall( $db_fullpath, $db_username, $db_password )
;-------------------------
;Install the ACT Palm Link
;-------------------------
	Local $db_fullpath, $db_username, $db_password
	
	While 1
		Select
			Case WinExists( "ACT!", "Welcome to ACT! Link for Palm" ) ;Welcome Dialog
				;Click Next
				ControlClick( "ACT!", "Welcome to ACT! Link for Palm", "Button1" )
				
			Case WinExists( "ACT!", "completed a HotSync" ) ;Completed hot sync???
				;Click I have completed
				ControlCommand( "ACT!", "completed a HotSync", "Button8", "Check", "" )
				
				;Click Next
				ControlClick( "ACT!", "completed a HotSync", "Button2" )
				
				WinWaitClose( "", "Closing the HotSync manager" )
				
			Case WinExists( "ACT!", "License Agreement" ) ;License Agreement
				;Click I accept
				ControlCommand( "ACT!", "License Agreement", "Button4", "Check", "" )
				
				;Click Next
				ControlClick( "ACT!", "License Agreement", "Button2" )
				
			Case WinExists( "ACT!", "Select Program Folder" ) ;Select Program Folder
				;Click Next
				ControlClick( "ACT!", "Select Program Folder", "Button2" )
				
			Case WinExists( "ACT!", "Select Database" )
				;If the user field has data don't do anything
					If ControlGetText( "ACT!", "Select Database", "Edit1" ) = "" Then
						
						;Click Browse
						ControlClick( "ACT!", "Select Database", "Button1" )
						
						;Enter DB name 
						window( "Select File", "ACT! Database" )
		;~ 				ControlFocus( "Select File", "ACT! Database", "ComboBox2" )
						Send( $db_fullpath, 1 )
						Send("{ENTER}" )
						
						;Enter username
						window( "ACT!", "Select Database" )
						ControlFocus( "ACT!", "Select Database", "Edit1" )
						Send( $db_username, 1 )
						Send( "{TAB}" )
						
						;Enter password
						ControlFocus( "ACT!", "Select Database", "Edit2" )
						Send( $db_password, 1 )
						
						;Click Next
						ControlClick( "ACT!", "Select Database", "Button3" )
					Else
						;Do nothing
					EndIf
					
			Case WinExists( "ACT!", "Manage Data" )
				;Click Next
				ControlClick( "ACT!", "Manage Data", "Button3" )
				
			Case WinExists( "ACT!", "Enter Your Information" )
				;Enter User Information
					ControlFocus( "ACT!", "Enter Your Information", "Edit1" ) ;First Name
						Send( "ACT" )
					ControlFocus( "ACT!", "Enter Your Information", "Edit2" ) ;Last Name
						Send( "QATesting" )
					ControlFocus( "ACT!", "Enter Your Information", "Edit3" ) ;Company
						Send( "Sage Software" )
					ControlFocus( "ACT!", "Enter Your Information", "Edit4" ) ;Title
						Send( "" )
					ControlFocus( "ACT!", "Enter Your Information", "Edit5" ) ;Address #1
						Send( "8800 N Gainey Center Drive" )
					ControlFocus( "ACT!", "Enter Your Information", "Edit6" ) ;Address #2
						Send( "Suite 200" )
					ControlFocus( "ACT!", "Enter Your Information", "Edit7" ) ;City
						Send( "Scottsdale" )
					ControlFocus( "ACT!", "Enter Your Information", "Edit8" ) ;State
						Send( "AZ" )
					ControlFocus( "ACT!", "Enter Your Information", "Edit9" ) ;Country
						Send( "USA" )
					ControlFocus( "ACT!", "Enter Your Information", "Edit10" ) ;ZIP
						Send( "85258" )
					ControlFocus( "ACT!", "Enter Your Information", "Edit11" ) ;Phone
						Send( "480-627-3505" )
					ControlFocus( "ACT!", "Enter Your Information", "Edit12" ) ;E-mail
						Send( "actqa@sage.com" )
					
					;Click Next
					ControlClick( "ACT!", "Enter Your Information", "Button3" )
					
			Case WinExists( "ACT!", "Setup Complete" )
				;Uncheck both 'view's
				ControlCommand( "ACT!", "Setup Complete", "Button1", "UnCheck", "" )
				ControlCommand( "ACT!", "Setup Complete", "Button2", "UnCheck", "" )
				
				;Click Next
				ControlClick( "ACT!", "Setup Complete", "Button3" )
				ExitLoop
				
;~ 			Case WinExists( "", "" )
				
		EndSelect
		Sleep( 500 )
	WEnd
	
	;Check for BestPractices.txt document
	Sleep( 1000 )
	If WinExists( "BestPractices.txt", "" ) Then
		WinClose( "BestPractices.txt", "" )
	EndIf
	
EndFunc


Func ACTPALMUninstall()
;---------------------------
;Uninstall the ACT Palm Link
;---------------------------
	;~ $reg_value = RegRead( "HKEY_LOCAL_MACHINE\SOFTWARE\ACT Link For Palm 3.0\Install", "InstallPath" )
	Run( 'C:\WINNT\system32\RunDll32.exe "C:\Program Files\Common Files\INSTAL~1\engine\6\INTEL3~1\ctor.dll",LaunchSetup "C:\Program Files\InstallShield Installation Information\{8348D1DA-6F16-4E83-86A7-FAAEF4A627B4}\setup.exe"  -uninst' )
	
	;Wait for confirmation dialog
	WinWait( "ACT!", "This will remove ACT!" )
	
	;Click 'yes'
	window( "ACT!", "This will remove ACT!" )
	ControlClick( "ACT!", "This will remove ACT!", "Button1" )
	
	;Wait for confirmation dialog
	WinWait( "ACT!", "Link for Palm OS" )
	
	;Click 'ok'
	window( "ACT!", "Link for Palm OS" )
	ControlClick( "ACT!", "Link for Palm OS", "Button1" )
	
	
EndFunc


Func newPALMbuild()
;------------------------------------------------------------
;Search for a new Palm Build, returns 1 if a new build exists
;------------------------------------------------------------
Dim $file_array[200]

;~ "\\azsbuilds2\Builds\AZSBUILDS1_Data\ACT!_Devo_Barney\Manual\x131\x1"
;Look in the $ppc_folder for the newest file
		;search for *.exe files
		$search = FileFindFirstFile( $palm_folder &"\*.*" )  
		
		; Check if the search was successful
		If $search = -1 Then
			MsgBox( 262144, "Error", "No Palm folders were found in the '" &$palm_folder &"' folder." )
			Exit
		EndIf
		
		;Add files to the array
		$file_cnt = 0
		While 1
			$file = FileFindNextFile( $search ) 
			If @error Then ExitLoop
			$file_array[$file_cnt] = $file
			
	;~ 		MsgBox(4096, "File:", $file  )
			
			$file_cnt = $file_cnt + 1
		WEnd
		
		;Close the search handle
		FileClose( $search )
		
		;Sort the array to place the newest build at the top of the array
		_ArraySort( $file_array, 1 )
		
		Return $file_array[0]
		
EndFunc


Func _ArrayDisplayAny( $array, $title = "Array Display", $base = 0 )
;===============================================================================
;
; Function Name:  	_ArrayDisplayAny()
; Description:    	Displays a 1-dimensional or multi-dimensional array in 
;                 	a List View GUI.  Option to use base 0 as header.
;					Improved version of _ArrayDisplay.
;				  	Sets @Error if an error occurs
;				  	Returns:
;				  		1 = Array specified is not an array
;						2 = Specified base range was invalid
;						3 = Base must be 0 for 1-dimensional arrays
;
; Author(s):      	Justin Taylor <xwing1978@hotmail.com>
;
;===============================================================================
;~ 	#include <GuiConstants.au3>
;~ 	If NOT IsDeclared( "GuiConstants.au3" ) Then
;~ 		#include <GuiConstants.au3>
;~ 	EndIf
	
	#region --- Variable Declaration ---
	Local $is_array, $rows, $cols, $label
	Local $ok_control, $list_control, $row_data
	Local $header = ""
	#endregion --- Variable Declaration ---
	
	;Base = 0 if not specified
	If $base = "" Then $base = 0
	
	;Verify array is an array
	$is_array = UBound ( $array )
	If $is_array = 0 Then 
		SetError ( 1 ) 
		Return 1
	EndIf
	
	;Verify base is correct
	If $base < 0 OR $base > 1 Then
		SetError ( 1 ) 
		Return 2
	EndIf
	
	;Determine the size of the array
	$rows = UBound( $array ) - 1
	$cols = UBound( $array, 2 ) - 1
	If $cols = -1 Then $cols = 0
	
	;If base is > 1, verify that a multidimensional array has been specified
	If $base > 0 AND $cols = 0 Then
		SetError ( 1 ) 
		Return 3
	EndIf
	
	;Create Header using '0 to x' if base = 0 otherwise use the [x][0] location for the headers
	If $base = 1 Then
			;Headers using array data
			If $cols = 0 Then
				$header = $header & $array[$cnt] &"|"
			Else
				For $cnt = 0 To $rows
					$header = $header & $array[$cnt][0] &"|"
				Next
			EndIf
	Else
		;Standard 0 to x headers
		For $cnt = 0 To $rows
			$header = $header & $cnt &"|"
		Next
	EndIf
	
	
	
	$array_gui = GuiCreate( $title, 300, 320,(@DesktopWidth-300)/2, (@DesktopHeight-320)/2 , $WS_OVERLAPPEDWINDOW + $WS_VISIBLE + $WS_CLIPSIBLINGS )
	$label = GUICtrlCreateLabel( "Column headings indicate array dimension", 10, 10, 250, 20 )
	$ok_control = GuiCtrlCreateButton( "Ok", 230, 290, 60, 20 )
	$list_control = GUICtrlCreateListView( $header, 10, 30, 280, 250 )
	
	;Add the array values to the list view
	If $base = 1 Then
		;Base = 1 
		$row_data = ""
 		For $c = 1 To $cols
			;Add all column data for each row to a single variable
			
				If $cols = 0 Then
					$row_data = $row_data &$array[$c]
				Else
					For $r = 0 To $rows 
						$row_data = $row_data &$array[$r][$c] &"|"
					Next
				EndIf
			
			;Add row and column data to control
			GUICtrlCreateListViewItem( $row_data, $list_control )
			
			;Clear variable for next array row
			$row_data = ""
		Next
	Else
		;Base = 0
		$row_data = ""
		For $r = 0 To $rows
			;Add all column data for each row to a single variable
			For $c = 0 To $cols
				If $cols = 0 Then
					$row_data = $row_data &$array[$r]
				Else
					$row_data = $row_data &$array[$r][$c] &"|"
				EndIf
			Next
			
			;Add row and column data to control
			GUICtrlCreateListViewItem( $row_data, $list_control )
			
			;Clear variable for next array row
			$row_data = ""
		Next
	EndIf
	
	;Show array in gui
	GuiSetState()
	While 1
		$msg = GuiGetMsg()
		Select
			Case $msg = $GUI_EVENT_CLOSE
				GUIDelete( $array_gui )
				Return
			Case $msg = $ok_control
				GUIDelete( $array_gui )
				Return
			Case Else
				;;;
		EndSelect
	WEnd
	
	SetError(0)
	Return 1
	
EndFunc   ;==>_ArrayDisplayAny


Func fileselection( $directory, $file_type = "*.*", $option = 1 )
;--------------------------------------------------------------------------------------
;Select the newest or oldest file in a specified directory, 1 is newest, and is default
;--------------------------------------------------------------------------------------
	
	Dim $file_array[400][2]

	;Look in the $ppc_folder for the newest file
		;search for *.exe files
		$search = FileFindFirstFile( $directory &"\" &$file_type  )  
		
		; Check if the search was successful
		If $search = -1 Then
			MsgBox( 262144, "Error", "No files were found in the '" &$directory &"' folder." )
			Exit
		EndIf
		
		;Add files to the array
		$file_cnt = 0
		While 1
			$file = FileFindNextFile( $search ) 
			If @error Then ExitLoop
			$file_array[$file_cnt][0] = $file
			
			$file_cnt = $file_cnt + 1
		WEnd
		
		;Close the search handle
		FileClose( $search )
		
		;Retrieve file date attribute
		For $file_time_cnt = 0 To $file_cnt
			If $file_array[$file_time_cnt][0] = "0" Then 
				;No file don't read
				
			Else
				$file_time = FileGetTime( $directory &"\" &$file_array[$file_time_cnt][0], 0, 1 )
				If @Error Then
					MsgBox( 262160, "Error", "Unable to retrieve the modification date of '" &$file_array[$file_time_cnt][0] &"'." )
				Else
					;Save the value to the array
					$file_array[$file_time_cnt][1] = $file_time
				EndIf
				
	;~ 			MsgBox(4096, "File:", $file_array[$file_time_cnt][0] &@CRLF &$file_array[$file_time_cnt][1])
			EndIf
		Next
		
		;Sort the array to determine which file is the newest
		_ArraySort( $file_array, $option, 0, 0, 2, 1 )
		If $option = 0 Then
;~ 			_ArrayDisplayAny( $file_array )
			Return $file_array[400 - $file_cnt][0]
			
		Else
			Return $file_array[0][0]
		EndIf
		
EndFunc


Func DomainMachineList( $domain = "")
;------------------------------------------------------
;Returns a '|' delimeted list of machines on the domain
;------------------------------------------------------
	Dim $computers[5000]

	#region --- Read Machines on domain ---
	;Open Command window and show all machines on current machine's domain
	If $domain = "" Then 
		$net_list = Run( @ComSpec &" /k " &"net view" )
		;Wait for command to complete
		Do 
			Sleep( 500 )
		Until WinGetTitle( @ComSpec &" /k " &"net view" ) = 0
	Else
		$net_list = Run( @ComSpec &" /k " &"net view /DOMAIN:" &$domain )

	EndIf
	Sleep( 500 )
	
	;Wait for command to complete	
	Opt( "WinTitleMatchMode", 3 )
		Winwait( @ComSpec )
	Opt( "WinTitleMatchMode", 1 )
	
	;Retrieve data from window
	window( "C:\WINDOWS\system32\cmd.exe" )
	$win_pos = WinGetPos( "C:\WINDOWS\system32\cmd.exe" )
	Opt( "MouseCoordMode", 0 )
	MouseClick( "Right", $win_pos[0] + 20 , $win_pos[1] + 20, 1, 1 )
	Opt( "MouseCoordMode", 1 )
	
	Send( "s{ENTER}" )
	
	WinClose( "C:\WINDOWS\system32\cmd.exe" )
	
	$string = Clipget()
	
	$string_array = StringSplit( Clipget(), @CRLF ) 
	
	;Parse array for computer names
	For $cnt = 1 To $string_array[0]
		If StringInStr( $string_array[$cnt], "\\" ) Then 
			$array = StringSplit( $string_array[$cnt], " " )
			If @Error Then
				$computers[$cnt] = String( $string_array[$cnt] )
			Else
				$computers[$cnt] = String( $array[1] )
			EndIf
			
			$computers[0] = $computers[0] + 1
		EndIf
	Next
	
	$list = ""
	For $cnt = 1 To 499
		If $computers[$cnt] = "0" Then 
			;No nothing
		Else
			$computer_name = StringReplace( $computers[$cnt], "\\", "" )
			$list = $list &"|" & $computer_name
			
		EndIf
	Next
	
	
	Return $list

EndFunc


Func defect_current()
;-----------------------------------------------
;Return the defect ID of the current open defect
;-----------------------------------------------	
	Local $defect
	
	$defect = ControlGetText( "Support", "", $defectid )
	
	Return $defect
	
EndFunc


Func display_resolution( )
;-------------------------------------------------------------------------------------
;Read resolution and refresh rate for Monitor #1, [0] = x, [1] = y, [2] = refresh rate
;-------------------------------------------------------------------------------------
    Local $res[3]
    Local $sVideo_1_GUID
    
    ;Determine GUID
    $sVideo_1_GUID = RegRead( "HKEY_LOCAL_MACHINE\HARDWARE\DEVICEMAP\VIDEO", "\Device\Video0" )
    $sVideo_1_GUID = StringTrimLeft( $sVideo_1_GUID, StringInStr( $sVideo_1_GUID, "\System" ) - 1 )

    ;Retrieve Resolution Data, first determine if this is an actual machine or an image
    IF StringInStr( $sVideo_1_GUID, "vmx" ) Then 
        ;If errors were encountered try system is probably a virtual machine
        $res[0] = RegRead( "HKEY_CURRENT_CONFIG\System\CurrentControlSet\SERVICES\VMX_SVGA\DEVICE0", "DefaultSettings.XResolution" )
        $res[1] = RegRead( "HKEY_CURRENT_CONFIG\System\CurrentControlSet\SERVICES\VMX_SVGA\DEVICE0", "DefaultSettings.YResolution" )
        $res[2] = RegRead( "HKEY_CURRENT_CONFIG\System\CurrentControlSet\SERVICES\VMX_SVGA\DEVICE0", "DefaultSettings.VRefresh" )
        
    Else
        ;Works on real machines
        $res[0] = RegRead( "HKEY_CURRENT_CONFIG" &$sVideo_1_GUID , "DefaultSettings.XResolution" )
        $res[1] = RegRead( "HKEY_CURRENT_CONFIG" &$sVideo_1_GUID , "DefaultSettings.YResolution" )
        $res[2] = RegRead( "HKEY_CURRENT_CONFIG" &$sVideo_1_GUID , "DefaultSettings.VRefresh" )
        
    EndIf

    Return $res
    
EndFunc
