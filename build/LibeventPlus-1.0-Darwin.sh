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
‹ ³re í}`Wuö®ã‡,?$;~å=QœDv¼òîêí¼$Kck-YŞè‘p­vg¥!ûÊ>d;ÁT©ã`Eq1%@
¡4-.ä§†09Ic…?%¤­éŠ(Ú4ABbhšüçŞ{îÎcwfWÖÃ²›çÓÌ9÷ÜsÏ=÷ÜÇÌ½Ó­D6Ú¦ùçt:«++ŠUî
†ø\•å.WUU¹àt•»ª6¡rº#¿T"é‹ƒ*»•P(Rúäxv>`-ä`9Òxüº¡şCJw‹Ò-÷É‘¤7”J”ù¦8°GUE…Iı»«İå.cı»Û&8§X¬¿ÿåõõM¾¸¿÷–Âk\İNAıAtÕVWÔVÕB¥ÓwÙÅêRp×T¸k(gW¡$•µ¿o{£¸E#÷è|›m®×fóFm¶n†ŸCü	¢àg@ü"âê Ã~ÄGÉxgáŸ#^lcx+¢ñ â×ŒøÄ•v†mˆqÄÏ"~ñÄÿA¼~ÃÄ0âıˆ‰xqÏEsşâæ1¬ÏğQÄ•~±¯€aÕB†/"^ZˆöE”1üâ=‹±ˆ›–0üˆo#^»”áÄO!v1\ZÌpÙ2†/ ~t9Ã/ÆúAüØ
†7¬døâ“«>¾š¡gÃC¼ş†öKñ>â—1|är†¾í}%Ãß_…ö¼šáÆ†ó®Áò"şÕZôŸk–_Çğ¿¯ºá÷ï)exñ?ûÖá5b×z†ÿ„¸í†ßBübjÃFü éˆEe?‚8øhGÄ_!®r2|qƒı±İÍğ$¢\ÎpsÃSˆ­dXVÅ0Šø÷ˆ­Õ‰x°†áuµO *›ĞodxñobxËÍ/¹…áˆ‡nÅú¯ÃvŠø‰zl7› şq¶‡F†£ˆwŠK¶0üâÕ[6#V7¡<Ä7†	Ä_!îßÆp]3ÃD¼¿…¡s;ú+â}­oŞÁĞ†ñæŒ‹½·¡¶1ü2b áOıÿ€ø…N¤#–ÜÎĞ‡øÄ‚?bø bñN´'bÑû°ı!îEü{Ä·y?Ã[?€ú#îİ…õxÃÅD¿Gü4âoWKw >ƒxW¶;Ã#ˆ.ì'Jzm¶XİöRáoö0¼±1ˆøâß!şñâ”ûU”W×’ôş
¿¬„6W÷¹ªÈÀ%HnµV†È ©V$c¤Í¾„ìrRá˜ƒ‚d*!z«%)±ÅÓ"æÁÛ—ÇŠFcşh$©DR²Suœ”â©HD‰ôHt¼fÆY“ ÎH*,ÅâJ4®$9!*YYËAØİİmNÌEu0—}ş^Ñ»Eñ6»œT©(ŞæJ6–ìÛ«¥¬‰kJ@’÷(fú×kPº·¹:©„å>_(cvAµ$£nPôN3"À’!"ïF[+	ï–>øO_özÎÊÙîÊn—I~nB£YŠF¢¹=Y.I.—3QîJÉR,÷ÔKŞÖvÉU%I½¾D¯‰dZIzÛ¥¹í!7ªñØ$÷ÆdâÅ+i¢(B±àìîJIêNùï_)‰¤}0ˆöû’Ñ8‘V«^µ7H$èrÈ!9)ÇÓmìüÑ_Ù£*6UzrªÅÜÚòäD2ògÑª†iUFÍÇ˜3­WÌT+.'éëM@T!‰Ær\Ha_Œ&“ã¥½Rz¹ô(”·F¾+åIÉ(¹név¡—Qe£Úë%P>Íª-S%)“Ëşâ¦"¦¥«Ä²(àä4ñdÕÜSß0P¢Y† ÈÇâr"Ö‹ù”I—nâ~UTâ	S“dÓpV‘ó\ıª„•ÀôëMWiò1mNYDÒGQA¦d"Lœ´‹F¿:Ûš!ø´5+:Üf– W{&T¥ÓXb‹â‚¢8¡N¨AÍLiVIêĞ¢8'•ûtYf’z…óOŸ½“œˆ‡Zw¥zÕ;çlpÀŠ„r·Yæ%Ó–AWP)¶÷„Ã†r†ÛË%-£Ö.‹pN>£İZt¯äSk«‚†ÈæÌ’ªÅ>o‡^Ìì[îg¿ú•ĞÚ´-ª1r~*îñRá•#d|-)AÏÎDÜ]#5ôÊş;ëãqß^oT‰@-5D#}r<¡D#HSIUûÄ
¢¥Ø¾ı|q½—Z|@ÒùâvîóVõF×ù×Êİyè<Óš‰FÎŸpB£³E·ê8˜üiš-KT"–Ãæcr$@VMi¦D|5¶qu¹?H‰ ñÉÌƒw’0ívÂà/HqPZŠËA*Aœ5ÅÎŒhÿŠW4œq¥ÌÂ[’¦f@zŞ.åAÚ@ÜˆæÂøúÂDÉ wê”`^ÿçgáÊ©’ÁTÄŸ„aë…V:Ï0Äˆh|ÜpŞ—/ìÛ#…¢¾€ô‘°u¡Õ_µ¤AeÚ
Å¼‡¿ ‚l/K´şh„uO¬Ø4¿¶f*8¦È~y·’5LIqĞ*“©”t[[³BE·HmlE‡Ş²/EZ÷’¢äiï`£ŞÑ!5Ævt8/ˆL†äp,äóË|<u§İ{¼'áQ¶Y>—İÙ˜€˜"g[i?îÅ¶æÉÂY×Ïó2U‘ïºÀJU#]ˆ#»ô[#ç{9ÜF9/úhÌ¬ĞĞ‹IşĞİæCPÚcH
t9¼kÀ;‘€â—m-a2cYŸ¢]a”mí’¸üüATsA§³3cı3‘YÎeÓÄÆt%:VòÖH”ê¦å§ÜØãLP[÷lĞ6$û‚’;èDûe{Õ'g"mYÚİôÍ;sxu,ïb@şã‰v73A=(¼íUpÃÛ!µoÍ24(×ùpFc±j
zÏÖ(ß^±§7İ´fj¶3™š®EMk¦ç¢¤Ê±\K›]E$–ãŠbXXI&<a±f&ºUÄØ“0)÷æi{"ír¦sŠj·o–rª“W6¦Tê2˜òwÓ´ÊÄxíµ¤Á7÷M¯î³Ò£ŠOS}J„òkº»°qŠ}L ÓX¿œúì`HœŠù}™¯GM[¦ñv²2‹=•’`RbÑİrÜm2œ¾ˆ¼'™æ´â‹F y*}
D)%H'ajr±Âª49sŸÆwjÌõJgÏ×[„¼>Ã—Õ´Á­^òB«Ï¨.Õøà$ë@‰núÈC|ªœ~œ5íªÕd·ÑÌÚ§†¬ñêVJ< ±I¸­ÙĞWO»2µéa©yuM`,+²±ì6Ëj+:s,›«pÓØRÍÚ‹í¥qbş0ZfuWqö¨—Å‘Å´#‹úºFã»}ñ€äK°i˜fúÈf‡Ü‰ˆŸ/‚Yd¾øšl¦Œ*Œ,ï^O“u«d`eòòõ¬PÍäõY¡[®w×Î±v9^O›½ûAf‘‚v¿×Pë„mPóĞIĞU"c—6+tuŸ½®³ê]Ä	ûí¬Ò~âN=«Ô×z<êÅ²R"
û|=b{óyêWÚ2é¢[--ä]š,ëzúOo3¦Ø„}Æ4Óú0ÉÔUC^?	úR¡¤Z×³®¢µî9i­Ã­VÏ&¢vGlöÏ™ÓlÂ:sªi=T9êZë¢S¢ö¹Üş:4;+¡EÍ©vÑ_‹¸Ú9ó±Ü­ÊÁ·2—qôÏN¨jİ©)Ğ-ÉqY`ÓP¦åÅ‰ªÉ¾8Q%µo–`‚‘õÅ‰*|‡Ğø>|­¦¬J$!Ç“ÆÂNËãĞ
T'«BXMÙ–½}ºª"Æ@îhŒ=™“"ònÍZT˜:acL—IÉÚ“.—/¤ôDH•JI3)Ó<ú0{‚aµŸşì?ÇJi­”}‘§–31d¸ÎŞ”3ª¤Ñ´Ù¢v¾zç·l2ù¾&ÇQ³QSİ+O™¯<åÒvÚ‡˜“÷ÚÕr*İv6œ1>=»Š1e!{
Ûã¤}|:t™CM_O¥	g@Ë©
Ó{úÏen|N‘'t®:çjMMãN®˜Á¬5Ì¿úrÒ”wrİ?kşÔÂdjåDşÖkÙ,_÷¢áÑ™»i_$oÔtŸÜç^í)Räİ6ƒ
Ó=ä3 —§gøÆ×«i:óW¬İôÌhŸ§óP=hXĞ½bIøk	ìLÍr5VÆúA~)3W"2Í†±ÅfÃY¡p[00+T4{yv(gÖÒfƒrú(ÔhlšN§ÈfwĞëB]Ô%'Ô¢Úı½¾H $^ÜFSö…Ñ$ÏÔYâR¦0İ0ºËßl£KËlF€1=äØœVí[ƒl;ïÖÆgGÉÚî	³½Ûíå’şCH×œ•(b¢JòıS³dº]mí.²Åk0çë¸lë]+Ô¦Z¸³Ì÷øYçİ–™y›>wR	™;µ;ÿ<¸îŠËK[÷ìÕĞF=e;yÄn]Asmëni¯‘ÈîÌÌÇYÓ¬ˆ;oEt(Ş.ªê#<@©İmÊgªê/	hÎŠó7ØM7k²í–µÖrĞúF+MV‰l2&ªÆ”½³¿2ON.OK~Y^~ŸŒÌ31’03jƒ™Q§M“üÍ=m*dTD{Ò]á·7İy$9š•ÌŒ Gô$Õ½ˆ„[ò‡|‘ÉŠJáÂJ
CK ÍÍå&Ÿ~ÁÏ¾ìÕ}ô…1”ûìŸUÑĞû2nWÅå0Lá²Pjarçó' &,‰^Ó<\¢Wû	Í÷SÊ¥¬Üì3™$÷„¹M¾¶‚7Ù1	Ù+‚ıL¾£Wí®Íş½ªòŠ*'~Gjâ j—Á¶Œ~1êø¯wØlö‹ào;ü›ÿÌÿ,¿Kà_éóïû•*Gæè¯à¿ùÈ^(ïIªé$©CÜÙ‘)ïWeª<¢Ëø6[#S¬_Ë'I=~¿$ïñË1²n×m”7rJíÉ·Ê,Ša#{Ò­‡*²ë·?Y€×cn½¼‹2äÑ‘’iyùÇ'Q=Û)·…r(/O‡YÇnIIRK£–^Ê?fy	ƒq7Ó©¸Ïfû%»¥+¾$É½R0îËÙõ+õpEQ^3“×µé¼ÈfëÕÊ#ê¯áå™·ş³4)¹ß»}±àÔí‡hz›Ó.ÇÏÃ¿ÿÿ®²6EÖ_gÓÀÏ›ö¿VÜ4°ïLÓ x¦i@?EMƒûÆ›4í?QÀ®÷?[|Ç3‡õüûÎhhEW5åå¢³üšk(Ûét¾úL›NĞ«¢«êl^ú^N8?SzWp`”°¤Şˆ¿mØ~
µ;òTÏ°ià8Ü<Ä£Mƒp%ß‡ƒƒâo!Õs@<wGY¥jÜ>Ú2(v7¦G!ÁsEOè
}„ºéPê´>Énîå»À& ô!Zo_áu6Fÿ–]uŸ¶~½´ü©q,¨vİ‰¹¹¾'¹ ¦†›­¤—‡¶Ÿl9$r¦±ƒ§ša>¼fšöƒÏzïxó«Ë´g¤ÅÜ‡µ6=7‡›~<#MƒÎÁÎ7ŠÚş[°Ø)°Ü˜ÎFÃFĞ›YmTGm4Âmtr@|™•3˜İÑ™‹Óş~päà‹uKØúÿİ~°ó­şŸÚns­ı ø;’®îÔ[ß"ÖõRİ›ÏÙ‹ÄïÕ=°ïM×Kß%»îÍpçŸ¾÷~÷m]o¦ïl'`05®Í×XZı\ÃÏQŞıglE¯µ}c˜{´Ÿ×÷`M—Ÿ‘&HVù™åÕŸ‹ÿ“ÓÌŸ§>MƒóXÅ;u?Ky³ØË¤>„4ÿ@ç)Mš¦ÁÎS< õlÈ:ˆ®šQ
ÎïÔÄÇQc¢şœvThVØ>RciçÆ;âIë¤-á$o	ãâkéÏZ‚iı“2î×sŸVÍÂ›¿Eú¬ñh`mû4ù¥c4ëb]  wÖœß`	Ìy¨s<ƒA8!¾f³õß
¯Ã)Ö‚¶;™ºşÃà„7Ã&ÏOøŸE¡ÎR¾3ƒ`ß(¯‡Qmì¤!C_ßà#´?9Ao†lş0®ö5g;^ØwÆ¼òõiİ^ÏÊ'Õ À›™©=4±Â»!ôQ$ƒº©±G¾íGW¸	×Ç¤ô£e·ö‡‰”orõ‘«<SŸ¡ş_/*¶¿^´Ìfè&¢Ï·Y<O‡U:Öæİ¢>¾ëUK7+®ZFç ~÷ï·İ×Cq=ítCL>F¦=RZ>V’Q›N°êä·É8
‘0k8ı§ï¾û.ôÒılı+û¥u>‹ù³×øY¤ŸhüÊ«}¦ıÑx=öËKŸÌòBYS§šÿbŞ·Óc¡¬=º™½˜Ø‹±àé+™B÷äÖÄÙÆæwg´ƒ@Á¨ïş}gŠ‹>ÍÆnÔ9ûİÀĞ|ü©³ÑáltãàÔjü–§½ÓüéÉ…>A—¿nŒF9–|°Í)+mÚ^ˆÌóŒ&8»ö—m=ÂiĞ/=•=Éª˜NvOi”oL7d§¡Ìİ>¦¶=N¼ıóöpQíá¬ı!/ş{_‹ÙIC¨€IÈ@'X}ûhópïI/„jpï¡÷Éz ï='~“¸Ï1pŸvœó¦ø‡àŞPz®? $G É+¬YÁ»®azÿà¬è¾VùGøLê¨½éÆíÃ´Rj‰zBÍöFq&iŒïú_&ñúßtLy¿ª"Ê8PGÔMË|’^<×´ÿ¹ât´I§§ÿyt®:wãÅ8]ÉN«U<øujº´ıdÌ[ÈJÈ¡}µfJ›çİá¦§›^üåÀñı?µ7-|ñõ¦¢õÇ_/Ú9LşqÉ¡"îÀ0üyà&b‹ƒÅ-ß%×7áõš¿x,—`§*¸B'Ø‰‚*¨ ª/¹]·K¹şpóP)7P|_AQÙñ¢.baüäÀŸ0?eÎ4Ù¡¬ÖğÔ\Ï-Ç}gR8Do¾Xôç‰êö0sÿV¬–k…®\ÅX€úr­ÀÛs5å¢€¯}ğ8k­¥#Ã†ã$÷ã¸hKú.%¼»“û#MW¿Ø´T=ĞK¤Ú×ßtèë½o+È,l§v8¥uP²¨m`Î¼“–Aÿ&í´ÀÚY=8´RH2˜ÃvÍÑäÉæÀq,ò7uç]tÔö$¨¼mv5©:<ÁEt±b0 7FßaCL9ùNÚÉÑÛƒôÌ´ôRxÔ8Î¤ÿ:0ö^çSOQÚ¡1&Tm_ûk Ô<HşbŠ}Gn<Ë£ïğ,Yæ‡Ñ†U¥k2#ÍÀ5ÿ¯°B©IÑ¨w„©ÇœŞÄîª¦zGSGÀ8d,‡Î"†èAâ^4í?nÍvÛ'±º4zr'MñäÃjá¾ş0Ë¬U|“ÛÇè<Ótï³¤¯ KROîáh:_#k¼"“©ìãë¥i;ë‡îÙÇd)÷øK×-&æ¥—É³×Ôùâ8]/ØÚŞtõHY<°†—]C€¡Ìér~ÿFq¼h?²‚y:ÇN#ÉõüÀ÷šŞ¢c†1œ5‘µÊS¦öÒ?m4Ëã?½ˆHİúrÚ¶u¸€l¾~¸ÿ„`9äë§º‰"¢A?ÉÇS|TÀç÷¾6D­Jš¤<£ş§8°}F'[`¢}<' ÂG¾«Î&ìaLzĞ£ ¥ßõwbFéì‡$Üí!ËA‘ÔÀáL·æ³Ø‡ó0éãy­›ÑªÂ«+°³‰È5”êe(^SvdúÛß„EJ‰¸K¹J¸´{d@|”et‰>#f¡{Ÿ%f£«ÁGÌÆ‡–şo^ŸŸfü‚Iû c¹3sŠoİ™Ú$ÎhÛÊ'‡+Ş†Ä·pV†åƒ®W|ºSñí`Ñ¦ÂáBóx‘ïø|0ãùPºv}.=9Åxãº¹‰ŸM÷úó„×È³¿øFçK“·wÖùàdç3ÓÍ¯}ã4ÒºÑÎMŞ?óÔwíõà(OAyşš'{@ü5QyÔĞ|s=/›àú;†óô¼ãªfú}=%Ÿö‚ı¹º<@±jª)º^º— 9ÿyßMÏ¶³=ßc„ã§æe©ıï43Í½’ıI·›Œ‡:Hå^ËWç×â¾–•îÏà8JkoJÓê{bº‹wM'O~ı)Ã—pt3PğÀö_“çêMÆç¹Yü‡¼†Ò? Ò-}LÊÿ2ùèª‘f|B^9Ğ¯h¥ŸïŸÿÿdĞ—57z
HŸõù…7]ÿd,GÿRŸå}Ê1:¾£İÉËğ!ó1öVF†¼:V6R&ø—í™böñnFz'M;:	úŒâŠèÔ9ªi“Z{ÖéùéXtD}ŒBÛÜÈàB˜ˆœ¨+P5˜X|…òçìo¦¤¿˜x¼õêêœÄ²ıûÆ¡ÓæyB'oœ¾Á†ı¿apŸ±ó$7×ÃTàTÑıË‘”öÖÓØQ.¡ï`ë%†(ò:Ä‘,—@`\M×?Ä—‹Úè‚†8J¯‰rõ2¹z–¯vˆÏf[êø=yíçøïéRÇÇªKÃ¤äù*€8rúÏ'¨İ¨İ°ªİôškG©ÇÒÚË¥İo
ÌµÃ	Á›î¦7mìÕ6nö%Õ¢mm^İxïŞ×ú©lİ’öQzVIøs·ûWÙø°2•v•#§ÉRŒÉŸ\ ™¶ŸR/h$ÒKÜ>Dß«¢‚·S/Ã 2Ææœ×ªÒÆCXˆÃvúfÊ÷ÙLæh–Õú0ğ$3Ô(ä4
.2çäo›Ğ†Ü£hl²¤ÿ°&Èm˜.éĞJf¯ÇPÑ£zÑ?·™‰æux#øk‘(äô#jGÔÅŸ.ÕtD™ÃZe3e¸T©Ó;Ô£øöİ1²²BÓh’ï£oRÊ1UĞAmi±
´Âi+.Ö/ßû,q$Óñ$™QqÏd¯b¾Î†£’ı¿¶Ó«X720’ysÓÇÒ®Í óµ	Î_,ßªñŠ[aŒy§æ9ÓIMÅ¦{e§åúÄYÏWó/^”ßxñ"³ş¬èI˜õßjòşÙ8&½N–èX­t\xºÀ†] {6Æ,úñÎGØÒÏ©&˜‘üÙpz*=5Ï'Êoò<r¦ıÅiè¿O½YW`/º¯†Ûxã™öå
óó0êÓ—%V¦EÔºÔ¼çÀŞÜË65®±Á³Y}jÆ ¤ZX¨±ëÎ¶=8ÍøæüêèÛ¤R~ãxzÀ0Hû—Íöîg—Øç®WaÇï¾k_jë°Ù:Ûîµwâ½%ä%{ï¼í¶ÎNÎ·Ø¶ÁfÛpÙí¶­”sÅ<GZ¹¾zkBw]¼¤Tw½zÉFİµcŞíõ<ïeŸ´ãJ
+uüÚëwíËmŸ††şéy/Ï;µÀöŸ…ÿjÇûËlŸ‚??e¿şãslOÚkä]¾Ğ©“·bÉ]ş•—õóüá'á?İo#»ñ>ßFq™	İ›ƒC¼‰A=¿Ï÷£çH?–ƒÎïü³A>/Ğ˜]§G¦ş¸äK†ô+0=ßÈr¥Izé}&ô!¤;Lè£Hw™Ğ‹ç2\gB¯ËAå å "½Ô„n›Çà:ºée&ô.¤›ùßa¤ãÎ¡tı”b‚bÜPUi × İ‹tSÿDz¡	½é÷ä7qÿX`-_ÈA¯Cúfúå !İiĞo'ê7š#=ßÀUa¦ÒWšĞ»nV¾şô!¤W3HëßËÛ/ÒÍô/^h­¿é—›Ğc­õ;œƒ~éfş3Œt³ö3C~q¡5İ™ƒîEºYıÅr¤?Œt³ò!ÁÌşc9äÓoò‹YË÷"İ,>ÇYç8GşC9Òç !½•AÚ¿÷ ;3üœ~·ßÅÖòÇ[ëo[b^@úU&ôºé»r¤ïÏ‘~éfí{4Gúq¤/5¡s‚½x©µ|'ÒÍì[—#}Wzı#áfiÿx˜ûÒ?`¦ÃÕ&t/Ò¯7Óéfõ;„ôkLè£H7­?¤›Ö_±uşÒßoBï/¶Î(‡üa¤7™Ğ‹—14Ó_ÈAw"İÌÿ»nê?9èCH7úÏŞ¿æHO7"Û,ÚÏrëôÎéë.Î×ëwõ;¼†¡™#}¾	}éëMè|¸©!ıZº÷kıú‘n6?°]ÊÀl~àDúr³ü‘n¦éu&ô£HßÎ(iûòñíåÖò…ô:¤›Ù'–ƒ>„ô›MècH_eB·]ÁÀ´ÿCºÙø¡.½é›LèC9òFºYûÏA®´–_‡t³öçEú2z,‡üÃH7³ÏQ$˜ùÇhıÆräÏ›Æ§«¬Ó;s¤¯Ë‘¾+GúÒÍæÇC9äç åÈéfíKºMè]H7ó¿ÃH¯6¡"İ´ÿGz«	½îjëô]H¯4¡!İl|d+a°È„^Œô%&téföõ"İtıé¦ë3H¯aÏ§xÿtÓù1*v“™~H7#}­™~HßbBGz…Aÿ3|ş³ÖZÿ.¤ßb–?ÒMÛÒÍâÛÒÍâïøMãËµÖù;sĞ½9äw!}ıœìôÃ8p¿İ„>Õa–?ŒÌæ7]H7"½Û„>tÓøƒoÖşc7XçéfıÿQ¤o7¡“µò3[Ÿqn°Îß‹tÓúË‘¾?GúÃH7óÏ£H7³¿€ËƒÒí¯ "ı
“ô£Hß`Bç»fõëÌAïÊA?œƒ>ŒôKLècH7³ï
Dûİm6ûb{ñâäÑ
	$&ûÆ»ôÇ‡Ã¶ú¥Å÷ÏiXÂÏñ"|Dä»Ì‚/¤‘gÅ÷ùã›¹ù€gò÷*üEy1¾ÅPî‘cŒïJ¾
àF¾>¾]À·æ[ŒÏaÁwğ	Èç²à{øjoßËÀW—ßÛÀ×”ßZˆ­Ş<øZ€o'ò•Zğ%¯ù®³à{øz‘¯Ì‚ïYà‹}+·Ÿ¾|5ßÎí/+.‚v‹|…|7ßÃyÈ ßá<ø¾ƒÈwƒßãyV|¯ ßH|sçBû@¾
¾Àw
ùVZğu ßXåı0ğÌƒl-şNîr¼ |k¾“»o Ÿù.·à»|ô‹ßÉ­_#ğ	yğ…æ©úYùÕCä™ßwr·£'€¯ |_ÕÈ³â[gò¨
¸ÏÃvÍWıÅJŞ}óU±²ËcóU¶ªß—çççoÏWıÏ*ßµ Şç‘oËUUÿ‘\ ¶7+ıY –×J¿gïhò^¾#ùÄ¿ˆ/yøËMÀw0 _,y_/ò]eÁ÷8ğuå!ïàÛ™‡¼¹¡ËCŞàkÊ#uä)ïÃyK-ø]¨Æ++¾ªñÅ*ß7ªñÔªŞ./Ì/4ªñÀ2şªñÀªªú}À‚ï‰BÕ~«-ø^¾:ä»Ş‚oñ"U•¿T,Rå]cÁ·K#Ï2şiäYÙå±Ejd¥ßË‹Ôşèı|o/RÛ‡•~k«şl•oËbµ¼M|ÉÅj<°*ï#‹Uı¬ø]¬ÚÏª]¾¶8¿úX±D•gÿ€oO|%ù•÷Á%ùÕÇãKÔú°’÷
ğ<ÛOç‚ÃÈ7ß‚oğíA¾õ|À×<·¿|X#ïZ¾G5ò¬ÊñÂRµ¼Vó²7€où¬æe—A¼B¾å|Eª<«ò†€ï$òÕYğ=|uÏä–÷ğÕäÁ÷*ğ9ŸÉm¿ÅÅª<+¾ŠbU¿›-øvßNä[eÁwğyŸÉí÷_òY¯^ÖègÅ÷¶¦¼›,øÖ.ËO¿–eª~Vq(©‘gÅ÷È2Õ~Vù>«‘g^[¦–w™ßŠåª¿XÆ?à+ÍÃÎàòğÓoMåxœ4Æ<ô{øÎ<[ŞÜ‹¡ı>[Şà;™‡¼àÎCŞ‡ïXò¾!ä³Z/yøä‘ïyV|—¯°ÙÎC¿Fàë:wÜßAäs[ğ=´BÕÏª}<±B-oµß«+ò«Å+Õúhµà«X™Ÿ¿ìZ©úK¥Ù+1|VãİÇVªím‘ßËÀWŒ|K,øŞ^©¶«z[K‚w>ño•*Ïj0¹JÏ–ño•Oo²à{øºÏj=çµUj<]kÁ·bµ*o‹ßMÀ7’G9À7Š|·Xğ=|§ò°óãÀ7–GøNæwç®Qõ³jç€ïXúu ßÑ<ø>|GòÈ÷Qà;Œ|ëç˜ó½ |ÿã»İ‚ïRŞŒ/ı‰‹lñï›­`„ñYÍ“oüDîò†€ïòu[ğ=|Î‘Üíò	à«É¯^¾®‘<âß¥Ğ>Ïj¼V|^äÛnÁ·øö ŸÕ:æ}À×Ÿ‡~iäYùËË—æWŞ·5åµ’·„ÔänG-—©õaU¿Ià+~ñ]aÁ÷ğ ß¾g5ò¬üå5à[“ß
¢B|7_i|às"ß%|jä™Õïö»½-ô‰å‚ÏÎ…ËbşÜrÊŠ}†ÉáıFÁO°bò?‰£ÈÿÏœÿ)sşûàßøgùKœÿ¯Ìù'ü%#ó/ |ÔœÿUøçE~>n(è1ç''ŠFş{8ÿVs~òı¤ş!FæûÛ
®7çO¿÷óŒÌÇYÌùş®G™Ç¥‚ÿ8aÊOWö#ÿç8ÿ	sş¹Ûş#óùgÁÍù+€ÿğßø?jÎ }Ç—ßËû›ó?üu_cd|ÔV°ÃœŸ<¯´á:h×§Úœÿ9êzşP°ÚœíEÀÿ,#äüo=—•ÿoËèfHÇ^À; =€» /üGÀG6Û¿~ÊA÷ 9B€)ÀÛÔ¯€ß|2ŞøSÀ?|ñ¯EÀ» ¬ß@ß…r|ÿúÎ¨c`0 øiÀ6ÀŞ|İsæXø/€'×ÛlÇ_ ü(àWïüsÄ»ğşëé»n/¯£ïô;·!Ş€H:¤;_/¥6s<YÊî?Š÷Æû©RúŞ‚#øÀ&ä»ğIÀE¥ôİ\Çàæ­€?¼›Èü.à×¯gôÇ Ÿìlì |ğÆëéOÇõ×Ó­–+‹¯§ï:;Ş¹î-uüİu4>9>x)ÏuŒ/~ãëB¾eÈ÷ß×Ò½Ÿ\Ëò¾–¾ûíøÊµ,ŸzÀ£€W~ğw,¿@ì	øAÀ{ÿğ6Àï
kYı/YK¿Çå8	~p3à_º ÿ ğ àË%Œÿx	“àÏk8ğ[€§¯¶Ù>ø/€;~ğãWÓmä¦; øï€wşÜ şàö«™ßT\Íü¦äjæ7K w?˜?>	ØEÊ%Ğ=&Ào¿|ğEèĞ_$åü)7à±ÏUôJÇo®´Ùª ÿ°ğóWÒ½†{¯¤{6.ÀG‰ı_ ùB‡ş!"pà+X;H!Şv}×İáB\ØCê:¶€ï¼°ğÀ•€
øûËè·Ğc€À—ÿê2úî¤ãcˆ»/£ïã8À=€[/cíôF¤¯Ü
¸
ğë¤İ^JßÍwüâRú˜ãó€7’z¸”îÉuÈ€ƒDKé«Nåú.¦Ãw	}§×q#`-¡~p|ıœãUÀ0iÿ€ß'öZÃô—ÿ/± X¾†•ãò5Ì¯¡ïR:Ş\MßIsül5Óû‹«Y»;¸šµÏ¯fí3‰tïjÖN›0]Ş/Àt?^Åèÿ´ŠÑŸZÅèŸÆû[ÅÚwÇ*Æë*¦WÁ*–ß[+Y;úàÀgW²öû+Y{üèJÖã+Y{\´’•çä
Ö?³‚İÿ×‹ÙılÜw1}÷Ø¼˜ÙëvÀNÀ+/fù.¿˜•óå¿³œé÷ÅåŒşÑåL¯İËé;È;—Ów	W/gíû7ËèŞnÇ–±vùàgHışà]€Ÿ õ±Œî!w¼Sl³íüU1‹o?*Æ8ø7$àW cÅ,ŠYÜõ³8\‹¸²˜¾³êøi‘Íö3ÀoÑqã“€ßÑ÷·W>Xø,àé¥,<¿”éû¥Lß» _"z’t€ÍDş˜Cü!ÑğS¤½-¡ïü:n[ÂÚW%à“öØ@Ò-¶Ùş‚ä³˜åó•Å¬ûôbÖ¿İ»˜µ›ŞÅ¬^ÄÅ¬}¬GşË7.|pàm¤.b~ôâ"º'ËñUÀ÷y‹èGÇ&ÀÏ“öøUR?0±<ø=À¿&å ü{Â¬Œ’òş 0øo¡ï&şø—¤İ&H:À“$À/“|2yvÀOş°€é?\@ß³s|¼€Aà¸ğ)R>À/^øwD¿6Û àXºo- ïR:>xˆÄÀ“| ï%ö¬'íe>ãğAÀg ~°ŸøÁ|º'ÇáÜIÊ‰üe€x-à’M$n¼5ùÑø$à8à—æ±şånÀ3¤ışŠÔà?Ëğ€ÿ	ıÈã€¿ƒëû Cø¸ğÀ× 1¿	x‘¼“õ: y'ì5À7ç0}şkÓç€2à7?ø
à‡ç0½6Ïaş¸i}ÇÛAÖ/Ú‰}çĞoa^±şóaâ?€û _²3ùÏÛ™ü/Û™ÜO î³3ù€¿$ß3%ù@YÈ«ÚÉø•èøS@ˆäØ´j_hK6? şšØßFß-uc»‰İ}¤ı¾8¶†¾4:q±±±Q@´!YMË9|5ıîèÒ±Õ(q±±±Q@´!­ÂôˆCˆıˆ]ˆuˆ¢ql%¦GBìGìB¬Cmˆc+0=âb?â¬¼±¬¼]x¿Q@´!]Œò]ÌÒ½˜¥Âûıˆ]ˆuˆ¢ql9ÊCBìGìB¬Cmˆd?$M8„ØØ…X‡( ÚÇŠ1=âb?bb¢€hC+ÂôˆCˆıˆ]ˆuˆ¢ql)¦GBìGìB¬C×,ev'û¡‰İmxl	ÊCBìGìB¬Cmˆc‹1=ââÃ‹Y~‡³üúñ~b¢€hC<³ÛÓ"lO‹P>âb?bb¢€hC$çĞôˆCˆıˆ]ˆuˆ¢ql!¦G<¶ıw!ú/ŞïGìB¬Cmˆä¼*q±±±Q@´!-ÀôˆCˆ/@{/@{ãı=x?†÷»ğ~¢€hC›ò‡û»ëDâØ<L8„ØØ…X‡( ÚÇæbzÄ!Ä‡çbùæbùğ~b¢€hC»ˆáÉ‹XzrI?Œ÷‡û»ëk0Ó	xß†86åÏAùsP>Ş?†÷âı!¼ßØ…X‡( ÚÇìhÄ!Ä~Ä.Ä:DqÛ»Û;Ş‡92Ó×†úÚP_¼?„Ø¸ùbÈ×…÷ëDâ3—S¾ísa’Hú~~Ô_+ìš¤HpuÄ¿B:?—é6LÏÏZ…×üÜŸ#??§g7Òù¹8ßD:?gæq¤ós9xÍÏáøòós¾‡×|ıÈÏ÷­¯Ãk¾úãÈÏ÷íã5ßw3òó}9M·ÚlWÙûÓû›ƒ0Ù/òó–¾jg×ü|&÷vÍÏsÚŠt~~Ò£·°k~ŞÒÿ¹•]óó«ş	ùùyW7·²k~~ÓÇ‘ÎÏ›Ú~3æüw!ŸwµõáçO#Ÿgu«„ùÙÙue»æçq}Ù…×ìÒöÅÈ¿¿u²ë1¼~®óÃë?[ÃìÇ÷/·lb×|¿ı7W²k¾¿»x1»æûÁÿ¯ùşş¿^Ä®ùys»æûó×à5>¨x~>»æûÿ^`×|?´¼ë¯“W²k¾ø7£ş(?¾óGşÔÅ¨æ÷À
ÌÓï]åÅëkoÁòay¯`×|ÿöÎ÷ƒ—Ü†éQ~3^óıÌ«D,>¨øájvÍ÷¾Pùáù?ßJê§?½_°u.¹NŸŸõ»9ìšŸg5xI?œŞx+_‹×(¯í´‡À®·nGû¢¾O¢=ùşü¨Ìäw!ÿ æ‡ûgoİÀäóıú—\Ç®ùş»ï7¢}±¼V°òğı—?¿Ë‹ú\ŠöC{»nDÃöüú*äÇëù=L?hw;»æç3ü²ƒ]óó2V_ò1ıoÑü<ˆ`%ãçûGŸu±òğóĞ†7²k~¾ÙÓNf~ÑOÊØ5?¿¨Ûßo™ô¢=1~?·ƒ]óız;°|Ãø¢Á—¶¢|¤·ÜşÎw0}øó˜_–²k~¾ÛËX?ÃHÿ
Ö?Ÿé»ÛXyÇ0F,œ‡öÁúİ¸¯±şÖîÀö‡úÀÜŸÉÇú¯Æk¾?òCUŒŸŸçq–oœ,ÇøÀÏKòğòàƒók®GûãõµØ¾ùùÿs»æûuCX~~şÖÛëP</lY-¦Çüî±¾ñúÁ”‡íÕÑŒşs5»şLú¯À®wU£ãObyùşİSMŒŸïÇ=€öãç¯ÜİŠş×1´??¿jçUxú½ˆù?ï°ıóóÒ.Àö‹í/q5ÖúSíûĞ?±~íd×|¿û"Œ¿üüŸ70~ŞÏ×şˆñóóñşåvŒGxŞÜg
ÑØ~š±}óó vßÁøùù|ÇwaşüÅ$LÏ÷‡-Áöñµùùù¼ãÖ÷ÿÅş„Ÿ¯³ÓóózÚ?€åG}öàçámÀøÇÏ§úÖ'?ÁÛ€õ‹õsÆ7~âMÈÏÏ—ZSñíıR–¯‹1^óóÔJ°åç;½ägt~Şİ®"¬_´çÿt1:?¯Í^Œííw÷´7Ö/Y¥åC{6bz~ŞÜ—1=?©­›Ñùy…äì}ªúã×}o0}1ÊçïJ¨êûW¾»ã?OáuìŸùùPë±üü<Åoaz¾ÿ¿ËÇÏ³Û„t~~Òé˜ÿw±½ñóÕZë˜|A`×ß»õÅú©kA{`<{h=ö§˜_¶W~Ş…û+~~Ø¬~× ^óó¿şû#~ÕÓk±~ñz]ö7X~	ã?ÿñcŒ'Ø>ïØŒöÁøs^óóÈ^âşˆ×?ÃşãCŠW0¾v·áø ã×Ÿ™=ùùßíe×ü<Šb¼îÂëo|ù1Ş;ğšï÷6ŒØŸ<×|ÿû;ÍX>ô÷ù¨/?îÛHçç¹<ƒõÅÏ‡ûÆ{~Ü2Ş_`}ÿ)ö/ü<Ç9ÿùù_w#??oaùùù–ºQŒIœµ!ıÖôPş>{›şú·nıõ.ıõA§şzÉ&ı5iÆÚëñ[ô×ôÛÊõ×*ô×½ú×××Ê£™ŠĞß_|Hı)Cú¥†ô1Ğ¿m°Ç#ş—ôoÖ_—ä}Şpİgàÿ€Aş£¾†òUèU†ô6I’ü{|R²7İm“ä>9’”º}	YŠÈp-½¿=Y›”ãa%âKÊ}äF ä¥ØÚ,—$—«R’z}‰^I6_2÷x[Ûá6ŞD²‡Ü¨Æ}¾PJ–’{c²Gñ¶V†”n¹¯R$ÙŠ¢èíƒÿ4¸7W÷¹ªœNg•HeUidQİ<íµ07O³®‰éÁdÔR›êªî‘“R<‰(‘fY1;gM(É{Sz@	Ht—+
Ç¤DÒ—L%LxÊAR-É¾;.ûî4c ù[1¸ÜD„?I*‘”,êêî†cq9‘RÌ§Ä=Ù9Ùú½Ö
Eı´úiİhÉÓÒíQ§3QîÁ±dÜS/™TóThæÿìNùï—)‰¤UUŠ7Ås«~ë:›CõŠH*,Ç?È+É„',–‡}{Ô` evÃ@1,&SÑ)ÏqıU•x"™¿jŞYU…Ùµo>¿Õ·Ğ~rZİÚ¢äD2ògQ°ælí;;44W0¬3]îp6¶;×ªYkFê%‰Ærn‡}1š¡÷(yçŒ„Ë£Ğ¿kä»R¾”Œ’k%'®Yhæ2jFOL12ZEóQlêk©ŠóûÌıgÊ‡¹1Ó¬´]øL7os­¸œ¤¯;45,=¹½RÊí£VÚë%P>Íª-S%)“Ë}„?šŠ˜8ÑĞàé’’Ã#M6´(.V&p&˜£LJ—é‹V“ÖrF"×äµœ(6%¦Ì£õNU¥;'¡iŞƒ±iìgs£ù)Gb„[çdÌ+}äÁÉ%Ÿ¤'YöéÍ=WæÓåS“5Ê9Ò+ws=wÆ:§Ã´rSc‘qZ2ÉRHö=-a§ØÖ¬ĞâX$šz+‚íÀ0æ:ŸcÉÊ°oŠúRĞGªÇ¤|³xÎå"«ãh?0‘ÉÇµÏ'ıgAËÌG¿óÕı«î”÷ûV*W9U2˜Šø“J4bÖ&¦¾ ÄÌœ	ånÙ¤#Ÿcë¬ú5ÏvÕ¹œ’Hş$Q‹åĞÉ	š¡¶:Q¬>+ŸóT%d48_ô˜¨Ş<é™¸ùgÚ{'¬áÌ=®8+ÕfæyÅ„U›±Öš¯½9Qœ:%Ìân¸-TœÍ3šF÷,ì[M•*×yRF~VÙj\³® -´Yi/Ï‘éÔWUƒIVS·¨GÓÖÌò&™E¢)Wú¨%H_ÄÉ¨˜iÊ}:}Ç,ÓYœ&Uç@¯™èËMóşÎÚ´:fs/áš½„™RÓÚK˜e:½Ä¹(ŸY¦³#’e(g|'¹Ñ}aŒ|Óå0°á) ¦ng·/ ùâqß^²ÿ@
É‘do£Ë¬Š]†4åÈn34\ àå ÔHl3Š”ÍéFß§Û«ŒÆeŸ¿—İÒQ2¶`hÌÈŠY{+3ò-ziÑ¤”q3W¢q%¹WR"J’ïiOº\¾Ò!†—èíÈîpÆ]º…ƒ^'È¦œD2M%c:ñ;hAôñË1òÀà<@TÆå„öùocs!ø11g *Åešãë» JÍÒ¢Tµé]iĞ,‡{ûÂaÃ ÉÀ˜Î§DôŒÕi±™B"ÓúJDl21sC‘šLİÚÚEi¶¨çrf«¢¡·½Q§åLè“]/‡	ÙkÒzd­´úVÂ¬j b·×šUÍ$s5«€É¦"ò$éÜÂ²h$a£ô‡îÖ´ÇóåÍeQiœ×TH’’¢}rœöÑ"a\AÙùÏÛPNö°X.±ZÊ^¾©ó¹,m¦ãNèñw*0İí6çá\r<ƒÏ|o¯·¹:		´ÍÔÑ½µ#M¼«y-`ú—¤ü!M jikVŒ¯fN÷Šœ^%ûãD’-—|ø­È	Q§)ÏC+2txÌ¦Yúñ¸’ˆù’ş^>àî–{`´âg·_B%·/ŞCäVøeEÍ+˜QÉ|{4òÁ„ÄN)¥w×ÃıÎÈn%ÚäD*,ëg8qYÎjº¯»»»Û°jšÇâÙ”®¯“Nëœèà²ĞÁ•î© 	ÒİRºhîÙfœQ¹±ibR²&«ÈLÆŞÆÓ¤¤…8Ë”™ªgª¦“µ¿³F!YÒ½ØãÙ–EŒØÏR˜IjèrrwªG
tÃ<òQDSÓ’ºŸ–>µj²}j•Ô¾Y‚!YÖ>µŠ+ Øº"»j4E†j„Fì¿`ËZ««Ş„O;-+Õ¨N¦Bn‰è^É—ÔiÂgØ•¼nŸ)È95b¦}.QzfU’Ö[9ç€N.ôM3÷îíI
HÙ‘Ÿ€`VÁü´‹gZ]aÊ¿¶SµcG«@4Ä,¶Vè”wgI:‹çe†…A—¯!’<•Ş™ˆ»k¤†^Ùg=¼y£JPÑÌÚJ4âé€4•TE±O¬ ZŠíÛ'Ô§s©ˆlÛĞw˜í¢DfÛ¢±Ç<çOÙ´cg²Z¤5cEŒÙq—ŒÒ9Eµƒ½Í:u¦óI¨²‡-gv*‹«Ô§]E§Y|õ¥"Í>O³U™t.^#£zÒf*Rë}²6—!r—¢ÆÚpNßƒ0>[ñêuÓm¼£ıÆ6è8 ]¡±>…ôe ƒg'DR¸]Iïz¶Á€ŞI3a1µ­½ZÊ:­Ægq¢w‹âmv9Õ9¬·™=fƒ¢ñÄ¼1Ašİ¾8LÈ¬cÓÌ'˜‚:Ev/Â˜&›÷‘­Aªeù[\¬e»t»ÛÚ+s½üÄ›…±Ê¼Mab‡Šìc%ÑÒW¦ïDŠL²Ô<ü˜mµCFÙFÆÕÛÈÿØ »µİ%y¶íLÄh~"õ.“9í*«yk$JuÓçÜ rù$µumqI	z·Œú<á°a*Ü®gÔv/†Õ¬vtÇƒyÂĞ›! ”KœËø ZÛ”„wKüš“N&wŒÚ%‘LªpŠãCÓT®œ©2Î$ËhT9Q£˜Ë¢° XcPË^IşÕ3£m-{	¡Õ|ú–¡óæ˜"ûåİ
™ÎóDRRÛ0É£5êLÛ$Úfu/âTNc8/Ÿ"´ªhÿDó³4Ó6­0²· ™X[µì>!çÜ£(yÚ;pa ¼ã‚29G¥Ï/ã“Úİùâ=	’¿f³{Ez_ZLa5ˆb7k´Y,¬æïºÉÚ—›µ¯z,€—¶O2ÛšE•Y¿EÌ¢‰^,+ò>øhØŞ,Ñ‰üùW4×Tm¦GÓÆ…˜ Ï^]]g­ëÌíçÓ­#’ät‰<èK…’ªGLDí™Ùë7åjÏø+Òç•µ§RíÛu©[á>´v¥Ö.LĞu»õ«Ø›¥¶îsÎs¡ˆ+Eòš	iTnqÕfãˆ†ÅŒÙqô¢ö¿™LàIÎÌÆ8•ŠÏäS¨÷tjT/s@—¯QgÃã¬ı&Q®é?nÊì?{´<§æY¾±@ÖÌQé€“#²ŞF3%â«%IU—¯%%‚JÄ'³iY7İNIê‰FRœ¼R—ƒTÂì)væ¦½Øoğé>Zâ…[<-bFß¹T [nkw‘å_\[É¹xĞÈ–…[aŠ¤®_kCDMÍËYÄÌ¾Zc± “õİ™ÖÇ•xëZhË¬†6}=´f]ÿ×®Ï{p½® ­¯œ+m·64àn-æ]µwªk2n¹*3ïUgÜ)Ï¼U[•qËyËUU‘),3aæ-—+Ë½ZwfÒÌ[U®Ì,3o¹œ.ò¦lÏ=RL'¢_ˆl²ësfÊsÚl×¸6º‚úsU;]µÕÕåp³Òé‚;ŒìG¨¨„òòÊ*ÆÙUHÇêeşX¬,šş,Öşğ_ïO¡_„ßÓ"Ÿ3. ß,|ô îCZú_~_±tşzş››şüVRŞ“Ô~«Bi¦¼¿›£Ê#ià'NçÚúõŸóêñû5Ö1Ê;Šrğó{¶“ì{ê¦?6‚ğA“H±w“¥–F-}÷£-NÍeŸ–>Sş«N¼$É½R0îËÙËË¿;-`ªŞùL^ïBV‹àO­<7ü#Ÿ"¥ÙÏ#I\šÎ”Ü'ßq\H¾IlG>ƒÈ¿5Í¿ÇS-´°ƒÙ¯³iàçMû_sFšöiHt¾Ù2 µl?Ù4(Âmq´ipßø`êµà øË¦Áíc-ƒâÉ¢§FO!MÇk´i  iÿ³Î;	ËŠ®º/oùp{05>ØIeƒ\½d0ÙL¢N
¢šn‡|ïx¦èª~M~Å*“Îeí2õcüT^e=­ò7œ ·Š®ÏñÒ?Õk}ú}g4ùd¡Sù®áç(Ûş3¶¢‡†×Ú‹¾1ÌSdÑŸ¦I!#M0˜Wy²ä•a¯Ô˜d0õFöT‡9p`œ$Š|S-ÖÓEO¥ŞL'ü¤>;~‚6ı@ç)” â:O=5EŒpÇ3¶w?»Ä>÷ây×Ø±«Smº_âV:ÿnä%&ôQÄkLèü~®²>-ÛÒ/3Óï8Lè‡ñËL?¼³ÎL?Ôc£	İ‰ôzé·šĞW Úïn³Ù÷Û‹/( :“Ï‘’Ošı÷»ô×ÉÔ/-¾NÃìN(	È'‘o«_ˆüñ6ã»Ä‚ï!øwå]cÁ÷ü«Cy—Yğ½Jìƒ|¾ÅvUË‚¯øv"ß:¾]À×…|-øî¾^ä«±à{øú‘ïV>ü-Ô§·…Öè‚Ï’­˜×ë”5ò&ıŞVĞƒ‚ò>ş³Ü»ñRÀU€¯Úé'‹D§e€{o\Xm§}šÃXx½ös€’ø]¢ãs6Úï9HÃ_töÿŸ_‡( ÚÇl‡‡¶Ñ¦2ÿ°-–öãı.Ä:DÑ†ø3;åßşÑwÚîDo»-İşŠñš·gòİvrÍÛÿxÍÛóÓxÍÛç/ñš·ÇQ”×…vşO×_àùãoÒy¼óã5O­xÍ[xÂßUÆëÅ6}ã¿Í®¿.£¿ş´şCúAİø]Û€şo.3ûÊ«nU—ÃÑ>YÌ¤”û,·gÖàMW–›nõôœs¤OÚHÈ™ìµJB‚qªz&x‚€²äóª;2³L»cÓ@w¹ÉşC®İXh¶K,¦(‘ómŒíğcCæY-eıúWş/‹gP&3­÷~gûS"şP* oÌÍyö?§ÓY]Y)P¬bètW0ÄŸàª¨,¯¨p¹ªªÊ§«ÂYQn*§S)şK%’¾8¨²[	…¢!hmñì|ÀZÈÁr¤ñ<ùñúgk½±Ø4äádkfõïr—W±úwUVƒ@ıWVUWÛ„i×ÿËëÿ%	ÈAÁÓÚĞÒÙ(Jâíbk‡Ôäõ^·•ˆœ…Rxzpu7÷[4¤zÏAb:q«’ÂÂˆ/,'b>¿,Ğø/ÜSXıL"!Ğ .É*ôT}ĞÙl*ädTÌz€Cª;¤øU:M\ªv ëòß •TBR"JŸİ%…``ƒèÆá¯¯'±	¦}\·Ï§ŒşîB_T	¬È›ŠënÌ–Ñ$ƒBÿ{ ¯nØ3Çuß!}snfäH³Ğ§ª*ÏGÓ:´ùuG£!úâRfé{t±XÀñÁz!Ùgdbƒ¦Œ´ÚqC©Ä/ŒŒéqJ©Æ¾y1mĞª%ESIHµÊµüˆF¬ÚÛ{¿)ùéâºµNm9â¿Ûå®4Äÿª*gå{ñ&~ÙãÿæúvÑ¢H“-z•¢{RxK®~àFİy kÙ3hb¾qÉÀ¦Mºlo2t˜øõ·0)	«Î…èPjŒùôfú/ˆÕİ¦ñœ1: Z°‰4òÕ²ö\E½ŒõBú¯Róîpw¯/™½74–y²òXï*¬‡ŞU#št-ñT¤4Ë-ÚsD#~èÎéŸİ!È¦¨xIN+’¢²Õ ³WâÇeôki‚®cÖgvŒé2d”€”U8!dO¢=YGK¤&Ñ¼a`I#/¬‚SáNFÍ HĞ¨äïÖŒmˆ"úHw÷úcŠh§Ét‚Œ£JKßë¶ÏÛ„àiû“ßÄçÿå€ïÍÿgâGêßöİ9+@g±şã®x¯şgä§ÖŒ‘mï¡Tbjaâõ_UUå~¯şgâgRÿÚ‹†h$¨ô”Q®³Ê#ÇüÏérºÓõ_;İåïÍÿfæÇgi¥BÉÚ{¶×7‹RCg[™åµíÉ¶}:oè€±£œL0w(Öë¼÷›Ì/ö5îˆDıg	r­ÿWTVÚe…û½ö?#¿k“ü^#l•#dmCÛÁ3„$uA	ÇèJ¯’Ë
'ŸdÔ‡}‘@Bûö
2LF…;#ÑİB²W&Óà°/)àke…0£-eÍ³İ»£­C"³gév±­İ³£Up­#=LGÔ¸Dëö%D À\>Å™BII!['«9É½¥õm[ÅA›L¨÷zÅÖFÁÛ¶Ã+¶u¼O`™‹RÃÖ-­mõ»ĞºƒİXGE2¸d2ûÖ	Ei±fãi‰-ÖfÉÓÚ!¶m©o¥–úÖ­õ[Åv‰ËJvî,Ñ%ÙÑ@ó×°¬½‡ÈÛ&nñìÜ·±[‰l„À Õ ÌGÄ€ÍÈ.¨R,£D#Ä*Zò“Óî° 	½MÖåLF¼$AÏ1×%Ì[9aÎAºå½Ñ¸G¯’èqFdq*
‘h2Ósòs™²«Ë?şŸı 0Gü¯®®tÇUåî÷âÿLü´Ñ»{/à……J°4=Ü^¿mGoûÊÒ·=­šÛ%B‹ØŞ.¸ËjÖ‘åÂ°œHøzäÒ-õõ-’ØÖ¶£Bín¹™p•9…¸|WJ‰Ë’u…tÑ°tÉ–	çAQ¢ÂKHºò’<3(Ï–<1¨gÿŞRog{“áÏ—
(+ƒîÊuSĞw×}¤7MÊş¤àëñ)dÅ<œ
%•XHèÜÈÙ ìîUü½Ânbƒ>%7äˆàÅe_`/–’¨‚ƒ/.“gÓp‡¬îáh\fº`×€|{ú€~w]62s3yOt–éşˆĞùByvÁÓ*x:Äííº¾‹¸[–Î+S>ôTYIû¨Ç‚ûá`!cÖÜ2ìa-C‘ÇA¹„é¬—C ¶@nÃu…©ˆ¹½i[6Q¾½£M¼­³¾ÅÌ”$Clƒ Sº¦@<æ™Xô÷‚ ;¼ä^\N¦â‘R]ØjİÑaVWéâ–PS&’q%ÒSÚ&z[`Ì&”ÜX"”lJLRÓ]WšÚ1÷MD¤Æ<fb5,LtÖ8ÛËBiw*IGS¾Ph]ºa+6æs“¸övË¤±c$@áe»"8ªÙM‚Y©®ûÔ$Ï½ 7`šĞXPH¬é¬]+·cåp+ŒÁ±TR¦—„L0›?Äâ ex¹î“Ih¦æbñŸL È_ä9İÎ§kú°É:q\è…½õĞ§å-È0¶-éIìĞóªh#sy9Sœ¦I€ÃAº]h/„.ˆ|Á"î‹ïÕO·Ú;`’Ô5À	ÏÑÒ³2şêD£§MlèØÑôlÓ\ˆ+Ñ¥¥¼Ïæ¶z–,„ùmÚä‡0\R¸®0Ç˜‰d\nÓ–ÜÁ¸$ºc2ã%_u‰'èÛ#=8^a‚˜÷PÃÆËôæn‰úàël|A\LIGÁ Tn.]VHò-İÚ²c3TŒÎ¦‚\t¬ÇÉŒN^#”tğDJ{¶i'Íê TŒ}%VıŸ†Ñœ’`’}‘TLHÊÄ7Á÷„>_\!¯·'p¤s4o4&/~‘p«:53÷ÈˆN	î…h£;;{Ÿ?™Ş½ä-‰DÒhuÄ£3H¶™<1Œ!µŞ˜%ÖóyCxæ£ì4ÅLFš‹›š½r`âµ™íz—±3Û·«œ:Œ0lğ¢‰Ü]†Üv•’Î,‰…@Tfıµ]™ x£‰„ÒM›‰/íƒ{Ê¦ÂõBJvûø.O`0’à@3 ¯WÒa¸döBÒ³hX/ÔGx!¬©¿€(ã—)è;
[¶ ”H)?)LAõ–¡únÆç¿¬F5¢ïí¥>B^?ñ‘NŒÁ¬Aƒ`ï¶;©±iY!Vô/µ}F`¬iğ›wó¶Ç‡œº›Ù]šRGf5³ƒDHğcõ“1_aÓ›^_Ÿºe˜Ú°i‚ñh˜Z(õMjíCd®DÌc!tT1™÷iFDe3°R•9n5™ÿçıüïvÌù,Vr¬ÿ”W:Ëë?ÕUåï­ÿÌÄÛüßG^¢TüÜÅX!½8ñ;æp4 Ñ Ğ"äœ&eJ×•‘…ô$‘‘J°e¤İq%IqQüœMB¹´‘—®|$ˆÂ(YÍ‡dd©àú~6óq½,ÖÒé÷E ıhF¾PF,>Aû Š/®Ğ¦/£<Öu’Öã¶ú†æú­éÆ#‰;ë: ¢÷§âq²;[…ÍµH8%êõÊt•IN‰F–8iôĞ‡öªñ„a…FYY1äÜ°c;€=›[D³ìÁÆ·Üœ™g$„†Û·¤„apqb&2ë–IÈ{™DG£ÉËè@·Ô —Pâ*s–Ğ±¦¦mñ´6¦o«oİ*’àeÂ¾‡kÌs§3ÃlæŠû"=2]!J-¤“GÍ4 GÕ%B=yÖbĞW7Î*„ñ!Œ(¬ó­ß9Ñ|·¶‰õ0„7Éº~'ÏšewŞâÎüó–XSÖ1²Ô¶Ö·Ô·´‹†¥I:Ú:Eİ’O	W®§éVR§•6cÕê)¼ê²eÀ‡*[7.âëglÂí[¸¼0Ô²YH¢‘ë“tä!°î¾İó~q4îFÉKÔØ (=Ò¨•ä&İÂ½æÖš…(âw%5%Æµ©Œ•-P“ Òó
º¼ıöúj|+wo¬ªèV’P¤Àì6„/Œh²/îï…Ânâ+hÙJ¨ªXÃV¤|ÉŞRq§·MUe³BÖ_k„õBMzq #„­½ÇpkŸPºöŒ} ø:3	Rgk{§§£^un¤sİ…¿÷{ï÷Şï½ßYış?ÌĞ º 