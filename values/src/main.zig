const print = std.debug.print;
const std = @import("std");
const os = std.os;
const assert = std.debug.assert;

pub fn main() void {
    const one_plus_one: i32 = 1 + 1;
    print("1 + 1 = {}\n", .{one_plus_one});

    const seven_div_three: f32 = 7.0 / 3.0;
    print("7.0 / 3.0 = {}\n", .{seven_div_three});

    print("{}\n{}\n{}\n", .{
        true and false,
        true or true,
        !true,
    });

    var optional_value: ?[]const u8 = null;
    assert(optional_value == null);

    print("\noptional 1\ntype: {s}\nvalue: {s}\n", .{
        @typeName(@TypeOf(optional_value)),
        optional_value,
    });

    optional_value = "hi";
    assert(optional_value != null);

    print("\noptional 2\ntype:{s}\nvalue: {s}\n",.{
        @typeName(@TypeOf(optional_value)),
        optional_value,
    });
}

pub fn fib(n: i32) i32 {
    if (n == 0) {
        return 0;
    } else if (n == 1) {
        return 1;
    }
    return fib(n - 1) + fib(n - 2);
}
