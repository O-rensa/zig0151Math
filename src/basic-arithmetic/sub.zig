const std = @import("std");

pub fn sub(comptime T: type, a: T, b: T) !T {
    return switch (@typeInfo(T)) {
        .int => blk: {
            const res, const isOverflow = @subWithOverflow(a, b);
            if (isOverflow != 0) {
                break :blk std.math.minInt(T);
            }
            break :blk res;
        },
        .float => blk: {
            const res = a - b;
            if (std.math.isInf(res)) {
                break :blk res;
            }
            if (res > std.math.floatMax(T)) {
                break :blk std.math.floatMax(T);
            }
            if (res < -std.math.floatMax(T)) {
                break :blk -std.math.floatMax(T);
            }
            break :blk res;
        },
        else => blk: {
            break :blk error.TypeNotAllowed;
        },
    };
}

test "subtract integers" {
    try std.testing.expectEqual(@as(i32, 2), sub(i32, 5, 3));
}
test "subtract negative integers" {
    try std.testing.expectEqual(@as(i32, -8), sub(i32, -5, 3));
}
test "subtract with unsigned integers" {
    try std.testing.expectEqual(@as(u32, 2), sub(u32, 5, 3));
}
test "subtract floats" {
    try std.testing.expectEqual(@as(f64, 2.5), sub(f64, 5.5, 3.0));
}
test "subtract zero" {
    try std.testing.expectEqual(@as(i32, 10), sub(i32, 10, 0));
}
test "sub with ints - normal and edge cases" {
    // normal subtraction
    try std.testing.expectEqual(@as(i32, 5), sub(i32, 10, 5));
    try std.testing.expectEqual(@as(i32, -5), sub(i32, 0, 5));

    // edge: underflow (clamp to minInt)
    try std.testing.expectEqual(@as(i32, std.math.minInt(i32)), sub(i32, std.math.minInt(i32), 1));

    // edge: subtracting 0
    try std.testing.expectEqual(@as(i32, 42), sub(i32, 42, 0));
}
test "sub with floats - normal and edge cases" {
    // normal subtraction
    try std.testing.expectEqual(@as(f32, 5.0), sub(f32, 10.0, 5.0));
    try std.testing.expectEqual(@as(f32, -5.0), sub(f32, 0.0, 5.0));

    // edge: positive overflow (clamp to +floatMax)
    try std.testing.expectEqual(@as(f32, std.math.floatMax(f32)), sub(f32, std.math.floatMax(f32), -1.0));

    // edge: negative overflow (clamp to -floatMax)
    try std.testing.expectEqual(@as(f32, -std.math.floatMax(f32)), sub(f32, -std.math.floatMax(f32), 1.0));

    // edge: subtracting 0
    try std.testing.expectEqual(@as(f32, 42.0), sub(f32, 42.0, 0.0));

    // edge: Infinity handling
    const inf = std.math.inf(f32);
    try std.testing.expectEqual(inf, sub(f32, inf, 1.0));
    try std.testing.expectEqual(-inf, sub(f32, -inf, 1.0));

    // edge: NaN handling (NaN != NaN, so check with isNan)
    const nan = std.math.nan(f32);
    const res = try sub(f32, nan, 1.0);
    try std.testing.expect(std.math.isNan(res));
}
test "add: unsupported type" {
    const result = sub(bool, true, false);
    try std.testing.expectError(error.TypeNotAllowed, result);
}
