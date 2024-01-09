#!/bin/sh

# Display usage
cpack_usage()
{
  cat <<EOF
Usage: $0 [options]
Options: [defaults in brackets after descriptions]
  --help            print this message
  --version         print cmake installer version
  --prefix=dir      directory in which to install
  --include-subdir  include the LibeventPlus-1.0-Darwin subdirectory
  --exclude-subdir  exclude the LibeventPlus-1.0-Darwin subdirectory
  --skip-license    accept license
EOF
  exit 1
}

cpack_echo_exit()
{
  echo $1
  exit 1
}

# Display version
cpack_version()
{
  echo "LibeventPlus Installer Version: 1.0, Copyright (c) Humanity"
}

# Helper function to fix windows paths.
cpack_fix_slashes ()
{
  echo "$1" | sed 's/\\/\//g'
}

interactive=TRUE
cpack_skip_license=FALSE
cpack_include_subdir=""
for a in "$@"; do
  if echo $a | grep "^--prefix=" > /dev/null 2> /dev/null; then
    cpack_prefix_dir=`echo $a | sed "s/^--prefix=//"`
    cpack_prefix_dir=`cpack_fix_slashes "${cpack_prefix_dir}"`
  fi
  if echo $a | grep "^--help" > /dev/null 2> /dev/null; then
    cpack_usage
  fi
  if echo $a | grep "^--version" > /dev/null 2> /dev/null; then
    cpack_version
    exit 2
  fi
  if echo $a | grep "^--include-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=TRUE
  fi
  if echo $a | grep "^--exclude-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=FALSE
  fi
  if echo $a | grep "^--skip-license" > /dev/null 2> /dev/null; then
    cpack_skip_license=TRUE
  fi
done

if [ "x${cpack_include_subdir}x" != "xx" -o "x${cpack_skip_license}x" = "xTRUEx" ]
then
  interactive=FALSE
fi

cpack_version
echo "This is a self-extracting archive."
toplevel="`pwd`"
if [ "x${cpack_prefix_dir}x" != "xx" ]
then
  toplevel="${cpack_prefix_dir}"
fi

echo "The archive will be extracted to: ${toplevel}"

if [ "x${interactive}x" = "xTRUEx" ]
then
  echo ""
  echo "If you want to stop extracting, please press <ctrl-C>."

  if [ "x${cpack_skip_license}x" != "xTRUEx" ]
  then
    more << '____cpack__here_doc____'
This package is available for use in compliance with the official Libevent license, given below:

==============================
Libevent is available for use under the following license, commonly known
as the 3-clause (or "modified") BSD license:

==============================
Copyright (c) 2000-2007 Niels Provos <provos@citi.umich.edu>
Copyright (c) 2007-2012 Niels Provos and Nick Mathewson

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:
1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.
3. The name of the author may not be used to endorse or promote products
   derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
==============================

Portions of Libevent are based on works by others, also made available by
them under the three-clause BSD license above.  The copyright notices are
available in the corresponding source files; the license is as above.  Here's
a list:

log.c:
   Copyright (c) 2000 Dug Song <dugsong@monkey.org>
   Copyright (c) 1993 The Regents of the University of California.

strlcpy.c:
   Copyright (c) 1998 Todd C. Miller <Todd.Miller@courtesan.com>

win32select.c:
   Copyright (c) 2003 Michael A. Davis <mike@datanerds.net>

evport.c:
   Copyright (c) 2007 Sun Microsystems

ht-internal.h:
   Copyright (c) 2002 Christopher Clark

minheap-internal.h:
   Copyright (c) 2006 Maxim Yegorushkin <maxim.yegorushkin@gmail.com>

==============================

The arc4module is available under the following, sometimes called the
"OpenBSD" license:

   Copyright (c) 1996, David Mazieres <dm@uun.org>
   Copyright (c) 2008, Damien Miller <djm@openbsd.org>

   Permission to use, copy, modify, and distribute this software for any
   purpose with or without fee is hereby granted, provided that the above
   copyright notice and this permission notice appear in all copies.

   THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
   WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
   MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
   ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

==============================

The Windows timer code is based on code from libutp, which is
distributed under this license, sometimes called the "MIT" license.


