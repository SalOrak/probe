const std = @import("std");
const print = std.debug.print;

const Task = struct{
    n_ins: u256,
};

fn tt(comptime T: type) [3]T {
    var array: [3]T = undefined;

    array[0] = 3;
    array[1] = 2;
    array[2] = 1;

    return array;
}

pub fn main() !void {
    const fields = @typeInfo(Task).@"struct".fields;

    const array = tt(blk: {
        inline for (fields) |field| {
            if (std.mem.eql(u8, field.name,"n_ins")){
                break :blk field.type;
            }
            break :blk u8;
        }
    });

    print("{any}\n", .{@TypeOf(array)});


}
