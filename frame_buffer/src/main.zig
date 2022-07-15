const uefi = @import("std").os.uefi;
const L = @import("std").unicode.utf8ToUtf16LeStringLiteral;

// Assigned in main().
var con_out: *uefi.protocols.SimpleTextOutputProtocol = undefined;

pub fn main() void {
    con_out = uefi.system_table.con_out.?;
    const boot_services = uefi.system_table.boot_services.?;

    _ = con_out.reset(false);

    var graphics_output_protocol: ?*uefi.protocols.GraphicsOutputProtocol = undefined;
    if (boot_services.locateProtocol(&uefi.protocols.GraphicsOutputProtocol.guid, null, @ptrCast(*?*anyopaque, &graphics_output_protocol)) == uefi.Status.Success) {
        var frame_buffer = @intToPtr([*]u8, graphics_output_protocol.?.mode.frame_buffer_base);
        var i: usize = 0;
        while (i < graphics_output_protocol.?.mode.frame_buffer_size): (i += 1) {
            frame_buffer[i] = @intCast(u8, i % 256);
        }
    }
    
    _ = con_out.outputString(L("Hello UEFI!\r\n"));
    _ = boot_services.stall(5 * 1000 * 1000);
}
