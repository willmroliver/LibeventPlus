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
� �re �}`Wu���,?$;~�=Q�Dv������$Kck-Y��p�vg�!��>d;�T��`Eq1%@
�4-.䧆0�9Ic�?%����(��4ABbh����{��cwfW�ò����9��s�=���̽ӭD6ڦ��t:�++�U��
��\��.WUU��t����6�r�#�T"鋃*��P(R��xv>`-�`9�x�����CJw��-�ɑ�7�J���8�GUE�I�����.c���&8�X�������M������k\�NA�At�VW�V�B��w���Rp�T�k(gW�$���o{��E#��|�m��f�Fm��n��C�	��g@�"�� �~�G��xg��#^lcx+�� ����ĕv�m�q��"~���A�~��0����xq�Es���1����Qĕ~���a�B�/"^Z��E�1��=�����0��o#^����O!v1\Z�p�2�/ ~t9�/��A��
�7�d�⓫>���g
���6W�����%Hn�V�� �V$c�;��rR���d*!z�%)���"��ۗ���Fc�h$�DR�Su����HD��Ht�f�Y� �H*,��J4�$9!*YY�A����mN̞Eu0�}�^ѻE�6��T�(��J6��۫���kJ@��(f��kP���:���>_(cvA�$�nP�N3"��!"�F[+	�>�O_�z�����n��I~
��ؾ�|q��Z|�@���v
ż�� �
t9�k�;����m-a2cY��]
z��(�^���7ݴfj�3����EMk�碤��
D)%H'ajr�ª49s��wj��Jg��[��>×մ��^�B�Ϩ.���$�@�n��C|��~�5���d���ڧ����VJ<��I����WO�2��a�yuM`,+���6�j+:s,��p��R�ڋ��qb�0�ZfuWq���őŴ#���F�}��K�i�f��f�܉��/�Yd���l��*��,�^O�u�d`e����P���Y�[�w�αv9^O���Af��v��P�mP��I�U"c�6+tu�����]�	����~�N=���z<�ŲR"
�|=b{�y�W�2�[-�-�]�,�z�
T'�BXMٖ�}��"�@�h�=��"�n�ZT�:acL�I�ړ.�/��DH�JI3)�<�0{�a����?�Ji��}���31�d
��}|:t�CM_
�{��en|N�'t��:�jMM�N����5̿�r�Ҕwr�?k���d�j�D��k�,_���љ�i_$o�t���^�)R��6�
�=�3� ��g��׫i:�W����h���P=hXнbI��k	�L�r5V��A~)3W"2͆���f�Y�p[00+T4{yv(g��f�r�(�hl�N���fw��B]�%'��ڝ���H $^�FS����$��Y�R�0�0���l�K�lF�1=�؜V�[�l;��ƏgG���	������CHל�(b�J��S��d�]�m�.��k0�븍l�]+ԦZ�����Y�ݖ�y�>wR	�;�;�<����K[����F=e;y�n]
CK����&�~�Ͼ��}�1����U���2nW��0L�Pjar��' &,�^�<\�W�	��Sʥ���3�$���M���7�1	�+��L��W�������*'~G�j� j����~1���w�l���o;����́�,�K�_�����*G�����^(�I��$�C�ّ)�We�<����6[#S�_�'I=~�$���1�n�m�7�rJ�ɷ�,�a#{ҭ�*��?Y��cn���2�ё�iy��'Q=�)��r(/O�Y�nIIRK��^�?fy	�q7ө��f�%��+�$ɽR0����+�pEQ^3�׵���f���#��噷��4�)�߻�}����hz��.��ÿ����6E�_g��ϛ��V�4��LӠx�i@?EM��ƛ4�?Q���?[|�3�����hhEW5�墳��k(��t��L�NЫ���l^�^N8?SzWp`������m�~
�;�Tϰi�8�<ģM�p%�����o!�s@<wG�Y�j�>�2(�v7
}���P�
�����Qc���vThV�>Rci��;�I�-�$o	��k��Z�i��2��s�V��E���h`m�4���c4�b]  w֜�`�	�y�s<�A8!�f���
��)�ւ�;������7�&�O��E��R�3�`�(��Qm�!C_��#�?9Ao�l�0��5g;^�wƼ��i�^��'ՠ����=4�»!�Q$����G��GW�	�Ǥ��e�����or���<S����_/*��^��f�&����Y<O�U:��ݢ>��UK7+��ZF�� ~�����C�q=�tCL>F�=RZ>V��Q�N����8
�0k8����.���l�+��u>�����Y��h�ʫ}���x=���K���BYS����b޷�c��=������؋����+��B�������wg��@����}g��>��n�9����|�����lt���j�������Ʌ>A��n�F9��|��)+m�^���&8���m=�i�/=�=ɪ�NvOi�oL7d����>��=N����pQ����!/�{_��IC��I�@'X}�h�p�I/�j�p���z ��='~���1p�v��������Pz�? �$G �+�Y���az������V�G�L꨽�����Rj��zB��Fq&i���_&���tLy��"�8PG�M�|�^<״���t�I���yt�:w��8]�N�U<�uj����d�[�Jȡ}�fJ���ᦁ��^�����?�7-|������_/�9L��qɡ"��0�y�&b��Ő-��%�7����x,�`�*�B'؉�*� �/�]��K��p�P)7P|_AQ��.ba����0?e�4١����\�-�}g�R8Do�X����0s�V��k��\�X��r���s5���}�8k��#�Æ�$���hK�.%�����#MW�شT=�K����t��o+�,l�v8�uP��m`μ��A�&�����Y=8�RH2
H����7]�d,G�R��}�1:������!�1�VF��:V6R&���b���nFz'M;�:	�����9�i�Z{����XtD}�B����B����+P5�X|����o����x����Ĳ��ơ��yB'o�������ap����$7׏�T�T��ˑ���ӏ�Q.��`�%�(�:�đ,�@`\M�?ė��肆8J��r�2�z��v��f[��=y�����R���Kä��*�8r��'���ݰ����kG����˥�o
̵�	���7m��6n�%բmm^�x�����lݒ�Qz�VI�s��W���2�v�#��R��ɟ\ ���R/h$�K�>D߫���S/à2��ת��CX���v�f���L�h���0�$3�(�4
�.2��o��Іܣhl����&�m�.��Jf��Pѣz�?����ux#�k�(��#jG�ş.�tD��Ze3e�T��;�����1��B�h��oR�1U�Ami�
��i+�.�/��,q$��$�Qq�d�b��Ά��������X720�ys��Ү� �	�_,����
��0�ӗ%V�EԐ�Լ�����6�5�����Y}jƠ�ZX���ζ=8����������R~�xz�0H�����g��箞Wa�
+u���w��m�����y/�;������j���l��??e���slO�k�]�Щ��b�]�������'�?�o#��>�Fq�	ݛ�C��A=�����H?������A>/И]�G����K��+0=��r�Iz�}&�!�;L�Hw�Ћ�2\gB��A��堏"�Ԅn���:��e&�.����a��Ρt��b�b�PUi�� ݋tS�Dz�	����7q�X`-_�A�C�
���H�`B��f���A��A?��>��KL�cH7��
D��m6��b{����
	$&�ƻ�Ǉö�����iX���"|�D�̂/��g���㛹���g��*�Ey1��P�c��J�
�F�>�]���[��a�w�	���{�j�o����W����ה�Z���<�Z�o'�Z�%������{�z��̂�Y��}+���|5���/+.�v�|�|7��y� ��<����w���yV|� �H|s�B�@�
�
�VZ�u �X��0�̃�l-�N�r� |k���o ��.��|��ɭ_#�	y����Y��C��wr��'�� �|_�ȳ�[g�
���v�W��J�}�U���c�U��ߗ���o�W��*ߵ ��o�U�U��\��7+�Y���J�g��h�^�#�Ŀ�/y��M�w0 _,y_/�]e��8�u�!��ۙ�����C��k�#u�)��yK-�]��++����*�7��Ԫ�./�/4���2�������}���B�~�-�^�:�ނo�"U���T,R�]c��K#�2�i�Y��Ejd��ˋ����|o/Rۇ�~k��l�o�b��M|��j<�*�#�U����]��Ϫ]��8��X�D�g��oO|�%����%����K�����
�<��O炐��7߂o��A��|��<��|X#�Z�G5����R��V�7�o���e�A�B��|�E�<���$��Y�=|u��������*�9��m��Ū<+��bU��-�v�N�[e�w�y�����_�Y��^��g������,��.�O��e�~Vq(��g���2�~V�>��g^[��w�ߊ媿X�?�+��������oM�x�4�<�{��<�[�܋��>�[��;�����Cއ��X��!�Z/y����yV|�����C�F��:w��A�s[�=�B�Ϫ}<�B-o�߫+��+��h��X����Z��K��+1�|V���V��m����W�|K,��^���z[K�w>�o�*�j�0�J�ϖ�o�Oo��{����j=�Uj<]k��b�*o��M�7�G9�7�|�X�=|�����7�G�N�w�Q��j���X�u ��<�>|G���Q�;�|��� |��݂�
�B|7_i|�s"�%|j�������-���΅�b��rʊ}����F�O�b�?����Ϝ�)s�����g�K�����'�%#�/ |Ԝ�U��E~>n(�1�''�F�{8�Vs~����!F���
�7�O�����Y����G�ǥ��8a�O�W�#��8�	s��ۏ�
kY�/YK���8	�~p3�_� ��� ��%��x	����k8�[�����>�/��;~��W�m��; ��w�܏ ������T\����j�7K w?�?>	�E�%�=�&�o�|�E��_$��)7���U��J�o��٪ ����Wҽ��{��{6.�G��_ �B��!"p��+X;H!�v}���B\�C�:���������
�����c�����2���c��/���8�=�[/c��F���
�
���^J��w��R�����7�z����uȀ�D�K�N��.��w	}��q#`-�~p|
�?����׋��l�w1}������v�N�+/f�.���������������L����;Ȏ;��w	W/g��7���nǏ��v��gH���]�� ����!w�Sl���U1�o?*�8�7$�W c�,�Y���8\��������i���3�o�q�㓀����W>X�,��,<������L߻ _"z��t��D��C�!��S��-���:n[��W%����@�-����䳘��Ŭ��bֿݻ����Ŭ^�Ŭ}�G��7.|p�m��.b~��"�'��U��y��G�&�ϓ��UR?0�<�=��&� �{�������0�o��&�����&H:��$�/�|2yv�O����?\@߳s|���A��)R>�/^�wD�6� �X�o-��R:>x�����| �%��'�e>��A�g ~����|�'���Iʉ�e�x-���M$n�5����$�8�����n�3������?�����	��〿��� C���
���0�6�a��i}��A�/ډ}��oa^���a�?�� _�3��ۙ�/ۙ�O �3����$�3%�@Yȫڎ�����S@����j_hK6? ����F�-u�c���}���8���4:q���Q@�!�YM�9|5���ұ�(q���Q@�!����C���]�u��
���]����ko��ay�`�|�������܆�Q~3^��̫D,>���jv���P����?�J�?�_�u.�N����9욟g5xI?��x+_��(�������nG���O�=������w!�� ��go�������\Ǯ����7�}��V�����?�ˋ��\��C{�nD����*����=L?hw;���3���]��2V_��1�o��<�`%���G�u����І7�k~���Nf~��O��5?����o���=1~?��]��z;�|�������|��܎���w0}��_��k~���X?�H�
�?���Xy�0F,�����ݸ
��~��}�� v�����|�wa���$L���-����������������������z�?��G}�����m���ϧ��'?�ۀ���s�7~�M��ϗZS����R���1^���J���;��gt~�ݮ"�_���t1:?��^���w��7�/Y��C{6bz~�ܗ1=?�����y���}����}o0}1���J���W���?O�u���P���<�oaz�����ϳۄt~~���w�����Z�|A`�߻����kA{`<{h=���_�W~ޅ�+~~��~�� ^����#~��k�~�z]�7X~	�?��c�'�>�،���s^���^����?���C��W0�v��� �ן�=����e��<�b����o|�1�;���6�؟<��|��;�X>����/?��H��<���χ��{~�2�_`}�)�/�<�9���_w#??oa�����Q�I��!���P��>{����n��.��A��z�&�5i����[��
ǤDҗL%Lx�AR-ɾ;.��4c �[1��D�?I*��,��cq9��Ŗ�=ٍ9�����
E���i�h������Q��3Q���d�S/�T�Th���N���)���UU
ɑ�do�ˬ�]�4��n�34\ �� �Hl3����Fߧ۫��e�����Q2�`h�ȊY{+3�-ziѤ�q3W�q%�WR"J��iO�\���!������p�]����^'Ȧ�D2M%c:�
t�<�QDSӒ���>�j�}j�ԾY�!Y�>��
�غ"�j4E�j�F�`�Z��ބO;-+��N�Bn���^ɗ�i�gؕ�n�)�95b�}.Q�zfU��[9�N.�M3���I
Hّ��`V������gZ]aʐ��S�cG�@4�
���DRR�0ɣ5�L�$�fu/�TNc8/�"���h�D�4�6��0����X[��>!���(y�;pa ��29G��/�����=	���f�{Ez_ZLa5�b7k�Y,����ڗ���z,���O2ۚE�Y�E���^,+�>�h���,щ��W4�Tm�G�ƅ� �^]]g�����ӭ#��t�<�K���GLD���7�j��+�畵�R��u�[�>�v���.L�u���؛���s�s��+E�	iTnq�f㈆Ō�q�����L�I�̝�8�����S��tjT/s@��Qg�㍬�&Q��?�n��?{�<��Y��@��Q��#��F3%�%IU��%%�J�'�iY7�NI�FR��R��T��)v����o��>Z�[<-bFߞ�T�[nkw��_\[ɹx�Ȗ�[a���_kCDM��Y�̾Zc�����ݙ�Ǖx�Zhˬ�6}=�f]�׮�{p��� ����+m�64�n-�]�w�k2n�*3�Ug�)ϼU[�q˝y�UU�),3a�-�+˽Zwf��[U��,3o��.�lϞ=RL�'�_�l��sf�s�l׸6����sU;]����p���;��G������*��UH��e�X�,��,���_�O�_���"�3. �,�|���CZ�_~_�t��z�����VRޓ�~��Bi������#i�'N���������5�1�;�r��{���{�?6��A�H�w���F-}��-N�e��>S���N�$ɽR0����˿;-`���L^�BV��O�<7�#�"���#I\�Δ�'�q\
��
'�d�
2LF�;#��B�W&��/)�ke�0�-eͳݻ��C"�g�v��ݳ�Up�#=LGԸD��%D��\>��BII!['�9ɽ��m[�A�L��z��F�۶�+�u�O`���RÎ�-���m���к��XGE2
�h2�s�s����?��� 0G����t�U�����L��ѻ{/���J�4=�^�mGo��ҷ=���%B���.��j֑�°�H�z��-��-��ֶ�
(+���uS�w��}�7M������)d�<�
%�XH�܁�� ��U���nb�>%7���e_`/������/.�g�p����h\f�`׀|{��~w]62s3yOt������Byv��*x:�������[��+S>�TYI��ǂ��`!c��2�a-C��A��鬗C �@n�u�����i[6Q���M�����̔$C�l� S��@<�X����;��^\N��R]�j��aVW��PS&�q%�S�&z[`�&��X"�lJLR�]W��1��MD��<fb5,Lt�8�
[� ��H)?)LA����n���F5����>B^?�N���A�`;��iY!V�/�}F`�i�w�Ǉ����]�RGf5��DH�c��1_aӛ^_��e�ڰi��h�Z(�Mj�Cd�D�c!tT1��iFDe3�R�9n5������v��,V�r���W:�
������j|+wo���V��P���6�/�h�/���n�+h�J��X�V�|��Rq��MUe�B�_k��BMzq #����pk�P����}��:3	Rgk{���^un�s݅��{�����Y��?��� � 