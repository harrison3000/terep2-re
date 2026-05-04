# terep2-re - Reverse engineering the terep2 demo

Just publishing some things I did in a effort to reverse engineer the old Terep2 DOS demo

I started doing this in 2019 and gave up, but after I discovered people still care about this game I decided to try again

For now I made it into a win16 app, so it can be run using wine (and winevdm) instead of dosbox, it also makes debugging and reverse engineering with ghidra a bit easier, later I may even convert it to x86-32, who knows?

## Discoveries

 * The game tries to load 2 16bit integers from `sim.cfg`, they seem to affect how stiff the cars are (aparently people already knew this one)
 * The keys `[` and `]` can be used to make gravity stronger or weaker, respectively (or even reverse the gravity if you press it for long enough)



## It kinda works

<img width="340" height="259" alt="Screenshot From 2026-04-27 23-02-18" src="https://github.com/user-attachments/assets/d4b37fef-2f56-480c-87b1-b15e4a9e8ec5" />
This is the very first time I got it working on win16 mode, no palette, no sound, no physics, nothing... just a very crude proof of concept


<img width="359" height="260" alt="Screenshot From 2026-04-28 20-55-18" src="https://github.com/user-attachments/assets/5c3be341-af07-4a9e-9e34-23a75b006979" />
After a bunch of fixes, playable, but no sound yet
