---
title: "Restoring a SPARCstation 20 VSIMM (24-bit TrueColor memory module)"
date: 2026-08-29T01:00:00-07:00
draft: false
description: "How we made a damaged rare VSIMM work once again"
---

Twenty-five years ago, I had a lab running old SPARCs that I used for learning Unix and Solaris. This experience led me to my career as a DevOps engineer.


When I got married and had to move, there was no space for my lab in the new home, so I put it in storage. A few months later, I realized that storage wasn't a viable solution, as the costs would eventually exceed the value of the equipment. I had to make the hard decision to dump most of it, a bad decision then, and even worse today.


At the time, I had a maxed-out SPARC IPX, a SPARCstation 20 with Quad 125MHz CPUs and 4MB VRAM, and  Ultra5. To prepare for the disposal, I removed the SPARCstation 20 CPUs, VSIMM, and RAM, put them them into a small plastic box that I kept in a drawer for 20 years.


Two years ago, after I was laid off and soft-retired, I decided to rebuild my SPARC lab; which proved difficult, as these machines have become niche collector items. I eventually acquired a SPARCstation 20, 10, 2, and  Ultra10.


When I opened my little box, I was surprised to find three SM71 Processors: a HyperSPARC dual 120 MHz, a 200Mhz, 150Mhz, and 100Mhz. I also found most of the RAM and a *4MB VSIMM*. Sadly, the dual 125Mhz didn't work, but the other HyperSPARCs were fully functional. One of the SM71s, however, had a cracked CPU die and was unfixable.


I popped in the 200 MHz CPU, RAM, and an SCA SCSI drive. It booted, and I was able to install Solaris 2.6. Next, I installed the VSIMM, but it wouldn't power on. Upon inspection, the reason was apparent: during my move or storage, some capacitors had gone AWOL.

![Missing components](missing_components1.gif#center)
![Missing components 2](missing_components2.gif#center)


Tantalum `C0706` was broken, and `C0204`, `C0207`, and `C0202` were missing. All of these surround the `RAMDAC (Brooktree BT463)` video controller chip. The `C0706` is the power filter that absorbs spikes; the smaller ones are MLCC capacitors that reduce noise. The standard for these is 100nF 16V.


Since SPARCstation VSIMMs are rare by 2026, I had to attempt a repair. The tantalum was easy; under a magnifier, I identified it as 22uF 16V (C package). After soldering the missing parts, 


![Repaired 1](with_new_components1.gif#center)
![Repaired 2](with_new_components2.gif#center)

I went the final test: I inserted it into my SS20 and fired it up. To my surprise, I got a console display and successfully launched OpenWindows in 24-bit mode using:

```bash 
openwin -dev /dev/fb -defdepth 24
```

![VSIMM Running](vsimm_running.gif#center)

With only one one SPARCstation 20 at my disposal and one with a 8MB VSIMM in it, The second VSIMM slot is for a second framebuffer (video card) that connects to the SBUS slot and is made of unobtanium, I decided to return the 4Mb VSIMM to storage and keep it ready for a future use.

