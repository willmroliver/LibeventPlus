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
‹ j e í]p#W}_Y¾ËÅî´@ÃW]²¹ÓI²eù.¹`½wvÏg+²}s¥I—•´²—“v…veŸ¹¸5¤NqP:”!ÓNg˜)e ”¶1„’C§&0™¡3=è0šÎ¸-)´\¿ß÷ŞJ»«•$¹ƒÀûŒß>}ßû¾ïûõ}ßï{O’•×#ÒuF<O§R„Æƒ,'XÌA©t2H%I<ÑŸHêz7Q·lµMYÔËe³¬/hµ`>`+•¶ÃûÑŒ_"ÈÃü—õü„×4ÃÎ–ëV¬¸)/b[Î"O%œùO¤Óƒ0ÿéş~˜ÿø‹Ø†ø5Ÿÿşéüü&I
…áõ^ wKÒƒÒ+işë \
I’¢ÌÈçfÓ{xèæÉŠbkì›_Şú oÏM-º[r¡[Zq“ŠbÙõ¼ÕQŞ'îfñG|´ƒ}\ŞŞfù¹BAÑ.´ª­ØjŞ/oèm,»è.©3¥n,êFQÑ’Ğ¾y.ï£.z+y¯ã¼Š2š™É(#S“ÓLÚ0gè‡y€)¤sı4]ÓĞQŞ3RKNØÅ¿—·Åİ®1*gb|ò´<:îôqÅ×N1µ¢í	¹ä¼Â„×úÒ‡kUÕïl¢@ò.ÿÀ~N?ò^Iz®‹)Ê\{P’2˜ş$}:ñ2xåutóp„Û¤ÎXoĞ:Ûp¯çø‡Öş;58ø‘•Wí³ıÑ[?„4âôiô²ëô5ÓĞÏÃ}›·Hl<QÕ‡Ğ>xì“Ô­Ú‘²YPË8è`(³¦NÆ±´×l£œ¸[ÎÇ‡÷b+˜&¡ğÖ·BAVì×ø#èøĞ?ÿô’ek•Ø	wMwğöÆ7
q/§q¼ü˜k|oìgŒ5–Ÿ[•ŸkÈ›¯ß'Ic/½9ÖØ7öÀWÜ÷Äş7­´ó/?·ñ¥k×®9£<óõM*oõÄ7£”ö$­ô¾'JûßôGíõÓ2(·¾¹ñ7M¹%@,ŸÊÚ8~“$ı 3ÿXãÉü*mOv#¹?ÜËé¶özçí‡WO†‚ÛŸ…2–O5şg¬qæGBcöÙRCşáDC¾B»¿
Ã*?¶*?Û¿ZZ•™ß‚Œ+úÔÆ:´šô(tÿ±ÕÙ¯N¬ÊO7¾lßÚÿøSÿÆ\ùhk¶½şx³îõ€º'°I´şø*¤BÅ üÊÄê™gPrƒI^Éq6ÚÛŒ÷—ö8C]ºìä_zêÒ7‡/ı²­|7tiö'+ß	]:sõöĞ%ùÇXnø¡úO¾ˆ_”J<=|õk¡ıò×‡Z¾šxúp@‡¯>	)ßºù›öã¿Å¯–%®6Ó8C¨•V½[µ/±ÖøÚÆ4ğ>ğœ´ÿÃk·‡ö~Í™á }£e¨Ê½)¨ÌÆãÛİu¬Æÿ	Îÿğùõ]òß³»öŒ­î9‹#»ßø~ØáÎë³5^_wœÒäoÌn¸ÊŒ­Înl¼•#nıAşFıGœuµş£‡záğÇ]öjıqüÊßÆ«ÂÑZ§K¢&ÉW˜qX­Ã"\~fãæc.Ør¥Çt(ÛÀ’›ùÙµ.º77>íû’©g½uZh´UX|µNW˜Xm2¬¶õgº\ÍÜç¬9ÿøm)ŸYÈ€•¬0[÷Û¿=kìÖ·ı}bçö÷Z¨Íş>øÓk×‚ím¿X¿÷„v¿~ßTfë÷hp]mããÕÏÛ‚J5õ¹ÔØÄ"0qW[İúÊşÇëW7şE
\ÎŞõã.ßZB0áWq	í|sãá61° ®½ù÷ Y×Ş|}*ô©Òg>ëô¹HŸKôy‘>—éóéó=ôù }>HŸï£Ï}®ÒçûéóôùAúü}>LŸBŸJŸcßN¾ö±—‡º_µç`ˆYùÚµĞ-Ò!I:tÛYéÔáö|Œ^/±ïÖŞÎé¨ÔüÎ7’÷D‡Ù÷Ş‹@LH­ï¬½KVZI³ïŸ¯Ü	*Šß#?.IçŞÆ¾S|‹´šÁ*}ä^*6ñu·ŠƒUŒï•BïØë(X	ñ¸‹Çawóx÷òø&ïãñÍ<îáñËx|_ÎãWğx?ğø•<¾•Ç¯âñ«yü<şM¿†Ç¯åñëxü[|ˆü=øe‘Øo?&±ß1wÿşºóÛïÎo”ÓïÛãO‰·xèï™ão­G$éÿF!ÌÀë<„Kş9Èÿ:ûG¡:Á€pÂ7 <!Ò%…F!T!ü9„o@x	K¡A“ŠŞáS¼EŠ2k,êFQÉiV½¢ıöiû¨­Õ*º¡ÚÚ&ËY‹ˆ”ÂUÉksº¡T»0Is.(U­f™†ZÖí%e!©–]4ëvURØo¬«Å¢ó2¯ZšRÔ­*àN¬WªŒ¶<é%³¦©…y–äÍ©iš'aN³•Zİ0tc.€}Î„ ë|[ªvA÷²–M³Ú–Ğ^S¦aëF]kËhjh‹ºZÓÍ™n´8‹ZÙyéî«lU3ŠĞÁ&éH±´¦K+—”B^­Í¡rÁüM¦èïİKßŞC5ró"<Vğ±şnĞ²ìé´­W´µ,½fAz}XZÃ¬+÷Ãã‘ûCÙff/`¡%(”ˆ·º¢[Ù“ğX§ûi"ÅÆş¨Ùİšı"g_	—œ•Î&áñ`Ê½[‰LÈÒc¡$<ÿ>$íM$¡«Í~Ëºtk?(˜,ıö`M«˜°%ê–¢l(KºkDúthTú
ÈÜ¬ƒÌµ:v:jzr|B–ş¸kAú`WXºŒy+‹ØÁIêNP…´lÕ®[²ô‘®¤{¶¡Ov¥Ûô’ÿªk›gÔ+NuÍ‚F~k¨áà¿w>/=^>†1^ÀA²±a<.[Ş)ù°}&,uõ"UT¨ã/Ã‚ÉÒç@Â,¼‚ËïÂG54P¤gÃRQ½…Rß7µ¨ï‡A§x«["ı'ˆ[7PœÍ˜š+Ò_w/HŸï†vbòzÅI~
’ÿ©'GúRwR––5Kš|Êş½§lÒ¯@Ò¾„ô…®~.Yúp8ÍWµœ=©gO»•#{šéjGZ‘	IO†Jÿ‘şµ{Túq·:-ÓúØ#u¥dª:ë¡£ôÅ	(/]bÿie½'ñxü ‰¯„ŞAVBñá8ĞYÈ"˜2,åÀ¿1´"=šffñ@¿"Ìş?â~Nqúœ>Çiü/ûÁ€ogôAN¯pz„ÓYN¿Ókœ¶9Møÿªù §ßÁé/8ô]Œş§×ïj9¤%NÇ8ı(§Ç9çõı¾ÃÏi‹Ó›Çı	N¯qú	N_æô§ñç níâıãôqN8ÊûËéÍ!F×9M8ÿg9çòŸæô/ÿ3N_æôma>œÿ.NKœ¾Óx}ïãôeNÓY>ßëNyNÿ€Ó„Ó{ºùx2úœ^ãùiN¯p:Ëé+œ.wÓ)r¶ÒıŒnş±÷ûè‡}ôŸùèÏøèôÉ_gtsòm½é£÷íñÒİï£ïñÑs>ú~ı~ı>úï|ô7}ôw|ôÏ|ôŞ½^úVı}ÈGûè; ¼Ebÿ[ªB„Ãb@ˆCH@HâØ@€‚€êSj†ªŠêˆ*Ë—.g4Ãêx+¶í:ÔE¤–ÿgæ²Íú¨;uy Àü…¶ä–ûõçx¼ñV™ÙuÀÖ ó"ˆ›o+Ú²’»”ì(h4ĞÓÑ¤'±å–íDkó±=oyşíH Sà%3xÓÄJ]8î_:fW±c—TxÈµû	Ìonˆõ6ˆ1XĞQ÷)Á½‰
dÜWí˜wnAÌ ÒtÛÓ!/¸- ¾uRÕÑNÒ:*·³%GÊ_‡#%ÎZY…ñ(¨å²Òœ]éÔÈt» UmÅVóem -%™`z‰C7
åzQ;r=ë€CK:•"4dq<9Àb’H¤û“ñD*Iâ‰xZ"©ëÙ(uğS5hÊ¢^.›epãµ`>`+•¶ÃûÑŒ_"pæŸ.“Ø|µzê€ñè8ÿ‰dÿ ÿÁÔ ¨À Ì*ˆK$~ÚÒ†_óù?¨—Œ¢V"ã“#³£²"Ÿ•'g”±l¶ç $ë†Ósk¹‹ªMÒÑ»]Yšví:ªU¤§ÇP+x¹‚F¨ÿ%{zÀ[¡H ã½ Öø%TLDwö0†z¾¬Zù´p´åDú>Aº­—Ë,œh“Rñ±æÍ¼*«sÖ!&˜:¼Z8¯”RÈ"¦^ì#à'¬Ş;ƒêÀ–´åĞçDë%Ç	¸+ÍÖ|wğ~5Õ6kÇ·gæM–’Z/Û-?`L½|<yÓ,ØRD]-k¦;¶lÂ7•}Ä^ğ3±sO[Y÷)+ªÃ9„Ÿ±y ŠºÆwGL‡ÜÍR`¥–¡_Ë GèÓ·Zo/
<ö¿¹Z_Ü:¶±ÿIØpÿŸHÄÓ`ÿƒÂşßÛÿ™iy'ĞÌŞÂ´rê†Y+j5­¨TÔêİÛù;=Ï¶ô.›¿•ƒ@9Q¿İ¦‰ÍW`oóm²•òúM²SG{É6ó¿£ú‚Kñª½ì¤yvö{‹óªìöüóÅ1/JúÀ‹º$££h4 ‰zÓ(€Û¦/óe¨NtœÄs£bŠV©¶{ç`Ùæ¿šHúÚ`ó(Û&Ã¹¶	Ì.â>»3é¸.Æ¶ÌÃ»µ>Rò?÷»6;Ş« 8àºö0Øï4İº÷¢Œ:wÃ¯}¤íî *Üó¯À_×³?b÷çÿşÄ`Rœÿopşõüõ¼z÷?É1ÿ7­ùŸÀÍ¾Q®[/®2ì~şSƒbşo:Ì¿›1’>£\Ï«mÎñD<Ù¼ÿKÁëx² )Î7Î)-J"·_9“9-+#³¹ò&Æ§g”ÑñÜ²Gf`O©ÙS‡éíùE÷@à…`ëŸÏøaÃ,<?K°İıÿ@z yÿ“ÄõŸH%Äú¿8xø¢ç 9¥xO¡ÉÈĞbS…!z¥Jozõ²ëyáõ@E#f¥¢E‹TÔ%bhP¡m’ó†¹HìyÇÕ&0ƒ–n±8éF™E?“ÊÍ(xªVÎÊ¹éñ©I’èE‰ã¬¼Å·ÚGP a*_‡îL‰ô°kq¼™±—¢3™Ü)y†¸‹‘L6+O’ln*+çf~—°ÊåQedjòäø©Ù\fêŸ&“S,¡—Šd-p$ã©Ü#”K—§á”Ş”815B…),4âNo³9ùäø¹å#yİ8«Ü-.V\‚”ˆ[ÔôÔdæŒì4\«ªö|ç’0|eİ²£¼»
5

›s¥0¯Îó>YŞáéİ¶*Œ…7Š§à®ºFz=ú’×–L´e^·HÕÄûkŞ¬—‹Ä0ívEÚ™ıjx¾Ûÿç¿ÜÆş§Ó©„Ïş÷¦RÂşß¸­w~‰ğ½mnÏd~g*ç(ır¬™<>éJ	yzš$cC½xXÑ,KÓ¢'33™	EÎå¦r$ÂœÃİÇ‘+'5í]u½¦#½=ô21Ú‹Õ2á‘æ±B…G°\d‡ôUÀ¬Mæ¹°ÍÎNù’œz©€XBr°÷Eğ]/i™­™¶V°‰:§êx“^©—m½ZÖ=; œCdq^/Ì“EjSKª^†Í j¹¦©Å%ŞKl
÷jMÃ÷¦!oıIÅ¬i¬-Üp>…½ûT¿Û”Ö»‹v¡
mÖŠM'„ùÎz0Ÿ$ã3ò™iÃBuğXíòÁ=f-Sõã›…mkk­ehe|'j;aÑÛF _?;cØÛS7:7]Ë?=““ï™ÍLtJ¬Ğ#Û' c¾«Cm<+ÙÂÁâ5SYL«iv½fD=fkrj¦Ó\5»¡CiÙ5İ˜‹æäìDfD&‘;#$rˆD:”Vlí‚íš_öònDº†§“Xhg§ÍŠF¢ùºM·Oj¹ÜÛ\ØºÁ6Y0Üh×`|É¢†‹[.<v¯Áwd”¥#úHÛºÜ*€u.ÜbÇ‚şBa—ØZµ¶W¬mÔŠÛàjİÖ¨ÅE“	CÄÎÕH¹ „ô‚†¦™³ÿx ÀWø¹R ¦ïºyw½îiPqÁg33àÓv,È·¡şe)¶ÃËÛZDG˜Êkíâ\sŒs 
Sàs=ÓŞ.HpM­-y[Óc™œ<Ú<À]ŸÑ&gäÜIXŠóÑ‰Ññœ<23•ƒü ³¿ˆ‹xÊNŒO†Ç‰\†+óú+€ôôöl³gÂL"Ùq%Ï8Ê‡*	wŒ'^üô{Í"àÛ9¾_a‚œˆçèÀÖbŞá0Õ"è:Û_ ªãá…³ `
<géXÖ=51uÂ1T,Ÿÿvyy¸_H¶9y—Ptğ(e:¨Bê¤ÙD[†ÑÅ±ÙÊÿ¹;çXL3ËšjÔ«ÄÖP7A÷È‚ZÓñÓäßyTƒ¯Y%&lÛĞÜ¶”šl÷pG§—–ÀšÀîÌÎQvx—ğÓ–í•ÖÇ3 AÇw_iï`F¶>ÄûÌ³³ËáNS>Çd4¹œ¡fEè µíëú^¿3[¾7J]ç;L‹m~A4Ê½×WÛ½‘tfMKLŠ¦Æü»!YÓ²ô<]&ªëÃÑ”c=}d†K&‹ªÅ?ÌS<Œhüà,üx%İ†« sæ°løè#ÃY!ÈZ7¬LA+ÖÁwuvO†¥«^€.Y¥:LoŒ·ÀëfÔÂy5Ú"úéÑ%ª#ø±˜3üîİ›cİ¶]cëáÓä˜úªµ>|;0¶4œÄİ+Mçµçl9=‰ÁªKi¦}š‹~…›Ÿ¶ó
;ŞÌ«Èkp´a\‚5³BGÈ‚ùÆY{'•pø`/¤‚£ªªxîsíˆb7àjª}ßÚáü¿ã÷ÿÎòšŸÇ-Ğ6÷?ı©x¿ïı¿T<> înøz€??D©cK½8êÓÃ³¨³yFQáV&ÚÃ‹teÔ-v´XÓmM¡ò6…Ë¥‹<ÚKT4¢°KnÕãl4ÎRAõl§:í:Ìl-]Õ€õãÚa¨ev,*q¿Qå\®Ğ¥¯qyÌuâj„}[fätæTsñ(ò¹ÌÈø'ÚñB½VÃOD:£ÂÎZhN±yó½eÒ,”èg©á¢7\^jÙ4Ã:µŞ¬øj™:àñr§êaŒï>Ş^gŒwÎÙH‘³'›Â
¨8ÆòÚP‚Ÿ×Ä6ú‡<F7ºQ_»H$‹Gè^“4óNO6ËL’Ñ¸CŸ¸ïqZìÔNO†AÃUS9ŞèÒñÂÑuà»êÉà{-¾öz¶À"A˜³Å€ÅÖõfÎí¶ŞS99[øUgÎ9U³Êw\·|nçu+¬LÇô²6Ì¶[Of&¦eßÒ6Efr³²çÊÈ)	Ô®çéz7ÒÓ*wÅ­Q÷Iq¦.¨f8Z²=û"çşŒ˜`½òŞ2^ÜÔ²S—³‘(šÆ[lºó ÌİO¿]‚Å=5>ªd±‡ˆ>gà¢Öíc‹{'œ­]Q¨w‘¡ˆÿnªífšI7PÍs…«¹ÎúW­–}ëOÈëöa6¨„çÀéŸl0_Ü¢Q´4µV˜‡ÎsnĞ‚zØjâ»‘Ríù¨|.›k5å„÷¯C¤5/ÚLØí}IË$zûEŒehxo'	ÊìäôìøL¦¥>Î ı¢]¸€€€ÀóÂÿæ§Á¾ Ö  