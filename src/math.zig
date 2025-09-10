pub fn add(comptime T: type, a: T, b: T) T {
    return a + b;
}

// tests
test "add test" {
    const std = @import("std");
    try std.testing.expectEqual(@as(i32, 5), add(i32, 2, 3));
}
