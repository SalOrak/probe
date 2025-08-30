
const std = @import("std");


const Color = enum {
    RED,
    BLUE,
    GREEN,
};

const Zone = enum {
    Zone1,
    Zone2,
    Zone3,
    Zone4,
};

const Ability = struct{
    damage: u8,
    color: Color,
};

const Monster = struct {
    health: u8,
    damage: u8,
    ability: Ability,
    is_alive: bool,
    zone: Zone,
};

const PackedMonster = struct {
    health: u8,
    damage: u8,
    zone: Zone,
};

pub fn main() void {
    const a = 2_400_000;
    for (0..80) |_| {
        process_oop_monsters(a); 
        // process_packed_monsters(a); 
    }
}

pub fn process_packed_monsters(comptime amount: u32) void {
    const amount_monsters = amount;
    var monsters_list : [amount_monsters]PackedMonster = undefined;
    var monsters_abilities : [amount_monsters]Ability= undefined;
    var monsters_alive_list: [amount_monsters]bool= undefined;
    for (0..amount_monsters) |i| {
        monsters_list[i] = PackedMonster{
            .health = 200,
            .damage = 30,
            .zone = Zone.Zone1,
        };
        monsters_abilities[i] = Ability{
            .damage = 47,
            .color = Color.RED,
        };
        monsters_alive_list[i] = if (i % 2 == 0)  true else false;
    }

    for (0..amount_monsters) |i| {
        monsters_list[i].health -= 1;
    }

    for (0..amount_monsters) |i| {
        if (monsters_alive_list[i]) {
            monsters_abilities[i] = Ability{.damage = 45, .color = Color.BLUE};
        }
        else {
            monsters_abilities[i] = Ability{.damage = 45, .color = Color.GREEN};
        }
    }
}


pub fn process_oop_monsters(comptime amount: u32) void {
    const amount_monsters = amount;
    var monsters_list : [amount_monsters]Monster= undefined;

    for (0..amount_monsters) |i| {
        monsters_list[i] = Monster{
            .health = 200,
            .damage = 30,
            .ability = Ability{
                .damage = 47,
                .color = Color.RED,
            },
            .is_alive = if ( i % 2 == 0 ) true else false,
            .zone = Zone.Zone1,
        };
    }

    for (0..amount_monsters) |i| {
        monsters_list[i].health -= 1;
    }

    for (0..amount_monsters) |i| {
        if (monsters_list[i].is_alive) {
            monsters_list[i].ability = Ability{.damage = 45, .color = Color.BLUE};
        }
        else {
            monsters_list[i].ability = Ability{.damage = 45, .color = Color.GREEN};
        }
    }
}


