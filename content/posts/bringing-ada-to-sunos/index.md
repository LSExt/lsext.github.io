---
title: "Bringing Ada to SunOs 4"
date: 2026-10-18T01:00:00-07:00
draft: false
description: "Our steps to make Gnat (Ada) part of our software collection"
---
When I started the path of creating a group of cohesive and utilitarian packages for SunOS4. 

I decided earlier on that I wanted GNU-Gnat to be a center piece of it along all
the other tools we come to expect on a modern Unix server.

From my previous experience adding GNAT to my Solaris LSE. I new there was some
challenge and first order of business is to FIND a ada compiler, the reason is
simple. One needs ada to compile gnats. It needs it self. 

The story says that long ago the first releases of Gnat used a commercial Ada
compiler to create the first build of Gnat and from there it compiled it self.
 
Of I turned to Google Gemini, then Internet archive, came out DRY! Not a mention
of Gnat anywhere in SunOS. (I'll latter discover why).

Then I figured It should be in one of the old CDs from Walnutcreek Inc. Or a
SunSite mirror.  Nothing! The earliest ada compiler is gnat-3.15p for
Solaris-2.5.1 that I knew about.

So I pivoted to try cross-compiling. I knew it was a thing; But I had never
attempted such a thing.

armed with the source code of gnat-3.15p gcc 2.8.1

I could not find in the internet good instructions of how to build ada on gcc;
Probably lost like so many things from that time. 

I did my best first thing is to get /usr/lib, /usr/include, /usr/kvm (this one i
learn about latter from sunos
and make them available for the cross-compiler;  I put them under /opt/cross.

Then one is supposed to copy ada into the gcc folder similar to how g++ is build
under 2.8.1 with I had done recentl when I started LSE for SunOs4. 
 
After 5 days of fighting with it;  I gave up, resigned to not having Ada  and 
concentrated on building LSE MVP.

When LSE for SunOs was almost ready I decided to try a second time builging
Gnat. 

This time decided to not start until I could locate some kind of document
explaining how to build it. To avoid falling in the same trap.
 
I gain fainding the document proved difficult. ButThis time decided to not start
until I could locate some kind of document explaining how to build it. To avoid
falling in the same trap.
 
I gain fainding the document proved difficult. But Ohh. RFM!!!.  It was right
there In front of my eyes the hole time. the source of Ada did have instructions
for compiling Ada under gcc 2.8.1!

Looking aback at my previous attempt, The one thing I missed is that unlike g++
One needs to patch gcc to get it to integrate with Gnat.

## The cross-compiler.

At first I did not really undestood what is a cross-compiler. One figure out is
just a flag when compiling like gcc -target=SunOS right! Nope!

In essence what is done is to build a new compiler stack that is a binary of your
build system. In my case Solaris 2.5.1 on a Ultra60. But it "thinks" is running
on your target platform SunOs 4.1.4 on a v7 CPU. I'll link the SunOs objects and
libraries. 

Once I had gcc, ada and its companions. Then is time to build ada. It was
actually a painful process because I learned Gnat 3.15p Does not build cleanly
in SunOs4 With looking back it makes sense thy I was not able to find any
binaries! Here comes lsecompat and my experience building shims (adding missing
functionality to vintage platforms.
 
The other problem I had is that as I was building and had a missing
cross-compiler binary I had to retarget build the binary and then clean up my
working folder from elf binaries to build the tool for SunOs (aout). 

This went for tome time I even created a script to find me and blast out bad
objects.

Because a "make all" or something like that did not work for my during cross
compiling I did it the try, fail and fix.

Copied my binaries and attempted building my ADA demo. With is a contact
database with disk based indexes.

I needed among others the driver (gcc, cc1  ada aware) and gnatmake.

Onece i got everything working I created a wrapper shell to make it work with my
target folder /usr/local/lse prefix, I could of rebuild gnat again now from
SunOS, But why? My cross compiled binaries work just fine.


I created a gnat-3.15p-SunOs-4.1.x.tar.gz that should be droped on
/usr/local/lse along with this document and a bundle with my crosscompiler. In
case somebody needs to use it. Probably not useful to anybody, I cannot see the
future so Better keep it around.


- Luis Enrique Limon, Oct 17, 2026

