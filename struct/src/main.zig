const std = @import("std");
const print = std.debug.print;
const Channel = std.event.Channel;

const Timestamp = struct {
    seconds: i64,
    nanos: u32,

    pub fn unixEpoch() Timestamp {
        return Timestamp {
            .seconds = 0,
            .nanos = 0,
        };
    }
};

pub fn main() void {
    print("Hello, World\n",.{});
}
