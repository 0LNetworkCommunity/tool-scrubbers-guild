# Tool Scrubbers Guild Meeting # 1
Date: 13/01/22
Attendess(discord handles):
- @andersph 
- @Ashiiix 
- @Daniyal 
- @Kalvinen 
- @misko9 
- @cj.blocz 
- @mortonbits 
- @Nour | Bᴺ 𝕊pace
- @0D | 0o-de-lally 
- @thenateway 

## Agenda

### Introduction
A [guild](https://en.wikipedia.org/wiki/Guild) for 0L that has two main goals:
1. Allow people to learn Rust, Move and 0L/Diem architecture
2. Help build/maintain core tools within the 0L ecosystem

Participation is paid via faucets for any level of participation. The goal is that renumeration is paid proportionally to the contibutions but is TBD as the project progresses. Initial meeting attendees will be paid 10,000 coins for attending

**Two Levels**
1. Show up and learn
2. Clean up rust tools via formatting/refactoring

> The scope may change over time. Faucet is intially done manually with the idea to get it automated within a month.

### Objectives
> OD shared his experience: Interperative code > Rust/OL is hard and seems insurmountable at first. Keep in mind each package within the Libra repo was built and maintained by a development team within Facebook. Noone has the ability to know it all.

- Be able to move from intererative languages and have an understanding of how rust differs


### Tools Needed

- [VSCode](https://code.visualstudio.com/)(Can be any IDE, this is what most people use)
- Extensions
    - [Rust Analyser](https://code.visualstudio.com/docs/languages/rust)
    - [LLdb](https://rustrepo.com/repo/vadimcn-vscode-lldb)(More advanced debugger - brought up in questions - not a prerequisite)

### Rust 

- create new rust program `cargo new <package name> -bin`
- file: cargo.toml holds all depenancies and metadata
- file: src/main.rs - the main program that runs
- Compile: compile your program from root `cargo run` - this creates target folder and compiled binaries

**Tutorials**

- https://doc.rust-lang.org/book/
- https://doc.rust-lang.org/rust-by-example/
- https://www.youtube.com/watch?v=MsocPEZBd-M
- https://www.youtube.com/watch?v=vOMJlQ5B-M0&list=PLVvjrrRCBy2JSHf9tGxGKJ-bYAN_uDCUL
- https://www.youtube.com/watch?v=EYqceb2AnkU&list=PLJbE2Yu2zumDF6BX6_RdPisRVHgzV02NW

### 0L

- Fork of Diems older version. Each folder is a different subsystem/program
- Most 0L code/tools are in the `/ol` directory. This includes:
    - txs
    - tower
    - onboard

- Other subsystems have changes to interact with 0L but for now we wont dive into them

### Blockchain Architecture

- Storage folder: Jellyfish Merkle DB
    - DB using sparse merkle trees and is in DiemDB folder
- Excecution folder: excecution of state machine
    - excucuter folder: excecuting state transitions
    - Importing pieces of language folder
    - needs a VM
- State-sync folder: sharing excecution with nodes
    - imports network data
- Network folder: helps clients interact with blockchain
- Mempool folder: client > mempool > excecution

### Questions

- What are we refering to with Clients?
    - diem-node: fullnode/validators
    - client is a program that interacts with a fullnode eg tower program in the `ol/tower` folder.

- Whats needed for a transaction?
    - Move code
    - Arguments
    - compiled to binary
    - sign
    - send to client and excecute

- Dependancies?
    - Added to `cargo.toml` imported into each file they are being utilized in to help keep things managable, maintainable and readable
    - local dependacies are imported as file paths

### Next Steps

- Tool scrubbers to configure environment for development
    - vscode
    - libra repo
    - vscode packages
- To format sub packages with the 0L folder, look at the github diffs to compare and see best practices.
    - Can be done running `rustfmt <path-to-file>` 



