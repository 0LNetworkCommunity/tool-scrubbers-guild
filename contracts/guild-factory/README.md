# Guild Factory

## Objective
- Easily allow someone to create a guild
- Make composable for a guild of any type
- Allow a member to level up, this should also decay without participation
- Allow path's or journeys that lead to apprenticeships
- Make members accountable to each other via a reputation system or vouch
- Always be optimistic by preventing fraud before it occurs
- Funding payment system should be seperate


## Inspiration
- [Raid Guild](https://handbook.raidguild.org/)
- [Near Guilds](https://near.org/start-a-guild/)
- [Guild.xyz](https://guild.xyz/)

## Guild

Guilds can be created by anyone, they are intentionally bare to allow composablity for any use case

<img width="1182" alt="Screen Shot 2022-08-05 at 12 38 31 PM" src="https://user-images.githubusercontent.com/97761083/183152164-f36c7d33-707a-43ec-8a9f-fa6b7223c255.png">

## Constitution

A `Guild` has a `Constitution`. These are a set of rules that `Member`s should abide by.

## Member

Once a user joins a guild, the `Member` resource is added to the users account. It will track the `Guild`s that a `Member` is associated with.

## Apprenticeship

A guild has `Apprenticeships`. These are badges/credentials([Soul Based Tokens?](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=4105763)) that a `Member` earns if they complete a series of specified `Journeys`.

### Journeys

`Journey`s are pathways that consist of a series of `Task`s. These are meant to capture a certain skill set eg Error Handling in Rust.

### Tasks

`Task`s are a step in gaining a skill set(`Journey`). These can be anything and only have two prerequsites(name and description). They track users submissions by a `Member` submitting a deliverable.

## Reputation

> WIP

three varibles in place that could be used to determine reputation(just to get the conversation flowing):

1. Vouching by other users
2. Member Score: Completion rate at different levels eg Apprenticeship and Journey
3. Deliverable scoring for tasks by peers(anonymous)

## Payments

> WIP


## Basic Functionality

**Guild functions**

- Create Guild
- Create Apprenticeship
- Add Constitution
- Add/remove Constitution rule
- Create Membership
- Add/remove Role


**Apprenticeship functions**

- Add Journey
- Add Task
- Add Deliverable


**Member Fuctions**

- Add/remove Detail
- Change Detail