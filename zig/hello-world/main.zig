const std = @import("std");


pub fn main() !void {
    // Via private stdout
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Hello world from Private Stdout\n", .{});

    // Via global stdout
    std.debug.print("Hello world! From global stdout\n", .{});
}

