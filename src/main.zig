const std = @import("std");
const http = std.http;

const TimeNowResponse = struct {
    message: []u8,
    data: struct {
        astrological_sign: []u8,
        gregorian: struct {
            year: u32,
            month: u32,
            day: u32,
            day_title: []u8,
            day_title_small: []u8,
            month_title: []u8,
            month_title_small: []u8,
            object_name: []u8
        },
        jalali: struct {
            year: u32,
            month: u32,
            day: u32,
            day_title: []u8,
            day_title_small: []u8,
            month_title: []u8,
            month_title_small: ?[]u8,
            object_name: []u8
        },
        hijri: struct {
            year: u32,
            month: u32,
            day: u32,
            day_title: []u8,
            day_title_small: []u8,
            month_title: []u8,
            month_title_small: ?[]u8,
            object_name: []u8
        },
        time: struct {
            hour: u32,
            minute: u32,
            second: u32,
            milli_second: u32,
            object_name: []u8
        },
    }
};

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
        TimeNowResponse,
        allocator,
        body,
        .{ .ignore_unknown_fields = true, .duplicate_field_behavior = .use_first }
    );
    defer parsed.deinit();

    const time = parsed.value.data.time;

    std.debug.print("{d}:{d}:{d}", .{time.hour,time.minute, time.second});
}
