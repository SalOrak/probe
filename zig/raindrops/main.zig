const std = @import("std");

pub fn main() !void {
    std.debug.print("Hello world\n", .{});
    
    const rainstring = try to_raindrops(83);
    std.debug.print("Raining to: {s}\n", .{rainstring});
}

pub fn to_raindrops(num: i32) ![]const u8 {

    const allocator = std.heap.page_allocator;
    // const str = std.fmt.allocPrint(allocator, "{d}", .{num});

    var ret = try std.fmt.allocPrint(allocator, "", .{});
    if (@mod(num,3) == 0 ) {
        ret = try std.fmt.allocPrint(allocator, "{s}Pling", .{ret});
    }
    if (@mod(num,5) == 0 ) {
        ret = try std.fmt.allocPrint(allocator, "{s}Plang", .{ret});
    }
    if (@mod(num,7) == 0 ) {
        ret = try std.fmt.allocPrint(allocator, "{s}Plong", .{ret});
    }

    if (ret.len <= 1 )
        ret = try std.fmt.allocPrint(allocator, "{d}", .{num});

    return ret;
}


const expect = std.testing.expect;
test to_raindrops {
    try expect(std.mem.eql(u8, try to_raindrops(1), "1"));
    try expect(std.mem.eql(u8, try to_raindrops(3), "Pling"));
    try expect(std.mem.eql(u8, try to_raindrops(5), "Plang"));
    try expect(std.mem.eql(u8, try to_raindrops(7), "Plong"));
    try expect(std.mem.eql(u8, try to_raindrops(9), "Pling"));
    try expect(std.mem.eql(u8, try to_raindrops(15), "PlingPlang"));
    try expect(std.mem.eql(u8, try to_raindrops(21), "PlingPlong"));
    try expect(std.mem.eql(u8, try to_raindrops(35), "PlangPlong"));
    try expect(std.mem.eql(u8, try to_raindrops(105), "PlingPlangPlong"));
}

