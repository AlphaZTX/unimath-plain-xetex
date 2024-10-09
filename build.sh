# XeTeX
for i in {1..3}
do
  xetex unimath-plain-xetex-doc
done
rm -rf ./*.aux
rm -rf ./*.toc
rm -rf ./*.log

# Lua
texlua unimath-plain-genmap.lua

# make TDS
if [ ! -d "./unimath-plain-xetex" ]; then
  mkdir ./unimath-plain-xetex
  mkdir ./unimath-plain-xetex/tex
  mkdir ./unimath-plain-xetex/doc
  mkdir ./unimath-plain-xetex/fonts
fi
cp README.md ./unimath-plain-xetex
cp unimath-plain-xetex.tex ./unimath-plain-xetex/tex
cp unimath-plain-xetex-doc.tex ./unimath-plain-xetex/doc
cp unimath-plain-xetex-doc.pdf ./unimath-plain-xetex/doc
mv -f *.map ./unimath-plain-xetex/fonts
mv -f *.tec ./unimath-plain-xetex/fonts

# tar
COPYFILE_DISABLE=1 tar --exclude ".DS_Store" --exclude "__MACOSX" -cvzf "unimath-plain-xetex.tar.gz" "./unimath-plain-xetex"
rm -rf ./unimath-plain-xetex