Copyright (c) 2010 BitTorrent, Inc.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

==============================

The wepoll module is available under the following, sometimes called the
"FreeBSD" license:

Copyright 2012-2020, Bert Belder <bertbelder@gmail.com>
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

  * Redistributions of source code must retain the above copyright
    notice, this list of conditions and the following disclaimer.

  * Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the
    documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

==============================

The ssl-client-mbedtls.c is available under the following license:

Copyright (C) 2006-2015, ARM Limited, All Rights Reserved
SPDX-License-Identifier: Apache-2.0

Licensed under the Apache License, Version 2.0 (the "License"); you may
not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

This file is part of mbed TLS (https://tls.mbed.org)

____cpack__here_doc____
    echo
    while true
      do
        echo "Do you accept the license? [yn]: "
        read line leftover
        case ${line} in
          y* | Y*)
            cpack_license_accepted=TRUE
            break;;
          n* | N* | q* | Q* | e* | E*)
            echo "License not accepted. Exiting ..."
            exit 1;;
        esac
      done
  fi

  if [ "x${cpack_include_subdir}x" = "xx" ]
  then
    echo "By default the LibeventPlus will be installed in:"
    echo "  \"${toplevel}/LibeventPlus-1.0-Darwin\""
    echo "Do you want to include the subdirectory LibeventPlus-1.0-Darwin?"
    echo "Saying no will install in: \"${toplevel}\" [Yn]: "
    read line leftover
    cpack_include_subdir=TRUE
    case ${line} in
      n* | N*)
        cpack_include_subdir=FALSE
    esac
  fi
fi

if [ "x${cpack_include_subdir}x" = "xTRUEx" ]
then
  toplevel="${toplevel}/LibeventPlus-1.0-Darwin"
  mkdir -p "${toplevel}"
fi
echo
echo "Using target directory: ${toplevel}"
echo "Extracting, please wait..."
echo ""

# take the archive portion of this file and pipe it to tar
# the NUMERIC parameter in this command should be one more
# than the number of lines in this header file
# there are tails which don't understand the "-n" argument, e.g. on SunOS
# OTOH there are tails which complain when not using the "-n" argument (e.g. GNU)
# so at first try to tail some file to see if tail fails if used with "-n"
# if so, don't use "-n"
use_new_tail_syntax="-n"
tail $use_new_tail_syntax +1 "$0" > /dev/null 2> /dev/null || use_new_tail_syntax=""

extractor="pax -r"
command -v pax > /dev/null 2> /dev/null || extractor="tar xf -"

tail $use_new_tail_syntax +304 "$0" | gunzip | (cd "${toplevel}" && ${extractor}) || cpack_echo_exit "Problem unpacking the LibeventPlus-1.0-Darwin"

echo "Unpacking finished successfully"

