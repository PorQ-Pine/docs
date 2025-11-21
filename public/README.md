#### [Video demo here](https://github.com/PorQ-Pine/docs/blob/main/public/demo.md)

### What is this
So let's explain a bit what is what where and who when

There is old Quill OS (Formerly InkBox), here: 
- https://github.com/Quill-OS/quill

Which was almost fully created by [Nicolas](https://github.com/tux-linux) and [Szybet](https://github.com/Szybet) (and some contributors along the way)

That OS was killed by the manufacturer. This organisation, is named PorQ-Pine, so Port Quill to Pine(Note), the port is pretty much a lie, the only thing we ported was us, this is a complete rewrite, but we learned some things along the way, so:

(Also thanks to donators and Pine64 itself, for providing the hardware and thanks to the pine community for providing building blocks in software that this projects uses)

### Design principles
Because we learn from our mistakes, sometimes (And the Pinenote user target is different from Kobo devices)
1. Rust.
2. It should be easily reproductible (so [quillstrap](https://github.com/PorQ-Pine/quillstrap/tree/main) exists)
3. Hackable but recoverable without needing another machine. These 2 points conflict with each other, usually, so balancing them is needed
4. Reasonable security (So home directory encryption by default, but don't conflict with point 3)
5. Choosing solutions which are easily maintanable and follow current standards of doing things (As in, not hacky solutions, old Quill was a bit spaghetti in the case of design)

### Current state
Usable for advanced users, but there are many major and minor issues to be solved.

### Technical overview
Look into [technical/README.md](./technical/README.md)

* * *

Also, our discord: https://discord.com/invite/uSWtWbY23m

