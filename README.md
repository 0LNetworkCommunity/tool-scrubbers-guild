# 0L Tool Scrubbers Guild
![old-dirty-tools-on-table-2297522](https://user-images.githubusercontent.com/97761083/179103005-fccff17b-72e1-4254-8c86-8a1405ee547f.jpg)

## Introduction
A guild for 0L that has two main goals:

* Allow people to learn Rust, Move and 0L/Diem architecture
* Help build/maintain core tools within the 0L ecosystem
> Participation is paid via faucets for any level of contribution(even passively attending meetings!). The goal is that remuneration is paid proportionally to the contributions but is TBD as the project progresses. Initial meeting attendees will be paid 10,000 coins for attending

**Two Levels**

* Show up and learn
* Clean up rust tools via formatting/refactoring
> The scope may change over time. Faucet is initially done manually with the idea to get it automated within a month.

## Meeting

We meet every Wednesday at 11AM PST in the 0L [Discord](https://discord.gg/GXazrCUV). Meeting minutes and recordings will be posted here shortly thereafter.

## Organization

We have a [project board](https://github.com/orgs/OLSF/projects/8) that we use to organize work that we need to do and collaborate on ideas. It is free for everyone to contribute to the conversation. Collaboration is not only welcome, it is expected 😁

## Fund Management

The guild is a community run project and funded by the tool-scrubbers-guild community wallet

`2640cd6d652ac94dc5f0963dcc00bcc7`

The steward running the community wallet is @Wade | TPT#4475 on discord.

### For validators wishing to help fund the guild.
1. Add json file as payguild.json
```
{
  "autopay_instructions": [
    {
      "note": "engineering fund, tool-scrubbers-guild, https://github.com/OLSF/tool-scrubbers-guild",
      "uid": 0,
      "destination": "2640cd6d652ac94dc5f0963dcc00bcc7",
      "type_of": "PercentOfChange",
      "value": 1,
      "duration_epochs": 1000
    }]
}
```

2. Enable autopay(if not already enabled)
`txs autopay -e`

3. Add guild autopay
`txs autopay-batch -f payguild.json`

## History

Intitially conceived by @0o-de-lally and the first month was funded by @LOL-LLC [moonshot-program](https://github.com/LOL-LLC/moonshot-program)

# Anyone and any skill level welcome ✊🏻☀️ 
