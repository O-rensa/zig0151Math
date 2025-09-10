pub fn sub(comptime T: type, a: T, b: T) T {
    return a - b;
}

test "subtract integers" {
    const std = @import("std");
    try std.testing.expectEqual(@as(i32, 2), sub(i32, 5, 3));
}

test "subtract negative integers" {
    const std = @import("std");
    try std.testing.expectEqual(@as(i32, -8), sub(i32, -5, 3));
}

test "subtract with unsigned integers" {
    const std = @import("std");
    try std.testing.expectEqual(@as(u32, 2), sub(u32, 5, 3));
}

test "subtract floats" {
    const std = @import("std");
    try std.testing.expectEqual(@as(f64, 2.5), sub(f64, 5.5, 3.0));
}

test "subtract zero" {
    const std = @import("std");
    try std.testing.expectEqual(@as(i32, 10), sub(i32, 10, 0));
}
