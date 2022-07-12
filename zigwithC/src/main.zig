const c = @cImport({
    @cInclude("unistd.h");
    @cInclude("stdio.h");
    @cInclude("stdlib.h");
    @cInclude("sys/types.h");
    @cInclude("sys/wait.h");
});
const std = @import("std");
const print = std.debug.print;

pub fn main() void {
    var pid: c.pid_t = c.fork();
    if (pid > 0) {
        print("child process {}\n", .{pid});
        c.exit(0);
    }
    _ = c.printf("OK\n");
}
