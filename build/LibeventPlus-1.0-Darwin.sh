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
‹ o e í=kG™£}8ağ|GxlrÚe-´ÒîÚÎcåİ±%¼E»›òqÉHíN,Íh	Kíaà¬ˆpËÔ(ÈQåºg8®ˆC8œâà09*•GÕ’â¨ÂÕBã£ ß×‘F£Ñ>œØKå¯ûëïëÇ×ß÷uKò¦4ı p•AÅÁH‘|€æb(Ls(DDq`0Œ 1Ø¹ÚÃP6L¥]YĞr¹BN›WKît@–ÍnÂ‡£–¿H ëŸÓRcZJWu3‘+Ì”¼€26]ÿ`0Ø¶­¿8ë?Ø
H|ûĞ^âëÿí_ıô·×	‚§ŞwAê†4Ü!ï^Iê_éŒGdyZ:9íÂ`Øïd©ƒË²©.šu²&~aš­zëx‡­;*Ë†YN-ù­ŞJó‡¸]Œß®ZûÙtZVÓjÑ”M%åä×wÍEŞ&´Y.ëš‘5=[péßŒßƒ6|3~¯a´²<Ê#“S”Û0#h‘·³KHÖÆY°-CK~kÁ0mo¯×:ú#|Æâ'¤Ñ¸5ÆG¾vÍ=,YğrHCnt”—ŠŠ9×ÚDš¬t3şÀö3ü‘wB¢Î)æ9ü>ÚÏ«ƒÂ¿ŞLFK~H}^/´†s÷Â€Kùë˜œx>rûgşkèŞ/ŸşøÀ<öÖ”!kL0Ê¶Ww2§ß¶÷
t],Ø-Ğ~b^D<]ğè–ÒÁ\!­äğ\àD&CNJêP l4Û˜hçóñá]¸”å~Ë[ !m¶Û6ÿ˜ŞsËP§“~jÉ0Õ|à¨]ÒM¬ÿ]ï£í{ç›8pàÀ8pàÀ8pàÀ8pàÀ8pàÀ8pàğÂÀL¬òß±ÓÏvÇ*Ë—bUéR¬"m¬Ï+±Êc€oÄ*]±Ó_ë~ûã{Ş¸ÒL¿|iıË—/_¶(FY=®«”7¿ê8ä×c6˜Ûy"ôíg÷¼ñ=ÍòIÌ·¼±ş÷5¾Y€€+=á?´şÛëáG¸’ÒÇ*ç×ñOHë_…ÚõÏ_Ïğ¦ş~ûı‡·ó÷ş' ÍÙlå‰Xåc•ñ§-•™g³éÇci¿
Ó*=R•­H_ËV¥CåSP±¥O¬ú]:Ã¤:óµ±ªôD¼ò=µçÑ'ÖÛ;p­ô4ô5Ñ,_¬É¾à"{w‰È«P
‚ùÚXuüiÌùsí„óà,ÒÙŞb¾ßÙeMuvÕª?óÄ™ïŸù9&[yÆsfæ¹•ï{ÎŒ_Üï9#ı·¾¿üÜ—ğK‚O_üºgôáû—/Ÿü
Ğá‹ç¡ä©ë¿e¿üüSœàÅZY/ÀV‰@]îfı«|}}/Ğ¾$ìùĞ¹ı=ÿtÎZa}#mˆÊ­]çÒfóñ[;×ıBéïbôŞ&}ïéoØYbÕÎ›ğÌVÅõÏî²f¸õş¬Ï×½»Z®ªÑWfÖmmbÕ™õõm‡ìúƒé+å_0ÒjùëïØå2
‹^´Ù«ân­·Ó2ZÈ„‰ø	)’Ö¨q¨–a.?½÷Xæ‚n'Pz\m+¸åFEzvıÏ:É^ÜXÏuºÚKºßZm4Ò+b/°ÙXŞ¨–É¦ƒØtlºëÚ{ëª?[‰ug«ã`b{1!”Ş9t+†h'íökSùÔ‚ºìôÛ¨­]ì‡ÍşnÄ(¯Ç˜ùAìñgÆ{`üÂú÷;È¢‰›Ùc»ışëMí7jĞ§Š´NÍÓÎªÅnœe«Ã{©õÃDÌlŒU"<sï †zX9“û®®Xåç±Ó_…ü,vú±½ñÊFüô¹ã•ŸÅO?†ÖßÒa©š›şÛû›Ş¤¿­ıA5Ş…—¿Wãİ°„ø-[ïeËH{O—¿#²œuOH_‡»¬÷óÃİÖköüğŞbngµeÿ§¶ë/»Ö÷´79Ìï^º|yÏ‡·çßŸ×ú}¢mëwŠ{¶†Wi=j¾F»¬÷óÑnë5{>º·Fà¾l~‰ºİãæL\Ö¶!kø×6[¯ç!×vMñNÍ¾.vaû&·V}¶²›€a¹hÖW÷<Z¾¸şŒ°¥?Böö5°Øé"ö{İXÿXXâËo¾ºuùÍ9òÔÉ³H%ò|y¾<Ïçıäù~òü y®’ç_’ç‡Èó#äù yşy>DŸ ÏO’çÃäùiòüy~–<ÿ–<¿€Ÿ{¹§ãUû<ìÊ—/{vã÷½îáøV¿·s¿U3ü[böìg¸_¨ıÎ£·û‡ò#ædcBıwê™F·#œÓßœŸ„›!_;ô·Ñßïº TèYà»"6ğ{‡àÁÏ@\ãéî6îËÛXŞÎò–w²|Ë¯cyË¯g¹—å/cùn–¿œå¯`ù–w³ü•,¿å¯bù^–ÿËÿå¯fù,Ë_Ëò×Ñ­l6j8pàÀ8pàÀ8pàÀ8pàÀ8pàÀ8pàÀ8pàÀ8pàÀá÷	@ÿæø#ıÿ
ìİúÛïÖß('¿·ÇJ|¸NCşy› ´ùá7£¦á=é”ÿÔƒş§¯Gğ†¤CZ…ôMH— ùÚÏ(¤"¤‡!}Ò³P»à€4é^H«¾é©vüçgôMÏÈIÕ(çUÀß6e2ÕR^ÓSÇ™\‚äúB29½¨È)uVÓå´b¦çpÑìâ¢\TKFAWrš¹$Ï‹¸Ô03…²Ydú7Ö•LÆzM)†*g4£HØËù"Å†òl¡¤*é9ZÔXSRÕ†‚YÕ”Ke]×ôYòÙ¼ ¯SM¥ê¢ÖHš+ŠMÍmqiº ›š^V›*š˜êêB^,i…3M¯SfÔœõj™bÚ¬·ËÆ±¨êvµxjÚPsY9RJ³Té`]'"9-Kı»ˆ¦®İ{áqî^Ğ¾Ä‰ASË«óJNxõ¼ğúvá,®¿ğNx¬¾Ó“¨UBÍ5pKZÅú85#qlóÒT¿,Ü¡s*ƒÌÉ)QÆÂŸ&ñËŠ§]øä<fU‚ÇÊæ¬ò0^Ÿ‚V¦Åì£„ğa÷-´—„÷zB’ğ$­.âA.`®Ò¼ğs(ƒò³KXä"”÷·‘ÖÑ&\ÁÖfSÒ„úA™%áM%5_˜WAèfÈJÚÔ 3„›G„zF…_{”)IøP§ˆç´€§s6Æ±ø˜$ü°m^ø	Ô+`¹÷à¡Ş#A²S1Ë†$l´…ìú’Şİ>Ø¤áPüçíC¸“z9ouTSèêûÛAB˜2‡ÍI*%ü }^ø”^À}ZÓqÇòxÉò‹ıy¡Ò!´e´Ù ãr»¥Ò’ğ˜IÒsÌáÜ)ü¸Û3”…¯wí¸Ù)Ğê_;jû°Ç:@_Y¯ë+)ü;°[Ñ0»9kªóÂj'ôsOM­øa(ş›N²¤î„%ıl–[ÒëÄKú(_½[º‚ÂÛûaº$áÚ™‘Ç´Ä	»V%NP=Âj5(¿j>ÕqHxªcDøRç¨ğíNXJ"ÿ{ ;"•ûtÛ!òrÚÏàÿÛeeND¢(v#qÅsZñˆÃ"ƒÏŠ'1™¸êE¨Z%•Ìş_‚­÷Ga-ÌüÄu‚ğŠvúÕ`ğ1üf†G>ÆpüÿÍì²vÅ÷1¼Èğ†3üm?Ëp“áİìÿÍù Ãÿg‹şÅ¿má‡(ş‹ÿaæß<ß`¸ÈpÄÚÇ.²öóı^døçŞ}3Å¿Âğ5Æï?~–ÕÿÄâÏpìW‰ü!ŠdøÆ Å§~á‹?Ëèfø
Ã¿ÅğáŠÿØâÏpĞ=:Œş(ÃïbüSß`ôU†Ÿcøç¾Êè¿Ép‘á?eøp„â¯î`í>Êğ¦Ow1\døÃÿ0Ã†‘á?Ïğ³_cx7“÷ë¿Xa°»“àmşşfŞçÀosà3üï¢x-Ä:åÀWøƒüïøãüûü9¾{W#şŞïÀÇ¸âÀïqàUşş°Ä?îÀŸtà?tà}@
@:IÄc¨:à%Æj‰U«3Ş²x[â­‡·6!ØL`S4)
é¨@m„±‚é¤ã-ä!…®’<$Ôãj´›|¹“€¸v›t­Ÿo*®‡Îš†È`³ÊDK™#Aê{\Ê­C#7j,¹T%]„ZíHp¨µà»àÑ ËL†\
-¿ìRîà\wÖÁ† «’mM;ïNãÒ\‰\ã6WJ÷PÎ”68ªkYé.bÛ[ã![LèZ_]÷‘¡;£Cö8Ò•ÀZº¸F›Û¦Äñ¬qó†l¨sïKófj¨so4ÚŠÛh«õÁö/Õ£=^Ëœ³”Vr9¹¶æÂñ‘˜Œ´Z4eSIåÔpSI(ÔT4$pØ4=+gÔƒWS"#Dòš‹¡0Í `8ÅÁp0‚Ä`X÷(r5;eAüc	º² år…„3%w: Ëf7áÃÆQË_$`­?Ùˆ¹bñ*È€ù‡[®0°õDÂ0wb020(
H¼
}i‚—øúïÓ²zFÍ¢øÄÈØÌ¨$KwHÓr,‘ğîƒbMW]j¼û˜Ö ›‰Ú„,í¹ÕVå#e°?Ájåózu%¯‚wM«ˆø}tŸ×¦Ş0	  E àæÁŞ&†º[êEøy¤±¦2{QÙÔr²QHŸ·d¢l¦^gÌJ&Z˜SLâjRJú”œÕQ:U¯/h™^^éˆ—ö­œÊiéz×H¿ıÎö¹ô¢Ï&½ÏUj_]šÑsÄMD/m×TI7!µEEcÍ»hUQø&aAI1¥[Z2l¦¡D5ªT¡CQùm-ke&b1u/2çDôÚÔÖ~èõk 'â$¬Gıt®³9¥a*[õÙ»%Cx­–a\Ë Î8xÙlÛ¿Ø¡Áş×vë+cû‚èÀ²ÿƒá~lÿÄ·ÿ×ÜíÿÑè”´‰¨Uoâ	ê5e½PÊ¨%5#ç•â­[ù#>nß3´¶Ò˜ßiĞHaíŒYªİ‚àœ£šêæ¤„ÖiU-Í-›,ç¶ä¹·b¢ÉQí
À%ÎÇ91Ï“õe¨|™3¶İpö»Ó\ĞÓà;Ék*âàÌÈP|^•º¬æ‹Ífß:Ğ69ZEƒçA½Í§v„nâa]¹V¸7±Ÿ¼í•dJlr›Öá;½^”uL»o°EWp„¶E¸#+Pó§tÄ«êNèEMwş—_|© ˜à«zöÇ°óó?D üü- ¯:¯œºš7@Wpÿ
óõ¿&P_ÿ1ŒáOreã…U†¯ÿÀÀ@ˆ¯ÿµ€ëoGF
zV›ª+’±ÅùOŠ!¼şáÈÀ`ŞÅP84ÀÏ×¬Sšùöß72=!É#3É$>åÅ§¦åÑxr¹A¦!¦TMƒªƒõx×#àğ|`ûŸ­ø½¾2K°åıÿ`˜ìÿÁşààà Şÿ‘p$È÷ÿµ€}'x÷¡ãªï)ÔÍ@&Q¤å‹äŠUË©ïó—‚F
ù¼¢g”W–®‚@³€Né…dÎ©øxœWL+hh=à…“®ŸZ´øxb29-ãSµ|‡”œŠON `æ§}d=öÙÕŞ‡"ªòeğD>Ÿ—ŞGã›sÉ?M—¦‘½Š&ÒÄ(J$'RrúO.Ê#“ÇâÇg’Ñi?…&&iAaI{`qÆ§ò¦Œ[\š‚SzãØäa&[¼°·F›HJÇâ'—¦4ı ìr;»@f	J|vVS“ÑqÉÆh¸TTÌ¹Ö-aúršaúÙpebdºærzNMŸbc2§§gËfXa|³!74ÜÑĞPOƒ¾¤Ô¥‚Ú2§¨XÀ÷Æ\¡œË ½`6+Òö4èÿ‡çÛ¾ı¿ò pû?8	:ìÿ@„ßÿ_°[ïÔ5à^¯–õ×ÂÁñè['“–Ò/jÅñ	[±ISS(êÁ×ˆyÕ0”YÕ,:“¥dr2‰|Ô9Üz¦
ˆ¨¤ŞSÖJjÆ×ã%—‰ş,–2·Œ4ËeÂÜ‡Ûõû¶) ßM µ6EXçô’?13sYr	ƒ@ Rh çğ]/j™(L5m"eVÑğMz¾œ3µbNEäì€ùô¡…9-=‡ˆMÍ*Z
T)¹’ªd–Ø(qW˜GPJ*şPJğ­?ÊJ*íóŒN¦Ÿ>eÀïö¸UƒõnE¢.¡Ïj¦æ„p½uîNƒâ(>-O58,¬n.«™?¸'×ªe¢± ~,XØ‚ĞUZÓ|lÎCÍáO¢¶bÖ0{[0dûrk{¼e½õ|“½Ü¢óSÓIéö™èX«©Äx;´¬·¨‰¦µM<Bc2ËJªY.éş³519İj­jÃõ‘©4Ì’¦Ïú“Rb,:"!ßòõ!_‹Ö²©.š¶ÕqT/ï„¥mzZ±µ‘PÖ®vvªW‘?U6Iø¤är=µ­é4È‚éÆvæ-¨x³3KÀ˜îÔYTFiÉaÔjŒ¤¯ËõXæğÍ´lè(4¶ù€ÍUkkÅÚB­˜.–M•X\l2aŠèù¡X.‹ AŸW±i&ÓEí?> à7ü¹œêÖõ¶¸§ÁŠ^8Ÿ¶mF€ú÷¥=¶´õMtª¼ÚÌÎ¶Æx@á`	®§Á´{ÁÉ —”ÒRãqk*MJ£µÓ0ÜñmbZJƒí([_'¥‘éÉ$Ô»eØEœ¯¡íX|â<&£´YÉ;|8fØçíñn3á@&j¹“§-åÃ*	wŒO¼ø[÷%o×gY¼B!8Ï’‰-§{¬ d@×i|U±£°6 ,AÃY:àÅrıÇÇ&Z†ŠÖÓóß¯#ô²É&'ocŠ<æ2å&8iºşºa´Q,û6ó6ÂÖ5ÕÌœªèå"2U¬› {h^)iøûê‚TƒMo¡ˆ
¶as[Wj:UîáˆNË.5èÌÎRÒfh—ğ·'Ó9+õˆ§aBÜïxb­'Ó·ù!Şa­(‡9Mé$åQ£²¦š~¡…Ö6ïë;ÎlùN(uœD˜~5æ{§CÚ>/vf5KŒ2•ú2w„ÃĞRd›(ìKS{{Ñ4ãŒƒ}™'Ó„ØøÁlü½F†+ÀsÖ0WH³=Ğ‹¢ºµC0iY·°2i5Sß™Ñè=6¤˜;2Êi’‘-ÃòXİŒ’>³Fz”U \_":‚¿–¢`'fMB+?Â&„y÷ÚÜÁ°MÛœ¼l™,3@ŞêûÃÑ­aî\iZï=+äl(tWeØJÓÍËœQñT°ñ£ëÓt^¡Ç›9e^)64ÀÁ[°TÈ“2`½ñªİÏJxú RÀQ|î³EDkp5Õ·¶8ÿoûó¿;˜ä+¸Úâş§?"ö;>ÿ‹ˆb˜ßÿ\`ûş)øK”ZÚR1ºE°ÇzGuà@¾QQ!uzFfVÆßÀé&æQ6è5ÒBI3U™ğ³ÈdÆ—lrR°…(¹.Ç
TF\AõÓ4S¬~ ¶–lÈ´¢Ãş±EJ® ‹‚ìTY—+dë«Œux7BÜ9=^Û<²t2:2ş‰<].•ğ7"­Y¡g-lNq÷æTrË¤˜£“¤„7=¸áÜRİ>`3¬+`à›‡ä‘Éq€ãGÇ¤Vâao½¥Yf€Î
$ĞÈÇjaTO>Œ¥TlCş¾&î£sÊ$Ğõ;ú…|Á€è#±&ªÕ‹OŒÖ:ŒN—°q‡11ßcõØ’NN†nÓURôY•Ü ÿ&Üñ…£íÀ¢jŠâÏZım]Y3+Ä€ˆbs¹Ñ“;•{<)E!„o!:zÒM…o[¶trû²eÚ¦ezh\VÛ®…Ç¢cS’ãFi‹&ÓÉ©áÊÈj	Ø×éjw²¡WvÁõYwp±–ÎM 5uŞq‘uFL°_Ù¯/fjé©Ë
$2ıMy êî§âo“&asOÆGåîFÒfu¼©5ópÃÅ}%œ­mQXï|C>çİTÓÍt“Pµs…­»ÖşSŒº}ë§4ó€*b5púgÌ³h`U)¥ç`°‡­4·Ö»8Do¤sÎ/L$ë]9ªáû×!Ô‹†j—M&lÿ}¢eäß_eèxO+òÌÄÔL|:ZWk’~×.œ®şç;%‘ Ø  