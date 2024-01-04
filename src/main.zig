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
    const uri = try std.Uri.parse("https://api.time.ir/v1/time/fa/time/now");
    var req = try client
        .request(.GET, uri, headers, .{});
    defer req.deinit();

    try req.start();
    try req.wait();

    const body = try req.reader().readAllAlloc(allocator, 1024 * 1024);
    defer allocator.free(body);

    if(printBody) {
        std.debug.print("{s}", .{body});
    }

    const parsed = try std.json.parseFromSlice(
        models.TimeNowResponse,
        allocator,
        body,
        .{ .ignore_unknown_fields = true, .duplicate_field_behavior = .use_first }
    );
    defer parsed.deinit();

    const time = parsed.value.data.time;

    std.debug.print("{d}:{d}:{d}", .{time.hour, time.minute, time.second});
}
