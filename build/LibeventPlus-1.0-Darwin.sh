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
� o�e �=k�G��}8a�|Gx�lr�e-������c�ݱ%�E���q��H�N,��h	K�aଈp���(�Q�g8��C8���09*�GՒ���B�� �׏�F��>�ؐK垞���������uK�4��p�A��H�|��b(Ls(�DDq`0� 1����P6L�]Y�r�BN�WK�t@��n����H ��RcZJ�Wu3�+�����26]�`0����8�?�
H|��^����_����	���wA�4�!�^I�_�GdyZ:9��`��d��˲�.�u�&~a��z�x���;*ˆYN-���J��]�߮Z��tZV�jєM%���w�E�&�Y.����5=[p�ߝ�߃6|3~�a��<���#�S��0#h���KH��Y�-CK~k�0mo���:�#|��'�Ѹ5�G�v�=,Y�rHC�nt����9��D���t3����3��wB���)�9�>�����¿�LFK~H}�^/��s�K�똜x>r�g�k��/����<���!kL�0ʶW�w2��߶�
t],�-�~b^D<]������\!���\�D&CNJ�P l4ۘ�h����]���~�[�!m��6���s�P��~j�0�|�]�M��]��{��8p���8p���8p���8p���8p���8p����L��߱��v�*˗bU�R�"m��+��c�o�*]��_�~��{޸�L�|i�˗/_�(FY=���7��8��c6��y"��g���=��I̷����5�Y��+=�?�����G����*���O�H�_����_���~�������'���l�X�c��-��g���ci��
�*=R���H_�V�C�SP��O��]:��:󵱪�D���=���'��;p��4�5�,_�ɾ�"{w���P
����Xu�i��s���,���b���eMuvժ?�ę���9&[y�sf湕�{Ό_��9#�����ܗ�K�O_��g�����/��
������e���S���ZY/�V�@]�f���|}}/О�$��й��=�t�Za}#m�ʭ]��f��[;��B��b��&}��o�Yb�Λ��V����f�����׽�Z���Wf�mmbՙ��m�����+�_0�j�����2
�^�٫��n���2Z����	)�֨q��a.?��X�n'Pz\m+��FEzv��:�^�X�u��K��Zm4�+b/��Xި�ɦ��tl���{몎?[�ug��`b{1!��9t+�h'��kS�Ԃ���ۨ�]���n�(����A��g���{`����;Ȣ���c����M�7jЧ��N��Ϊ�n�e��{����D�l�U�"<s� �zX9����X���_��,v�����F���㕟�O?����a�������ޤ���A5ޅ��W�ݰ��-[��e�H{O��#��uOH_��������k����bng�e����/����79��^�|y����ߟ��}�m�w�{��Wi=j���F�����n�5{>��F�l~�����L\֏�!k��6[��!�vM�N;.va�&�V}�����a�h�W�<Z������?B��5���"�{�X�XX��o��u��9��ɳH�%�|y��<ϐ����~�� y���_����#�� y�y>D�� �O�����i��y~�<��<���{���U��<�ʗ/{v������V��s�U�3�[b��g�_��������#�dcB�w�F�#��ߜ���!_;�������T�Y�"6�{����@\���6����X����w�|˯cy˯g���/c�n����`��w���,���b�^������f��,�_���с�l6j8p���8p���8p���8p���8p���8p���8p���8p����	�@���#��
�������('���J|�NC��y� ���7����=��������G���CZ��MH� ���(�"��!}ҳ�P���4�^H����v��g�M��I�(�U��6e2�R^�S���\���B29���)uV��b��p���\TKFAWr��$ϋ��03��Yd�7֕L�zM)�*g4�H���"ō��l��*�9Z�XSRՆ�YՔKe]��Y��� �SM���H�+�M�mqi����^V�*����B^,i��3M�SfԜ�j�bڬ���Ʊ��v�xj��PsY9�RJ�T�`]'"9-K���������{�q�^оĉAS˫�JNx����v�,���Nx��ӓ�UB��5pKZ��85#ql��T�,��s*���)Q�&�ˊ�]��<fU�����0^��V��죞��a�-����zB��$�.�A.`�Ҽ�s(����KX�"������&\��fS҄�A�%�M%5_�W�A�f�J�� 3��G�zF�_{�)I�P��紀�s6Ʊ��$��m^�	ԝ+`����#A�S1ˆ$l�������>ؤ�P���C��z9ouTS����AB�2��I*%��}^��^�}Z�q��x�����y��!�e�� �r��Ғ���I�s���)���3���w��)��_;j���:@_Y��+)�;�[�0�9k����j'�sOM��a(��N���%��l��[���K�(_�[�����a�$����Ǵ�	�V%NP=�j5(�j>�qHx�cD�R���NXJ"�{ ;"��t�!�r�����eeND�(v#q�sZ��"�ϊ'1���E�Z%���_���G�a-���u���v��`�1�f�G>�p�����v��1����3�m?�p������� ��g��ſm�(���a��<�`��p���.����^d���}3ſ��5��?~������p�W��!�d�� ŧ~��?��f�
ÿ��������p�=:��(��b�S�`�U��c������p��?e�p���`�>���Ow1\d���0����?��_cx7����Xa�����m��f���os�3����x-�:��W���������9�{W#���������q�U���ā?���t�?t�}�@
@:I�c�:�%�j�U�3޲x[⭇�6!�L`S4)
�@m������-�!���<$��j��|����v�t��o*��Κ��`��DK�#A�{\��C#7j,�T%]�Z�Hp������Ѡ�L��\
-��R��\w��� ��mM;�N��\�\�6WJ�P΍�68�kY�.bہ�[�![L�Z_]���;�C�8ҕ�Z��F�ۦ��q�l�s�K�fj�so4ڊ�h�����/գ=^˜��Vr9��������Z4eSI��pSI(�T4$p�4=�+gԃWS"#D����0��`8Ł�p0��`X�(r5;eA�c	����r��3%w: �f7���Q�_$`�?و��b�*Ȁ��[�0����D�0wb020(
H�
}i�����ӲzF͢����̨$KwH�r,���bMW]j���֠��ڄ,��V�#e�?�j��zu%��wM���}t����0	  E ����&��[�E�y���2{Q��r�QH��d�l�^g�J&Z�SL�jRJ����Q:U��/h�^^鈗����i�z�H��������&��Uj_]��s�MD/m�TI�7!�EEcͻhUQ��&aAI1�[Z2l��D5�T��CQ�m-ke�&b1u/2�D����~��k�'�$��G�t��9�a*[�ٻ%Cx��a\ˠ�8x�lۿء���v�+c��������~l���������蔴��Uo�	�5e�Pʨ%5#��[��#>n�3��Ҙ��i�Ha��Y�݂�����椄�iU-�-�,�乷b��Q�
�%��91ϓ�e�|��3��p���\���;�k*����P|^�����f�:�69�ZE��A�͞�v�n�a]�V�7����dJlr���;�^�uL�o�E�Wp��E�#�+P�tī�N�EMw���_|� ��z�ǰ��?D ��- �:����7@Wp�
���&P_�1��Ore�U������@������oGF
zV��+����O�!�����`��P84����S����72=!�#3�$>�ŧ���xr�A�!�TM����x�#��|`�������2K����`�������� ���p$�����}�'x��㪎�)��@&Q���U˩���F
���g�W����@��N�dΩ�x�WL+hh=�����Z��xb29-�S�|����ON�`��}d=���އ"��e�D>���G�s�?M�����&��(J$'Rr�O.��#����g��i�?�&&iAaI{`qƧ���[\��Sz����a&[���F�HJ��'��4� �r;�@f	J|vVS��q��h�TT̹�-a�r�a��pebd��rzNM�bc2��g�fXa|�!74���PO���ԥ��2��X���\��� �`6+��4����۾��� p�?8	:��@���_�[��5�^��������['���/j��	[��ISS(��׈y�0�Y�,:��dr2�|�9�z�
����S�Jj���%���,�2��4�e�܇����)��M �6EX���?13sYr	�@ Rh���]/j�(L5m"eV��Mz��3�bNE������9-=��M�*Z
T)���d��(qW�GPJ*�PJ�?�J*���N��>e����U��nE�.��j��p�u��N��(>-�O58,�n.��?�'תe���~,X؂�UZ�|l�C��O��b�0{[0d�rk{�e��|��ܢ�S�I����X���x;��������M<B�c2��J�Y.���519�j�j����4̒����Rb,:"!���!_�ֲ�.���qT/mzZ���P֮vv��W�?U6I���r=����4Ȃ��v�-�x�3K����YT�Fi�a�j�����X��ʹl�(4����Ukk��B��.�M�X\l2a����X.��A�W�i&�E�?> �7�����������^8���mF�����=����Mt�����ζ�x@�`	����{�� ���R�qk*MJ���0��mbZJ��([_��'����$Ի�e�E����X|�<�&��Y��;|8f����n3�@&j���-��*	w�O��[�%�o�gY�B!8ϒ�-�{��d@�i|�U����6 ,A�Y:��r���&�Z�������#���&'oc�<�2�&�8i���a�Q,�6�6��5�̜���"2U���{h^)i����T�Mo��
�as[Wj:U��N�.�5����R�fh��'�9+���aB܎�xb�'ӷ�!�a��(�9M�$�Q����~���6��;��l�N(u�D�~�5�{�Cڝ>/vf5K�2��2w���Rd�(�KS{{�4��}�'�����l��F�+�s�0WH�=Ћ���C0iY��2i5Sߙ��=6��;2�i��-��X݌�>�Fz�U \_":����`'fMB+?�&�y�����Mۜ�l�,3@�����ѭa�\iZ�=+�l(tWe�J��˜Q�T����t^�Ǜ9e^)�64��[�Tȓ2`��ݍ�Jx� R�Q|�ED�kp5���8�o��;��+�����?"�;>���b���\`��)�K�Z�R1�E��zGu�@��QQ!uzFfV����&�Q6�5�BI3U���dƗlrR��(�.�
TF\A��4�S�~���lȴ����EJ� ���TY�+d뫌u�x7B�9=^�<�t2:2��<].��7"�Y�g-lNq��Trˤ�����7=���R�>`3�+`�����q��GǤV�a�o��Yf��
$���jaTO>��TlC��&�s�$��;��|���#�&���O��:��N��q�11�c�ؒNN�n�UR�Y�ܐ �&�����j���Z�m�]Y3+Ā�bs�ѓ;�{<)E!�o!:z�M�o[�tr��eڦezh\Vۮ�ǢcS��Fi�&������j	؎��jw��Wv��Ywp���M 5u�q�uFL�_��/fj��
$2��My ���o�&asO�G��F�fu��5�p��}%��mQX�|C>��T��t�P�s������S��}��4�*b5p�g��h`U)��`���4�ֻ8Do�s�/�L$�]9����!ԋ�j�M&l�}��e��_�e�xO+����L|:ZWk�~�.����;%� �  