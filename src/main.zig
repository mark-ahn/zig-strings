const std = @import("std");
const testing = std.testing;

pub fn hasPrefix(s: []const u8, prefix: []const u8) bool {
    if (s.len < prefix.len) return false;
    return std.mem.eql(u8, s[0..prefix.len], prefix);
}

pub fn hasSuffix(s: []const u8, suffix: []const u8) bool {
    if (s.len < suffix.len) return false;
    return std.mem.eql(u8, s[s.len - suffix.len ..], suffix);
}

pub fn trimPrefix(s: []const u8, prefix: []const u8) []const u8 {
    if (!hasPrefix(s, prefix)) return s;
    return s[prefix.len..];
}

pub fn trimSuffix(s: []const u8, suffix: []const u8) []const u8 {
    if (!hasSuffix(s, suffix)) return s;
    return s[0..(s.len - suffix.len)];
}

test "hasPrefix" {
    try testing.expect(hasPrefix("some-strings-value", "some"));
}

test "hasSuffix" {
    try testing.expect(hasSuffix("some-strings-value", "value"));
}

test "trimPrefix" {
    try testing.expect(std.mem.eql(u8, trimPrefix("some-strings-value", "some"), "-strings-value"));
}

test "trimSuffix" {
    try testing.expect(std.mem.eql(u8, trimSuffix("some-strings-value", "value"), "some-strings-"));
}
