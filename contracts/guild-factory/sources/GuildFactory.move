// SPDX-License-Identifier: MIT

/// @title GuildFactory
/// @notice Create composable guilds for public use.
/// @dev This is a factory for creating `Guild`s.


address STD {
    module GuildFactory {
            use Std::GAS::GAS;
            use Std::Vector;
            use Std::Signer;
            use Std::DiemConfig;
            use Std::Diem;
            use Std::DiemAccount;

            const ADDRESS_DOES_NOT_CONTAIN_GUILD = 1;
            const GUILD_DOES_NOT_CONTAIN_JOURNEY = 2;

            // @dev The member resource that is store on a users account to track their memberships.
            struct Member has key, store {
                memberships: Vector<address>,
                details: vector<Detail>,
            }

            // @dev The membership resource that is stored on a member and guild account to track.
            struct Membership has key, copy {
                guild: address,
                user: address,
                role: u64,
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
                journeys: Vector<Journey>,
                apprenticeships: Vector<Apprenticeship>,
                details: Vector<Detail>,
                created: u64,
                updated: u64,
                active: bool,
            }

            // @dev reputation keeps track of the credentials a member earns in a guild and if their peers support them.
            struct Reputation {
                vouchers: vector<Vouch>,
                credentials: vector<Apprenticeship>,

            }

            // @dev apprenticeships is a badge of honor that a member would get after completing a set of journeys.
            struct Apprenticeship {
                name: string,
                description: string,
                journeys: Vector<Journey>,
                created: u64,
                updated: u64,
                active: bool,
            }

            // @dev journeys consist of a group of tasks that would help them learn a particular skill or complete a mission.
            struct Journey {
                name: string,
                description: string,
                tasks: Vector<Task>,
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



            // @dev create guild, two values must be specified.
            public entry fun init_guild(sender: &signer, name: vector<u8>, description: vector<u8> ) { 
                let g = Guild(
                    name: name,
                    description: description,
                    constitution: Vector::empty<Vector<u8>>(),
                    members: Vector::empty<Memberships>(),
                    roles: Vector::empty<Role>(),
                    journeys: Vector::empty<Journey>(),
                    apprenticeships: Vector::empty<Apprenticeship>(),
                    details: Vector::empty<Detail>(),
                    created: DiemConfig::get_current_epoch(),
                    updated: DiemConfig::get_current_epoch(),
                    active: true,
                );

                move_to<Guild>(_sender, g)
            }


            fun init_member(_sender: &signer) {
            if (!exists<Member>(Signer::address_of(_sender))) {
                let new_details = init_details();
                move_to<Member>(_sender, Member {
                    memberships: Vector::empty<address>(),
                    details: new_details,
                })
            }
            }

            fun create_membership(_sender: &signer, guild: address) {
                assert(!exists<Guild>(address), ADDRESS_DOES_NOT_CONTAIN_GUILD);

                //create member resource on sender if they do not currently have it.
                init_member(_sender);
                let g = borrow_global<Guild>(guild)
                let u = borrow_global<Member>(Signer::address_of(_sender))
                let r = Reputation();
                let m = Membership(
                    guild: guild,
                    user: Signer::address_of(_sender),
                    role: Vector::empty<u64>(),
                    level: Vector::empty<u64>(),
                    reputation: new Reputation(),
                );
                Vector::push_back<address>(&u.memberships, guild);
                Vector::push_back<Membership>(&g.members, m);

            }

            // @dev create a new journey for a guild.
            fun create_journey(guild: address, name: vector<u8>, description: vector<u8>) acquires Guild {
                assert(!exists<Guild>(address), ADDRESS_DOES_NOT_CONTAIN_GUILD);

                let g = borrow_global<Guild>(guild)
                let j = Journey(
                    name: name,
                    description: description,
                    tasks: Vector::empty<Task>(),
                    created: DiemConfig::get_current_epoch(),
                    updated: DiemConfig::get_current_epoch(),
                    active: true,
                );
                Vector::push_back<Journey>(&g.journeys, j);
            }

            fun create_task(guild: address, journey: vector<u8>, name: vector<u8>, description: vector<u8>) {
                assert(!exists<Guild>(address), ADDRESS_DOES_NOT_CONTAIN_GUILD);


                let g = borrow_global<Guild>(guild)
                let (t, i) = get_index_by_name(guild, name);
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


            //guild
            //TODO: add constitution to guild
            
            //journeys and tasks
            //TODO: add deliverable to task
            //TODO: get apprenticeship progress









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

            // @dev removes an element from the list of payments, and returns in to scope.
            // need to add it back to the list
            fun get_index_by_name(_guild_addr: address, _name: vector<u64>): (bool, u64) acquires Guild {
            let g = borrow_global<Guild>(_guild_addr);

            let len = Vector::length<Journey>(&g.journeys);

            let i = 0;
            while (i < len) {
                let j = Vector::borrow<Journey>(&g.journeys, i);

                if (p.name == _name) return (true, i);

                i = i + 1;
            };
            (false, 0)
            }


    }
}