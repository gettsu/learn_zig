const std=@import("std");
const uefi = std.os.uefi;
const L = std.unicode.utf8ToUtf16LeStringLiteral;
const LR = std.unicode.utf8ToUtf16LeWithNull;
const fmt = std.fmt;
const MemoryDescriptor = uefi.tables.MemoryDescriptor;

var memory_map: [4096 * 4] u8 = undefined;

var con_out: *uefi.protocols.SimpleTextOutputProtocol = undefined;

pub fn main() void {
    var str_buf: [256] u8 = undefined;
    var bfa = std.heap.FixedBufferAllocator.init(str_buf[0..]);
    const allocator = bfa.allocator();

    con_out = uefi.system_table.con_out.?;

    _ = con_out.reset(false);

    const boot_services = uefi.system_table.boot_services.?;

    var buf: [256]u8 = undefined;

    var memory_map_size: usize = @sizeOf(uefi.tables.MemoryDescriptor) * 200;
    var memory_map_key: usize = undefined;
    var descriptor_size: usize = undefined;
    var descriptor_version: u32 = undefined;

    if (boot_services.getMemoryMap(&memory_map_size, @ptrCast([*]MemoryDescriptor, &memory_map), &memory_map_key, &descriptor_size, &descriptor_version) == uefi.Status.BufferTooSmall) {
        _ = con_out.outputString(L("TOO SMALL"));
        while (true) {}
    }

    var i:usize = 0;
    var tmp: [*]u8 = &memory_map;
    while (i < 23) : (i += 1) {
        const memory_mapb = @ptrCast([*]MemoryDescriptor, @alignCast(8, tmp));
        const memory_str = fmt.bufPrint(buf[0..],"type={s:20} physical=0x{x:0>8} virtual=0x{x:0>8} page={:8}\r\n", .{@tagName(memory_mapb[0].type),memory_mapb[0].physical_start, memory_mapb[0].virtual_start, memory_mapb[0].number_of_pages}) catch unreachable;
        const utf16_str = LR(allocator, memory_str) catch unreachable;
        _ = con_out.outputString(utf16_str);
        allocator.free(utf16_str);
        tmp += @intCast(u8, descriptor_size);
    }

    while (true) {}
    _ = boot_services.stall(15 * 1000 * 1000);
}
