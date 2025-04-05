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
� �re �}`Wu���,?$;~�=Q�Dv�����$Kck-Y��p�vg�!��>d;�T��`Eq1%@
�4-.䧆0�9Ic�?%����(��4ABbh����{��cwfW�ò����9��s�=���̽ӭD6ڦ��t:�++�U��
��\��.WUU��t����6�r�#�T"鋃*��P(R��xv>`-�`9�x�����CJw��-�ɑ�7�J���8�GUE�I�����.c���&8�X�������M������k\�NA�At�VW�V�B��w���Rp�T�k(gW�$���o{��E#��|�m��f�Fm��n��C�	��g@�"�� �~�G��xg��#^lcx+�� ����ĕv�m�q��"~���A�~��0����xq�Es���1����Qĕ~���a�B�/"^Z��E�1��=�����0��o#^����O!v1\Z�p�2�/ ~t9�/��A��
�7�d�⓫>���g�C����K�>��1|�r���}%��_����������"��Z��k�_��������)ex�?���5b�z�������B�bj�F���Ee?�8����hG�_!�r2|q������$�\�ps�S��dXV�0�������x���u�O *��odx�obx��/�����n����v���zl7�� �q��F���w�K�0���[6#V7�<�7�	�_!���p]3�D����s;�+�}�o��І��������1�2b���O�����N�#���Ї�Ă?b� b�N�'b����!�E�{ķy?�[?��#�݅�x��D�G�4�oWKw >�xW�;�#�.�'Jzm�X���R��o�0��1����!�����U�Wג��
���6W�����%Hn�V�� �V$c�;��rR���d*!z�%)���"��ۗ���Fc�h$�DR�Su����HD��Ht�f�Y� �H*,��J4�$9!*YY�A����mN̞Eu0�}�^ѻE�6��T�(��J6��۫���kJ@��(f��kP���:���>_(cvA�$�nP�N3"��!"�F[+	�>�O_�z�����n��I~nB�Y�F���=Y.I.�3Q�J�R,��K��v�U%I��D��dZIzۥ��!7���$��d���+i��(B����JI�N��_)���}0�����8�V�^�7H$��r�!9)��m���_٣*6Uzr������D2��gѪ�iUF�ǘ3�W�T+.'��M@T!��r\Ha_�&����Rz��(��F�+�I�(�n�v��Qe���%P>ͪ-S%)�ˍ�⏦"���Ĳ(��4�d��ܐS�0P�Y� ���r"֋��I�n�~UT�	S�d�pV��\�������MWi�1mNYD�GQA�d"�L����F�:ۚ!��5+:�f��W{&T��Xb�₢8�N�A�LiV�I�Т8'��tYf�z��O������Zw�z�;�lp���r�Y�%ӖAWP)���Ær���%-��.�pN>��Zt��Sk������̒���>o�^��[�g����ڴ-�1r~*��R�#d|-)A��D�]#5���;��q�^oT�@-5D#}r<�D#�HSIU��
��ؾ�|q��Z|�@���v��V�F�����y�<���F��pB��E��8��i�-KT"����cr$@VMi�D|5�qu�?H����̃w�0�v��/HqPZ��A*A�5�Όh���W4�q��[��f@z�.�A�@܈�����D� w��`^��g�ʩ��Tğ�a�V:�0�Ĉh|�pޗ/��#�������u��_���Ae�
ż�� �l/K���h�uO��4��f*8��~y���5LIq�*���t[[�BE�H�mlE�޲/EZ����i�`����!5�vt8/��L��p,���|<u��{�'�Q�Y>��٘��"�g[i?�Ŷ���Y���2U���JU#]�#��[#�{9�F9/��h̬���I����CP�cH
t9�k�;����m-a2cY��]a�m�������ATsA��3c�3�Y�eӁ��t%:V��H�������LP[�l�6$���;�D�e{�'g"mY����;sxu,��b@��v73A=(��Up��!�o�24(��pFc�j
z��(�^���7ݴfj�3����EMk�碤��\K�]E$��bXXI&<a�f�&�U�ؓ0)��i{"�r�s�j��o�r��W6�T�2��wӴ���x��7�M��ң�OS}J��k����q�}L �X����`H���}��GM[���v�2�=���`Rb��r�m2����'���F�y*}
D)%H'ajr�ª49s��wj��Jg��[��>×մ��^�B�Ϩ.���$�@�n��C|��~�5��d���ڧ����VJ<��I����WO�2��a�yuM`,+���6�j+:s,��p��R�ڋ�qb�0�ZfuWq���őŴ#���F�}��K�i�f��f�܉��/�Yd���l��*��,�^O�u�d`e����P���Y�[�w�αv9^O���Af��v��P�mP��I�U"c�6+tu�����]�	���~�N=���z<�ŲR"
�|=b{�y�W�2�[-�-�]�,�z�Oo3�؄}�4��0��UC^?	�R��Z׳����9i�íV�&�v�Gl�ϙ�l�:s�i=T9�Z�S�����:4;+��Eͩv�_����9������2�q��N�jݩ)�-�qY`ӏP��ŉ�ɾ8Q%�o�`���ŉ*|���>|���J$!Ǔ��N���
T'�BXMٖ�}��"�@�h�=��"�n�ZT�:acL�I�ړ.�/��DH�JI3)�<�0{�a����?�Ji��}���31�d��ޔ3��Ѵ٢v�z�l2��&�Q�QS�+O��<��vڇ�����r*�v6�1>=��1e!{
��}|:t�CM_O�	g@˩
�{��en|N�'t��:�jMM�N����5̿�r�Ҕwr�?k���d�j�D��k�,_���љ�i_$o�t���^�)R��6�
�=�3� ��g��׫i:�W����h���P=hXнbI��k	�L�r5V��A~)3W"2͆���f�Y�p[00+T4{yv(g��f�r�(�hl�N���fw��B]�%'��ڝ���H $^�FS����$��Y�R�0�0���l�K�lF�1=�؜V�[�l;��ƏgG���	������CHל�(b�J��S��d�]�m�.��k0�븍l�]+ԦZ�����Y�ݖ�y�>wR	�;�;�<����K[����F=e;y�n]Asm�ni�������YӬ�;oEt(�.���#<@��m�ʝg��/	hΊ�7�M7k�햵�r��F+MV�l2&�Ɣ���2ON.OK~Y^~����31�03j��Q�M���=m*dTD{�]�7�y$9��̌�G��$ս��[�|���J��J
CK����&�~�Ͼ��}�1����U���2nW��0L�Pjar��' &,�^�<\�W�	��Sʥ���3�$���M���7�1	�+��L��W������*'~G�j� j����~1���w�l���o;����́�,�K�_�����*G�����^(�I��$�C�ّ)�We�<����6[#S�_�'I=~�$���1�n�m�7�rJ�ɷ�,�a#{ҭ�*��?Y��cn���2�ё�iy��'Q=�)��r(/O�Y�nIIRK��^�?fy	�q7ө��f�%��+�$ɽR0����+�pEQ^3�׵���f���#��噷��4�)�߻�}����hz��.��ÿ����6E�_g��ϛ��V�4��LӠx�i@?EM��ƛ4�?Q���?[|�3�����hhEW5�墳��k(��t��L�NЫ���l^�^N8?SzWp`������m�~
�;�Tϰi�8�<ģM�p%�����o!�s@<wG�Y�j�>�2(�v7���G!�sEO��
}���P��>�n���& �!Zo_�u6F��]u��~����q,�v݉���'�����������l9$�r������a>�f�����z�x�˴g��܇�6=7��~<#M����7����[��)�ܘ�F�F�ЛYmTGm4�mtr@|���3�������~p���uK����~�����ns����;����[�"���Rݛ�ً���=��M�K�%���p���~�m�]o��l'`05���XZ�\��Q��glE��}c�{�����`M���&HV���՟����̟�>M��X�;u�?Ky��ˤ>�4�@�)M����S<���l�:���Q
�����Qc���vThV�>Rci��;�I�-�$o	��k��Z�i��2��s�V��E���h`m�4���c4�b]  w֜�`�	�y�s<�A8!�f���
��)�ւ�;������7�&�O��E��R�3�`�(��Qm�!C_��#�?9Ao�l�0��5g;^�wƼ��i�^��'ՠ����=4�»!�Q$����G��GW�	�Ǥ��e�����or���<S����_/*��^��f�&����Y<O�U:��ݢ>��UK7+��ZF�� ~�����C�q=�tCL>F�=RZ>V��Q�N����8
�0k8����.���l�+��u>�����Y��h�ʫ}���x=���K���BYS����b޷�c��=������؋����+��B�������wg��@����}g��>��n�9����|�����lt���j�������Ʌ>A��n�F9��|��)+m�^���&8���m=�i�/=�=ɪ�NvOi�oL7d����>��=N����pQ����!/�{_��IC��I�@'X}�h�p�I/�j�p���z ��='~���1p�v��������Pz�? �$G �+�Y���az������V�G�L꨽�����Rj��zB��Fq&i���_&���tLy��"�8PG�M�|�^<״���t�I���yt�:w��8]�N�U<�uj����d�[�Jȡ}�fJ���ᦁ��^�����?�7-|������_/�9L��qɡ"��0�y�&b��Ő-��%�7����x,�`�*�B'؉�*� �/�]��K��p�P)7P|_AQ��.ba����0?e�4١����\�-�}g�R8Do�X����0s�V��k��\�X��r���s5���}�8k��#�Æ�$���hK�.%�����#MW�شT=�K����t��o+�,l�v8�uP��m`μ��A�&����Y=8�RH2�Ýv�������q�,�7u�]t��$��mv5�:<�Et�b0 7F�aCL9�N���ۃ�̴�Rx�8���:0��^�S�OQڡ1&Tm_�k �<H�b�}Gn<ˣ��,Y懎��U�k2#���5����B�IѨw������zGSG�8d,��"��A�^4�?n�v�'���4zr'M���j��0˝�U|����<�tﳤ� KRO��h:_#k�"�����i;����d�)��K�-&���ɳ�����8]/���t�HY<���]C����r~�Fq�h?��y:�N#������ޢc�1�5���S��ҍ?m4��?��H��rڶu��l�~���`9��맺�"�A?��S|�T����6D�J��<���8�}F'[`��}�<'� �G���&�a�LzУ ���wbF��$��!�A����L��؇��0��y��Ѫ�+����5��e(^S�vd��߄EJ��K�J��{d@|�et�>#f�{�%f���G�Ƈ��o^���f��I��c�3s�o���$�h��'�+��ķpV�僮W|�S��`Ѧ��B�x���|0��P�v}.=9�x㺹��M����ȳ��F��K��w���d�3�ͯ�}�4Ҟ���M�?��w���(OAy��'{@�5Qy��|s=/���;�����f��}=%������<@��j�)�^�� 9��y�M϶�=�c���e���43ͽ��I����:H�^�W���������8JkoJ��{b��wM�'O~�)×pt3P���_���M��Y������? �-}L��2�誑f|B^9Яh�������dЗ57z
H����7]�d,G�R��}�1:������!�1�VF��:V6R&���b���nFz'M;�:	�����9�i�Z{����XtD}�B����B����+P5�X|����o����x����Ĳ��ơ��yB'o�������ap����$7׏�T�T��ˑ���ӏ�Q.��`�%�(�:�đ,�@`\M�?ė��肆8J��r�2�z��v��f[��=y�����R���Kä��*�8r��'���ݰ����kG����˥�o
̵�	���7m��6n�%բmm^�x�����lݒ�Qz�VI�s��W���2�v�#��R��ɟ\ ���R/h$�K�>D߫���S/à2��ת��CX���v�f���L�h���0�$3�(�4
�.2��o��Іܣhl����&�m�.��Jf��Pѣz�?����ux#�k�(��#jG�ş.�tD��Ze3e�T��;�����1��B�h��oR�1U�Ami�
��i+�.�/��,q$��$�Qq�d�b��Ά��������X720�ys��Ү� �	�_,�����[a�y��9�IMŦ{e����Y�W�/^��x�"����I����j����8&�N���X�t\x���] {6�,���G��ϩ&����pz*=5�'�o�<r���i�O�YW`/����x���
��0�ӗ%V�EԐ�Լ�����6�5�����Y}jƠ�ZX���ζ=8����������R~�xz�0H�����g��箞Wa��k_j��:��w�%�%{���Nηض�f�p���s�<GZ��zkBw]��Tw�z�Fݵc���<�e���J
+u���w��m�����y/�;������j���l��??e���slO�k�]�Щ��b�]�������'�?�o#��>�Fq�	ݛ�C��A=�����H?������A>/И]�G����K��+0=��r�Iz�}&�!�;L�Hw�Ћ�2\gB��A��堏"�Ԅn���:��e&�.����a��Ρt��b�b�PUi�� ݋tS�Dz�	����7q�X`-_�A�C�f��!�i�o'�7�#=��Ua��W�л�nV���!�W3H����/���/^h��闛�c��;��~�f�3�t��3�C~q�5ݙ��E�Y��r�?�t��!���c9�Ӎo�Y��"�,>�Y�8G�C9�砏!��Aڿ��;3���~�������[�o[b�^@�U&���r��ϑ~�f�{4G�q�/5�s��x��|'���[�#}Wz�#�fi�x���?`���&t/ү7��f�;��kL�H7�?���_�u���oB�/��(��a�7�Ћ�14�_�Aw"�����n�?9�CH7��޿�HO7"�,��r�����.���w�;����#}�	}��M�|��!�Z��k���n6?�]��l~�D�r���n��u&��H��(i���������:���'��>���M�cH_eB�]����C����.��L�C9�F�Y��A���_�t���E�2z,���H7��Q$���h��r���Ƨ���;s��ˑ�+G�����C9�砏���f�K�M�]H7��H�6��"ݴ�Gz�	��j��]H�4�!�l|d+a�Ȅ^��%&t�f��"�t���3H�a��ϧx��t��1*v��~H7�#}��~H�bBGz�A�3|���Z�.��b�?�M����������M�˵��;sн9�w!}�����8p�݄>���a�?���7]H7"�ۄ>�t���o��c7X��f��Q�o7����3[�qn��ߋt��ˑ�?G��H7�ϣH7���˃�� �"�
���H�`B��f���A��A?��>��KL�cH7��
D��m6��b{����
	$&�ƻ�Ǉö�����iX���"|�D�̂/��g���㛹���g��*�Ey1��P�c��J�
�F�>�]���[��a�w�	���{�j�o����W����ה�Z���<�Z�o'�Z�%������{�z��̂�Y��}+���|5���/+.�v�|�|7��y� ��<����w���yV|� �H|s�B�@�
��w
�VZ�u �X��0�̃�l-�N�r� |k���o ��.��|��ɭ_#�	y����Y��C��wr��'�� �|_�ȳ�[g�
���v�W��J�}�U���c�U��ߗ���o�W��*ߵ ��o�U�U��\��7+�Y���J�g��h�^�#�Ŀ�/y��M�w0 _,y_/�]e��8�u�!��ۙ�����C��k�#u�)��yK-�]��++����*�7��Ԫ�./�/4���2�������}���B�~�-�^�:�ނo�"U���T,R�]c��K#�2�i�Y��Ejd��ˋ����|o/Rۇ�~k��l�o�b��M|��j<�*�#�U����]��Ϫ]��8��X�D�g��oO|�%����%����K�����
�<��O炐��7߂o��A��|��<��|X#�Z�G5����R��V�7�o���e�A�B��|�E�<���$��Y�=|u��������*�9��m��Ū<+��bU��-�v�N�[e�w�y�����_�Y��^��g������,��.�O��e�~Vq(��g���2�~V�>��g^[��w�ߊ媿X�?�+��������oM�x�4�<�{��<�[�܋��>�[��;�����Cއ��X��!�Z/y����yV|�����C�F��:w��A�s[�=�B�Ϫ}<�B-o�߫+��+��h��X����Z��K��+1�|V���V��m����W�|K,��^���z[K�w>�o�*�j�0�J�ϖ�o�Oo��{����j=�Uj<]k��b�*o��M�7�G9�7�|�X�=|�����7�G�N�w�Q��j���X�u ��<�>|G���Q�;�|��� |��݂�R��/���l����`��Y͓�o�D����u[�=|Α���	���^���<�ߥ�>��j�V|^��n���� ��:�}�ן�~�i�Y��˗�W޷5嵒��ԍ�nG-���aU�I�+~��]a��� ��g5���5�[��
�B|7_i|�s"�%|j�������-���΅�b��rʊ}����F�O�b�?����Ϝ�)s�����g�K�����'�%#�/ |Ԝ�U��E~>n(�1�''�F�{8�Vs~����!F���
�7�O�����Y����G�ǥ��8a�O�W�#��8�	s��ۏ�#��g���+�����?j� }Ǘ�����?�u_cd|��V�Ü�<���:hקڜ��9�z�P�ڜ�E��,#��o=���o��fH�^�; =�� /�G�G6ۿ~�A��9B�)��ԯ��|2��S�?|�E�� ��@߅r|��Ψc`0 �i�6��|�s�X�/�'��l�_ �(�W��sĻ����n�/����;�!ހH:�;_/�6s<Y��?�����R�ނ#��&��I�E���\��歀?����.�ׯg�� ��l� |����O���ӭ�+����:;޹��-u��u4>9>x)�u�/~��B�e����ҽ���\��������ʵ,�z���W~�w,�@�	�A�{��6��
kY�/YK���8	�~p3�_� ��� ��%��x	����k8�[�����>�/��;~��W�m��; ��w�܏ ������T\����j�7K w?�?>	�E�%�=�&�o�|�E��_$��)7���U��J�o��٪ ����Wҽ��{��{6.�G��_ �B��!"p��+X;H!�v}���B\�C�:���������
�����c�����2���c��/���8�=�[/c��F���
�
���^J��w��R�����7�z����uȀ�D�K�N��.��w	}��q#`-�~p|���U�0i���'�Z����/��X�����5����R:�\M�Is�l5����Y�;�����f�3�t�j�N�0]�/�t?^�����џZ����[��w�*��*�W�*��[+Y;���gW���+Y{��J��+Y{\�����
�?����׋��l�w1}������v�N�+/f�.���������������L����;Ȏ;��w	W/g��7���nǏ��v��gH���]�� ����!w�Sl���U1�o?*�8�7$�W c�,�Y���8\��������i���3�o�q�㓀����W>X�,��,<������L߻ _"z��t��D��C�!��S��-���:n[��W%����@�-����䳘��Ŭ��bֿݻ����Ŭ^�Ŭ}�G��7.|p�m��.b~��"�'��U��y��G�&�ϓ��UR?0�<�=��&� �{�������0�o��&�����&H:��$�/�|2yv�O����?\@߳s|���A��)R>�/^�wD�6� �X�o-��R:>x�����| �%��'�e>��A�g ~����|�'���Iʉ�e�x-���M$n�5����$�8�����n�3������?�����	��〿��� C����נ1�	x����: y'�5�7�0}�k���2�7?�
���0�6�a��i}��A�/ډ}��oa^���a�?�� _�3��ۙ�/ۙ�O �3����$�3%�@Yȫڎ�����S@����j_hK6? ����F�-u�c���}���8���4:q���Q@�!�YM�9|5���ұ�(q���Q@�!����C���]�u��ql%�GB�G�B�Cm�c+0=�b?������]x�Q@�!�]���]���������]�u��ql9�CB�G�B�Cm�d?$M�8�؏؅X�( �Ǌ1=�b?bb��hC+��C���]�u��ql)�GB�G�B�C�,ev'����mxl	�CB�G�B�Cm�c�1=��ËY~�����~b��hC<���"lO�P>�b?bb��hC$���C���]�u��ql!�G<��w!�/��G�B�Cm��*q���Q@�!�-��C�/@{/@{��=x?����~��hC�������D��<L�8�؏؅X�( ���bz�!ć�b��b��~b��hC���ɋXzrI?������k0��	x߆86��A�sP>�?�����!�ߏ؅X�( ���h�!�~�.�:Dq�ۻ�;އ92�׆��P_�?�؏��b�ׅ��D�3�S��sa�H�~~�_+��HpuĿB:?��6L��Z���ܟ#??�g7���8�D:?g�q��s9x������s���|�������k���������5�w3��}9M��lW������0�/��jg��|&�v��sڊt~~ң��k~�����]���	��yW7��k~~�Ǒ�ϛ�~3��w!��w����O�#��gu�����ue���q}م����ōȏ��u��1�~����?[����/�lb�|��7W�k���x1����������^Į�ys������5>�x~>�����^`�|?�����W�k��7��(?��G��Ũ���
���]����ko��ay�`�|�������܆�Q~3^��̫D,>���jv���P����?�J�?�_�u.�N����9욟g5xI?��x+_��(�������nG���O�=������w!�� ��go�������\Ǯ����7�}��V�����?�ˋ��\��C{�nD����*����=L?hw;���3���]��2V_��1�o��<�`%���G�u����І7�k~���Nf~��O��5?����o���=1~?��]��z;�|�������|��܎���w0}��_��k~���X?�H�
�?���Xy�0F,�����ݸ����������ܟ�����k�?�CU����q��o�,����K������k�G����ؾ���s���uCX~~����P</lY-�������������ь�s5��L����wU��Oby���SM����=�����݊���1�??�j�Ux�����?����.����/q5��S���?�~�d�|��"�����70~�����������v�Gx��g
��~��}�� v�����|�wa���$L���-����������������������z�?��G}�����m���ϧ��'?�ۀ���s�7~�M��ϗZS����R���1^���J���;��gt~�ݮ"�_���t1:?��^���w��7�/Y��C{6bz~�ܗ1=?�����y���}����}o0}1���J���W���?O�u���P���<�oaz�����ϳۄt~~���w�����Z�|A`�߻����kA{`<{h=���_�W~ޅ�+~~��~�� ^����#~��k�~�z]�7X~	�?��c�'�>�،���s^���^����?���C��W0�v��� �ן�=����e��<�b����o|�1�;���6�؟<��|��;�X>����/?��H��<���χ��{~�2�_`}�)�/�<�9���_w#??oa�����Q�I��!���P��>{����n��.��A��z�&�5i����[�������*�׽����ʣ����_|H�)C����1пm��#���o�_��}�p�g���A�����U�U��6I��{|R�7�m��>9���}	Y��p-��=Y���a%�K�}�F ��ڞ,�$��R�z}�^I6_2�x[��6ލD��ܨ�}�PJ��{c�G�V��n��R$ي����4�7W����Ng�HeUidQ�<�07O�����d�R���R<�(�fY1;gM(��{Sz@	Ht�+�
ǤDҗL%Lx�AR-ɾ;.��4c �[1��D�?I*��,��cq9��Ŗ�=ٍ9�����
E���i�h������Q��3Q���d�S/�T�Th���N���)���UU�7�s�~��:�C��H*,�?�+Ʉ',��}{�`�ev�@1,&S�)�q�U�x"��j�YU�ٵo>�շ�~rZ�ڢ�D2��gQ��l�;;44W0�3]�p6�;תYkF�%��rn�}1���(y���ˣпk�R�����k%'�Y�h�2jFOL1�2ZE�Ql�k������gʇ�1Ӭ�]�L7os�����;45,=��R��V��%P>ͪ-S%)�ˍ}�?���8������#M6�(.V&p&��LJ��V��rF"�䵜�(6%�̣�NU�;'�iރ�i�gs��)G�b�[�d̐+}����%��'Y���=W���S�5�9�+ws=w�:�ôrSc�qZ2�RH�=-a��֬��X$�z+���0�:��c�ʰo���R�G�Ǥ|�x��"��h?0��ǵ�'�gA��G��������V*W9U2����J4b�&����̜	�n٤#�c��5�v����H�$Q����	���:Q�>+��T%d48_����<陸�g�{'���=�8+�f�yńU��֚���9Q�:%��n�-T��3�F�,�[M�*�yRF~V�j\���-�Yi/ϑ��WU�IVS���G����&�E�)W��%H_�ɨ�i�}:}�,�Y�&U�@����M���ڴ:fs/ᚍ���R��K�e:�Ĺ(�Y��#�e(g|'��}a�|��0��)��ng�/ ��q�^��@
ɑ�do�ˬ�]�4��n�34\ �� �Hl3����Fߧ۫��e�����Q2�`h�ȊY{+3�-ziѤ�q3W�q%�WR"J��iO�\���!������p�]����^'Ȧ�D2M%c:�;hA���1���<@T����oc�s!�11g *�e��� J�ҢT��]i�,�{��a� ����ΧD����i��B"��JDl21sC��L���Ei���rf�����Q��L�]/�	�k�zd���V¬j b�ךU�$s5����"�$��²h$a���ִ����e�Qi��TH����}r���"a\A����PN��X.�Z�^���,�m��N��w*0��6��\r<��|o���:	�	���ѽ�#M��y-`����!M jikV��fN���^%���D�-�|���	Q�)�C+�2tx̦Y�񸒈���^>��{`��g�_B%�/�C�V�eE�+�Q�|{4����N)�w�����n%���D*,�g8qY�j�����۰j���ٔ���N������	��R�h��f��Q���ibR�&��L���Ӥ��8˔��g������F!Yҽ��ٖE���R�Ij�rrw�G
t�<�QDSӒ���>�j�}j�ԾY�!Y�>��+�غ"�j4E�j�F�`�Z��ބO;-+��N�Bn���^ɗ�i�gؕ�n�)�95b�}.Q�zfU��[9�N.�M3���I
Hّ��`V������gZ]aʐ��S�cG�@4�,�V�wgI:��e��A���!�<�ޙ��k��^�g=�y�JP���J4��4�TE�O� Z���'��s��l��w��Dfۢ��<�Oٴcg�Z�5cE�ٞq���9E����:u��I����-gv�*��ԧ]E�Y|��"�>O�U�t�.^#�z�f*R�}�6�!r����pN߃0>[��u�m����6�8 ]��>��e��g'DR�]I�z����I3a1���Z�:��gq�w��mv9�9���=f���ļ1A�ݾ8L��c��'��:Ev�/&����A�e�[\�e�t���+s��ě��ʼMab���c%��W��D�L���<��m�CF�F������ ���%y��L�h~"�.�9�*�yk$Ju��ܠr�$�u�mqI	z���<�a�*ܮg�v/�լv�tǃy���!��K����Z۞��wK���N&w���%�L��p��C�T���2�$�hT9Q��ˢ� XcP�^I��3��m-{	��|�����"���
���DRR�0ɣ5�L�$�fu/�TNc8/�"���h�D�4�6��0����X[��>!���(y�;pa ��29G��/�����=	���f�{Ez_ZLa5�b7k�Y,����ڗ���z,���O2ۚE�Y�E���^,+�>�h���,щ��W4�Tm�G�ƅ� �^]]g�����ӭ#��t�<�K���GLD���7�j��+�畵�R��u�[�>�v���.L�u���؛���s�s��+E�	iTnq�f㈆Ō�q�����L�I�̝�8�����S��tjT/s@��Qg�㍬�&Q��?�n��?{�<��Y��@��Q��#��F3%�%IU��%%�J�'�iY7�NI�FR��R��T��)v����o��>Z�[<-bFߞ�T�[nkw��_\[ɹx�Ȗ�[a���_kCDM��Y�̾Zc�����ݙ�Ǖx�Zhˬ�6}=�f]�׮�{p��� ����+m�64�n-�]�w�k2n�*3�Ug�)ϼU[�q˝y�UU�),3a�-�+˽Zwf��[U��,3o��.�lϞ=RL�'�_�l��sf�s�l׸6����sU;]����p���;��G������*��UH��e�X�,��,���_�O�_���"�3. �,�|���CZ�_~_�t��z�����VRޓ�~��Bi������#i�'N���������5�1�;�r��{���{�?6��A�H�w���F-}��-N�e��>S���N�$ɽR0����˿;-`���L^�BV��O�<7�#�"���#I\�Δ�'�q\H�IlG>�ȿ5Ϳ�S-���ٯ�i��M�_sF���iH�t��2 ��l?�4(�mq�ip��`���˦��c-��ɢ�FO!Mǁk�i��i���;�	ˊ��/o�p{05>�Ie�\��d�0�L�N
��n�|�x��~M~�*��e�2�c�T^e=��7��������?�k}�}g4�d�S����(��3�����ڋ�1�Sdџ�I!#M0�Wy��a����d0�F�T�9p`�$��|S-��EO��L'��>;�~�6�@�)� �:O=5�E�p�3�w?��>��y����Sm�_�V:�n�%&�Q�kL��~��>-��/3��8L���L?���L?�c�	݉�z鷚�W ��n���ۋ/( :�ϑ�O��������/-�N��N(	�'�o�_���6�Ă�!�w�]c����Cy�Y�J�|��vU�˂��v"�:�]�ׅ|-���^䫱�{����V>�-ԧ����ϒ�����5�&��VЃ��>��ܻ�R�U����'�D�e�{o\Xm�}��Xx���s����]��s6��9H�_t����_�( ��l���Ѧ2����-����.�:Dц�3;����w���Do�-����g��vr���x����x���/��Q�ׅv�O��_���o�y���5�O�x�[x�U���6}�ͮ�.�������C�A��]ۀ���o.3�ʫnU���>Y̤���,�g��MW��n��s�O�Hș�JB�q�z&x�����;2�L�c�@w���C��Xh�K�,�(��m����cC�Y-e��W�/�gP&3��~g�S"�P* o��y�?��Y]Y)P�b�tW0ğન,��p�������YQn*�S)�K%��8��[	��!hm��|�Z��r��<���gk���4��dkf��r�W��wUV�@�WVUWۄi�����%	�A������(J��bk����^�����Rxz�pu7��[4�z�Ab:q���/,'b>�,��/�SX�L"!Ў .�*�T}��l*�dT�z�C�;��U:M\�v ���� �TBR"J��%�``����ᯐ�'��	�}\������B_T	�ț��n̖�$�B�{� �n�3�u�!}snf�H�Ч�*�G�:��uG�!��R�f�{t�X���z!�gdb�����qC��/���qJ�ƾy1mЪ%ESIH�ʵ��F���{�)�����Nm9���4���*g�{�&~�����vѢH�-z��{RxK�~�F�y k�3hb�q���M�lo2t����0)	�΅�Pj���f�/��ݦ�1: Z��4����\E���B��R��pw�/��74�y��X�*���U#�t-�T�4�-�sD#~����!���xIN+���� �W��e�ki��c�gv���2d���U8!dO�=YGK�&Ѽa`I#/��S�NF� HШ��֌m�"�Hw��c�h��t���JK������i�����������g�G����9�+@g���x��g����m�Tbj�a��_UU�~��g�gR�ڋ�h$���Q���#����r���_;�����f��gi�B��{��7�RCg[�嵐�ɍ��}:o耱��L0w(�������/���5�D�g	r��WTV�e����?#�k��^#l�#dmC��3�$uA	��J���
'�d��}�@B��
2LF�;#��B�W&��/)�ke�0�-eͳݻ��C"�g�v��ݳ�Up�#=LGԸD��%D��\>��BII!['�9ɽ��m[�A�L��z��F�۶�+�u�O`���RÎ�-���m���к��XGE2�d2��	Ei�f�i�-��f���!�m�o���֭��[�v��Jv�,�%��@�װ�����&n��ܷ�[�l���ՠ�GĀ��.�R,�D#��*Z��� 	�M��LF�$A�1�%�[9a��A����G���qFdq*
�h2�s�s����?��� 0G����t�U�����L��ѻ{/���J�4=�^�mGo��ҷ=���%B���.��j֑�°�H�z��-��-��ֶ�B�n��p�9��|WJ�ˁ�u�tѰtɖ	�AQ��KH��<3(ϖ<1�g��Rog{��ϗ
(+���uS�w��}�7M������)d�<�
%�XH�܁�� ��U���nb�>%7���e_`/������/.�g�p����h\f�`׀|{��~w]62s3yOt������Byv��*x:�����[��+S>�TYI��ǂ��`!c��2�a-C��A��鬗C �@n�u�����i[6Q���M�����̔$C�l� S��@<�X����;��^\N��R]�j��aVW��PS&�q%�S�&z[`�&��X"�lJLR�]W��1��MD��<fb5,Lt�8��Biw*IGS�Ph]�a+6�s���vˤ�c$@�e�"8�ٝM�Y����$Ͻ 7`��XPH���]+�c�p+���TR���L0�?�� ex��Ih��b�L �_�9�����k���:q\腽�Ч�-�0��-�I���h#sy9S���I��A�]h/�.�|�"���O��;`�Ԑ�5��	��ҳ2��D��Ml����l�\�+ѥ����z�,��m��0\R��0ǘ�d\nӖ�����$�c2�%_u�'��#=8^a���P�����n����l|A\�L�IG� T�n.]VH�-�ڲc3T�Φ�\�t��ɌN^#�t�DJ{�i'��T��}%V���ќ�`��}�TLH��7���>_\!��'p�s4o4&�/~�p�:53�ȈN	�h�;;{�?�޽�-�D�huģ3H��<1�!�ޘ%��yCx��4ŝLF�����r`ⵙ�z��3۷��:��0l����]��v���,��@Tf��]� x����M��/�{ʦ��BJv��.O`0��@3 �W�a�d�BҳhX/�Gx!����(�)�;
[� ��H)?)LA����n���F5���>B^?�N���A�`;��iY!V�/�}F`�i�w�Ǉ����]�RGf5��DH�c��1_aӛ^_��e�ڰi��h�Z(�Mj�Cd�D�c!tT1��iFDe3�R�9n5������v��,V�r���W:��?�U��������G^�T���X!�8�;��p4 � �"�&eJו���$��J�e��q%IqQ��MB�����|$��(Y͇dd���~6��q�,����E��hF�PF,>A���/�Ц/�<�u����������#�;�:�����q�;�[�͵H8%���t�IN�F�8i������a�F�YY1�ܰc;�=�[D���Ʒܜ�g�$��۷��apqb&2�I�{�DG����@�Ԡ�P�*s�б���m�6�o�o�*��e¾�k�s�3�l��"=2]!J-��G�4 G�%B=y�b�W7�*��!�(���9�|����0�7ɺ~'Ϛe�w�����XS�1�Զ��Է����I:�:EݒO	W���VR��6c��)��e��*[7.��gl��[��0ԲYH���t�!����~q4��F�K�� (=Ҩ��&�½��֚�(�w%5%Ƶ���-P����
������j|+wo���V��P���6�/�h�/���n�+h�J��X�V�|��Rq��MUe�B�_k��BMzq #����pk�P����}��:3	Rgk{���^un�s݅��{�����Y��?��� � 