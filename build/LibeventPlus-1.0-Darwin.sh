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
� $��e �=ml�u{�(ь#2����ON�}dy�ݑi9vx"W�U�8�*��X-��ȭ�{���Ĩ�ta�$HѪ@HӨ(�E[ˉk)A�*I�
-Z�A?dC	��vd���f�������Q��$���w3�͛ٙ7�yoN�Ӎ��=~B���� �#���+����C�}$�Kd�^�>�bI-�P
�\ɋ�2���(�9y�`���ܸ>�-iF)�-{�w�����n��췯�@$r@"�wx���������Bj�������=��ph�0<x�^����Z����#��D���NbbT>l��I�[-����X��~�"l�q�q�
�s���[_C��G>�p	�o#�
�3B	��AG��m����$%��"���e������>����s/ ���o� �����a����(�������L7�!������b^	-��r|PQ��c�r�K�4�l.�O匒n�57��y��ʆ��
Sn�CE�4ʋJ���
zI׊��H��乹9w�s��\ASSr��?��(s����mI�T��������?Dg���GK����f:3z�v4=�F@x�)�k�?����ّr:�<#ayj:�s�HģQĥѨ�Q���FIeU����*%���jI3�`m�*m(i�9�}j:�&�R]�����[�0��EEM�t@=�q�>��Z7K�i)�����;���-b�~3G�;�8wl��8T���>�%�q�k�����P��®�U�{� }��T>ߛ�������NI�J��I���6�'������۳�.-��N�lG:���!Q��<���7�Z��ƲK�>$1F�f:E�O�@˥�|I)�sv~����������K�� �J�8�iE5���edr��9ۀ��2���WmA��E��}m^��a�������q��/�=�I���vU;��W��/��ʭ�=����~>(�����<�=3c�;{�s��rklM�5V�7nP�X�E(o�U��ξ���7;Y��_��i�b�W)o0~k �l(�+��g���x����Yʷ�a⛁�ב�;vvH�x���cm�5~�����\a�5^�KqVw�G��������š��L��X孱��u��2s3S�_���|�0��5�fE~)�&��W ��W�H�V.��\Z�yi|M���d�t� ��uk���P��k}��!��CkP����&�׀s����z���ҝ�sW�}w��O(��|�f~����so��ߠ�?W��Sao�͗}�?��f�{M't��+P��߅�7�����պ
]�!��x�/|��2�={K�x��>_��/�v�G֦*�um��������w�1}��[k�"�l��k�/�� U���S�����1����_Gҵ���o!�C&�p텀��\�]c[P*�?�ke؄+�k��=����r�"�{����/�۷���}hOo��=Hk=��%���A��1��\�B�?�_E���!��^��N�w�!�w�'��~k�v������/��G|�߉�8삏#�m}V�/6��7�w�Cp�#�Q|�.����xt��D�؍eߧ��t�����m��>�{>�~z�=]�atW�g[Fލ�FG��H��]���1��M��z��%|���o�!�������]?Э"��tǁ��}؃�Y���tKttmoq����]'҅=�����[��w��Pt�@7�]	膛��=�C����ő�Q��@7�t�t�aO�@��.t#�}:>�v��/ѝ�)�O�
����~�ھ��m�(==n�A�8z��9����Ap������ke:>��ۙ.	����� ���]��og�	��lI�� ?"IO���+P~i���1�L�س��1x����0�L�����UA#��+>���|p���Y��Z�#����� �(�/|@��@'�/1�����B;.����-L��XEx�0B�PBH���^@����a���p]��/ ����u^��Z����£���?���j���bY��A��W�T'Ҳ�'���?݈��oZxY؇������^Bza���xaoJ��1����M"^��ױ,����,��s�>؎e�?�X^E�~�O�O���4�œŲ�wbY�Gal/���#�ժ���6��|�^�Y�e����X˭6~R��<a�߰�l�߷�礍�%�k��;l�Y[���r����m�}��������+���bh�hxm��x5|��p�l�n���b⍂���+<�#�b�M%C\�כ��x�iq0��`|Մ�[ψ���X+�\I��qtE7l�,�L�ް@�\�����8���Ċ�[���b�&�M��żZJ-���iU���uCI�*NWԲ%5���$D�##1�C�	�X^Ԭ�Y�4wv�|�Azks��;�Շ�Ly䛚Oq��=�����Y���&��7����
Ŝ�f��/Q[�/r�DY��T{�6_0� �"_ �w�/x}G�m��|I�t�@������]��m'��
=������yS���p|�z�w���:x�"8�Z��a{�fcm����Ov$����Ӱ���Z���f}|M����5k4n�mm�fe�3�6�Z�2��B����3��=���H6�b��#��o��]ِ:���N`v���X�'cg��9V����w�*�����*?��}��c�������9����TMrP��� �6��'"b0g3�k�Hu���+�a>��������#k�6����Z���~ˬ�v��W�KO������:�&�_�_3W�wW	��Ǐ�<�����չ?��d�)s���K|�A���K	���q�������������� �^M�vLvnpٹ��se�Mv֛���������<T3m�k�M|��_3W���vy������9��_�oK�>\���muɢs���ɷE��m�ׯ�s��E����e�{L�o��2��M��>d.h�3R7�Le�v��Gn}S0���x��#Kn���Z�.d�_�Y�>����+aZ� � c�Y�xaã0,��X��|���0����!L��E��-�#�#Ϻ�7�'�|��Ż���s���F�-�t��q���{��2���`|�~�.�k�O�����yħ]���)_x��sψ.���;�AG�){0O�𠣱�x���Y�{փ��S����|�U���ͧ�n5�G�)_h"�C�)��;t4�"�^���o5�g�O��t�<�h>��mN7�A��)H������<�=�AG�)_F��]�y��(����go;�)�a������������he���ol���y���m<���6v�n�yz΋A���ڶ�<ȷ��(� @p�����|���|b �T܃�c��lpL��w*o@�Ӽ �C���GX���|������'��0ƹ�^{�BOJ�,�ꇰ,��u,�'a{��~���n������WEza�JXv���?����i��	R�vgR���#��+�E{���x�?��%�Ҟ�ű�n�[Ն���m�?���q�O��_��E��-$��`�KĎ\��z]����@�Z,��Ƣ���-j�L���y��V3���ˍ�T;\�v���5#����UN���;t~��7uϺv󸹻�n���n6�^�ư�=�9��l��F*[Nk��7����_�@dp������c���=������@m����`�����~�w?��z�Hk�����<�T�����P���}/J������L(��� V��vC]Ԋy5���ș�v���"a��4�6b	���v���)�nB�>a�t0W�KzV)�R'�ޔH&]�r�9���l,���SS'��ARs5�RNOw�0�D;[y.��jCc�t�'	L�ZΚs�}�=�1��q@=����������DsAX1������?Jr`W�R��+�zNT�����t�ԲZ���Aߡ����D�ͪkk�):��(�	�>L��u&�Z�ҝ��<,%W�s���N/��s�X�u���}4�����300����@��������E�e#PE{X��l�
i����E5�T#;���D���[w-M��Z�UV��ƚ�<��4oRFkW�����u걩��[a�VrR�4�c���d���e�Lt�l����)0���\��C �!%g(�b�^��;Du֡����]o^�׌�x��i��&�+Bf$�ӅO���M2���[@&��z9LI͙�:�
T���v3��]�I����/���z$P�?���Od��?���E�佌 m~��B}[�_�����	�wV6�������~<.�o.�䌌>�˨�P8�� ��P$��:�ݏG��Ŀ���D�����$��7�N*��ĊE��Sj�"?麓ˮ[��������ԝi����~l��?�������˧}/9�4N����H)1�!�b��Q����~��@G#��E�Hɢ�L:,��I#w��4z<^TKdI+����'� �h���T"��S�rLNLǦ&I��r��1��f��S���|^x����id��HFG�$17#�x\�%��T\N$?Ax��225y8vd&MB��dr�Wt1�|�3=�[�"��<��*����Q%6����#�2�<2="O+�7����-M�FX�&�}g�������~����9���R �Qa�@�����I|��uN�6�RR���Ұ���.���i�9�cA/�|�8��r6M�\�^r��_HS׼��s�����?0 [��~<f�=��x{��	T����N%�X�V�&M�~2.OO�H�P#.jŢ:�G��qEN$����qx�IJ�"�7�zAK���Y01�E��̅�F�0�~ڮ��d}Npœ�e��r >3=f��2�����zl�ϵ��r%-U"꼪�H�b9[��Y�����CN-�r��،�g�B3��-hjzߒ��Z�h�jhԟ,�
��Sx�)v��	�܍D;��1k�=�x@w�!�IK���E���x��K�Za��BB����Û�����F�,�׀!��b��ˆ�|���2��dB~z&:�6��CoW���h�;���X�T���R�`,jkr*�V�����,�
�1H��q�و�	?���Kk��^����+�ai�7�&��Q�N�5�+��7�f�]Ս����z旜��fGM��{��U�Q^s���#�J��s��]�_�l��h5�b�:8_.iL�R�	S���p9D�KU�l���� ��&��ϥsͺY`�8\���hlZӌl���J{�;���M����V�δ�t@�`	l�Ǣ���)� �²��5��C�H��7}F����Չ�XBIN% �t��@��Җ��c�Q�,��<�5�o�jo�3QG&q��I!|T$���/�g+
E�ݘG�3"p"�g[�N�xNM��s���:=<SC!6 ,��,��N��:$���&Ñ�nH�ySj�)�i����k�)FŊ�����1E.�YM5�yRҨl��%��Ӌ�Et�,��ӛ˓�mT�ք�O�{ԣ�3ˠM����L�T�����D�d����c���<�[k�d����6�,�4��,�Q�Sͯ"�Hm��>n7f+�� �0>�a���)��ގ�۩1�jb��i�ΰ��%$�+�9�M�"�!)ۻI9�Sj/�{��*?�ۀ^^dn�
<`���n5���eC@ˤ�tlgZ�a�H)wR,�����2,o/��jf��I�56"v1u�����R#&&�͎���u���v�4���LB�o��a��������'\NK��(�VJ�/sZ��:�ʏ�O�y�o�%�ip��݂��"��"�7]�_�g%:}��`��*=��<������[]��M���a�wj�����?}���V���?��?�^��SB���V�����b.��\pFZA-�ꥁ��Q.�0ҩ�^��O�)ȗm�@Q�/�֏p4$� �)�ǩb\A�kنL�����fs౨Ĝ����5��M'ݍ�EG�F�T7�"�FG�`�؋�ʅ�)f����:��[�X�I+R�v���`���5�@հδ@�FVl=�LM�;4.�us�ԓ�}���	G��;\uA��4��؜Fu(��5��S��݀m\�����I��ñ������#2U��Nh{ĈE��d�4]՘�X��<�Ӏ���^��Di��6^����	<
�~�����HB����utVt�;o�oy�����u]|�m�����i�Qj�$���-!#�J�^�{=H˨��f��E,�S\q�x[�"?�&د��k�U-?u	G"�3+1σps?��<�{*6���0z�>o�M��Z�J8[�QT��C~{l�.��dT�\a�ؿj����"���饠*A��Qa��B�J�������AAsz���xDJ--��x�6�C:���n2Tԩ�}glU+$��
�ˍ�239=KFk�#&��ڄo=[�ֳ������ x  