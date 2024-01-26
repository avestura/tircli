const std = @import("std");
const models = @import("./models.zig");
const http = std.http;

const printBody = false;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer {
        _ = gpa.deinit();
    }
    const allocator = gpa.allocator();
    var headers = http.Headers{ .allocator = allocator };
    defer headers.deinit();

    // Public API-Key is copied from time's website
    try headers.append("X-Api-Key", "ZAVdqwuySASubByCed5KYuYMzb9uB2f7");

    var client = http.Client{ .allocator = allocator };
    defer client.deinit();
    var res = try client.fetch(allocator, .{
        .location = .{ .url = "https://api.time.ir/v1/time/fa/time/now" },
        .headers = headers,
    });
    defer res.deinit();

    const body = res.body orelse return error.NoResponseBody;

    if (printBody) {
        std.debug.print("{s}", .{body});
    }

    const parsed = try std.json.parseFromSlice(
        models.TimeNowResponse,
        allocator,
        body,
        .{ .ignore_unknown_fields = true, .duplicate_field_behavior = .use_first },
    );
    defer parsed.deinit();

    const time = parsed.value.data.time;

    std.debug.print("{d}:{d}:{d}", .{ time.hour, time.minute, time.second });
}