exit 0
#-----------------------------------------------------------
#      Start of TAR.GZ file
#-----------------------------------------------------------;
‹ İ¢e í=kpÇy>d™±#%i;N›-d§ -A ø”ü"DDV	ƒ¤GuœÀ¼8 ¸)FaÃÄñTûP&u›G3U“i¤íÄÓdš‡'µ»±'“6J:qİ·òjØTádYÉ4Q¿ow¸;ø°-åµßhoïÛıöûöñí÷}» ÄŒaî'Wb±Ø`?eù Ïc‰> ñ¾ş¾ÁŞD¼··ŸÆâ½ñÁ¡ıW»cUËÖ*Ğ•E£P(Œ½Ldùü|Ä8êùO	d`ıFfÂÈèºi§
U+š[‚’—PÆ†ëÇ]ëë…õ‡·>Bc/aZÂÏùúñÿû£ë	µÃûH»!wò0y«¿Òé!ª:£Ÿ	`0ŒwŠÔ!ŠUÕÖOÚ2?¿áQ¾³wt7ªª–]ÍX-ùıÉİ<ÿCîÀNÁoG½ı\6«ê'³zÙVm-ãç7tÏc.¼´U­š‹†™S3_
èß¼à÷^¾¿›­ª&g’êÈÔä4ç6,Zäí"Á²µ…q–\ËĞ’ßs¤Á§İE¿CôÅİ¯1Ægb|ò¨2:îŒqÅ×_æjÅúrñ¹Ò¤›|åÃ•²fÏ·6Q}Ày·à&°WàgßAH¤Ï)ò¼ü0!£ï\%dñ2xO	"İ©Ò-¤5½‹Él‚[„œ[zöEC÷|ìÿx±û#èI@uÆÔ	£l{9{gsúQ{áëâÀ„Ï'òbúÂ±“ì¯Z•ı…RV+à\`b“¡fK}_"zÍ6ò‰¹ù|pxö‚óá²·ßy³\óô¡»†:ıôÓK–­£‡Ü’^/úÿÌÃ\^·Àq¾%H A‚	$H A‚	$H A‚	$H A‚	$H A‚	$H A‚	$üøav¬öÍ±‡.î«-_[U.Õ”õµ¿ÜIÈXí	À×Çj;Çzj÷ŸÜõº•fúåËk]¹rÅ¡õXW«®3~«Ç ¿Ù ·§™Ğ7>™ßõºw6Ëgmou}ícu¾y€h =ã?´ö÷×òßXÉéÇjO¯áO×XRkï†Úµ·\'ğ¦şÿÅÖûoO‡‚ûŸ‚6ækÏŒÕ¾?V;öœÃ¡6{1_S¾=QS.°á¯Â´*Ÿ\U.Ö”§ò«Ê·¡òY¨¸ ¥Ï¬=}„.=
ÃÿäêìS«Ê3ãµ'€ìÙ]?³öõv¬Uƒ¾¦šåÇê²ÏÈÀ.1ù±U(ÁÀüÂÄê±çss>œc|¶7™ï£;œ©ÎŸqêO?súKÃ§¿ƒd+_}~å«¡ÓÇ.İ:­|Û¿«úü§ğ‡Iñ/_ú\h—òùáw-_ŠùoqB‡/=%Ï^ÿ%(ûŞ§ñ§\ñKõ².ÀªÄ;ër7ê_ü\ísk_Ú‡.“]pîÖĞ®¿9ç¬p€¾±6Lå>Ôfóq"XVÀ~áôûı#[¤ÿ~Çöè¿Ú±­şŒ­vşÎìjlm±Ã™áÖû³1_ã-×ƒÖék³k®6c«³kk¯æí¨[¾Vı® ]­~wm_Ğ(ú˜Ë^b·öávÇhg[&âÓ¬H¹ÀÃj6áòsk×‡sÁ·(=–CÛ¶\¯)×RlO,¯¯İáşñ¤¿µÚh¬WØ|µÊv˜Øm
ì¶ókóînîtöœş6äÏ-dÀNV¹-‹ùíƒßÕvëƒÛş>¹ı½Æö}[“}¿íW®Ûómø£ìy“=¹7´}{òËAm¶`OËjZ/ï~¹%¨U}åkëØéRcXŸİõxõÒÚ¿‘@óâİÏîö-
x	·ô®Ç××ibüÊmo€n]¹íì©²§ÆYö¬²ç"{.±ç)ö\fÏ·±çÛÙó!ö|˜=›=kì¹Ê¿Ë¿ÏïfÏ÷°ç#ìùGìù>öü ÿuò•ÜêxUçø±ò•+¡È^BöŞr9²¯¹³×şÛÚ[!õß|#zod˜ÿî=Èiüf=ç5!d}€ÿş|ı ¨4äçï$äø=ü7Å7Ğ.ôQà{D¬ã{	ÅÀJŸÙABçvø’İ+!‘·‰¼]ä"ïù‘_'ò"¿^ä]"™Èoù"¹Èw‰|·È_!òWŠüU"ÿ‘ÿ¢ÈIä¯ùM"¿Yä¯áZñP‚	$H A‚	$H A‚	$H A‚	$H A‚	$H A‚	$H A‚	$H A‚	$HøIJøßÿ$áÇÜı÷×ÿ¾Äùåì÷öø§Ä‡4ìï™·Ò&ä‡£fà=é4”ê?Ïÿ#‚PWˆ„B2!ôH—!…ÛHhRÒ‡ }ÒEH´„ MBÊAz¤ˆ©ê¬¹h˜95­[Õ¢øıÓö[¯S³õ,ÈR,7‹©Ù“ššÑçSÍjvv‹æNTËzÅ*™ZÁ°—Ô…–Zv®TµËDåc]Ëåœ×ŒféjÎ°Êœ»°Z,sÜò”çK]ËÎó"oME×=sº­Vª¦i˜säs%x^'šJõ“†—´P*•›
šÛbi¶dÚ†YÕ›*š˜šú¢/WŒRçÌ0”9½à¼º‡çj[ÖÍ°:\,½ÎÄÒy5›Ñ*s¨\°~“ıìïİ“ßÙÁ4rı<Vğqş- e©£ƒ¶QÔ´yõym;9‡UŞ
³o¥ê•ƒ€/a£Exœ;	-ã±Æx+uxÊt¯Jîíçpi›š©d"EŞ ‚O¢ôd¼qó3!Ñş‘`°J‘÷WÈJ(¡'B0„·`o–“²@şŠÈBùYÕuñÌH}zƒ¼²ôP!¿:PÑ‹¥hKÕ²¶˜Eî!ÿ%ßiÓ
ù`uÁÚ8Kƒ ×‡Ç'ò™¶òÙ6uëUœŒ*!q¦Á–­ÙUK!O·%ÜêÒş¹m°IA¡ø?Ú†°£fµètÖĞ-èî×QÂ›q!Êh2òXû9×ŞNÎ È³v¬‚Yñ®á¿Ù…vÒ–3rL³AÆ³íF*ä›Àá<6^gËø(…¦ã*ù`iÇFLÑ¡Õ{:êjØ{;@	E¯‹E>ÔÃ/"»Kõµò-(>ƒÅçêÅß‡âu°¼Ø+øP'ÀÄ–E±‚Ü‰+ø§P~Ş$dgœ¬µõÂt)äïÚ…PR‡ÔQ·â¤rUAÍTÉ—Ú‡Èåöä¯:FÈ™ÎQòçÎr~¼“´õ+L«`/‡ =ùû¯YÎb4‹í¦±•Ğƒt%	 <…UX…Ân¿¶Ò¯„Väø_şòvşÿÊ <%ğ1ÿ“ÀÿŸ˜]`ø×ïâø¯|Dà)ß/ğs·NÅÿqón?(ğOüìÿ¢ÀÏßÁñ
|XÔßâxYà1ô¿)p*ê—ND~OàçEı‡zQÿ˜À<Èño	<&ğ—µ	~	|]à÷üœÀøÊÇ?$ğşŸô?øÙM»/ğg~^àïxYà&ğ±ş_tÚùÿ'ğsb~;D{Ç~FàÇ>,ğ¼Àc‚ÿÛ¾.êß+ğ”¨ÿx‹#êÿ[ÚSosğ¯øğ÷áßğáÏûğ;½üoâx=ÔÙãÃ‡|xÊ‡¿É‡ŸòáïóáõáOùğ¯øğÿñá;¼øÍ>¼Û‡øğI~¿×}¸íÃOûåAêt;¤½öAŠAŠCJ@ê…Ô©.9.3ªªª4nKÜj¸½pË£Y†”„tˆpû$#
iÿUEI#ÎàV¶Éû	˜?v9®Àú…¦â†ÿö×xÜùF•©–2GâÜY”§Z‡+AÔ"€iªJ´Ø–€DK£ñ€™M:±QŞğŠqO4Óˆ}6§]¦ñGCDR epÌDÊ"ŸZV‹ØrÄÔxÈ|Ö×ã±@ı"ftÀ°¸c¸@‚À°nË”87o$O]p_š7‡§.¸Ñh+n£­Z4_öÀ¸jæ#«
j}uÉ‘‘vV/Ûª­e
z_SI"ÑT4@|`˜ÙB5§ï÷—¿” gÁş~ÊòÇ}<@ã}ı}ƒ½‰xoo?Åûb}½„ö_ÍN9P»_®,…B© îµLdùü|Ä8êùO	8ëÏÔ.:_._0}}-×?LÔ×?€sj¼``ĞØUèKüœ¯ÿ#oæô<Ÿ™˜UTå>erFK¥ºö@±aê5]{„ÖĞ;™Ú$í¹ÛUfeûĞN¢Z…»ºL­¨ƒ×Èê”ù3zª«›eQæØ ¥ `ÀºdcÓÙ]œ š)ÙF=kiåŠÏ½Ğ jÕ*eO€O±i>·—Zó¥
¼´9k/gÌŒjFËPó&ÍföÒ…’‘ë¡`w­î;‚d`OšjØóõTï¦wQ0ÿº­S I£æ·xU·Xøõ\OE³K•»6çÜLÌ…Ô©2¥R‚û¸$×ËÀõY6\µüDü¬ÒÔÖ}2Š°xâ'¬Z"®¹ßÑ^w·TˆE Õ2ŒktıçF{QÂ–Ácÿë»õ¥•±‰ıO@t ì|°/6ö` > íÿµ€`û(9­làêÕx‚FMÕ,UrzEÏ©E­|÷f~à†Ç=ƒËæoä OÄo·Yaıìf¦¥™õ‘2Z¿%wd4·l2Ò[’ÜJˆö’ÓúÑ6ÒÚï-Îkv°ÛóOÌ‹dÇ½(í/êâŒnv‘€"æJfÜ6{Í@œŠç0µdªz±ÜìaœƒZ“ªWxœíivrõ£aç$°"¸‰ûDé®dSâºhÚ°ïªzhŞ7Uâí
v¼Gk80ºbìˆwê®Û{ñÄ¸é×ÚtHü3`‚¯êÙaûçÿ^ˆ äùÿZ ®¶¨¸š7@/àş'Ñ'×ÿš@cı'0Ã
Uë¥U†í¯ÿÀÀ@B®ÿµ€ëïFFJfŞ˜‹2ª$c“ó_,ã÷ıƒığKôö%äùïš€sJ‹Ğğ­§F%*êÈl:§¼‰ñéut<½ìÑ†ˆ)uÛâê¦İ]?îHx1°…ı/V|ŸYÊ¾0K°Ùıß`_ışgp ÷_\îÿk{ö½HèÚCè&ŞSè9:r4ƒÚLa¨Q,³Û\£ G»^¼4R*53gÑ¢¶DMÚ%zÂ,-R{^ÇãqQ³)¬ e”Ìhœt#Ü¢KM¥gT<U«÷)ééñ©IïFã¼¢Ça·Ú‡‘!å*_…áOwñ«o¼™±—"3Éôe†º›Ñd*¥LÒTz*¥¤g~ƒráÊ¨:25yxüÈl:9ò§éä/èf,yÎx*÷0ÜÆ•i8¥×9NL0fªÃ¸3ÚTZ9<~|yÆ0÷Ã.w³‹æ– $ìf5=5™<¦¸WÊš=ßº%L_Á°ìˆ®ÊŒ‚Ê×\ÍÎëÙbL–wzº7m†
cáÍ†êi¸­¡Ñn¾dô¥’	Ú2oX´\Âûk¾T-ä¨Y²›ikô³áù¶nÿ_x ¸‰ıìûìï@¿´ÿ×ÜÖ;³ÄxW—‘ÔÃÁcÉ_ŸJ;J¿­OºŠÃtB™¦‰èP7^#uËÒæôÈáäLrBUÒé©4sçp÷]HÑŠşæªQÑsáî.v™éF±œ¹c¤E®2æal×Ş¢€Ş ÜÚ”a³K‘Ôìô˜¯È‘ËD£İ/ïú©ö‘©JÉÖ³6Õæ4oÒ‹Õ‚m”:egä³—.ÎÙyºÈlj^3
P ›T+Tt-·$F‰]A«èøù3”à­?-–*:ï‹ğ‚NåŸ>åÀïvUƒõnE¢Ÿ,CŸõ\İ	a½sLCÇ'éøŒrlÚã°Pİ<V3pOUËLcAıD°°	a ´¦ùØ˜‡^ÀO¢6cæ™½MŠı¹3‡İ]U³õ|³½Ü¢óÓ3iåŞÙäD«©DŞ>-ë]j¢i-dO©×`L¥°¬¢ÛÕŠñ˜­É©™VkUn˜M¥eWs.’VRÉ…†ïÓğ^nÑZµõ“¶ku|ÕËÛaéšVl]$œu .uÉTm>i…Bw}c&²`ºÑ®ÁüÒE7»°‚yôSDt”—¤­ÆÈúºÜh€2—€o®eCÿ@¡±Ël¬Z›+Ö&j%lp¹jëÌâ¢É„)âç‡r¸œB|AGÓÌ¦‹Û< à~@®fGÉÄOİ¼Qo‹{T\ğÂ©äø´-3òÔ?)íÑvxi›h?Wy½™kq@á`	|®ÇcÚ»À© W´Ê’÷¸5=–L+£õÓ0ÜömrFI†í¨:_O+#3Si¨:Ëˆ‹¸°§íÄøäQxJ'y³‚wğ`Ìp¸«»k“˜	™x¢åNq”UîO¼ømòŠEÁ·›s"^áŒ(œˆçØÄV¢Şé(i9Ğu_ ªãá…³`	<géhÊ™˜:ä*^ÏÏÛ¼Ü×#.$›œ¼‹):xä2$9i¾‘†atQ,‡7ò.ÂÖ5×Ì‚®™Õ2µuÔMĞ=º Uüv¶%‚ jˆé-•i	Â64·¥æSáFtF~	¬	Dw`v–¨–µ«@»„ß°lÿ¬4"Ï„ßqb|­½“Şøï3ÏN”#œ¦rœó¨S9SÍ¿ŠĞBk›÷õ~g¶ü@”:Î"L‹¿Àù>à“ö@¸YİÓ\Iç~†Í]”ÒTÉ²ŒÛ&šûÃÑ”ƒ]=tFp¦‹š%¾Ì“Û„hüà¶~…’…áğœ‡5,”²bôĞ¤éì$­šV&«çªà;s¿§@CŠÜ©UÍÂ¬|–7*zàu3ZöÌëQ^ƒp}‰é~-EC'æLB+?"&Dx÷úÜÁ°m×œF»Ä29f€½5ö‡/ã[Ã)Ü¾Ò´Ş{NÈé)VeØJ3ÍËœÓñ'hüøú4Wøñf^[ĞAF‡£ppVJE6C¬7®Ú›ğ¬„Ó±ª¬á¹ÏE¯ÁÕTsÜÚâü¿åÏÿî’_À-Ğ&÷?½ı±^ßçı±XŸ¼ÿ¹ öüÓğK”FÖQ1¾EĞ‹£ŞqØW,åtZÊC™S…•‰tGñ"İFU‹_#-V[W?‡L|Ù&tS(DÉ9Nx à
ªŸåqœæôk·µlCf5ö+ÂĞ
%ˆX4êş Ê¹\a[_ü¸ëÄİq[rähòH}ó¨ÊñäÈø'6ğlµRÁoD:³ÂÏZhN±{ó:»eÒ-äè'©à¦7\XjØ4Ã³Ş¬ø$Lƒ xüĞ„ÒJ<Ìñİw5ËŒŠÁ9¹ïp= ,‚Šã4áa,££¥ø}Mì£Ê£,ĞøúEÃñh,ÌbMZ¯;<>9Zïx:9yDAãc¾Çé±#ƒ¦«¢™s:»!¡‘¸ã…£ë ¢ê0Mâg-¾şzBà@–ÀÌ	1 ¢ØXnòøvåI+Iá[ˆNwDsá[–­ßºl•·iÙƒnŞ‡€ÕvkááäÄ´â»QÚ¤ÉLzVñ\9-Ûö:]íNzzåÜ˜ugé‚pÃÑàí‰‹œû3~`‚ı*vxÃx	SËO]N ‘+™¿f³Èƒrw?=~¿2›{j|TMa7öRcÎÄMmØ=÷J8[».¢PïÂCaÿİTÓÍt“Põs…«»Îş×¬†}ëMìèËö>T*jàô/6˜/aÑÀ(ZºVÉÎÃ`:7hA#ltqˆßHiö|D9J7ºrÈÀû×!ÚC‡ê—M&ìÖS¾¢e¹õ”‡Ç2t¼»uvrzv|&ÙPg’~Ü.\‚	^ü?2:cÛ Ö  