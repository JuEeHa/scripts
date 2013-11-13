#!/bin/sh
cd /var/www
echo '/var/www:'
mdp2html.sh $(find -iname '*.mdp')
echo

cd $HOME/Public
echo '~/Public:'
mdp2html.sh $(find -iname '*.mdp')
echo

cd $HOME/Public/blog
echo '~/Public/blog:'
cp ../_top _top
cp _top _index_top
patch < top.patch
patch < index_top.patch
rm *.html
sh createblog.sh
