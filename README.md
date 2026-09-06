# terep2-re - Reverse engineering the terep2 demo

Testing branch, conversion to 32bit linux

Not meant to be released, it relies on things like modify_ldt to run segmented 32bit code, with a custom DS and all that jazz, but you can still build it by running `build_linux.sh` if you want to

-----

Just publishing some things I did in a effort to reverse engineer the old Terep2 DOS demo

I started doing this in 2019 and gave up, but after I discovered people still care about this game I decided to try again

For now I made it into a win16 app, so it can be run using wine (and winevdm) instead of dosbox, it also makes debugging and reverse engineering with ghidra a bit easier, later I may even convert it to x86-32, who knows?

## It kinda works

*Very early build running on win16 mode, no palette, no sound, no physics, nothing... just a very crude proof of concept*

![](https://github.com/user-attachments/assets/d4b37fef-2f56-480c-87b1-b15e4a9e8ec5)


*After a bunch of fixes, playable, but no sound yet*

![](https://github.com/user-attachments/assets/5c3be341-af07-4a9e-9e34-23a75b006979)

