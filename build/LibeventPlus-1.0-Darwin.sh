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
� &�e �=mp[W�O�H]����c�(d�8�-�N�+�K$���,[��Iz����ޓcS���Fe���2�˰��0��"�24�,��1�2�韝1�c���,dϹ�>����m����}��{�=�~�{ιWR�ԍ�U�`08��X��qV
G"��@0�'�Ph �H�jw�hZj�R����,�٤�98�_&������Q=�-h���͞����26]�P(�v��p�_"�����������$���}�HC-��!鵴�&Hg|��(��iC�x+O-�XQ,m�1�n~k},?�^�[$�H+NTQL��4�[����p�8�]������-����Xj�ͯ�v�x���h�ҍ����G����t����*�Ht:�O�O1nC��A��,!][g��7�f��6�|��կ�3?.���1�����ױ�Ǔ��4�FW�P!�Zs�MT8wp��`�8~�hfs�<�>���`rP�W�{��h�) �қ��p�~I��(#��{'>8|���~�zs��g{���cj�Q6����9����Kb�b�n��yQ}���M:P4����Ź�D'CI�
��ޞP�@��F>A'��څ�`|��;�	Y�ݎ�Gz߭��n��%���{�8%�����ì}'�q� @�  @�  @�  @�  @�  @� ۃ�X�c��눕�/����XI�X�]�$�J��+��N��=��y�J=������r�M1�뱮Tܠ��c�_�l��*�=�g���z���-n��s�o�Ǔ��\�3��O����J��E�?��g�����\���q����>��'���L�X�c���m���2%���%y���*�+�ϕ�of��O��)�X��'ֿ}�.���+�|s�,?/=dO�y��������&��+�/z��.Q��2��``�6Z{9��r���l������ά��g�8�3�D��g|gf�_����إ�}g�_c�����8zr�ҷ|{�oݿ|)���qB�.]����������6�K��.� ��xU�f��/}k=��/K{>~�fߞ;o�����6T�$�6ۘ��]�)�c�0�N��mҿk���;�O��zg�\b�=Í�gu�>���z�
}if��&V�Y_�c�S��T�'-�~�.�Q��A����(�0k�W��ѺH� LīP�?3�"l����>�\��J��ж�-7J�s�m�{qc�#�����F����4��"�tP�N�Mwq��������s�XG�<&!�	��Fȡ[1�:�_��g�c���l]��~8��F��z쁙�{f�����.��Z�7��N��w��oR�O%y���A����2塽���a"f6F�G�ܽ�BKGar�m��~;���/b��/m�O��1^�E��cd�x��j^���oj��6��x.�������)���ed�gK��.g��ס6���P����0��B@��Ym���m�K��ӋmҞ�n�������7�ˑ~��+Un.��??��?_��~�i�{�{��Wi�*���F�����5s!��B�^�?�m�A���r6����5~�g�-�,�A�vu�P��.��~�W+�>S��&`x.9���=�/�?#m鯈�}�E,��ź�>bϣ럮cK|�m�n]y[�>���g�>�������>?B���U��k��8}~�>��O��C���|�>������������K����}-�o���?P�rŷ0���;�c�y�;Zo��1��cXt3�R�wވ�b�uO2*U���uK�j���|uP�n���a�����x76��W�g���������v�m�&б��yϛy���V����u<o���<o���x�����kx���<-�_����|/������x~#�o��x�F6���F-@�  @�  @�  @�  @�  @�  @�  @� �1���?'���������n��r�{{�S�CU��̛$��/I��4�IHg��_����?%��$�!H�UH߅t��I�@�Cz�w!=�4K�~H��iҗ!=Ռp~�8�ieR3���ZZa^7TK[��t6As��<dJjQU�ڬn()�J�a��⢒�
f�P����,�Դҹ����7��t�~M����u3�8��y��5�\ASSs�����i5��������9x^'�J�E��4����
��bi*gX�Q��*�ک<_�s�3ݨR������L5M}֘w��1�iv�y�Z��Բ%�T�L�`]�#Y=	K��������������A��,}^[P��қ���X��X��/Q� ���x؂��`u���8� �y�O���A��TP�F�_L�ˊ�YZY@V쎹)��|��g��E�f�7���ye�=����ze�I Z]ġ�B���K(^����KP~v�)���h�j����VfS֥���2��[��|nA�uSQS��)�2,=��~�S�d��M0�<�Y�s 6����,=۴ ����P߇C�KRK�n�R��)KM�N�Il��p(���A�Q��;�k&t�#� !�W�hN�I����O��,�鼁��%��]��Z�R�Ԕ��tk��+ͶJ��G[@I��*>>�����B����ѝ���R�7�=���{]]I�;�nm���Pn]�V[��X�6k?��J�����_��:�����g+.鷡|��B�ǚ�`�d����G��q�V%�3=B�P��4J�m9(=�2,}�uD�~+,%��_ ;"S��\�A�r�K����6$�`��W|w�_p(�aŷ�KA\�P�J+���[��|+��0��I�k���U����-�p|�������v+��q<��a�q��?�q��������
�W3��6~���89�����9����8���/p|���x����Mÿ����9~�����A��_��~��>��9���UN������8N��S�?�A��|N��C���9}��s���s��r���?�8�0��ޞ�#��������ǃ����PB�2�/��_���78����a�����M6�f�6���ow�3����fx%�:��W\��.��\��.�G.�y�{W-�f���G]�������.��.�~΅?�t�Ϻ�nH�!�@: )�c��ˋ*�j����[�%n=�^hB�L�)��tDb6�XI�tұrB�z��<"U�f��|����v���_�+���`��DC��!�{<��C#/j,yTMz
�m �wG�{��<�ɑ^�B�/{��8W�u�&Ȫ�d[�.xӸ�4O"ϸ͓�;��"��Fu+�El;�j<�	=�+a��>�"�ft�Gz8CKO�hs۔�z�oȚ:��o��:�F#���4jQ��h�J=��ZfU�����*�5���d����Xj2���Jz{�%[�n��Ŵv�jʀC�@$B$v�dyo��Ya(�#�p��C�������B�c�R����,�٤�98�_&`�?݈=s��U���7\�P8a��D�@�%�D�W�/u�
_�}z�Hk���Ny|Z�%���X74���}\k�-Tmzm��Q�e�џ�Z���u^������v0��Ih  ( �� ��E�n����pmMd΢��g3�:	n�"�t�Μ�,rjN�\,��I���J� �d�v!���x���o�dVOU�F�pw�ۣ��ݞR������^"�X��J�|;�T���˪:��*�o'T+W��!�zFT�J�rYU�ѲRшiSwk�MĎ�um��ހzb#n��y4��:�Uk��1Q��[
���jƵ���f���5���[_Z[��^�l�?�C����-����Nɛ8�J�&��ZS4r��V��ʼ��m+?p��c��=Cc+�|n�F+o`̒��V���6'��n�j˨oYg9�%ϻ]KN*W ��|��"�1_F���98��#p����朑�I_�YgF��yU��6��7�����qT*j<��<�#t��ȳ»����S⸐۴���H�5U���q�^A��I`GjW��Ok/�W5�:�E��,� ��J0�W�쏰��h �+���p�S��ɫy��������&P]�Q���l�|i�a��	������`���p���=������{q�����������ߵ �� ��������I<�Ƨ�����r�6LCL�Y&S?�l�C�@���m�����\�Y�-�(<����}?��p/����>���"�}9�xO����h���}>O�X������倠����j�M2�.C�V��4r��5���x^�ȂV0����'� �h���䴂�j�Nyr*>1NB��1���{�w����E�$~;��ƛk)0�<&Og3M$�����Hȓ�N�pyD�??63��Sd|�tR��6g<��0������+G'�)3��F�mbR>?�| �`�;�������d551���
y՚k��/��V�W�FAak����I>&�vz:�l�
c�͆R�pGC#�5��Ԗrh˜n�|�;̹\1�&FΪW��i��Ϸ}����-���@$��� ���5��N.1�ޮg�pp,���I[�{*��qG����SS��g���5�Tg����ttT�'''&��9��nE�� )h�+�-��l����N˘�F��
e��v}�m
����M>��SK���T�Ud˥zz ��w���e�#����,�Ϊ:ޤ�����j���O795����)jS3���� j����%>J�
�jA���o��|����p����S�n�W5X�F$�b���+N��to'�iyl��a��yx�z���<���Ƃ��`aBOiu�9-��DmŬf��`����v����M�r��OMO�w�DGM%
���bа�1�:��B6q������4�X05fk|b��ZU��SiZݘLʉ��L�����M�Z+��h9V�U�����i��A�X{�٩ܼFɢE�'5��ll�`AL7�5�_rJ���-g�s���
2�J�Fc�}]�6@�K�7ݰ�{����6W��k��68_�4jq�d���C� \A�_��4��b� ���+)��3�S�ڨ��=*.x�Dt|ڶ��?��h;ji��� Sy���c�q@�`	\��ƴ��R  .������T,:)�TNG�p�g��iy�(lG����H|R����z�����״���Ǒ�(k���J���w�o3a �m���m�C���;�/~�`���,�W#'�Y:�����ͩi�u_������`	j��=�(7plt�m�X=;���:r���s�����˔�@�����A�����9טL3��j���P7A�ȂZ����&�jT�Oo.Or����*5�*�0��3K`M ���DԔU�%���i�g���L���'�պv2���]�َr�ӔO0*{��Whm�����̖��Rg��@�i��X#߻\���3�Xb��i��й�!$�3M=I��j���5�P{���)��_�Iw!?x�m��k�a�
<�`���]$j�;I�����Ii�"�δ��)А"wbS0$3S����=�u3j�$��QF�p}��~-EE'fOB#?�'�{�����-ǜ���e�� }��Wƶ�]�s�i��쐳��[�a+M�/sZ����c�Sw^aǛ9uAI�6,��-X���2a�q�ދg%�>��TpTy�}����\M�ǭ������N.��mq��	��>��D"���Z ��O�/Q�)[��A/�z�t`�|.��\ꌴ­L��/�-�Q4�5ҩ�ni
�g�)�/��N���(�*�4N\A�S,�S�~�g��nȔj��qDj6�J�Tٗ+t�k�s��!n���lE>��D�*
��H{V�Y�)voN��L���$�����KU��fX�V�ě���1��GF�F�a�o��^f�H��;�V�yPq�&<�%5�����}tOyt�~�'觱&�����T:>?&�q�1q�c�ؖNO�^�UP�Y�ސ��&����q�Q��D�WkB`O���1 ��\n��N�����7=a�f·-[>�}�
kӰ�����£��)�u��E�������n	؎��jw��WN��Ywq���K 3U�5q�}�L�_��/nj٩�$�9��<s�S�w���'�#J��M�Y7�n���������"
��?�w�M��lA7i U9W8�k��9լڷ����n�7 @%�N��`�����������}��5�jٍ�j����jW��x�:H��`�r�΄�|��h�n����2t��ef|j&>���=Ih.@� /��U� �  