// SPDX-License-Identifier: MIT

/// @title GuildFactory
/// @notice Create composable guilds for public use.
/// @dev This is a factory for creating `Guild`s.


address Std {
    module GuildFactory {
            use Std::GAS::GAS;
            use Std::Vector;
            use Std::Signer;
            use Std::DiemConfig;
            use Std::Diem;
            use Std::DiemAccount;

            const ADDRESS_DOES_NOT_CONTAIN_GUILD = 1;
            const GUILD_DOES_NOT_CONTAIN_JOURNEY = 2;
            const INDEX_DOES_NOT_EXIST = 3;
            const CANNOT_REMOVE_DEFAULT_ROLE = 4;
            const GUILD_DOES_NOT_CONTAIN_APPRENTICESHIP = 5;
            const USER_DOES_NOT_HAVE_APPRENTICESHIP = 6;
            const GUILD_APPRENTICESHIP_DOES_NOT_CONTAIN_MEMBER_SCORE = 7;
            const GUILD_JOURNEY_DOES_NOT_CONTAIN_MEMBER_SCORE = 8;
            const GUILD_DOES_NOT_CONTAIN_TASK = 9;

            // @dev The member resource that is store on a users account to track their memberships.
            struct Member has key, store {
                memberships: Vector<address>,
                details: vector<Detail>,
            }

            // @dev The membership resource that is stored on a member and guild account to track.
            struct Membership has key, copy {
                guild: address,
                user: address,
                role: Role,
                level: u64,
                reputation: Reputation,
            }

            // @dev allows members to specify outside credentials that may be applicable for indentity verification.
            struct Detail {
                key: vector<u8>,
                value: vector<u8>
            }


            // @dev guilds are groups of members that are trying to achieve a particular goal/s.
            struct Guild has key, store {
                name: string,
                description: string,
                constitution: vector<vector<u8>>,
                members: Vector<Memberships>,
                roles: Vector<Role>,
                apprenticeships: Vector<Apprenticeship>,
                details: Vector<Detail>,
                created: u64,
                updated: u64,
                active: bool,
            }

            // @dev A role that a guild is using and the reputation score.
            struct Role has copy {
                name: vector<u64>,
                reputation: u64,
            }


            //TODO: use Memberscore and vouching to determine reputation weight and role.
            // @dev reputation keeps track of the credentials a member earns in a guild and if their peers support them.
            struct Reputation {
                vouchers: vector<address>,
                credentials: vector<Apprenticeship>,
                weight: u64,

            }

            //TODO: use Member score as a mechanism to determine reputation.
            // @dev keeps track of the score a member earns in a apprenticeship/journey compared to the completed state.
            struct MemberScore {
                user: address,
                score: u64,
            }

            // @dev apprenticeships is a badge of honor that a member would get after completing a set of journeys.
            struct Apprenticeship {
                uid: u64,
                name: string,
                description: string,
                journeys: Vector<Journey>,
                member_scores: Vector<MemberScore>,
                created: u64,
                updated: u64,
                active: bool,
            }

            // @dev journeys consist of a group of tasks that would help them learn a particular skill or complete a mission.
            struct Journey {
                name: string,
                description: string,
                tasks: Vector<Task>,
                member_scores: Vector<MemberScore>,
                created: u64,
                updated: u64,
                active: bool,
            }

            // @dev tasks are individual components within a journey that have a specific deliverable.
            struct Task {
                name: vector<u8>,
                description: vector<u8>,
                deliverable: vector<u8>,
                created: u64,
                active: bool,
            }

            // @dev deliverables are for members to post submissions to tasks.
            struct Deliverable {
                member: address,
                link: vector<u8>,
            }



            ///////// INIT FUNCTIONS ////////

            // @dev create guild, two values must be specified.
            public entry fun init_guild(sender: &signer, name: vector<u8>, description: vector<u8> ) { 
                //Role is defaulted for any new member
                let r = Role(
                        name: 'New Member',
                        reputation: 0);
                
                let g = Guild(
                    name: name,
                    description: description,
                    constitution: Vector::empty<Vector<u8>>(),
                    members: Vector::empty<Memberships>(),
                    roles: Vector::empty<Role>(),
                    apprenticeships: Vector::empty<Apprenticeship>(),
                    details: Vector::empty<Detail>(),
                    created: DiemConfig::get_current_epoch(),
                    updated: DiemConfig::get_current_epoch(),
                    active: true,
                );

                Vector::push_back(g.roles,r);

                move_to<Guild>(_sender, g)
            }

            // @dev create Member resource on the user account if the user does not already have it.
            fun init_member(_sender: &signer) {
                if (!exists<Member>(Signer::address_of(_sender))) {
                    let new_details = init_details();
                    move_to<Member>(_sender, Member {
                        memberships: Vector::empty<address>(),
                        details: new_details,
                    })
                }
            }



            ///////// CREATE FUNCTIONS ////////

            /// @dev create a new membership for the guild.
            fun create_membership(_sender: &signer, guild: address) {
                assert(!exists<Guild>(address), ADDRESS_DOES_NOT_CONTAIN_GUILD);

                //create member resource on sender if they do not currently have it.
                init_member(_sender);
                let g = borrow_global<Guild>(guild)
                let u = borrow_global<Member>(Signer::address_of(_sender))
                let r = Reputation(
                            vouchers: Vector::create<address>(),
                            credentials: Vector::create<Apprenticeship>(),
                            weight: 0,
                        );

                let m = Membership(
                    guild: guild,
                    user: Signer::address_of(_sender),
                    role: Role(
                        name: 'New Member',
                        reputation: 0,
                    ),
                    level: Vector::empty<u64>(),
                    reputation: r, 
                );
                Vector::push_back<address>(&u.memberships, guild);
                Vector::push_back<Membership>(&g.members, m);

            }

            // @dev create a new journey for a guild.
            fun create_journey(guild: address, apprenticeship: u64, name: vector<u8>, description: vector<u8>) acquires Guild {
                assert(!exists<Guild>(address), ADDRESS_DOES_NOT_CONTAIN_GUILD);

                let g = borrow_global<Guild>(guild)
                let j = Journey(
                    name: name,
                    description: description,
                    tasks: Vector::empty<Task>(),
                    member_scores: Vector::empty<MemberScore>(),
                    created: DiemConfig::get_current_epoch(),
                    updated: DiemConfig::get_current_epoch(),
                    active: true,
                );
                Vector::push_back<Journey>(&g.journeys, j);
            }

            fun create_task(guild: address, journey: vector<u8>, name: vector<u8>, description: vector<u8>) {
                assert(!exists<Guild>(address), ADDRESS_DOES_NOT_CONTAIN_GUILD);


                let g = borrow_global<Guild>(guild)
                let (t, i) = get_Journey_index_by_name(guild, name);
                assert(!t, GUILD_DOES_NOT_CONTAIN_JOURNEY);

                let j = Vector::borrow<Journey>(&g.journeys, i);

                let t = Task(
                    name: name,
                    description: description,
                    deliverable: Vector::empty<Deliverable>,
                    created: DiemConfig::get_current_epoch(),
                    active: true,
                );
                Vector::push_back<Task>(&j.tasks, t);
            }


            ///////// GUILD UTILS ////////

            fun create_constitution(guild: address, constitution: vector<vector<u8>>) acquires Guild {
                assert(!exists<Guild>(address), ADDRESS_DOES_NOT_CONTAIN_GUILD);
                let g = borrow_global<Guild>(guild)
                g.constitution = constitution;
            }


            fun add_constitution_rule(guild: address, rule: vector<u8>) acquires Guild {
                assert(!exists<Guild>(address), ADDRESS_DOES_NOT_CONTAIN_GUILD);
                let g = borrow_global<Guild>(guild)
                Vector::push_back<vector<u8>>(&g.constitution, rule);
            }


            fun remove_constitution_rule(guild: address, index: u64) acquires Guild {
                assert(!exists<Guild>(address), ADDRESS_DOES_NOT_CONTAIN_GUILD);
                let len = Vector::length<Constitution>(&g.constitution);
                let g = borrow_global_mut<Guild>(guild);
                assert(index  <= len - 1 , INDEX_DOES_NOT_EXIST);
                Vector::remove(&mut g.constitution, index);
            }

            //TODO: check reputation is below threshold
            fun add_role(guild: address, name: vector<u8>, reputation: u64) acquires Guild {
                assert(!exists<Guild>(address), ADDRESS_DOES_NOT_CONTAIN_GUILD);
                let g = borrow_global_mut<Guild>(guild)
                let r = Role(
                    name: name,
                    reputation: reputation,
                );
                Vector::push_back<address>(&mut g.roles, r);
            }


            //TODO: check if members have role, no members should have a role that is being removed.
            fun remove_role(guild: address, name: vector<u64>) acquires Guild {
                assert(name == 'New Member', CANNOT_REMOVE_DEFAULT_ROLE);
                assert(!exists<Guild>(address), ADDRESS_DOES_NOT_CONTAIN_GUILD);
                let len = Vector::length<vector<u64>(&g.roles);
                let g = borrow_global_mut<Guild>(guild);
                assert(index  <= len - 1 , INDEX_DOES_NOT_EXIST);
                Vector::remove(&mut g.roles, index);
            }



            ///////// COMPLETION UTILS ////////

            //TODO: likely a better way to bubble up the completion. Seems super inefficient.
            //@dev update the completion(MemberScore) of a Apprenticship for a user.
            fun update_apprenticeship_completion(user: address, guild: address, name: vector<u8>) acquires Guild {
                assert(!exists<Guild>(address), ADDRESS_DOES_NOT_CONTAIN_GUILD);
                let g = borrow_global<Guild>(guild);
                let (t, i) = get_apprenticeship_index_by_name(guild, name);
                if(!t) {
                    assert(false, GUILD_DOES_NOT_CONTAIN_APPRENTICESHIP);
                }
                let a = Vector::borrow<Apprenticeship>(&g.apprenticeships, i);
                let journey_length = Vector::length<Journey>(&a.journeys);
                let apprenticeship_score = 0; 
                let i = 0;
                while(i < journey_length){
                    let j = 0;
                    let journey = Vector::borrow<Journey>(&a.journeys, i);
                    let ms_len = Vector::length<MemberScore>(&journey.member_scores);
                    while(j < ms_len){
                        let ms = Vector::borrow<MemberScore>(&journey.member_scores, j);
                        if(ms.user == user){
                            apprenticeship_score += ms.score;
                        }
                    }
                }
                let (t2, i2) = get_apprenticeship_member_score_index(a, user);
                if(!t2) {
                    assert(false, GUILD_APPRENTICESHIP_DOES_NOT_CONTAIN_MEMBER_SCORE);
                }
                let ams = Vector::borrow<MemberScore>(&a.member_scores, i2);
                ams.score = apprenticeship_score;
            }

            //@dev update the completion(MemberScore) of a Journey for a user.
            fun update_journey_completion(user: address, guild: address, name: vector<u8>) acquires Guild {
                assert(!exists<Guild>(address), ADDRESS_DOES_NOT_CONTAIN_GUILD);
                let g = borrow_global<Guild>(guild);
                let (t, i) = get_journey_index_by_name(guild, name);
                if(!t) {
                    assert(false, GUILD_DOES_NOT_CONTAIN_JOURNEY);
                }
                let j = Vector::borrow<Journey>(&g.journeys, i);
                let journey_length = Vector::length<Task>(&j.tasks);
                let journey_score = 0; 
                let i = 0;
                while(i < journey_length){
                    let t = Vector::borrow<Task>(&j.tasks, i);
                    let d_len = Vector::length<Deliverable>(&t.deliverable);
                    let j = 0;
                    while(j < d_len){
                        let d = Vector::borrow<Deliverable>(&t.deliverable, j);
                        if(d.user == user){
                            journey_score += d.score;
                        }
                    }
                }
                let (t2, i2) = get_journey_member_score_index(j, user);
                if(!t2) {
                    assert(false, GUILD_JOURNEY_DOES_NOT_CONTAIN_MEMBER_SCORE);
                }
                let jms = Vector::borrow<MemberScore>(&j.member_scores, i2);
                jms.score = journey_score;
            }

            //@dev Get the completion status(MemberScore) of an apprenticeship for a user.
            fun get_apprenticeship_percentage_completion(user: address, guild: address, name: vector<u8>) acquires Guild {
                assert(!exists<Guild>(address), ADDRESS_DOES_NOT_CONTAIN_GUILD);
                let g = borrow_global<Guild>(guild);
                let (t, i) = get_apprenticeship_index_by_name(guild, name);
                if(!t) {
                    assert(false, GUILD_DOES_NOT_CONTAIN_APPRENTICESHIP);
                }
                let a = Vector::borrow<Apprenticeship>(&g.apprenticeships, i);
                let ms_len = Vector::length<MemberScore>(&a.member_scores);
                let i = 0;
                while(i < ms_len){
                        let ms = Vector::borrow<MemberScore>(&a.member_scores, i);

                        if (ms.address == user) return (true, ms.score);

                        i = i + 1;
                    };
                    (false, 0)
            } 

   
            ///////// TASK INTERATIONS ////////

            fun add_deliverable(guild: address, task: vector<u8>, apprenticeship: vector<u8>, journey: vector<u8>) acquires Guild {
                assert(!exists<Guild>(address), ADDRESS_DOES_NOT_CONTAIN_GUILD);
                let g = borrow_global_mut<Guild>(guild);
                let d = Deliverable(
                    name: name,
                    score: 0,
                );
                let (t, i) = get_apprenticeship_index_by_name(guild, apprenticeship);
                if(!t) {
                    assert(false, GUILD_DOES_NOT_CONTAIN_APPRENTICESHIP);
                }
                let a = Vector::borrow_mut<Apprenticeship>(&mut g.apprenticeships, i);
                let (t2, i2) = get_journey_index_by_name(guild, journey);
                if(!t2) {
                    assert(false, GUILD_DOES_NOT_CONTAIN_JOURNEY);
                }
                let j = Vector::borrow_mut<Journey>(&mut a.journeys, i2);
                let (t3, i3) = get_task_index_by_name(guild, task);
                if(!t3) {
                    assert(false, GUILD_DOES_NOT_CONTAIN_TASK);
                }
                let t = Vector::borrow_mut<Task>(&mut j.tasks, i3);
                Vector::push(&mut t.deliverable, d);

                //bubble up completion to update scores.
                update_journey_completion(g.owner, guild, journey);
                update_apprenticeship_completion(g.owner, guild, apprenticeship);
                
            }



            ///////// UTILS ////////

            fun init_details(): Vector<Detail> acquires Detail{
                //creates a details array for a worker
                let details = Vector::empty<Detail>();
                //initialized with some defaults Alias, github, twitter, discord
                Vector::push_back<Detail>(details,Detail {key: 'alias',value: Vector::empty<u64>()});
                Vector::push_back<Detail>(details,Detail {key: 'github',value: Vector::empty<u64>()});
                Vector::push_back<Detail>(details,Detail {key: 'twitter',value: Vector::empty<u64>()});
                Vector::push_back<Detail>(details,Detail {key: 'discord',value: Vector::empty<u64>()});

                details
            }


            //TODO: make below three details functions reusable between guild and Member
            public fun add_detail(_sender: &signer, key: vector<u8>, value: vector<u8>) acquires Member, Details {
                let w = borrow_global_mut<Member>(_sender);
                Vector::push_back<Detail>(&w.details, Detail{
                    key: key,
                    value: value
                })
            }


            public fun remove_detail(_sender: &signer, key: vector<u8>) acquires Member, Details {
                let m = borrow_global_mut<Worker>(_sender);
                let (t,i) = get_index_by_key(Signer::address_of(_sender));
                assert(!t, KEY_DOES_NOT_EXIST); 
                    if (t) {
                        Vector::remove<Detail>(&mut m.details, i);
                    }
            }


            public fun change_detail(_sender: &signer, key: vector<u8>, value: vector<u8>) acquires Member, Details {
                let m = borrow_global_mut<Member>(_sender);
                let (t,i) = get_index_by_key(Signer::address_of(_sender));
                assert(!t, KEY_DOES_NOT_EXIST); 
                if (t) {
                    Vector::remove<Detail>(&mut m.details, i);
                    let d = Vector::borrow<Payment>(&mut m.details, i);
                    d.value = value;
                }
        
            }


            fun get_index_by_key(_worker: address, _key: Vector<u8>): (bool, u64) acquires Worker, Detail {
                let w = borrow_global<Worker>(_worker);
                let len = Vector::length<Detail>(&w.details);

                let i = 0;
                while (i < len) {
                    let d = Vector::borrow<Detail>(&w.details, i);

                    if (d.key == _key) return (true, i);

                    i = i + 1;
                };
                (false, 0)
            }
 

            // @dev removes an element from the list of payments, and returns in to scope.
            fun get_journey_index_by_name(_guild_addr: address, _name: vector<u64>): (bool, u64) acquires Guild {
                let g = borrow_global<Guild>(_guild_addr);

                let len = Vector::length<Journey>(&g.journeys);

                let i = 0;
                while (i < len) {
                    let j = Vector::borrow<Journey>(&g.journeys, i);

                    if (g.name == _name) return (true, i);

                    i = i + 1;
                };
                (false, 0)
            }


            // @dev removes an element from the list of payments, and returns in to scope.
            fun get_role_index_by_name(_guild_addr: address, _name: vector<u64>): (bool, u64) acquires Guild {
                let g = borrow_global<Guild>(_guild_addr);

                let len = Vector::length<Role>(&g.roles);

                let i = 0;
                while (i < len) {
                    let j = Vector::borrow<Role>(&g.roles, i);

                    if (j.name == _name) return (true, i);

                    i = i + 1;
                };
                (false, 0)
            }


            fun get_apprenticeship_index_by_name(_guild_addr: address, _name: vector<u64>): (bool, u64) acquires Guild {
                let g = borrow_global<Guild>(_guild_addr);

                let len = Vector::length<Apprenticeship>(&g.apprenticeships);

                let i = 0;
                while (i < len) {
                    let a = Vector::borrow<Apprenticeship>(&g.apprenticeship, i);

                    if (a.name == _name) return (true, i);

                    i = i + 1;
                };
                (false, 0)
            }


            fun get_apprenticeship_member_score_index(&mut _apprenticeship: Apprenticeship, user: address): (bool, u64) acquires Apprenticeship {
                let ms_len = Vector::length<MemberScore>(&_apprenticeship.member_scores);
                let i = 0;
                while (i < ms_len) {
                    let ms = Vector::borrow<MemberScore>(&_apprenticeship.member_scores, i);
                    if (ms.address == user) return (true,i);
                    i = i + 1;
                };
                (false,0)
            }


            fun get_journey_member_score_index(&mut _journey: Journey, user: address): (bool, u64) acquires Journey {
                let ms_len = Vector::length<MemberScore>(&_journey.member_scores);
                let i = 0;
                while (i < ms_len) {
                    let ms = Vector::borrow<MemberScore>(&_journey.member_scores, i);
                    if (ms.address == user) return (true,i);
                    i = i + 1;
                };
                (false,0)
            }
}
}