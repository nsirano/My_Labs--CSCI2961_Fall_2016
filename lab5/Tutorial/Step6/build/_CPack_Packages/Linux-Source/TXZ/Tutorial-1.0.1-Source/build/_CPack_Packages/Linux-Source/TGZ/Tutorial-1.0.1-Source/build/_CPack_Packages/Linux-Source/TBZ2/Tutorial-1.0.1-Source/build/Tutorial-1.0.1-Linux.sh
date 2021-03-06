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

� ���W �[}p�_�߲-�$�\�q�X��!;��d#8���ib�:�Y2�5L�8aP	)M3)ͤIg�N�L;M�iZ0%�$���I���PZHq>�i�ݽ��nu�� mS?�io���w�q����7�AW�Gcc��Sgc�#=M��ml�otպ�����lp5"��jF(U}
6%��<�T�����zq�����>u`y,ܧ#��we똢��������t��o�u��w\Y3�����oZ�S��Xj=92�:�6ɰт՘��-}�5�-�EQ�i7���a{�f}.����.��o��m��dJ�hBK���v[N����Ȃ������fxO�Ώ���J>�=���2��)?�=GF�?W�c�WJ1G)�L����w�X��c���äl� )��ݠ��n�3>�=g:�$��s�'�M�����'��--wU]�����vG�+Fs��.���^{����v�.��D�����d�����4i��ɏ�j�en)�7sd�ms�{	��Ö'xN<7��/Ȃ���3�|�L��qv��(}l��،/b�'	��ΞDH���ۣ�U_/NUEK؝"�|vUV���S}���b4�e�"��r��#�l_�������E������2��OZ�o9��s8��s��n������ �z��[ �G̛Y���t^��03�������Ȼ�������b��f��3�Z�w#c�`l�p��d��@!�b���o�l{Bπ<�.���N��!O�q�A�EY�A�S�?Mى��15�}��U���_���t������s�N�ׂx_�����M�n�w�Nɸ���������񹓞��N�j���M�3y'5�n2�u)�cX��N�{n]�j1ҥ��;6��ڬu��p��rf���*�g�q0�8�|�pu��Nx.�.�ei��֜V��~آ�-n]��srwa�L�(;�o^ԗ�]��;R�d�誯	��C�pl�z��U���G#�Zj�x�oC�Y;
`3�as���C������o�����x�\�i)+9�!��,D7=VZ��[�;�IY)詚���f��6����=��N=z_��*��F���SO�����-�s7�x����g-)����;o��}<(����L�x���1�%����e��0��f#�m#ͳ�׃H�J���;8|'�ӊ,En�g>᳔6Z���=�z�P{lH����������9�� g�������]����>ŋ��|���	�6��M�E/C�=?�㺏c���HLE>5@�!%VH�H�D��4����I�`8����v�/+r0��Jg{K(�;}�!I2u�%�$�����A���N�ZWc�K���O�׃�0�iZ�U�j[B�hT�j�ڲ����E�����}5�?vo����g���`�;��2������O����� ��(���>`U���G��{��	H|hT����/��3qQ�����w�;� EgN�E`���ɣ�9N�f�'&���_
(����|�5��1��8��5��GG�H�&]<z��ӱb�e�����
lx�XM�A�����[���csg�"����A����2`g��n*�տS�/�`b|\<<�T4�$�~A�>���i+���h����]�~�A�$calX�KyK0d���tH�Ö�X��ob�����@�xϙ�X���v��?'�c'G�?g��!����p���@@*�<iȃH�ďRd���D������+��k�� ;������%�ckpI@,{`T�{�q�8NOА�����	�V�jI	���U�]�A*#]:6�TF�}��g��6]J��CtqQ#�ݞu�x����l�[�!W������k[����h��4�?�K|����wU��/m�w��/��G�������!�Ͻ���td_j|}p�L���Qa��D���P�W�-�+���pA86�++�9 �-1�"J$�
��P�/���z2|��4'g�bx?c�w��N��x�4�x����9N�:qd���M�2���N|���}K��#� ����H�	�ն�Z����+�;��ً�-�"��c��7'[{���H9�����ވ,ia~&��k�ھnn�V<��
{s��U�VǮ|��4R�nu+�&���V5[̇�����9^�W7�c����i�,d�j�1F|L�R�o�B��S��>XǴ<���d����?����t�Y��|[��O�ur����Aʖ,�t=�Sҗ ?��%�=�,:�bL��y�yf7�Yq���J��	��g�9�|����ֱ<�C�� �-�x`t�[��s`q =nN���xR������y�q����K��٣h2ċ��B�[��G�g�[4����a�9i�(=n�Ρxj���g$�z|&:`�_���z�<9����H0�o0�9x�����H�_=��.����������퉕вL���Ό��k�9�?��v����2�6�N�~XK�3�s;�a�mF�(f�� �s�<��~E�f�c��z_A�탲����.�ƨ�Y��믏(�9N.��yg���L�~~<8(�9������L�q�d�5�Mv���D�M�q�5&����Y�4�}^��2�s�7ǉ�i2�����>��q\�E�q<h��8Ti6�-4ۿ$~��8~��5��{���-R[��NIB���J}$�%�������B�_�(Q�F}������~{cCS�1I>E�m�䰪lCtX���a����XU���;�����O�W�ZFBK�|v�SBI�hD���$N�l�*O{k���ūV�꒼"��u`����)^Ѷ���&�^�|��S��4�y�K
�ia7�;=@Ebpz$J��qWz�bx<����"oZ ��o���V���4�V��~���c��X0�����������TU���ښ]��8c��n(��*�#�[{�hhW%�,�S	Ҁ_I�4Qm�h�~S�B���Q�Քv����D����̩�$-?�����oF��cj�F�?����3T`����1^0y���8[�{�����I���u���u���l�
ٺ��~���a��_·��m��f.%{���_�����ψ�A�i�����l]Ʒ{�A���O��l]�2��#HƆ}G���}J���8'���q ���K�����U����w8���/���6�gf���3���E?��?B����仧��g�|j�T�/����q�l�s �˹���2�Ȇ"�+��Q�����*K�g�p�E����X1�[�H��"��|j�[˳�mֿL����\�l�6Q6y�,=��'�o��?��Op���u��v��. �3�g�/R>�d|F���s8O�v�ji%����3V�P�3�q_�W-��3V��9��g�>��b~���ȥ��Gm}}���\b�����+Zǔ�_�����p�k��Q窟>�w-���rT��U��u�ej�i����pK$�_��T󿮡6���w��������ׂjjrt��v{L��Bd�~_�/DeU���B �l�Xn�ˁ`XN�:o���ի�v����s��U���d�Z��׷{:E�[��QA���|*�rPR"[�~Y����A�H�`�������ͱ0V&��u^�m�
aa�z���?���4M�4M�]�o�n�* @  