#!/bin/sh

# Display usage
cpack_usage()
{
  cat <<EOF
Usage: $0 [options]
Options: [defaults in brackets after descriptions]
  --help            print this message
  --prefix=dir      directory in which to install
  --include-subdir  include the Tutorial-1.0.1-Linux subdirectory
  --exclude-subdir  exclude the Tutorial-1.0.1-Linux subdirectory
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
  echo "Tutorial Installer Version: 1.0.1, Copyright (c) Humanity"
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
The MIT License

Copyright (c) 2010-2016 Google, Inc. http://angularjs.org

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

____cpack__here_doc____
    echo
    echo "Do you accept the license? [yN]: "
    read line leftover
    case ${line} in
      y* | Y*)
        cpack_license_accepted=TRUE;;
      *)
        echo "License not accepted. Exiting ..."
        exit 1;;
    esac
  fi

  if [ "x${cpack_include_subdir}x" = "xx" ]
  then
    echo "By default the Tutorial will be installed in:"
    echo "  \"${toplevel}/Tutorial-1.0.1-Linux\""
    echo "Do you want to include the subdirectory Tutorial-1.0.1-Linux?"
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
  toplevel="${toplevel}/Tutorial-1.0.1-Linux"
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

tail $use_new_tail_syntax +163 "$0" | gunzip | (cd "${toplevel}" && tar xf -) || cpack_echo_exit "Problem unpacking the Tutorial-1.0.1-Linux"

echo "Unpacking finished successfully"

exit 0
#-----------------------------------------------------------
#      Start of TAR.GZ file
#-----------------------------------------------------------;

