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
� j��e �]p#W}_Y�����@ÏW]���I�e�.�`��wv�g+�}s�I������v�ve���5�Nq��P:�!�Ng�)e ��1��C�&0��3=�0�θ-)�\����J���$������>}������}��{O��׍#�uF<O�R�ƃ,�'X�A��t2�H%I<џ�H�z7Q�l�MY��e��/h�`>`+�����ь_"���������4�Ζ�V��)/b[�"O%��O�Ӄ0���~����؆��5������&I
���^ wK҃�+i�� \
I�����f�{x��Ɋbk��_�� o�M-�[r�[Zq��b����Q�'�f�G|��}\��f��BA�.����j�/o�m,���.�3�n,�FQэ�оy.�.z+y�㼊2���(#S��L�0g��y�)�s�4]��Q�3RKN�ſ���ݮ1*gb|�<:��q��N�1���	������҇kU՞�l�@�.��~N?�^Iz���)�\{P�2���$}:�2x��ut��p�ۤ�Xo�:�p������;58���W���[?��4��i����5����}��Hl<QՇ�>x쓎ԭڑ�YP�8�`(��N����l���[�Ǉ�b+�&��ַBAV���#���?���ek��	wMw���7
q/�q���k|o�g�5��[��kț��'Ic�/�9��7��W����7���/?��k׮9�<��M*o��7���$���'J���G���2(����7M�%@,����8~�$� 3�X���*mOv#�?����z��WO��۟�2��O�5�g�q�GBc��RC��DC�B��
�*?�*?ې�ZZ��߂�+����:���(t���ٯN��O�7�l����S��\�hk���x�����'�I���*�B� ����gPr�I^�q6�ی���8C]���_z��7�/���|7ti�'+�	]:s���%��Xn���O��_�J<=|�k���ׇZ��x�p@��>	)ߺ�����ů�%�6�8C��V�[�/�����4�>���k���~͙� }�e�ʽ)�����݁u���	�����]�߳�����9�#���~����5^_w���o�n�ʌ��nl���#n�A�F�G�u������z���]�j�q���ƫ�Z�K��&�W�qX��"\~f��c.�r��t(�����ٍ�.�77>����g�uZh�UX|�NW�Xm2����g�\���9��m)�YȀ��0[���=k����}b���Z���>��kׂ�m��X���v�~�Tf��hp]m����ۂJ5�����"0qW[������W7�E
\����.�ZB0�Wq	�|s��61�������Y��|}*���g�>���H�K�y�>�����=�� }>H���}��������A��}>L�B�J�c�N������_��`�Y�ڵ�-�!I:t�Y����|�^/���������7��D���ދ@LH���KVZI��	*��#?.I��ƾS|����*}�^�*6�u���U��B���(X	��aw�x����&����<����x|�_��W�x?����<��ǯ��y�<�M��ǯ���x�[|��=�e��o�?&��1w�������o�����O��x���o�G$��F!���<�K��9��:�G���:��p�7 <!�%�F!T!�9�o@x	K�A����S�E�2k,�FQ�iV����i����*����&�Y����U�ks��T�0�Is.(U�f��Z��%e!���]4�vUR�o��Ţ�2�Z�Rԭ*�N�W���<�%����y��ͩi�'aN��Z�0tc.�}΄ �|[�vA���M�ږ�^S�a�F]k�hjh��Z����n�8�Z�y�lU3���&�H���K+��B^�͡r��M����K��C5r�"<V��nв�鴭W��,�fAz}XZì+����C�ff/`�%(�����[ٓ�X���i"�����ݚ�"g_	����&��`ʽ[�L��c�$<�>$�M$���~˺tk?(�,��`M���%�ꖢl(K�kD�thT�
�ܬ�̵:v:jzr|B���kA�`WX��y+���I�NP��lծ[�����{���Ov������k�g�+Nu͂F~k���w>/=^�>�1^�A��a<.[�)��}&,u�"UT��/Î����@�,������G54�P�g�RQ��R�7���A�x�["�'�[7P�͘��+�_w/H��vb�z�I~
���'G�RwR���5K�|����lү@Ҿ��~.Y�p8�W��=�gO��#{��jGZ�	IO��J����{T�q�:-���#u�d�:롣��	(/]b�ie�'�x� ����AVB��8�Y�"�2,���1�"=�ff�@�"��?�~N�q��>�i�/���og�AN�pz��YN���k��9M���� ����/8�]�����j9�%N�8�(��9������i�ӛ��	N�q�	N_����� n�����qN8�����!F�9M8�g9����/�3N_��ma>��.NK����x}���eN��Y>��NyN��ӄ�{��x2���^��iN�p:��+�.w�)r����n�����}���������_gts�m�����������s>�~�~�>��|�7}�w|��|�޽^�V�}�G��; �Eb�[�B��b�@�CH@H��@�����S�j����*���.g4��x+��:�E���g����;uy���������x��V�َu��֠�"��o+ڲ����(h4��Ѥ'����Dk�=oy��H S�%�3x��J]8�_:fW�c�Txȵ�	�on��6�1X�Q��)����
d�W�wnA̠�t��!/�-���uR��N�:*��%G�_�#%�ZY��(��Ҝ]���t��Um�V�em�-%�`z�C7
�zQ;r=�CK:�"4dq<9�b�H����D*I≁xZ"���(u�S5hʢ^.�ep�`>`+�����ь_"p�.��|�z���8��d� ���� �� �*��K$~�҆_��?����V"�#���"��'g��l�� $���s�k���M�ў�]Y�v�:�U���P+x��F��%{z�[��H � ��%TLDw�0�z��Z��p��D�>A�����,�h�R�����*�s�!&�:��Z8��R�"�^�#�'��;��������D�%�	�+��|w�~5�6kǷg�M��Z/�-�?`L�|<y�,�RD]-k��;�l�7�}�^�3�sO[Y�)+��9���y ���wGL���R`���_ˠG�ӷZo/
<���Z_�:���I�p��H��`��������iy'�����r�Y+j5��T������;=϶�.����@9Q�ݦ��W`o�m�����M�SG{�6���K��y�v�{�������1/J����$���h4 �z�(�ۦ/�e�Nt��s�b�V��{�`�濚H��`�(�&ù�	�.�>�3鐸.ƶ�û�>R�?��6;ޫ 8��0��4ݺ���:wï}��� *���_׳?b�����`R��op�����z�?�1�7�������Q�[/�2�~�S�b�o:̿�1��>�\ϫ�m��D<ټ�K��x� )�7�)-J"�_9�9-+#����&Ƨg���ܲGf`O��S����E�@��`���a�,<?K����@z�y�����H%���8x��� 9�xO����bS�!z�Joz���y��@E#f��E�T�%bhP�m��H�y���&0��n�8�F�E?����(x�V�ʹ��I��E�㬍����GP a*_��L���kq�����3��)y����L6+O��ln*+�f~����Qedj�����\f�&�S,���d-p$��#�K���ޔ815B�)�,4�No�9�����#y�8��-.V\���[���d��4\���|�0|eݲ���
5

�s�0���>Y���ݶ*��7��஺Fz=��זL�e^�H���kެ���0�vEڙ�jx���������ө�����R�����w~���mn�d~g*�(�r��<>�J��	yz�$cC�x�X�,K�Ӣ'33�	E��r$��Ǒ+'5�]u��#�=�21ڋ�2᎑�B�G�\d��U��M湰��N����z��XBr��E�]/i����V��:��x�^��m�Z�=;��Cdq^/̓EjSK�^�� j����%�Kl
�jM���!o�IŬi�-�p>���T���ֻ�v�
m֊M'���z0�$�3�i��Bu�X���=f-S��㛅mkk��ehe|'j;a���F _?;c��S7:�7]�?=����LtJ��#�'�c��Cm<�+����5SYL�iv�fD=fkrj��\5��Ci�5ݘ����DfD&�;#$r�D:�Vl��_��nD����Xhg�͊F���M�Oj���\غ�6Y0�h�`|ɢ���[.<v��wd��#��Hۺ�*�u.��bǂ��Ba��Z��W�mԊ��j�֨�E�	C���H� �􂆦���x �W��R ���yw��iPq�g33��v,ȷ��e)�����ZDG��k��\s�s 
S�s=��.H�pM�-y�[�c��<�<��]��&g��IX���щ��<23��������x�N�O��ǉ\�+���+�����l�gL"�q%�8ʇ*	w�'^��{�"�ۍ9�_a�������b��0�"�:�_������ `
<g�X�=51u�1T,���vyy��_H�9y�Pt�(e:�B��D[��ű����;�XL3˚jԫ��P7A�ȂZ�����yT��Y%&l��ܶ��l�pG���������Qvx������֎�3 A�w_i�`F�>��̳���NS>�d4���fE蠵���^�3[�7J]�;L�m~A4ʽ�W۽�tfMKL�����!YӲ�<]&���єc=}d�K&���?�S<�h��,�x%݆� s�l��#�Y!�Z7�LA+��wuvO����^�.Y�:Lo����f��y5�"���%�#����3���ݛcݶ]c�������>|;0�4���+M��l9=���Ki�}��~������
;�̫�kp�a\�5�BGȂ��Y{'��p�`/�����x�s�b7�j�}�����������-�6�?��x����T<> �n�z�??D�cK�8�Ӂ����yFQ�V&�Ëte�-v��X�mM��6�˥�<�KT4��Kn��l4�RA�l�:�:�l-]�Հ���a�ev,*q�Q�\�Х�qy�u�j�}[f�t�Ts�(����'��B�V�OD:���ZhN�y��e�,��g��7\^j�4�:�ެ�j�:��r��a��>�^g�w��H���'��
�8���P����6��<F7�Q_�H$�G�^�4�N�O�6��L��ѸC���qZ��NO�A�US�9�ސ������u����{-��z���"A��ŀ���f���S99[�Ug�9U��w\�|n�u+�L���6̶[Of&�eߍ�6Efr�����)	Ԯ��z7��*wŭQ�Iq�.�f8Z�=�"����`���2^�ԲS���(��[l�� ��O��]���=5>�d���>g���c��{'��]Q�w����n��f�I7P�s������W��}�O���a6�����l0_ܢ�Q�4�V���snЂz�j���R���|.�k5儎��C��5/�L��}I�$z�E��ehxo'	������L��>� ��]����������� �  