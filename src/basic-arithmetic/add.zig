pub fn add(comptime T: type, a: T, b: T) T {
    return a + b;
}

test "add int32" {
    const std = @import("std");
    try std.testing.expectEqual(@as(i32, 7), add(i32, 3, 4));
}
test "add int32WithNegative" {
    const std = @import("std");
    try std.testing.expectEqual(@as(i32, -6), add(i32, -10, 4));
}
test "add int32BothNegative" {
    const std = @import("std");
    try std.testing.expectEqual(@as(i32, -10), add(i32, -5, -5));
}
test "add float32" {
    const std = @import("std");
    try std.testing.expectEqual(@as(f32, 8), add(f32, 3.5, 4.5));
}
test "add float32WithNegative" {
    const std = @import("std");
    try std.testing.expectEqual(@as(f32, 3.2), add(f32, 5.5, -2.3));
}
test "add float32BothNegative" {
    const std = @import("std");
    try std.testing.expectEqual(@as(f32, -7.2), add(f32, -3.6, -3.6));
}
