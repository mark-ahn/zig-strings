const std = @import("std");
const testing = std.testing;

pub fn hasPrefix(s: []const u8, prefix: []const u8) bool {
    if (s.len < prefix.len) return false;
    return std.mem.eql(u8, s[0..prefix.len], prefix);
}
test "hasPrefix" {
    try testing.expect(hasPrefix("some-strings-value", "some"));
}

pub fn hasSuffix(s: []const u8, suffix: []const u8) bool {
    if (s.len < suffix.len) return false;
    return std.mem.eql(u8, s[s.len - suffix.len ..], suffix);
}
test "hasSuffix" {
    try testing.expect(hasSuffix("some-strings-value", "value"));
}

pub fn trimPrefix(s: []const u8, prefix: []const u8) []const u8 {
    if (!hasPrefix(s, prefix)) return s;
    return s[prefix.len..];
}
test "trimPrefix" {
    try testing.expect(std.mem.eql(u8, trimPrefix("some-strings-value", "some"), "-strings-value"));
}

pub fn trimSuffix(s: []const u8, suffix: []const u8) []const u8 {
    if (!hasSuffix(s, suffix)) return s;
    return s[0..(s.len - suffix.len)];
}
test "trimSuffix" {
    try testing.expect(std.mem.eql(u8, trimSuffix("some-strings-value", "value"), "some-strings-"));
}

pub fn trimSpace(s: []const u8) []const u8 {
    if (s.len == 0) return s;
    var start: usize = 0;
    var end = s.len;
    for (s, 0..) |c, i| {
        if (!std.ascii.isWhitespace(c)) break;
        start = i + 1;
    }
    while (start < end) : (end -= 1) {
        const c = s[end - 1];
        if (!std.ascii.isWhitespace(c)) break;
    }
    return s[start..end];
}
test trimSpace {
    try testing.expect(std.mem.eql(u8, trimSpace("        "), ""));
    try testing.expect(std.mem.eql(u8, trimSpace(""), ""));
    try testing.expectEqualSlices(u8, "any  string", trimSpace("  any  string   "));
    try testing.expectEqualSlices(u8, "any  string", trimSpace("  any  string"));
    try testing.expectEqualSlices(u8, "any  string", trimSpace("any  string   "));
}

pub fn toLower(allocator: std.mem.Allocator, s: []const u8) ![]u8 {
    var v = try allocator.alloc(u8, s.len);
    for (s, 0..) |c, i| {
        v[i] = std.ascii.toLower(c);
    }
    return v;
}
test toLower {
    const str = try toLower(testing.allocator, "SOME_UPPER_CASE");
    defer testing.allocator.free(str);
    try testing.expect(std.mem.eql(u8, str, "some_upper_case"));
}

pub fn toUpper(allocator: std.mem.Allocator, s: []const u8) ![]u8 {
    var v = try allocator.alloc(u8, s.len);
    for (s, 0..) |c, i| {
        v[i] = std.ascii.toUpper(c);
    }
    return v;
}

test toUpper {
    const str = try toUpper(testing.allocator, "some_upper_case");
    defer testing.allocator.free(str);
    try testing.expect(std.mem.eql(u8, str, "SOME_UPPER_CASE"));
}
