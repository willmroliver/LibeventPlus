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
‹ $î÷e í=mlÇu{”(ÑŒ#2‰’¨µONŠ}dyÔİ‘i9vx"WâUü8*“ÈX-ïöÈ­{×û Ä¨Èta­$HÑª@HÓ¨(¨E[Ë‰k)AŠ*Iá
-Z°A?dC	˜Àvd£­úfæÍİîŞîŞQ²Ô$åÂÇw3ïÍ›Ù™7ï½yoNÓıÒ=~B¡ĞàÀ ¡#ı¢Ì+ÃıƒƒCı}$ôKdà^Œ>åbI-ÀP
¹\É‹È2¼ùå(ü9yæ`ı³úÜ¸>§-iF)-{Õw¸˜ıınëßì·¯ÿ@$r@"¡wxÏÿóõÿÈÇÔBjá©ö½áı‘©=áÁph°0<x€^Ïÿ†ùZ’ğÇ#œòD»¢ôNbbT>lâ÷IÒ[-’´¾¦Xâğ~á"lñqøq„
Âs¿Œğ[_C¸ùG>ƒp	áo#ü
Â—ş3B	ûïAGøm’Ôùˆ$%êÏ"¼€ğe„ÿ‚ğÁí>†ğãás/ ¼„ğoş áÛßÛÊaù‡ ¬(ŸœÈÒİú¸L7ì!µ¨…Ãéòb^	-•‹r|PQŠ‡cãr´KÎ4‘l.—OåŒ’n”57¢Áy­¤Ê†¡ó
Sn”CE 4Ê‹J¾ ç
zI×Š²îHÚüä¹¹9w¤sƒ™\ASSrü°?±á(s€‰àŠmIT¥õ´¢ÖİÆ?DgƒáãGKú¢¶¤f:3zœv4=éF@xÚ)œk½?¼–œ×Ù‘r:ì<#ayj:äŠsËHÄ£QÄ¥Ñ¨·Q·ê´èFIeUµ”šÍ*%­°¨jI3µ`mÂ*m(iË9ã}j:í¼’&üR]õ‚¶˜[Ò0ëEEM•t@=‘q×>ë Z7K³i)ûœ©¹´;¡Ô-bµ~3GÜ;8wl¬Œ8TÖ ®>á%üq³kıƒ„„ÂPÃÑÂ®÷Uí{£ }ıŞT>ß›£üşîíşÏNIòJ–ÀI ª¥6°'áıı’Äí–Û³ş.-ÖòNülG:Şä´É!Q”¤<›¬ç7ÚZãÇÆ²K’>$1F«f:E™O¥@Ë¥´|I)©sv~‚¾†”…Á´¸¿ğKåó ÙJÙ8¥iE5ãßedrøÑ9Û€ñı2¯²°WmAÉÔEÍù}m^ÚÆa¼ó»ÜÁ×¦qÁÌ/Ÿ=ÇI­ï†ŞvU;¥õW¡õ/¯¾Ê­¬=³ÿ‚†~>(ñõü Ç<¸=3c•;{³s¬²rklM¾5V‘7nPÄXåE(oŒUÚÆÎ¾ÔùÌ7;Y­§_¹Åi‘bñW)o0~k  l(·+¬Óg¾™éxäÙúşYÊ·¼aâ›§×‘Ç;vvHêxö´ícmˆ5~µú‡³«\aõ5^KqVwƒGïîıàÛŸóûÅ¡ÍÅLåêXå­±ÊÄuÁ¡2s3S‘_¯Èë|è0íò¥5ùfE~)³&¿ÈW ±µWùHÖV.Âô\Z›yi|M¾«¼d¯t¼ °òuk¼¾ÿPµïk}Ó!±şCkPóõñµ‰ë&Î×€sˆ¯†×zàìãÒøsWÏ}wøÜO(Ùê|çf~ºú¯¾soîó“ß í†?WşéŸSaoøÍ—}ò·‡?·òfø{M'tøÍ+PóÊß…º7ş‚ªğ›Õº
]€!›Èx/|¹ò2£={Kêxşò>_Ç×/‹vGÖ¦*’umšœ‡¾ö“•şwï1}“ã[kå"²l·ık/—õ UúÊÌS›±µ™¢1Ë¥¯”_GÒµòëÎo!èC&ıpí…€Øâ\©]c[P*È?×keØ„+×kÊ·=­‡¶Úr£"ß{‘¿ãí/½Û·ı£­}hOoßö=Hk=“%ËÓÅAå1„‡\ğBç?æ‚_E¸×á!¢¢^ØÓNŸwÿ!Ÿwÿ'°æ”~kvÁ£•ı°Ä/¹ñG|Ğß‰ö8ì‚#Şm}Và/6À¯7Àw¢CpÁ#şQ|ñ½.øˆßï‚¿†xtåªò‘DùØeß§’ït§¯óÁmçË>¨{>—~z›=]¢atWçg[FŞáFG¯ËH÷]ÖÄï1ºçMüözĞı%|·÷ûoğ!·÷û ¯Æï”]?Ğ­"İÓtÇîÒ}ØƒîY »ˆtKttmoqº İß]'Ò…=èş‹¾ï[×wìÁPtã@7Ô]	è†› û= Cº€«Å‘îQº›@7‹t½t»aOŸ@ºı.t#ô}:>ÎvÎÎ/ÑÖ)öOò
¼Áù ~–Ú¾‚Œmü(==nìA´8zµ­9Ó·²³Ap°•·‚ïke:>øßÛ™.	¾¶éÜ õªà]ƒÏogã	ßÎlI°á£ ?"IO¾ïü+P~i³Áç·1LìØ³1x«…Ãï´0LôÜÛÂÎUA#¥ğ+>¦“‚|p§ÍYÆZø#‰ƒ‚¯ ü(À/|@ª @'ß/1¼ÔÂÎB;.¶°³á®-LÉíXExá0B‚PBHí…—^@¸ŠğÂa„¡„p]Âö/ ü‚ÄÇu^âãZÅú‡„Â£ÛıÄ?Á¼ïj©ÙébYèå¯A¹ÃW³T'Ò²°'ï÷ñ²°?İˆúşoZxYØ‡ßÜÆËÂŞ^BzaŸ¿ˆxaoJˆö1ü„½M"^Øç×±,ìå÷±,ìïsø>ÂŸØeá?èX^Eù~ßOøOˆşÒ4âÅ“Å²ğwbYøGal/ü×#¾ÕªÅüÔ6«ñ|Å^öYËï‘¬e¿­¬·XË­6~R«µ<a£ß°•låß·ç¤ÿ%şk¶ö;låY[ù‹¶r·ÿmü}’µü­ıûû+µàbh§hxmºôx5|Æâpélünƒÿbâ‚ïÍä+<#êbòM%C\£×›„óx»iq0µ¡`|Õ„©[Ïˆ°©¡X+·\I©«qtE7l¶,¬LƒŞ°@é\¹”¯ë†É8µ¸‰ÄŠ[›ºbí&²Mæ¡ëÅ¼ZJ-°ĞñiU™ÓæuCIñ*NWÔ²%5§æë$DÁ##1ÃC¢	­X^Ô¬‹YĞ4wvË|İAzksùƒ;ÌÕ‡æ›Lyä›šOq¹¥=ŒŒ˜İY­¿®&¡‹7ú´’×
Åœ¡f©ˆ/Q[çš/rÎDYòµT{î6_0û ‡"_ Êwš/x}Gm»º|IÚt¾@ğéÄòÃÜ]¾ m'‡Â
=ÀãûêySù‚±p|Âzçwõó×:xå"8×Z¬ùa{Áfcm÷˜·ÇOv$³¨‹‡Ó°øÊÆZ™•¡f}|M¾ŞñÂ5k4n¬mmâfe¬3³6ñZ¦2¶›Bí€×„3Çç=ûç·H6b»Æ#ùèoŒ]Ù:¥ÇN`vƒ¾ÅXå'cg¿Ñ9VùñØÙwÇ*±³—÷Ä*?}‘˜c–îñàæóã9İãù”TMrP°–ï¤ ³6¼›'"b0g3ãk‡Hu’éè+‡a>ÓÖüÜİøİó#k±6ºÜôûZ¬–œ~Ë¬Åvã²óWàKO¿¶üµÌÿ:Ü&¾_î_3W†wW	­µÇï<¿ÄæşƒÕ¹?İÖd†)sşòK|ıAà¨àÑK	ØÅÇqƒ¥½ëæ¥õê¬ğ‰ÂÙÀ™ ·^M‰vLvnpÙ¹²seç†MvÖ›—§â³Æäˆæ×î<T3mük´M|¿í_3W¢»«vyàóËççõ9ª‰_–oK¯>\¨ÓmuÉ¢sòíÏÉ·EÊÁm¿×¯Ÿsë´ºEôáÌßeü{LãoÀ×2•òM·á>d.hó†3R7ŞLeƒvŠúGn}S0íßèx¡ü#Kn«®£Z¾.dæ_™YÇ>®ÛûØ+aZú ë c™YïxaÃ£0,¿óXëÇ|şÏê0«¸à¯!L¸àEüÁ-Ÿ#â#Ïºà7´'è¥|Ş±Å»½ˆç sõÂßFÆ-ŸtñßqÁ‡¶{ï2âİæ`|ì˜~ñ“.økˆOºßóüyÄ§]ğò)_x“‡sÏˆ.ù”¤;âAGó){0O’ğ £±Ãx“ù”Y¤{ÖƒæSšÉÏĞ|ÊU¤û¼Í§„n5æGó)_h"ßCó)ç‘î;t4Ÿ"ò^ã£ù”o5gšO¹tÇ<èh>¥ómN7éAÇò)H—ô £ù”<Ò=ãAGó)_Fº´]³y‹(ŸâÕögo;æ)şaûçîÜÁóÚÊãÿŸhe÷›‚olçğÛyşàÕm<Ÿñô6vÆnãyzÎ‹A²çÚ¶ñ<È·ø™(ø @p¤‚ÿèã|¾êã|b áTÜƒõcƒ£lpLâøw*o@ùÓ¼ C€ÅçGX•šË|¿…ñ›ø£'úø0Æ¹…^{ËBOJ¼,ôê‡°,ôäu,½'a{¡ç~ãşÂnü‡Ï§ÿÉWEza§JXvé’Ï·?í…İìi±æ	RˆvgR²æ#½°+»E{¤¯øxœ?„å%«Ò·Å±¿n‹[Õ†ÃÖşmø?±áíqñOÛè_²áE´Î-$Şä`—KÄ\¯Âz]©­êÒ@°Z,êóÆ¢©¶»-jõL¬—–yƒ´V3¹¹ûËîT;\Êv‹¼æ5#­óîÑUNÆ©ü;t~·˜7uÏºvó¸¹»În—¯İn6»^ÊÆ°©=œ9äÍlüèF*[Nk÷ô7€›ÿı_ä@dpë÷÷ãëÏc×ùü=èÃû÷¡ğ@mıôõ…`ıûûú¶~ÿw?½zÆHk›Ÿ•ù˜<™TÆâñö½P­š¦}/Jù›ˆ§L(¿é× VşövC]ÔŠy5¥¦ÓÈ™övĞğÅ"aÊŠ4‹6b	ÔüÁv‘€©)ånBÿ>aÅt0W•KzV)æR'ÁŞ”H&]Ãr…9µ –l,˜…™SS'•ŒARs5ìRNOwµ0ÿD;[y.«§jCcãt‘'	L•ZÎšs”}ì=ì1¬Çq@=µ»»èæíêìï£DsAX1ŸÁ×Á—­?Jr`WÔR®ğ¤+ÃzNT¥šËå²ìtÀÔ²Z—ÊÅAß¡›”–ìDÜÍªkkö):ˆ(Ø	«>L€Ïu&«Z¦Ò¨Ç<,%W¦s¼ïµ’N/ğsñXôu·¾³}4Ğÿğ¨ş300ØÏôÿ@ßÀÖï¿ïËã¬ÿE§e#PE{X‚¦lä
i­ ¥•E5ÿT#;ğ„¥DóüÍ[w-MùìZ‹UV¿Æšãº<«•4oRFkW¢ú–uê±©şœ[a×VrR½4¸cŸ˜»dÇéƒeâLt¡lª˜şÍ)0ìë\ºƒC é!%g(Úb¾^·‹;DuÖ¡Š°˜Ò]o^ª×ŒêxˆËiç&æ+Bf$›Ó…O½ÇÒM2¶©Â[@&·Âz9LIÍ™Ü:ë
T¦õv3†]ºIİõ²À/šñÛz$PÁ?›ÿşOdëü?ºş©Eõä½Œ m~ıûB}[ë_Úú›ÿ	¨wV6¿şıı¶Öÿ~<.ëo.ŒäŒŒ>ßË¨î¨ç¿P8áë é“P$ìß:ÿİGœÒÄ¿ïÌÈDô¨¬ŒÌ$ô”7›N*£±ÄŠE’àSj¥"?éº“Ë®[ÏÏÌÓÄşÇ¹Ôi‚ûŸ†~lû¿?ŞÚÿ÷åÙ¼Ë§}/9¢4N¡¥ÉÈH)1!úbÅQõ¬ÖÛ~÷ı@G#¹ÅEÕHÉ¢ºL:,åÈI#wŠ”4z<^TKdI+õœÑÛ'İ ×h±‰øT"©ĞSµrLNLÇ¦&I¸‹rŒñ1âˆıf±÷S†„‹|^x¿¿id¦´HFGä$17#Ñx\%ñÄT\N$?Axçò¨225y8vd&MBÿÓdrŠWt1–|‚3=•[˜"·˜<§ô*ÇñØäQ%6™”‡£#²2<2="O+‚7ñÌÎú-M¦FXÿ&’}gÄÅòáØìÊ~Ç”²9ËêÅR ßQaš@á­¤´ÔI|‘¢uNº6£RR¤áÅÒ°éÁ‘.‹€ÌiË9ÄcA/’|8Š¹r6MŒ\©^rš™_HS×¼ş¿s°şÛı?0 [úÿ~<fí=·Ìx{»	TİÁ‰è¯N%ÄXé­VÇ&MÕ~2.OO“HïP#.jÅ¢:¯G“ÑqEN$¦ Š˜qxêIJÕ"í7ÊzAKû»ÚY01ĞE»åÌ…’F¨0æ~Ú®Ïßd}NpÅ“ÏeõÔr >3=f«ı2½½ğ‰èzl×ÏµŒr%-U"ê¼ªÓHúb9[ÒóY°³åÓCN-è©rŠ©ØŒªg¡B3ˆš-hjzß’ƒZĞhæjhÔŸ,æ
š¤Sxö)v·Ë	ÊÜD;‡1kéª=¢x@w¦!±IKÊÓÛEÅÍÁxÕóKåˆZaâ‡ÎBBÇŞêæÃ›‡–¥™¨FÌ,³×€!î€b»ÚË†û|³½ì2øédB~z&:î6•´CoW¼é…êhÜ;ñ°÷„XÆTœÖ´R¹`,jkr*é¶VÕ×õ³©,–
º1HÈñqğÙˆÿ	?ñ÷¿Kkö«^ÓêØĞ+›aiš7¶&ÎÚQÏNç5˜+—˜7¥f³]Õ­Üç‚é¦zæ—œÒèfGM€Ì{èUQ^s¸½#ëJ­ísø¦]Ú_›l€·h5¬b…:8_.iLãR•	SÄÏùp9DËKUÍlº¸ş§ ú&ÈÙÏ¥sÍºY`—8\°ÂñhlZÓŒl¾õÏJ{ª;¬´µM´Ÿ‹¼VÏÎ´Æt@à`	l¦Ç¢ÚÛÁ)à ÔÂ²õ¸5„CÒHõÔ7}F«ÊÄÕ‰ÑXBIN% ït¬Á@œßÒ–ğÆc‡QŞ,‹ı<˜5ìoïjoà3QG&qİÉI!|T$á…ÀÓ/ıg+
E¶İ˜G…3"p"g[èµN÷xNMƒ¬sÿ‚Š:=<SC!6 ,å,İÛNûŸ:$Çó£à&Ã‘ÁnHÖySjà)—i§™‘æk¨)FÅŠßËş™İ1E.™YM5ÊyRÒ¨l‚ì‘%µ Ó‹ÜEt‚,¢Ó›Ë“¸mTİÖ„šO¸{Ô£Ó3Ë MÀ»µ³LÔT©´ËôöD±dŸ•šÇc™§“<[këdú½Ïó6õ,¼4šò,çQ¥SÍ¯"¸Hmı¾>n7f+Çı Ô0>àa¹ó¬)ßã¶ŞûÛ©1«jb’ÎiÜÎ°¹ë%$+õ9¶MÔ"ì!)Û»I9“Sj/ó¤{€*?øÛ€^^dn¸
<`³¹în5Ä¡¤eC@Ë¤´tlgZçaªH)wR,§à•Š™2,o/ÀjfÔÔI˜56"v1u™É½–¢R#&&ÁÍà„ u¯Î¼vÉ4§½í¸LB°oµıaóÀøÖ•›÷½'\NK¥³(ÃVJÖ/sZ£¿:¡Ê¯Oİy…oÔ%Ìip´áİ‚…Ü"›¡"¬7]µ_§g%:}à©`¨ò*=÷™<¢Şû©ª÷[]ÎÿMçÿaÏwjÿéõÙâ?}ôşÇVüçŞ?¸à?•^¢ÔSBÄø¡VœÊ—àb.­‘\pFZA-èê¥ôåQ.ò0Ò©‚^ÒÆO)È—mò@Q©/¹Öp4$® ú)îÇ©b\A®kÙ†L©ì“‡¡fsà±¨Äœ¨Á¶õ5äÇM'İà·EGFT7"ÏFG’`ŸØ‹§Ê…½)f…Ÿµ¨:¥Ã[ĞX”I+Rv’İô`†³Ë5ı@Õ°Î´@‘FVl=LM€;4.»usüÔ“õ}öâË	G‚Œ;\uAÄé4ÑÃØœFu(¡÷5éíSŞËİ€m\Äîù™¯Iª¸Ã±ÉÑêÀÑÉ#2UîğNh{ÄˆEïìdè4]Õ˜×X„„<¸Ó€£é€^µŸDi®Å6^‹ìÈ˜	<
ï~£³›í÷HB‚ïÒutVtÍ;oºoy¶ù¾ŞÆu]|«m–ÂÃÑñiÙQjĞ$™˜‘-!#ÑJ›^§{=HË¨Ì×fİÆE,S\qÔx[ü"?ã&Ø¯¸ÃkÊU-?u	G"3+1Ïƒps?û¤<›{*6ªÄé0zˆ>oĞM­—Z÷J8[›QTîüC~{lª.²ÃdTõ\a®Ø¿j±¦ßú"ûôÏé¥ *AœşQaƒúBJ±¨Ñÿõ¼ìAAszÃÚ‡xDJ--äÙx¢6”C:¿‘n2TÔ©°}glU+$°ïŒ…Ç
¼Ëƒ239=KFkâ#&éÿÚ„o=[ÏÖ³õÜÑó¿êÃ x  