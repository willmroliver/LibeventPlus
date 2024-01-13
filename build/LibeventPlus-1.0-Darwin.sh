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
‹ &ñ¢e í=mp[W•OşH]ˆì¶åc¹(dã8’-ÙNÒ+öK$âÕ,[æõIz²‘Ÿ„Ş“cSÜñÂFeÍ°è2¥Ë°ËÂ0™ı"ì24¥,éğ1„2ÓéŸ1¶c ìÒ,dÏ¹÷>éééÉmèöÉ}÷{Ï=ç~œ{Î¹WRœÔÒU†`08‰ÌXŞ¶qV
G"ÁÈ@0î'ÁPh –Häjw¡hZjºRÈå¬Íè€,“Ù¤Ş98Ì_&„õÏêÉQ=©-h†•ÈÍô”¼„26]ÿP(Ôv¬®p _"Á—°á¾şßÿÍÏ$ùšá}¤HC-’ô!éµ´ş&Hg|’¤(Óò‰iCŞx+O-¼XQ,mÑ1Án~k},?Û^Å[$´H+NTQL«˜4ò[½å¹pÚ8¿]•ö³©”¢-¦´¼¥XjÒÍ¯ûv–x“Ô¥hœÒ´¢™œGÿîâütà›ñ»‰Ó*ÊHt:ªOŒO1nCœ AŞÌ,!][g7â·f±ö6à|½ÁÕ¯å3?.Äí1®¸úÃñµ×±ÜÇ“¯†4éFWùP!¯ZsMT8wpşç`û8~îƒ’”hfsŠ<‡>Ìúù`rPøWÁ{‚Ëhá) ©Ò›¤Æpş~Iê÷(#—ó‹±{'>8|ğù‡~øzs­ó¦g{¡ŒØcj…Q6½†¾Ó9õı¾¹KbëbÃn‰õyQ}ğµÁ£M:P4²¹”šÅ¹ÀD'CIå
ÚşŞPÏ@­ÙF>A'Ÿ¿Ú…½`|‡Ô;ß	Y³İùGzß­ƒ­nú©%ÓÒæ{8%½÷¿íÃ¬}'Çq¾ @€  @€  @€  @€  @€  @€ Ûƒ™Xé¿c§Ÿëˆ•–/ÇÊòåXIŞXÿ]»$ÅJ¾+µÅN³ã=ïyËJ=ıòåõÿ¸råŠM1Âë±®TÜ üÊc_lÛ*ô=gö¼å¾zù´ò-n¬ÿs…o Ç“ò\ÿ3èîO°’ÑÇJÖñ§E´?‰õg®—¤õï\Ïñºşqûı‡·>ïş' ÍÙLé‰Xéc¥±§m¥™ç2%ù§£%y¿Ó*Ÿ+ËÏ•äofÊòO¡ò)¨XƒÒ'Ö¿}„.…áŸ+Ï|s´,?/=dOíyô‰õæ¬•Ÿ†¾&êå+²/zÈÅ.QùÁ2”‚``¾6Z{9¡™r¾œƒl¶·˜ï‡Úì©Î¬Úõg8óƒ¡3¿D²•g|gf_ù‘ïÌØ¥›}gä_c»¡û‹Ï8zrèÒ·|{äoİ¿|)ôä×qB‡.]€’§®ÿ”ıúßñ§6¡K•².À ªÄxUîfı/}k=´§/K{>~şfß;o¯°‡¾Ñ6Tå$¯6Û˜¯]ç)Ëc¿0úNÿ‰mÒ¿k‡ô½;ëO¬Üzg¶\b—=Ã÷gu¾>µ«áz
}ifİÑ&VY_ŸcíˆS¾Tü'-µ~ï.QØôA‡½ºø(ş0kıW­¶ÑºH· LÄ«Pè?3å"lÂå§×ã>Û\°íJåĞ¶„-7JòsëŸm¥{qcı#­ö’í·FöŠÚ4Ëå"İtP›N†Mwqıœ³·±¶òØs¥XG¦<&!¶	¡ôFÈ¡[1Â:é´_›ÊgÔc§ßÎl]ĞÃ~8ìïFìâzì™Ç{fôùéÑÆ.®ûZé¢7³ÇNûıw›ÚoR£O%y™§AÌÊùÌ2å¡½ÌúÆa"f6FËGÎÜ½ÔBKGarïm‹•~;ıèÀ/b§Û/mÄOŸ¿1^úEüôcdıx‹­j^úïìoj“ş6öåx.¾—ã°„ø–)Ç÷òed½gK‰ï„.gÕ²×¡6ûıÂP‡ıš¹0´·B@¸ÛYmØÿ©múKğï±Ó‹mÒûn°å—ÛÖßÔÌ7…Ë‘~íò•+Un.ùè??íá?_Ôú~¦ië{’{¾ÆWi½*Ÿ½FÛì÷Ñû5s!º·Bà½^´?‹mÔAİáór6ëËÚĞ5~³g›-ü,îAÏvuñPÅş.¶¡~«W+›>SÚÀ&`x.9†õ=/­?#mé¯ˆ³}ÅE,¶Åº„>bÏ£ëŸ®cK|åmï…n]y[–>úÌÓg>ï£ÏÓçú¼Ÿ>?BŸ¥ÏUúükúü8}~’>¤ÏOÑçCôùú|˜>¡ÏÏÑççéóèóéóKøüô«}-¯oİçã?P¾rÅ·0ÜıÆ;¥cûyı;Zo±ë1ÃßcXt3ÇRåwŞˆŞb¿uO2*U§®uKÒj˜ıæ|uP’nüüa ¿ıx76İüWÓgïˆØÀ÷É³¾vämÒ&Ğ±âãyÏ›yŞÂóVïâùu<oãùõ<oçù«x¾›ç¯æùkx¾‡ç<-Ï_Çó×ó|/Ïÿ„çÊóx~#ÏoâùxşF6°•ÍF-@€  @€  @€  @€  @€  @€  @€  @€ ü1‘Øß?'±ÿ¯Àù÷×í¿ınÿrú{{üSâCUú÷Ì›$©É/I¿4ïIHg ü_ şÛì?%ğµû$ß!H¤UHß…t’¿Iò@ÊCzÒw!=‰4K¾~HãŞiÒ—!=ÕŒp~Æ8¥ieR3‹óàï²ZZa^7TK[À‚t6AsãÔ<dJjQU’Ú¬n()ÕJÍaÑìâ¢’×
fÎP³ºµ¤,±Ô´Ò¹¢•—ö7ÖÕtÚ~Mª¦¦¤u3Ï8‹óy†›5å™\ASSs¬¨¶¦ i5³š¥Š†¡³ä³9x^'ëJµE½–4›Ëåë
êÛbi*gXºQÔê*ê˜Ú©<_Ğsœ3İ¨R¦µ¬ıêL5M}Ö˜wËÁ1¯ivµy›Z…ÚÔ²%•T³Lé`]Ç#Y=	Kı¯»¨¦®İ÷ÃãüûAûÇ,}^[P³ÒÒ›š¥³XñğXı€/Q© üšğxØ‚–¡`uœº™8º yªO‘îˆ°…¹AæÄTP‘FÒ_LâËŠ¯YZY@Vì¹)«‡|œ×g¡ÕEËfö7¾„ôye÷=´—¥ùzeéI Z]Ä¡B®ò‚ôK(^‡ò³KP~vÊ)‡û›hë¿j’®õÂVfSÖ¥×õ2ËÒ[ûÚ|nA½uSQS–˜)İ2,=ë‘~ëS§déãM0œ<ÎY§s 6ÆÑø¨,=Û´ ıêÎáPß‡CÍKRKˆnÓR­¢)KM½NıIl¨Óp(şËæAì¤Qœ·;ªk&tõ#Í !ÌW²hN’IéÇÍÒO ô,öé¼›Ç%›¯]ìûZ¤R‹Ô”ÖÓtk€Œ+Í¶JËÒG[@I°ñ*>>‰÷ú¦BŠô­©Ñ­¾ÖRÙ7€=ÖúÊ{]]Ié;ÀnmÙÍÙPn]V[¡ŸX¼6k?ÅßJ—ô­°¤_’‹:¶Ôù’şg+.é·¡|ŠÚBÒÇšû`ºdéš¸‘GõÄq§V%3=BµP¤ß4JŸm9(=Õ2,}µuDú~+,%•ÿ_ ;"S•û\ÓAúrÚKÏàÿí²6$Á`°ƒW|w“_p(ÈaÅ·âKA\õPµJ+¹ı¿[ïÏ|+Òù0÷×IÒkšÙÿUƒàçø-p|”ãøÿÍì²v+Ã÷q<Ïñaqüİ?Ëq‹ãüÿÍùÇÿ
ÇW3üû6~á¿ã89Äı›á9ä¸ÄÛÇ8ŞÁÛ/p|ããx‚·ÿ‚MÃ¿Îñóœß9~–×ÿŒãA£_¥ò~€ã>Åñ‡9¾ÈñUNÿÇïæø÷8NúşS›?ÇA÷˜|N„ãCœ’ã9}™ãsü‹Ïsúïr¼ƒã?ç8‰0ü†Şã#¿›ëÓİïàøÇƒÿÇñÿPBø2Ç/òú_åøÇ78şÛ¿Øa´»•âM6şfş6ŞíÂowá3­µüïfx%Ä:éÂW\øƒ.üŸ\øã.üG.üy¾{W-şfŞçÂG]¸êÂßçÂË.ü“.ü~Î…?îÂŸtáÏºğnHû!õ@: )ˆc€„Ë‹*…j‰ª‡êŒ[·%n=Ü^hBĞL )‚…tDb6ÂXI†tÒ±rBz¯’<"Uãf´ë|¹›€ºv‡ô¬_¨+®†îššÈ`³ÊDC™Ã!æ{<ÊC#/j,yTMz
èm ¸wG‚{îõ<ò˜É‘^BÛ/{”»8Wu¨&Èª†d[Ó.xÓ¸ƒ4O"Ï¸Í“Ò;”ó"¥Fu+½El;òj<èˆ	=ë+a¢ç>ò"ôftĞGz8CKOÏhsÛ”Ïz×oÈš:ï¾Ôo¦š:ïF#¸4jQİâhÿJ=ÚãZfU˜¥”šÍ*•5—Ãd¤´¼¥Xj2«…ëJz{ëŠ%[€n¤²Å´vàjÊ€Cä@$B$vdyoØÆYa(‰#Áp¸ŸC½ı¡ÊáêBücºRÈå¬Íè€,“Ù¤Ş98Ì_&`¯?İˆ=sùüUóÑ7\ÿP8aëŒDÂ@€%áD‚W¡/uğ
_ÿ}zÆHk‘ùNy|Z‰%íû X74šö}\kÈ-Tmzmí¹ÍQå§eûÑŸ ZùÛÛu^ïšÒõûäöv0õ¦Ih  ( ÷° öşEªn©‹àópmMdÎ¢¢¥g3—:	nÉ"™tµÎœË,rjNµ\,¨«Iª©“JÆ ©dµv!§§»x¥Ãí¬oÅdVOU»Fûpw°Û£İéİR»«ÒÌÎÃ^"ºX»ºJú|;ÑTÔÖÜËª:ùˆ*Äo'T+W¸µ!ÃzFT¡JærYUÀÑ²RÑˆiSwkÁMÄ¡um‡Ş€zb#nÂÊy4Àæ:“Uk¦²1Q·³[
„‡ĞjÆµêŒÁËfÛşå5ö¿²[_Z[Øÿ^ˆlû?îCûé‹ôû-ÀÛş‰NÉ›8Jõ& ZS4r…´VĞÒÊ¼š¿m+?p¸Ãcáö=Cc+|nƒF+o`Ì’äVçÍÒ6'¥´n«jË¨oYg9·%Ï»]KN*W â|Üó"Ù1_FºÀ—98£í†#pÀ£ˆšæœ‘ßI_“YgFâyUÉŠ6Ÿ¯7ûö¶ÎqT*j<éª÷<•#tûºÈ³Â»‰óäí¬¤Sâ¸Û´ïôºHÆ5Uü¾ÁqÔ^AÀÚI`GjW âOk/è¨W5Ü:ĞEêî,¯ ¿øJ0ÁWõì°óóh Ü+Îÿ×pıSóêÉ«y´óõïöŠõ¿&P]ÿQÆğã“lÑ|i•açë	÷õ‹õ¿Ğ`ıÈpÎÈè³=”êÉØâü{qıÃı‘ş¼Ãæˆóßµ û” ş›ï‹—•á™ÉI<åÆ§¦•‘øär6LCL©Y&S?élÿC@À‹mì¾âû\ê…Y‚-ö(<¦û ¶}?îÿp/ú±ÿ¯>ìÛÿ"¡}9¦xO¡¥Éğh±¨Â}>O¯Xõ¬ÖÓşâå€ áÜü¼j¤M2¯.CVœ4r§ˆ5§áñx^µÈ‚V0õœÑÓ'İ ³hñ±ÄÄä´‚§jåNyr*>1NBÈ1ÎúÈ{ìwª½¦òEğ$~;»Æ›k)0<&Og3M$äñ’˜œHÈ“ÓN˜pyD??63ùSd|‚tR–¬6g<•×0åÜâòœÒ+G'†)3Åæ…FÜmbR>?±| ©`—;Ùõ¤— Äïd551“Œ†
yÕškÜ¦/«›V€W¡FAak®¤æ´ÔI>&³vz:·l†
câÍ†RÓpGC#5ú’Ô–rhËœn’|ï;Ì¹\1›&FÎªW¤íiĞÿÏ·}ûÿÂÀ-ìÿÀ@$ä²ÿà Äıÿ5§õN.1ŞŞ®g•pp,ú®‰I[é—{*ÅñqG±ŸŒÊSS¤·g°¯ç5ÓTgµÀÑèttT‘'''&‰Ÿ9‡ÛnEª )hï+ê-íïl§—‰NË˜ÛFšç
eîÇv}şm
èóÀ¬M>—ÕSKÄÌTÌUdË¥zz õöw¾¾ëeí#…œ¥¥,¢Îª:Ş¤Ï³–Ïj„O795§§æÈ)jS3ª…Í j¶ ©é%>Jì
÷jAÃ…¡oıÉ|® ±¾pÀéöéSün§W5XïF$Úbú¬¥+Nëíto'ñiylªÆa¡ºyx¬zşà<«–©Æ‚úñ`aBOiuó±9-‹ŸDmÅ¬fö¶`È÷äöv¶ÆóM÷rƒÎOMOÊwÌDGM%
¬áíbĞ°Ş1 :šÆB6qğ„ÔŒ‰–4«X05fk|bºÑZU†ë§SiZİ˜LÊ‰Ñè°Lü‡ıÄßMüZ+–¶h9VÇU½¼–éiÄÖAÂX{ÚÙ©Ü¼FÉ¢EÃ'5›í¬llİ`AL7Ú5˜_rJÃÍÎ-gŞs—Á£
2ÂJ‘Fc¤}]®6@™KÀ7İ°¡{ ĞØá6W­­kµâ68_´4jqÑdÂ±óC¾ \Aƒ_ĞĞ4Óébö ø†+)à‘3ğS·Ú¨·Á=*.xáDt|Ú¶¹ê?–öh;ji«›è Sy­cq@á`	\®§Æ´·ƒR  .¨…¥ÚãÖT,:)TNGÀpÇg´ñiyò(lGÅşêÄH|R˜„z¯³¿ˆó×´‡Ç‘É(k–åòJö·w¶o3a êm¸“§måC•„;Æ/~ë¾`ğíÆ,W#'âY:±…ÚéÍ©iĞu_ ªãá…½`	jÎÒ=í(7pltâˆm¨X=;ÿíğ:r¿¬sò¦èà‘Ë”—@ê¤Ùª†ÑA±ìßÌÿ9×˜L3³šjóÄÒP7A÷È‚ZĞñûê&‚jTƒOo.Or¶¡¹­*5›*÷0¢Ó3K`M º³³DÔ”UÚ%üö„i¹g¥ñÔLˆ×ñ'ÆÕºv2ı›â]æÙr¸Ó”O0*{ªÙWhmı¾¾ËíÌ–ïòƒRgÀù@„i²àX#ß»\Òîò·£3«Xb’ÎiÌÏĞ¹ë!$‘3M=I·‰jÂş°5åP{™æœÉ)Õä_æIw!?xm€ßk¤a¸
<ç`³¹ß]$jØ;I‹†€•Iié"øÎ´Îî)Ğ"wbS0$3S„åíá=¨u3jê$ÌíQF…p}‰ê~-EE'fOB#?Â'„{÷ÊÜÁ°-Çœö´óe²Í }«îWÆ¶†]¸s¥i¼÷ì³¦Ğ[•a+M×/sZÃ© ñcëSw^aÇ›9uAI6,ÀÁ-XÈÍÓ2a½qÕŞ‹g%œ>ˆ…TpTyÏ}ˆ¨ç\MÕÇ­ÎÿÛşüïN.ùÜmqÿÓ	ö¹>ÿë‹D"âşçZ ßğOÅ/Qê)[ÅØA/zÇt`ÿ|.­‘\êŒ´Â­L ³/Ò-äQ4Ù5Ò©‚ni
åg“)œ/İäN¢¢…(¹*Ç4N\AõS,Sí~íg¶–nÈ”jÀşqDj6‹JœTÙ—+tëkœs¸!n‹«lE>ÿD*
øH{VØYÍ)voN£·Lš‰İ$Üôà†³KUû€fX§VÀÄ›—äá‰1€ãGFåFâao»µ^fœHá;VÂyPqœ&<Œ%5´¡¿¯‰}tOyt®~¨'è§±&©ÔT:>?&£q‡1qßc÷Ø–NO†^ÓUPYŞÀ&ÜñÂÑqàQµŸDñ³WkB`O–ÀÌ1 ¢Ø\nôÄNå›”£Â7=a‹fÂ·-[>±}Ù
kÓ°¬«íÔÂ£ÑÑ)Ùu£´E“éÉ¹æÊÈn	Ø×éjw²¦WNÁÕYwq±—ÎK 3UŞ5q‘}ÆL°_ù¯/njÙ©Ë$Ò9ã<s÷SñwË°¹'â#J»ÑMôY7µnª¹¸¯¡„³µã"
õÎ?èwßMÕİlA7i U9W8ºkïß9Õ¬Ú·¾Şıá¤ní7 @%¼NÿÜ`ƒùâŒ¢©©…Ôö}ƒæ5ÂjÙ”jÍä‰ÉjWèxÿ:HºÈ`år Î„İ|«h™n¾§†Ç2t¼³ef|j&>­ª=Ih.@€ /şÁUï£ Ø  