if !exists("main_syntax")
if exists("b:current_syntax")
finish
endif
let main_syntax = 'css'
elseif exists("b:current_syntax") && b:current_syntax == "css"
finish
endif
let s:cpo_save = &cpo
set cpo&vim
syn case ignore
syn keyword cssTagName abbr address area a b base
syn keyword cssTagName bdo blockquote body br button
syn keyword cssTagName caption cite code col colgroup dd del
syn keyword cssTagName dfn div dl dt em fieldset form
syn keyword cssTagName h1 h2 h3 h4 h5 h6 head hr html img i
syn keyword cssTagName iframe input ins isindex kbd label legend li
syn keyword cssTagName link map menu meta noscript ol optgroup
syn keyword cssTagName option p param pre q s samp script small
syn keyword cssTagName span strong sub sup tbody td
syn keyword cssTagName textarea tfoot th thead title tr ul u var
syn keyword cssTagName object svg
syn match   cssTagName /\<select\>\|\<style\>\|\<table\>/
syn keyword cssTagName article aside audio bdi canvas command data
syn keyword cssTagName datalist details dialog embed figcaption figure footer
syn keyword cssTagName header hgroup keygen main mark menuitem meter nav
syn keyword cssTagName output progress rt rp ruby section
syn keyword cssTagName source summary time track video wbr
syn match cssTagName "\*"
syn match cssSelectorOp "[,>+~]"
syn match cssSelectorOp2 "[~|^$*]\?=" contained
syn region cssAttributeSelector matchgroup=cssSelectorOp start="\[" end="]" contains=cssUnicodeEscape,cssSelectorOp2,cssStringQ,cssStringQQ
syn match cssClassName "\.-\=[A-Za-z_][A-Za-z0-9_-]*" contains=cssClassNameDot
syn match cssClassNameDot contained '\.'
try
syn match cssIdentifier "#[A-Za-z�-�_@][A-Za-z�-�0-9_@-]*"
catch /^.*/
syn match cssIdentifier "#[A-Za-z_@][A-Za-z0-9_@-]*"
endtry
syn match cssValueInteger contained "[-+]\=\d\+" contains=cssUnitDecorators
syn match cssValueNumber contained "[-+]\=\d\+\(\.\d*\)\=" contains=cssUnitDecorators
syn match cssValueLength contained "[-+]\=\d\+\(\.\d*\)\=\(mm\|cm\|in\|pt\|pc\|em\|ex\|px\|rem\|dpi\|dppx\|dpcm\)\>" contains=cssUnitDecorators
syn match cssValueLength contained "[-+]\=\d\+\(\.\d*\)\=%" contains=cssUnitDecorators
syn match cssValueAngle contained "[-+]\=\d\+\(\.\d*\)\=\(deg\|grad\|rad\)\>" contains=cssUnitDecorators
syn match cssValueTime contained "+\=\d\+\(\.\d*\)\=\(ms\|s\)\>" contains=cssUnitDecorators
syn match cssValueFrequency contained "+\=\d\+\(\.\d*\)\=\(Hz\|kHz\)\>" contains=cssUnitDecorators
syn keyword cssColor contained aqua black blue fuchsia gray green lime maroon navy olive purple red silver teal yellow
syn keyword cssColor contained aliceblue antiquewhite aquamarine azure
syn keyword cssColor contained beige bisque blanchedalmond blueviolet brown burlywood
syn keyword cssColor contained cadetblue chartreuse chocolate coral cornflowerblue cornsilk crimson cyan
syn match cssColor contained /\<dark\(blue\|cyan\|goldenrod\|gray\|green\|grey\|khaki\)\>/
syn match cssColor contained /\<dark\(magenta\|olivegreen\|orange\|orchid\|red\|salmon\|seagreen\)\>/
syn match cssColor contained /\<darkslate\(blue\|gray\|grey\)\>/
syn match cssColor contained /\<dark\(turquoise\|violet\)\>/
syn keyword cssColor contained deeppink deepskyblue dimgray dimgrey dodgerblue firebrick
syn keyword cssColor contained floralwhite forestgreen gainsboro ghostwhite gold
syn keyword cssColor contained goldenrod greenyellow grey honeydew hotpink
syn keyword cssColor contained indianred indigo ivory khaki lavender lavenderblush lawngreen
syn keyword cssColor contained lemonchiffon limegreen linen magenta
syn match cssColor contained /\<light\(blue\|coral\|cyan\|goldenrodyellow\|gray\|green\)\>/
syn match cssColor contained /\<light\(grey\|pink\|salmon\|seagreen\|skyblue\|yellow\)\>/
syn match cssColor contained /\<light\(slategray\|slategrey\|steelblue\)\>/
syn match cssColor contained /\<medium\(aquamarine\|blue\|orchid\|purple\|seagreen\)\>/
syn match cssColor contained /\<medium\(slateblue\|springgreen\|turquoise\|violetred\)\>/
syn keyword cssColor contained midnightblue mintcream mistyrose moccasin navajowhite
syn keyword cssColor contained oldlace olivedrab orange orangered orchid
syn match cssColor contained /\<pale\(goldenrod\|green\|turquoise\|violetred\)\>/
syn keyword cssColor contained papayawhip peachpuff peru pink plum powderblue
syn keyword cssColor contained rosybrown royalblue rebeccapurple saddlebrown salmon
syn keyword cssColor contained sandybrown seagreen seashell sienna skyblue slateblue
syn keyword cssColor contained slategray slategrey snow springgreen steelblue tan
syn keyword cssColor contained thistle tomato turquoise violet wheat
syn keyword cssColor contained whitesmoke yellowgreen
syn case match
syn keyword cssColor contained ActiveBorder ActiveCaption AppWorkspace ButtonFace ButtonHighlight ButtonShadow ButtonText CaptionText GrayText Highlight HighlightText InactiveBorder InactiveCaption InactiveCaptionText InfoBackground InfoText Menu MenuText Scrollbar ThreeDDarkShadow ThreeDFace ThreeDHighlight ThreeDLightShadow ThreeDShadow Window WindowFrame WindowText Background
syn case ignore
syn match cssImportant contained "!\s*important\>"
syn match cssColor contained "\<transparent\>"
syn match cssColor contained "\<currentColor\>"
syn match cssColor contained "\<white\>"
syn match cssColor contained "#\x\{3,4\}\>" contains=cssUnitDecorators
syn match cssColor contained "#\x\{6\}\>" contains=cssUnitDecorators
syn match cssColor contained "#\x\{8\}\>" contains=cssUnitDecorators
syn region cssURL contained matchgroup=cssFunctionName start="\<\(uri\|url\|local\|format\)\s*(" end=")" contains=cssStringQ,cssStringQQ oneline
syn region cssFunction contained matchgroup=cssFunctionName start="\<\(rgb\|clip\|attr\|counter\|rect\|cubic-bezier\|steps\)\s*(" end=")" oneline  contains=cssValueInteger,cssValueNumber,cssValueLength,cssFunctionComma
syn region cssFunction contained matchgroup=cssFunctionName start="\<\(rgba\|hsl\|hsla\|color-stop\|from\|to\)\s*(" end=")" oneline  contains=cssColor,cssValueInteger,cssValueNumber,cssValueLength,cssFunctionComma,cssFunction
syn region cssFunction contained matchgroup=cssFunctionName start="\<\(linear-\|radial-\)\=\gradient\s*(" end=")" oneline  contains=cssColor,cssValueInteger,cssValueNumber,cssValueLength,cssFunction,cssGradientAttr,cssFunctionComma
syn region cssFunction contained matchgroup=cssFunctionName start="\<\(matrix\(3d\)\=\|scale\(3d\|X\|Y\|Z\)\=\|translate\(3d\|X\|Y\|Z\)\=\|skew\(X\|Y\)\=\|rotate\(3d\|X\|Y\|Z\)\=\|perspective\)\s*(" end=")" oneline contains=cssValueInteger,cssValueNumber,cssValueLength,cssValueAngle,cssFunctionComma
syn keyword cssGradientAttr contained top bottom left right cover center middle ellipse at
syn match cssFunctionComma contained ","
syn keyword cssCommonAttr contained auto none inherit all default normal
syn keyword cssCommonAttr contained top bottom center stretch hidden visible
syn match cssAnimationProp contained "\<animation\(-\(delay\|direction\|duration\|fill-mode\|name\|play-state\|timing-function\|iteration-count\)\)\=\>"
syn keyword cssAnimationAttr contained alternate reverse
syn match cssAnimationAttr contained "\<alternate-reverse\>"
syn keyword cssAnimationAttr contained forwards backwards both
syn keyword cssAnimationAttr contained running paused
syn keyword cssAnimationAttr contained infinite
syn match cssBackgroundProp contained "\<background\(-\(attachment\|clip\|color\|image\|origin\|position\|repeat\|size\)\)\=\>"
syn keyword cssBackgroundAttr contained scroll fixed local
syn keyword cssBackgroundAttr contained left center right top bottom
syn match cssBackgroundAttr contained "\<no-repeat\>"
syn match cssBackgroundAttr contained "\<repeat\(-[xy]\)\=\>"
syn keyword cssBackgroundAttr contained cover contain
syn match cssBorderProp contained "\<border\(-\(top\|right\|bottom\|left\)\)\=\(-\(width\|color\|style\)\)\=\>"
syn match cssBorderProp contained "\<border\(-\(top\|bottom\)-\(left\|right\)\)\=-radius\>"
syn match cssBorderProp contained "\<border-image\(-\(outset\|repeat\|slice\|source\|width\)\)\=\>"
syn match cssBorderProp contained "\<box-decoration-break\>"
syn match cssBorderProp contained "\<box-shadow\>"
syn keyword cssBorderAttr contained stretch round fill
syn keyword cssBorderAttr contained dotted dashed solid double groove ridge inset outset
syn keyword cssBorderAttr contained thin thick medium
syn keyword cssBorderAttr contained clone slice
syn match cssBoxProp contained "\<padding\(-\(top\|right\|bottom\|left\)\)\=\>"
syn match cssBoxProp contained "\<margin\(-\(top\|right\|bottom\|left\)\)\=\>"
syn match cssBoxProp contained "\<overflow\(-\(x\|y\|style\)\)\=\>"
syn match cssBoxProp contained "\<rotation\(-point\)\=\>"
syn keyword cssBoxAttr contained visible hidden scroll auto
syn match cssBoxAttr contained "\<no-\(display\|content\)\>"
syn keyword cssColorProp contained opacity
syn match cssColorProp contained "\<color-profile\>"
syn match cssColorProp contained "\<rendering-intent\>"
syn match cssDimensionProp contained "\<\(min\|max\)-\(width\|height\)\>"
syn keyword cssDimensionProp contained height
syn keyword cssDimensionProp contained width
syn match cssFlexibleBoxProp contained "\<flex\(-\(direction\|wrap\|flow\|grow\|shrink\|basis\)\)\=\>"
syn match cssFlexibleBoxProp contained "\<\(align\|justify\)\(-\(items\|self\|content\)\)\=\>"
syn keyword cssFlexibleBoxProp contained order
syn match cssFlexibleBoxAttr contained "\<\(row\|column\|wrap\)\(-reverse\)\=\>"
syn keyword cssFlexibleBoxAttr contained nowrap stretch baseline center
syn match cssFlexibleBoxAttr contained "\<flex\(-\(start\|end\)\)\=\>"
syn match cssFlexibleBoxAttr contained "\<space\(-\(between\|around\)\)\=\>"
syn match cssFontProp contained "\<font\(-\(family\|\|feature-settings\|kerning\|language-override\|size\(-adjust\)\=\|stretch\|style\|synthesis\|variant\(-\(alternates\|caps\|east-asian\|ligatures\|numeric\|position\)\)\=\|weight\)\)\=\>"
syn keyword cssFontAttr contained icon menu caption
syn match cssFontAttr contained "\<message-box\>"
syn match cssFontAttr contained "\<status-bar\>"
syn keyword cssFontAttr contained larger smaller
syn match cssFontAttr contained "\<\(x\{1,2\}-\)\=\(large\|small\)\>"
syn match cssFontAttr contained "\<small-\(caps\|caption\)\>"
syn match cssFontAttr contained "\<\(sans-\)\=serif\>"
syn keyword cssFontAttr contained Antiqua Arial Black Book Charcoal Comic Courier Dingbats Gadget Geneva Georgia Grande Helvetica Impact Linotype Lucida MS Monaco Neue New Palatino Roboto Roman Symbol Tahoma Times Trebuchet Verdana Webdings Wingdings York Zapf
syn keyword cssFontAttr contained cursive fantasy monospace
syn keyword cssFontAttr contained on off
syn match cssFontAttr contained "\<\(\(ultra\|extra\|semi\)-\)\=\(condensed\|expanded\)\>"
syn keyword cssFontAttr contained italic oblique
syn keyword cssFontAttr contained weight style
syn keyword cssFontAttr contained bold bolder lighter
syn match cssFontProp contained "\<font-smooth\>"
syn match cssFontAttr contained "\<\(subpixel-\)\=\antialiased\>"
syn match cssMultiColumnProp contained "\<break-\(after\|before\|inside\)\>"
syn match cssMultiColumnProp contained "\<column-\(count\|fill\|gap\|rule\(-\(color\|style\|width\)\)\=\|span\|width\)\>"
syn keyword cssMultiColumnProp contained columns
syn keyword cssMultiColumnAttr contained balance medium
syn keyword cssMultiColumnAttr contained always left right page column
syn match cssMultiColumnAttr contained "\<avoid\(-\(page\|column\)\)\=\>"
syn match cssMultiColumnProp contained "\<page\(-break-\(before\|after\|inside\)\)\=\>"
syn match cssInteractProp contained "\<pointer-events\>"
syn match cssInteractAttr contained "\<\(visible\)\=\(Painted\|Fill\|Stroke\)\=\>"
syn keyword cssGeneratedContentProp contained quotes crop
syn match cssGeneratedContentProp contained "\<counter-\(reset\|increment\)\>"
syn match cssGeneratedContentProp contained "\<move-to\>"
syn match cssGeneratedContentProp contained "\<page-policy\>"
syn match cssGeneratedContentAttr contained "\<\(no-\)\=\(open\|close\)-quote\>"
syn match cssGridProp contained "\<grid\>"
syn match cssGridProp contained "\<grid\(-\(template\|auto\)\)\=\(-\(columns\|rows\|areas\)\)\>"
syn match cssGridProp contained "\<grid-\(column\|row\)\(-\(start\|end\|gap\)\)\=\>"
syn match cssGridProp contained "\<grid-\(area\|gap\)\>"
syn match cssGridProp contained "\<grid-auto-flow\>"
syn match cssHyerlinkProp contained "\<target\(-\(name\|new\|position\)\)\=\>"
syn match cssListProp contained "\<list-style\(-\(type\|position\|image\)\)\=\>"
syn match cssListAttr contained "\<\(lower\|upper\)-\(roman\|alpha\|greek\|latin\)\>"
syn match cssListAttr contained "\<\(hiragana\|katakana\)\(-iroha\)\=\>"
syn match cssListAttr contained "\<\(decimal\(-leading-zero\)\=\|cjk-ideographic\)\>"
syn keyword cssListAttr contained disc circle square hebrew armenian georgian
syn keyword cssListAttr contained inside outside
syn keyword cssPositioningProp contained bottom clear clip display float left
syn keyword cssPositioningProp contained position right top visibility
syn match cssPositioningProp contained "\<z-index\>"
syn keyword cssPositioningAttr contained block compact grid
syn match cssPositioningAttr contained "\<table\(-\(row-group\|\(header\|footer\)-group\|row\|column\(-group\)\=\|cell\|caption\)\)\=\>"
syn keyword cssPositioningAttr contained left right both
syn match cssPositioningAttr contained "\<list-item\>"
syn match cssPositioningAttr contained "\<inline\(-\(block\|box\|table\|grid\|flex\)\)\=\>"
syn keyword cssPositioningAttr contained static relative absolute fixed subgrid
syn keyword cssPrintAttr contained landscape portrait crop cross always
syn match cssTableProp contained "\<\(caption-side\|table-layout\|border-collapse\|border-spacing\|empty-cells\)\>"
syn keyword cssTableAttr contained fixed collapse separate show hide once always
syn keyword cssTextProp contained color direction
syn match cssTextProp "\<\(\(word\|letter\)-spacing\|text\(-\(decoration\|transform\|align\|index\|shadow\)\)\=\|vertical-align\|unicode-bidi\|line-height\)\>"
syn match cssTextProp contained "\<text-\(justify\|outline\|warp\|align-last\|size-adjust\|rendering\|stroke\|indent\)\>"
syn match cssTextProp contained "\<word-\(break\|\wrap\)\>"
syn match cssTextProp contained "\<white-space\>"
syn match cssTextProp contained "\<hanging-punctuation\>"
syn match cssTextProp contained "\<punctuation-trim\>"
syn match cssTextAttr contained "\<line-through\>"
syn match cssTextAttr contained "\<\(text-\)\=\(top\|bottom\)\>"
syn keyword cssTextAttr contained ltr rtl embed nowrap
syn keyword cssTextAttr contained underline overline blink sub super middle
syn keyword cssTextAttr contained capitalize uppercase lowercase
syn keyword cssTextAttr contained justify baseline sub super
syn keyword cssTextAttr contained optimizeLegibility optimizeSpeed
syn match cssTextAttr contained "\<pre\(-\(line\|wrap\)\)\=\>"
syn match cssTextAttr contained "\<\(allow\|force\)-end\>"
syn keyword cssTextAttr contained start end adjacent
syn match cssTextAttr contained "\<inter-\(word\|ideographic\|cluster\)\>"
syn keyword cssTextAttr contained distribute kashida first last
syn keyword cssTextAttr contained clip ellipsis unrestricted suppress
syn match cssTextAttr contained "\<break-all\>"
syn match cssTextAttr contained "\<break-word\>"
syn keyword cssTextAttr contained hyphenate
syn match cssTextAttr contained "\<bidi-override\>"
syn match cssTransformProp contained "\<transform\(-\(origin\|style\)\)\=\>"
syn match cssTransformProp contained "\<perspective\(-origin\)\=\>"
syn match cssTransformProp contained "\<backface-visibility\>"
syn match cssTransitionProp contained "\<transition\(-\(delay\|duration\|property\|timing-function\)\)\=\>"
syn match cssTransitionAttr contained "\<linear\(-gradient\)\@!\>"
syn match cssTransitionAttr contained "\<ease\(-\(in-out\|out\|in\)\)\=\>"
syn match cssTransitionAttr contained "\<step\(-start\|-end\)\=\>"
syn match cssUIProp contained "\<box-sizing\>"
syn match cssUIAttr contained "\<\(content\|padding\|border\)\(-box\)\=\>"
syn keyword cssUIProp contained cursor
syn match cssUIAttr contained "\<\(\([ns]\=[ew]\=\)\|col\|row\|nesw\|nwse\)-resize\>"
syn keyword cssUIAttr contained crosshair help move pointer alias copy
syn keyword cssUIAttr contained progress wait text cell move
syn match cssUIAttr contained "\<context-menu\>"
syn match cssUIAttr contained "\<no-drop\>"
syn match cssUIAttr contained "\<not-allowed\>"
syn match cssUIAttr contained "\<all-scroll\>"
syn match cssUIAttr contained "\<\(vertical-\)\=text\>"
syn match cssUIAttr contained "\<zoom\(-in\|-out\)\=\>"
syn match cssUIProp contained "\<ime-mode\>"
syn keyword cssUIAttr contained active inactive disabled
syn match cssUIProp contained "\<nav-\(down\|index\|left\|right\|up\)\=\>"
syn match cssUIProp contained "\<outline\(-\(width\|style\|color\|offset\)\)\=\>"
syn keyword cssUIAttr contained invert
syn keyword cssUIProp contained icon resize
syn keyword cssUIAttr contained both horizontal vertical
syn match cssUIProp contained "\<text-overflow\>"
syn keyword cssUIAttr contained clip ellipsis
syn match cssUIProp contained "\<image-rendering\>"
syn keyword cssUIAttr contained pixellated
syn match cssUIAttr contained "\<crisp-edges\>"
syn match cssUIAttr contained '\<preserve-3d\>'
syn match cssIEUIAttr contained '\<bicubic\>'
syn match cssUIProp contained '\<tap-highlight-color\|user-select\|touch-callout\>'
syn match cssIEUIProp contained '\<interpolation-mode\|zoom\|filter\>'
syn keyword cssUIProp contained appearance
syn keyword cssUIAttr contained window button field icon document menu
syn match cssAuralProp contained "\<\(pause\|cue\)\(-\(before\|after\)\)\=\>"
syn match cssAuralProp contained "\<\(play-during\|speech-rate\|voice-family\|pitch\(-range\)\=\|speak\(-\(punctuation\|numeral\|header\)\)\=\)\>"
syn keyword cssAuralProp contained volume during azimuth elevation stress richness
syn match cssAuralAttr contained "\<\(x-\)\=\(soft\|loud\)\>"
syn keyword cssAuralAttr contained silent
syn match cssAuralAttr contained "\<spell-out\>"
syn keyword cssAuralAttr contained non mix
syn match cssAuralAttr contained "\<\(left\|right\)-side\>"
syn match cssAuralAttr contained "\<\(far\|center\)-\(left\|center\|right\)\>"
syn keyword cssAuralAttr contained leftwards rightwards behind
syn keyword cssAuralAttr contained below level above lower higher
syn match cssAuralAttr contained "\<\(x-\)\=\(slow\|fast\|low\|high\)\>"
syn keyword cssAuralAttr contained faster slower
syn keyword cssAuralAttr contained male female child code digits continuous
syn match cssMobileTextProp contained "\<text-size-adjust\>"
syn keyword cssMediaProp contained width height orientation scan grid
syn match cssMediaProp contained /\(\(max\|min\)-\)\=\(\(device\)-\)\=aspect-ratio/
syn match cssMediaProp contained /\(\(max\|min\)-\)\=device-pixel-ratio/
syn match cssMediaProp contained /\(\(max\|min\)-\)\=device-\(height\|width\)/
syn match cssMediaProp contained /\(\(max\|min\)-\)\=\(height\|width\|resolution\|monochrome\|color\(-index\)\=\)/
syn keyword cssMediaAttr contained portrait landscape progressive interlace
syn match cssKeyFrameProp /\d*%\|from\|to/  contained nextgroup=cssDefinition
syn match cssPageMarginProp /@\(\(top\|left\|right\|bottom\)-\(left\|center\|right\|middle\|bottom\)\)\(-corner\)\=/ contained nextgroup=cssDefinition
syn keyword cssPageProp contained content size
syn keyword cssPageProp contained orphans widows
syn keyword cssFontDescriptorProp contained src
syn match cssFontDescriptorProp contained "\<unicode-range\>"
syn match cssFontDescriptorAttr contained "U+[0-9A-Fa-f?]\+"
syn match cssFontDescriptorAttr contained "U+\x\+-\x\+"
syn match cssBraces contained "[{}]"
syn match cssError contained "{@<>"
syn region cssDefinition transparent matchgroup=cssBraces start='{' end='}' contains=cssTagName,cssAttributeSelector,cssClassName,cssIdentifier,cssAtRule,cssAttrRegion,css.*Prop,cssComment,cssValue.*,cssColor,cssURL,cssImportant,cssError,cssStringQ,cssStringQQ,cssFunction,cssUnicodeEscape,cssVendor,cssDefinition,cssHacks,cssNoise fold
syn match cssBraceError "}"
syn match cssAttrComma ","
syn match cssPseudoClass ":[A-Za-z0-9_-]*" contains=cssNoise,cssPseudoClassId,cssUnicodeEscape,cssVendor,cssPseudoClassFn
syn keyword cssPseudoClassId contained link visited active hover before after left right
syn keyword cssPseudoClassId contained root empty target enable disabled checked invalid
syn match cssPseudoClassId contained "\<first-\(line\|letter\)\>"
syn match cssPseudoClassId contained "\<\(first\|last\|only\)-\(of-type\|child\)\>"
syn region cssPseudoClassFn contained matchgroup=cssFunctionName start="\<\(not\|lang\|\(nth\|nth-last\)-\(of-type\|child\)\)(" end=")"
syn match cssPseudoClassId contained  "\<selection\>"
syn match cssPseudoClassId contained  "\<focus\(-inner\)\=\>"
syn match cssPseudoClassId contained  "\<\(input-\)\=placeholder\>"
syntax match cssUnitDecorators /\(#\|-\|+\|%\|mm\|cm\|in\|pt\|pc\|em\|ex\|px\|ch\|rem\|vh\|vw\|vmin\|vmax\|dpi\|dppx\|dpcm\|Hz\|kHz\|s\|ms\|deg\|grad\|rad\)/ contained
syntax match cssNoise contained /\(:\|;\|\/\)/
syn region cssComment start="/\*" end="\*/" contains=@Spell fold
syn match cssUnicodeEscape "\\\x\{1,6}\s\?"
syn match cssSpecialCharQQ +\\\\\|\\"+ contained
syn match cssSpecialCharQ +\\\\\|\\'+ contained
syn region cssStringQQ start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=cssUnicodeEscape,cssSpecialCharQQ
syn region cssStringQ start=+'+ skip=+\\\\\|\\'+ end=+'+ contains=cssUnicodeEscape,cssSpecialCharQ
syn match cssVendor contained "-\(webkit\|moz\|o\|ms\)-"
syn match cssHacks contained /\(_\|*\)/
syn region cssAttrRegion start=/:/ end=/\ze\(;\|)\|}\)/ contained contains=css.*Attr,cssColor,cssImportant,cssValue.*,cssFunction,cssString.*,cssURL,cssComment,cssUnicodeEscape,cssVendor,cssError,cssAttrComma,cssNoise
syn region cssAttrRegion start=/transition\s*:/ end=/\ze\(;\|)\|}\)/ contained contains=css.*Prop,css.*Attr,cssColor,cssImportant,cssValue.*,cssFunction,cssString.*,cssURL,cssComment,cssUnicodeEscape,cssVendor,cssError,cssAttrComma,cssNoise
syn match cssAtKeyword /@\(font-face\|media\|keyframes\|import\|charset\|namespace\|page\|supports\)/ contained
syn keyword cssAtRuleLogical only not and contained
syn region cssAtRule start=/@media\>/ end=/\ze{/ skipwhite skipnl matchgroup=cssAtKeyword contains=cssMediaProp,cssValueLength,cssAtRuleLogical,cssValueInteger,cssMediaAttr,cssVendor,cssMediaType,cssComment nextgroup=cssDefinition
syn keyword cssMediaType contained screen print aural braille embossed handheld projection tty tv speech all contained
syn region cssAtRule start=/@page\>/ end=/\ze{/ skipwhite skipnl matchgroup=cssAtKeyword contains=cssPagePseudo,cssComment nextgroup=cssDefinition
syn match cssPagePseudo /:\(left\|right\|first\|blank\)/ contained skipwhite skipnl
syn region cssAtRule start=/@\(-[a-z]\+-\)\=keyframes\>/ end=/\ze{/ skipwhite skipnl matchgroup=cssAtKeyword contains=cssVendor,cssComment nextgroup=cssDefinition
syn region cssAtRule start=/@import\>/    end=/\ze;/ contains=cssStringQ,cssStringQQ,cssUnicodeEscape,cssComment,cssAtKeyword,cssURL,cssMediaProp,cssValueLength,cssAtRuleLogical,cssValueInteger,cssMediaAttr,cssMediaType
syn region cssAtRule start=/@charset\>/   end=/\ze;/ contains=cssStringQ,cssStringQQ,cssUnicodeEscape,cssComment,cssAtKeyword
syn region cssAtRule start=/@namespace\>/ end=/\ze;/ contains=cssStringQ,cssStringQQ,cssUnicodeEscape,cssComment,cssAtKeyword
syn match cssAtRule "@font-face\>" nextgroup=cssFontDescriptorBlock
syn region cssAtRule start=/@supports\>/ end=/\ze{/ skipwhite skipnl contains=cssAtRuleLogical,cssAttrRegion,css.*Prop,cssValue.*,cssVendor,cssAtKeyword,cssComment nextgroup=cssDefinition
if main_syntax == "css"
syn sync minlines=10
endif
hi def link cssComment Comment
hi def link cssVendor Comment
hi def link cssHacks Comment
hi def link cssTagName Statement
hi def link cssDeprecated Error
hi def link cssSelectorOp Special
hi def link cssSelectorOp2 Special
hi def link cssAttrComma Special
hi def link cssAnimationProp cssProp
hi def link cssBackgroundProp cssProp
hi def link cssBorderProp cssProp
hi def link cssBoxProp cssProp
hi def link cssColorProp cssProp
hi def link cssContentForPagedMediaProp cssProp
hi def link cssDimensionProp cssProp
hi def link cssFlexibleBoxProp cssProp
hi def link cssFontProp cssProp
hi def link cssGeneratedContentProp cssProp
hi def link cssGridProp cssProp
hi def link cssHyerlinkProp cssProp
hi def link cssInteractProp cssProp
hi def link cssLineboxProp cssProp
hi def link cssListProp cssProp
hi def link cssMarqueeProp cssProp
hi def link cssMultiColumnProp cssProp
hi def link cssPagedMediaProp cssProp
hi def link cssPositioningProp cssProp
hi def link cssPrintProp cssProp
hi def link cssRubyProp cssProp
hi def link cssSpeechProp cssProp
hi def link cssTableProp cssProp
hi def link cssTextProp cssProp
hi def link cssTransformProp cssProp
hi def link cssTransitionProp cssProp
hi def link cssUIProp cssProp
hi def link cssIEUIProp cssProp
hi def link cssAuralProp cssProp
hi def link cssRenderProp cssProp
hi def link cssMobileTextProp cssProp
hi def link cssAnimationAttr cssAttr
hi def link cssBackgroundAttr cssAttr
hi def link cssBorderAttr cssAttr
hi def link cssBoxAttr cssAttr
hi def link cssContentForPagedMediaAttr cssAttr
hi def link cssDimensionAttr cssAttr
hi def link cssFlexibleBoxAttr cssAttr
hi def link cssFontAttr cssAttr
hi def link cssGeneratedContentAttr cssAttr
hi def link cssGridAttr cssAttr
hi def link cssHyerlinkAttr cssAttr
hi def link cssInteractAttr cssAttr
hi def link cssLineboxAttr cssAttr
hi def link cssListAttr cssAttr
hi def link cssMarginAttr cssAttr
hi def link cssMarqueeAttr cssAttr
hi def link cssMultiColumnAttr cssAttr
hi def link cssPaddingAttr cssAttr
hi def link cssPagedMediaAttr cssAttr
hi def link cssPositioningAttr cssAttr
hi def link cssGradientAttr cssAttr
hi def link cssPrintAttr cssAttr
hi def link cssRubyAttr cssAttr
hi def link cssSpeechAttr cssAttr
hi def link cssTableAttr cssAttr
hi def link cssTextAttr cssAttr
hi def link cssTransformAttr cssAttr
hi def link cssTransitionAttr cssAttr
hi def link cssUIAttr cssAttr
hi def link cssIEUIAttr cssAttr
hi def link cssAuralAttr cssAttr
hi def link cssRenderAttr cssAttr
hi def link cssCommonAttr cssAttr
hi def link cssPseudoClassId PreProc
hi def link cssPseudoClassLang Constant
hi def link cssValueLength Number
hi def link cssValueInteger Number
hi def link cssValueNumber Number
hi def link cssValueAngle Number
hi def link cssValueTime Number
hi def link cssValueFrequency Number
hi def link cssFunction Constant
hi def link cssURL String
hi def link cssFunctionName Function
hi def link cssFunctionComma Function
hi def link cssColor Constant
hi def link cssIdentifier Function
hi def link cssAtRule Include
hi def link cssAtKeyword PreProc
hi def link cssImportant Special
hi def link cssBraces Function
hi def link cssBraceError Error
hi def link cssError Error
hi def link cssUnicodeEscape Special
hi def link cssStringQQ String
hi def link cssStringQ String
hi def link cssAttributeSelector String
hi def link cssMediaType Special
hi def link cssMediaComma Normal
hi def link cssAtRuleLogical Statement
hi def link cssMediaProp cssProp
hi def link cssMediaAttr cssAttr
hi def link cssPagePseudo PreProc
hi def link cssPageMarginProp cssAtKeyword
hi def link cssPageProp cssProp
hi def link cssKeyFrameProp Constant
hi def link cssFontDescriptor Special
hi def link cssFontDescriptorProp cssProp
hi def link cssFontDescriptorAttr cssAttr
hi def link cssUnicodeRange Constant
hi def link cssClassName Function
hi def link cssClassNameDot Function
hi def link cssProp StorageClass
hi def link cssAttr Constant
hi def link cssUnitDecorators Number
hi def link cssNoise Noise
let b:current_syntax = "css"
if main_syntax == 'css'
unlet main_syntax
endif
let &cpo = s:cpo_save
unlet s:cpo_save
