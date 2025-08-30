const std = @import("std");
const Allocator = std.mem.Allocator;
const ArrayList = std.ArrayList;
const assert = std.debug.assert;

pub fn main() !void {
    std.debug.print("Hello world!\n", .{});

    const alloc = std.heap.page_allocator;

    var stack = Stack(u32).init(alloc);
    defer stack.deinit();

    try stack.push(1);
    try stack.push(3);
    try stack.push(6);
    try stack.push(8);

    assert(stack.pop() == 8);
    assert(stack.pop() == 6);

}


pub fn Stack(comptime T: type ) type {
    return struct {
        const Self = @This();
        allocator: Allocator,
        items: std.ArrayListAligned(T, null) ,
        last: ?T,

        pub fn init(allocator: Allocator) Self {
            return Self {
                .allocator = allocator,
                .items = std.ArrayList(T).init(allocator),
                .last = null,
            };
        }

        pub fn push(self: *Self, value: T) !void {
            try self.items.append(value);
        }

        pub fn pop(self: *Self) ?T {
            return self.items.pop();
        }

        pub fn deinit(self: Self) void {
            self.items.deinit();
        }
    };

}