� ���W �[}p�ߓ�e[�I C�48�0�,ɖ��%ۂ3����&搥�-�s:Q�$�����4��L�v��f�iڿH�S2�L҄�M�4���Қ@��9�6A��ەt��h��yN{���޾ۏ��o��h=��d�ٚ��x�ڛ���4M������l�74�x���t:�҆!J��M����L�7]9y�t�?B��á�.�2�<�+�X4n�]�:�������L��P�;�M���]^3�����oX��Cˌ���l9�6�H3l4B5��į�"[�e% �zc���Xc�S�s��Gdw�]T�vo�rǥm��2���n)�ܻ�o%0�^!y��,����X�l�����m�-��h��,��l���oB��E� 3!v���uA���͵�P�$B&3��!�A�?}�gb�{�;�=���0 ��3-��'Z�������ށDTI�Nk��V�J���~��jk�:nVq��v��e�IV�v���W]QR�6�|�^�C?�e������-ȑ��-���
t[�y��<xQ�$�op(��*�5;����Mf���&�x!�>M�ep�$|nȮ��Q|0Ud5�w��YiDրO��@<ј���")
ˢ1E��X�[�B����ICbP�E$��B���a[���c��x5P����Ic��t9��=7��7�1o汗����R��30�q�Z�y�y�{4NR�OᘴU�&D��V�@�~�0638k7��D!��r"���,�����y�]`�׳Qa� y4��t�/�S�@�^?M�3����דPbr��RuL��9�v����M���j�k���.q㼛��ed���SBo}S����iOLM'�j�ҹ��3z'5�9�lpkR���4����$ܚ��r�I�כ~�,&��6jR��m���\-��%�4=F;�<_!�z���\4m'|�Y��֜R�~Ĩ�G�nM���-e��r��Q~�߼nR_�v���h��~@�FWc}8PE#u#ͮ:W�5�:�M�}�Oۑ'6#��������W?z��|u��%m�TVJ䐇�ײ���heiaa�B�Fe�DO킇�z�8������w���;�Ƚ�}��g�����N>�x�����o������y�TQ�Γg�p�4U�x@��˦��bia��<��<��˃��G�|�ܖ�8O�_?@}07�S
���;��&`,s�<�	������?���ճ�c<�t|>N������&����b�������w���$��0^��5�v�o!����fPe��8��h�@\	�
�)� ˡ����E��PĈ/��?���h�=]b@���P\�䞮�p,*���%���"JT%03�E�F1{�"v��p q)�]�
JQ�uմr��M�m��q)�Z�kˊΎ�6�auX��j���������ļP�;M�f������O�e��s^��"��g���Yx��S=[*�.ZP���1�h�v�PzX-O9gâTM�5/t�;�BE�O�E`��ѣ�>���G&���ߖ� ���g�#��!��0�׉5=G��H�B]8r���@�����e`4�W�C� �N���-�����Y�ϣ��	�� ��Y���A7���?��C��!9!o����+צ��Sm�P�Z������Y(H2����X�B܇���y2�$��|ʥ���R��Oo�2���-y�Y!�81z�Yn{���{B�m����x��3�!.BM�<���ΧR�_Cփ���o��H��=�mtv(*_K����1!靀e0=�C:�(�B�&�Z	�E%�w"h�=*${Uփ�u��T���ß7j4�����G�¢F�;=�<ɔ���ӹ�fC!;OJ�v$?�H��y�)<�}V0��6��)��m:^:��v&?i�RUFs­g�	qW��nO�g�G<�73�><L��2��5q~�$�C�(_����7��n�aA4�d#�����O�x9S�X���Cq�����/��`�R�~�f��Q�����Y*�4L��s�u8��qL��H?VbA8���.�-���"�?��TʍL��9+��_+�Z�-Yܰ�ˀ� _�چ�9���k8���ѷ�YX�{C���m���d����4�����S�j�}�H0�v��ђ.�[65{L6�����C>��j*���
����5����!�&�?F��iU���[�$O���TYGT�<�����R>�)��|*��}U�!,Ej>��)P�F*GR���1�k��Ҿ�#�\�s��F�i�iy^���<���,ʘ��t���L�S$O�s����J]ǲTL��:��ČJ���1%�=����Y� E/L�-^�7Z�8=��x�n��=�f]�,=.��1=~�x�E�+��.^	l:�Q�����:��g�iZ|V:ޠ�g���5�y�ū��[�_x]�:��X g]Oh�9����sץ*���T��,ߞX.˵��������&��n%8��m�����I�k�}n{n#z�{��N̟�/?��\�ʃ�k�����h��ޗ�~��<z�¿��<�8�343��1�s��y��}�Y�s��"N�ώ�s��rN?���ӏ�Ȝ~\f�ӏ�����D�8�8�N?~��<zr�q������\�8�8�?9��O�A?�s�Ǖ^���As���~<h�A��ey�k��#������~ �+ۺ�Ύ�=�2!Q��~X���NL�|a1����K� ,2�)`mr6;��p�H�ɲo�(Ey+�[�b �l�"Y9�Ѱ*d�tgoz�˻=]^ѻ������^���8�P��}�*OWG���ƫV���Q-�wC����*^ѹ���)�^�|��G��vzŋ
��a7�;;@�bpZ$Jc�qWv����X�K�eE��@�E�ߦ:; ���ar8���Q��In0��$B�@]( pn����(ԧ����lQ�욌(�3����T%|$tk�������z*A
ș�*��U��o���_$�H�ZS�iz
�r��f�3g����|���#�hc���5�3��);#O�Q� ���G��O���S�u�� v�P�<� �o�B�B
кI��:�J�l!�u%��6 uMC婿\Lj�0�����ϒ�~u3��^�~J�*��G��>"O�el����ȷ�<��wy�.,"2���@{Ɔ~G� k���IF���p3�&}����Y�����`����D��L��=3�CF��%Uda^����S���ԏ��|�4�����웪��?[��<]� �Ùg�	^hC��2����l�x���?<����g����_��߀�wT>�ϭ���6�_*O��>�~�^�4O]?M�1�i��T��a�'y���,Z;YyJ����3�(_��������!��
f�]��R�~�q_��\�+����3g����É�tE��������`�����A���� 2tY똶��j�;m���G�s��?�
��6\��ꢷ��Fn^b�^t�� D�?=��C���0��op:���Ӆ濳qf�_���!���nO�R���o ����(��`��d��)�Ji@\��^۱z���Y����O�б
2���k�b��.O�`4BK1)���Xe��c[B��F��A�� ���c�b��D*��:�عz���E�}k��n������.�7�8� @  