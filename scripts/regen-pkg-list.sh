#!/bin/sh

DISTDIR="${HOME}/sunos_source/build/distfiles/2.5.1/"
RELEASE_LOCATION="lsesol/releases/download/v0.9.0-sunos4-sparc/gcc-4.1.2-sparcv7-sunld/"

SUBDIRS=(
   "GCC 4.3.6 (Compiled to use GNU ld):gcc-4.3.6-sparcv7-gnuld"
   "GCC 4.1.2 (Compiled to use Sun ld):gcc-4.1.2-sparcv7-sunld"
)

function package_title
{
   filename=${a#./}
   pkgname=${filename%%-*}
   release=`echo $a | perl -ne 'print $1 if /-([0-9].*?)-/'`
   devel=""
   if echo $a | grep -q "devel"; then
      devel=" Development "
   fi

   echo "${pkgname^} $devel - $release"
}

function file_size
{
   GZ=""
   if echo $1 | grep -q "gz$"; then
      GZ=" .gz"
   fi
   echo "`du -h $1 |awk '{print $1}'`$GZ"
}


# General packages
for a in $(cd ${DISTDIR} && find . -maxdepth 1 \( -name "*lse" -o -name "*.tar" -o -name "*.gz" \) ); do

   title=$(package_title $a)
   hfilesize=$(file_size ${DISTDIR}$a)

   echo "  * {{< pkg file=\"${RELEASE_LOCATION}${a#./}\" title=\"${title} ($hfilesize)\" >}}"
  
done

# Subdirs (using psudo hashmap for bash 2.0 in sunos4)
for pkgdir in "${SUBDIRS[@]}"; do
   title="${pkgdir%%:*}"
   folder="${pkgdir##*:}"
   echo "  * **${title}**"

   
   for a in $(cd ${DISTDIR}/${folder} && ls |grep -E "(\.lse\$|\.tar\$|\.gz\$)"); do
      title=$(package_title $a)
      hfilesize=$(file_size "${DISTDIR}/${folder}/$a")

      echo "    * {{< pkg file=\"${RELEASE_LOCATION}${a#./}\" title=\"${title} ($hfilesize)\" >}}"
   done
done

