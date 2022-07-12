const std = @import("std");
const expect = std.testing.expect;

fn LinkedList(comptime T: type) type {
    return struct {
        pub const Node = struct {
            prev: ?*Node,
            next: ?*Node,
            data: T,
        };

        first: ?*Node,
        last: ?* Node,
        len: usize,
    };
}

test "linked list" {
    try expect(LinkedList(i32) == LinkedList(i32));

    var list = LinkedList(i32) {
        .first = null,
        .last = null,
        .len = 0,
    };
    try expect(list.len == 0);

    const ListOfints = LinkedList(i32);
    try expect(ListOfints == LinkedList(i32));

    var node = ListOfints.Node {
        .prev = null,
        .next = null,
        .data = 1234,
    };
    var list2 = LinkedList(i32) {
        .first = &node,
        .last = &node,
        .len = 1,
    };
    try expect(list2.first.?.data == 1234);
}
