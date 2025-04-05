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
� ݢ�e �=kp�y>d��#%i;N�-d� -A ���"D�DV	��Gu�����8 �)Fa���T�P&u�G3U�i����d��'���'�6J:qݷ�j�T��dY�4Q�ow�;��-��ho���������}� Ča�'Wb��`?e� �c�>�������D����������W�cU��*ЕE�P(��Ld��|�8��O	d`�Ff����i�
U+�[���PƆ���]�����>Bc/aZ���������	���H�!w�0y����!�:��	`0�w��!�U��O�2?��Q���wt�7���]�X-����<�C��N�oG��\6��'�z�Vm-��7t�c.���U�����S3_
�߼��^������&g�����4�6,Z��"����q�\�В�s����E�C��ݯ1�gb|�2:�q���_�j��r����|�Õ�fϷ6Q}�y��&�W�g�AH���)��0!���\%d�2xO	"���-�5���l�[��[z�EC�|��x��#��I@u��	�l{9{gs�Q{������'�b�����Z���RV+�\`b��fK}_"�z�6��|px�������y�\�����:���K����ܒ^/����\^��q�%H� A�	$H� A�	$H� A�	$H� A�	$H� A�	$H� A�	$��av��ͱ�.��-_[U.�Ք����I�X�	���j;�zj������f���k�]�rš�XW��3~�� �� ����7>����w6�gm�ou}�cu�y�h =�?������X���jO��O�XRk�ڵ�\'������oO�����6��kόվ?V;��á6{1_S�=QS.��´*�\U.֔��ʷ��Y�� �Ϭ=}�.=
�����S��3�'���]�?���v�U���������Ȟ�.1��U(�������s�s>�c|�7��;��Οq�O?s�Kç��d+_��}~嫡��.�:�|��������I�/_�\h����w-_��oqB�/=%�^�%(�ާ�\�K��.���;�r7�_�\�sk_ڇ.�]p��Ю�9�p���6L�>�f�q"XV�~����#[��~���ڱ����v���jlm�Ù����1_�-׃��k�k�6c��kk���[��V�� ]�~wm_�(���^�b���v�h�g[&�ӬH����j6��skׇs��(=�C��\�)�RlO,���������h�W�|��v��m
��k��n�t���6��-d�NV�-���ߞ�v���>������}[�}��W���m���y�=�7�}{��Am�`O�jZ/�~�%�U}�k���RcX���x��ڿ�@�������-
x	������ib��mo�n]��쩲�ƞY����"{.��)�\fϷ�����!�|�=�=k�ʞ�˞�Ϟ�f����#��G��>�� �u���xU瞐���+��^B��r9��������[!��|#zod���=�i�f=�5!d}���|� �4���$��=�7�7���.�Q�{D��{	��J��AB�v���+!����]�"���_'�"�^�]"��o��"��w�|��_!�W��U"�����I��M"�Y��Z�P�	$H� A�	$H� A�	$H� A�	$H� A�	$H� A�	$H� A�	$H� A�	$H�IJ���$�����ם����������ć4��&䇣�f�=�4��?��#�PW��B2!���H�!��HhR҇ }�EH��� MB�Az����ꬹh�95�[բ����[�S��,�R,7���ٓ����S�jvv��N�T�z�*�Z���ԅ�Zv�T��D�c]��׌f�jΰʜ���Z,s���K]���"oME�=s��V��i�s�s%x^'�J�����P*��
��bi�dچY՛*�����/W�R��0�9�༺��j[����:\,����y5��*s�\�~����ݓ���4r�<V�q�-�e����Q��y�ym;9�U�
��o�ꕃ�/a�Ex�;	-��x+ux�t�J���pi����d"E� �O��d�q�3!����`�J��W�J(��'B0��`o����@���B�Y�u��H}z����P!�:Pы�hKղ��E�!�%�i�
�`u���8K��ׇ�'���6�u�U��*!q�����UK!O�%�����m�IA��?چ��f��t��-���Qq!�h2�X�9��NΠȳv��Y��مvҖ3rL�AƳ�F*���<6^g���(���*�`i�FLѡ�{:�j�{;@	E��E>��/"�K����-(>�����߇�u���+�P'�ĖE��܉+��P~�$dg�����t)����PR���Q�⤎rUA�Tɗڇ����:Fș�Q���r~����+L��`/��=���Y�b4���Ѓt%�	 <�UX��n��ү�V��_��v��� <%�1��������]`�������|D�)��/�s�N��q�n�?(�O���������
|X���xY�1��)p*�ND~O��E��zQ���<��o	<&�	~�	|]��������?$�����?��M��/���g~^��xY�&���_t���'�sb~;D{��~F��>,��c����.��+��x�#��[�Sos�����������;��o�x=���Ç|xʇ�ɇ��������O�������;���>�ۇ���I~��}���O��A�t;����A�A�CJ@���.9.3���4nK�j��pˣY���t�p�$#
i�U�EI#��V���	�?v9���������x��F���2G��Y��Z�+A�"�i�J��ؖ�DK��M:��Q���qO4ӈ}6�]��GC�D�R ep�D�"�ZV��r��x�|���@�"ft���c�@���n˔87o$O]p_�7��.��h+n��Z4_�����j�#�
j}uɑ�vV/۪�e
z_SI"�T4@|`��B5������ g���~����}<@�}�}���xoo?���b}���_�N9P�_��,�B� �Ld��|�8��O	8���.:_._0}}-�?�L��?��sj�``���U�K����#o��<���UT�>erFK���@�a�5]{���;��$��Ufe��N�Z���L�������3z���eQ�� � `��dc��]���)�F=ki��ϽРj�*eO�O�i>��Z�
��9k/ǧjF˞P�&�f�҅���`w��;�d`O�j���T�wQ0���S I��xU�X���\OE�K��6��L̅ԩ2�R�����$����Y6\��D�����}2��x�'�Z"����^w�T�E��2�kt��F{Q�c��������O@t �|�/6�` > ����`�(9�l���x�FM�,UrzEϩE�|�f~��ǝ=���o� �O�o�Ya��f�����2Z�%wd4�l2�[��J������6���-�kv���Ődǽ(�/��n�v��"�Jf�6{�@����0�d�z���a��Z���Wx��ivr��a�$�"���D�dS�hڰ�zh�7U��
v�Gk80�b�w��{����ׁ�t�H�3`����a���^� ���Z ������7@/��'�'���@c�'0Ï
U�U�����@B������FFJfޘ�2�$c��_,������K��%��sJ���F�%�*��l:������ut<��ц�)u�����]?�Hx1���/V|�Yʾ0K����`_��gp �_\��k{��H��C��&�S�9:r4��La�Q,��\��G�^�4R*53gѢ�DM�%z�,-R{^��qQ�)��e��h�t#ܢ�KM�gT<U��)���I�F�㼏��a�ڇ�!�*_��Ow�o����"3��e����d*�L��Tz*��g~�r�ʨ:25yx��l:9���/�f,y�x*�0�ƕi8��9NL�0f����3�TZ9<~|y�0��.w��斠$�f5=5�<��Wʚ=ߺ%L_����ʌ���\����bL�wz�7m�
c�͆�i����n��d���	�2oX�\��k�T-�Y��ik�����n�_x �������@������;��xW������c�_�J;J���O���tB�����P7^#u�������LrBU��4s�p�]H�ъ��Q�s��.v��F���c�E�2�al�ޢ�� �ڔa��K������ȑ�D���/�������J�ֳ6��4oҋՂm�:eg䳗.��y��lj^3
P��T+Tt-�$F�]A����3��?-�*:���N�>���vU��nE��,C��\�	a�s�LC�'���rl��P�<V3pO�U�LcA�D��	a����ؘ�^�O�6c晽M���3��]U��|��ܢ��3i����D��D��>-�]j�i-dO��`L�����Պ�ɩ�VkUn�M�eWs.�VR������^n�Z����ku|���a隞Vl]$�u���.u�Tm>i�Bw}c&�`�Ѯ���E7���y�SDt���������h�2��o�eC�@���l�Z�+�&j%lp�j���Ʉ)��r��B|AG�̦��< �~@�f�G��OݼQo�{T\�©���-3��?)��vxi�h?Wy���k�q@�`	|��cڻ�� W�ʒ��5=�L+���0��mrFI��:_�O+#3Si�:ˈ��������QxJ'y���w�`�p���k��	�x��N�q�U�O��m�E���s"^�(�����V���(i9�u_������`	<g�hʍ��:�*^��ۼ���#.$����):x�2$�9i���atQ,�7�.��5�̂���2�u�M�=��U�v�%� �j��-�i	�64���S�FtF~	�	Dw`v�����@��ߞ�l��4"τ�qb|������3�N�#��r��S9SͿ��Bk���~g��@�:�"L����>���@��Y��\I�~��]��Tɲ��&���є�]=tFp���%�̓��h���~�����5,��b�Ф��$��V&���;s��@C�ܩU��|�7*z�u3Z���Q^�p}��~-EC'�LB+?"&Dx�����mלF��29f��5��/�[�)ܾҴ�{N��)Ve�J3�˜��'h���4�W��f^[ЁAF��ppVJE6C�7�ڛ���������E���Ts����������_�-�&�?���^����X���� ����K�F�Q1�EЋ��q�W,�tZ�C��S���tG�"�FU�_#-V[W?�L|�&�tS�(D�9Nx��
���q���k��lCf5��+��
%�X4���ʹ\a[_�����q[r�h�H}������'6�l�R�oD:���ZhN�{�:�e�-��'��7\Xj�4��ެ�$�L� x�Є�J<���w5ˌ��9���p= ,���4�a,����}M�ʣ,Ѝ��E��h,�bMZ�;<>9Z�x:9yDA�c���#�������s:�!���ㅣ� ��0M�g-��zB�@���	1 ��Xn��v�I+I�[�NwDs�[��ߺl��iكnއ��vk���Ĵ�Qڤ�LzV�\9-��:]�Nzz�ܘug�p���퉋��3~`��*vx�x	S�O]N �+��f�ȃrw?=~�2�{j|TMa7�Rc��Mm�=�J8[�.�P��Ca��T��t�P�s������׬�}�M����>T*j��/6�/a��(Z�V���`:7hA#ltq��Hi�|D9�J7�r����!�C��M&��S��e�����2t��uvrzv|&�Pg�~�.\�	^�?2:c� �  