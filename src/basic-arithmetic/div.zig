const std = @import("std");

pub fn div(comptime T: type, a: T, b: T) !T {
    return switch (@typeInfo(T)) {
        .int => blk: {
            break :blk std.math.divExact(T, a, b);
        },
        .float => blk: {
            break :blk a / b;
        },
        else => blk: {
            break :blk error.TypeNotAllowed;
        },
    };
}

test "integer division edge cases" {
    // Normal division
    try std.testing.expectEqual(@as(i32, 2), try div(i32, 6, 3));

    // Division by zero
    try std.testing.expectError(error.DivisionByZero, div(i32, 5, 0));

    // Overflow (minInt / -1)
    try std.testing.expectError(error.Overflow, div(i32, std.math.minInt(i32), -1));

    // Negative combinations
    try std.testing.expectEqual(@as(i32, -2), try div(i32, 6, -3));
    try std.testing.expectEqual(@as(i32, -2), try div(i32, -6, 3));
    try std.testing.expectEqual(@as(i32, 2), try div(i32, -6, -3));

    // Boundaries
    try std.testing.expectEqual(std.math.maxInt(i32), try div(i32, std.math.maxInt(i32), 1));
    try std.testing.expectEqual(std.math.minInt(i32), try div(i32, std.math.minInt(i32), 1));
    try std.testing.expectEqual(@as(i32, 0), try div(i32, 0, 123));
}

test "float division edge cases" {
    // Normal division
    try std.testing.expectEqual(@as(f32, 2.0), try div(f32, 6.0, 3.0));

    // Division by zero
    try std.testing.expect(std.math.isPositiveInf(try div(f64, 1.0, 0.0)));
    try std.testing.expect(std.math.isNegativeInf(try div(f64, -1.0, 0.0)));
    try std.testing.expect(std.math.isNan(try div(f64, 0.0, 0.0)));

    // Negative combinations
    try std.testing.expectEqual(@as(f32, -2.0), try div(f32, 6.0, -3.0));
    try std.testing.expectEqual(@as(f32, -2.0), try div(f32, -6.0, 3.0));
    try std.testing.expectEqual(@as(f32, 2.0), try div(f32, -6.0, -3.0));

    // Infinity behavior (finite / inf = 0.0)
    try std.testing.expectEqual(@as(f32, 0.0), try div(f32, 5.0, std.math.inf(f32)));

    // Infinity / finite = inf
    try std.testing.expectEqual(std.math.inf(f32), try div(f32, std.math.inf(f32), 2.0));
}
