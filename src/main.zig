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

test "hasPrefix" {
    try testing.expect(hasPrefix("some-strings-value", "some"));
}

test "hasSuffix" {
    try testing.expect(hasSuffix("some-strings-value", "value"));
}
