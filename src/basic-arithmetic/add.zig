const std = @import("std");

pub fn add(comptime T: type, a: T, b: T) !T {
    return switch (@typeInfo(T)) {
        .int => blk: {
            const res, const isOverflow = @addWithOverflow(a, b);
            if (isOverflow != 0) {
                break :blk std.math.maxInt(T);
            }
            break :blk res;
        },
        .float => blk: {
            const res = a + b;
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

test "add int32" {
    try std.testing.expectEqual(@as(i32, 7), add(i32, 3, 4));
}
test "add int32WithNegative" {
    try std.testing.expectEqual(@as(i32, -6), add(i32, -10, 4));
}
test "add int32BothNegative" {
    try std.testing.expectEqual(@as(i32, -10), add(i32, -5, -5));
}
test "add float32" {
    try std.testing.expectEqual(@as(f32, 8), add(f32, 3.5, 4.5));
}
test "add float32WithNegative" {
    try std.testing.expectEqual(@as(f32, 3.2), add(f32, 5.5, -2.3));
}
test "add float32BothNegative" {
    try std.testing.expectEqual(@as(f32, -7.2), add(f32, -3.6, -3.6));
}
test "add: integer correctness" {
    try std.testing.expectEqual(@as(i32, 7), add(i32, 3, 4));
    try std.testing.expectEqual(@as(i64, -1), add(i64, -2, 1));
}
test "add: integer overflow" {
    const max_i32 = std.math.maxInt(i32);
    try std.testing.expectEqual(max_i32, add(i32, max_i32, 1));
    try std.testing.expectEqual(max_i32, add(i32, max_i32, max_i32));
}
test "add: float correctness" {
    try std.testing.expectEqual(@as(f32, 7.5), add(f32, 3.2, 4.3));
    try std.testing.expectEqual(@as(f64, -1.0), add(f64, -2.5, 1.5));
}
test "add: float overflow" {
    const max_f32 = std.math.floatMax(f32);
    try std.testing.expectEqual(max_f32, add(f32, max_f32, 1.0));
    try std.testing.expectEqual(-max_f32, add(f32, -max_f32, -1.0));
}
test "add: unsupported type" {
    const result = add(bool, true, false);
    try std.testing.expectError(error.TypeNotAllowed, result);
}
test "add with ints - normal and edge cases" {
    // normal addition
    try std.testing.expectEqual(@as(i32, 15), add(i32, 10, 5));
    try std.testing.expectEqual(@as(i32, -5), add(i32, 0, -5));

    // edge: overflow (clamp to maxInt)
    try std.testing.expectEqual(@as(i32, std.math.maxInt(i32)), add(i32, std.math.maxInt(i32), 1));

    // edge: adding zero
    try std.testing.expectEqual(@as(i32, 42), add(i32, 42, 0));
}
test "add with floats - normal and edge cases" {
    // normal addition
    try std.testing.expectEqual(@as(f32, 15.0), add(f32, 10.0, 5.0));
    try std.testing.expectEqual(@as(f32, -5.0), add(f32, 0.0, -5.0));

    // edge: positive overflow (clamp to +floatMax)
    try std.testing.expectEqual(@as(f32, std.math.floatMax(f32)), add(f32, std.math.floatMax(f32), 1.0));

    // edge: negative overflow (clamp to -floatMax)
    try std.testing.expectEqual(@as(f32, -std.math.floatMax(f32)), add(f32, -std.math.floatMax(f32), -1.0));

    // edge: adding zero
    try std.testing.expectEqual(@as(f32, 42.0), add(f32, 42.0, 0.0));

    // edge: Infinity handling
    const inf = std.math.inf(f32);
    try std.testing.expectEqual(inf, add(f32, inf, 1.0));
    try std.testing.expectEqual(-inf, add(f32, -inf, -1.0));

    // edge: NaN handling
    const nan = std.math.nan(f32);
    const res = try add(f32, nan, 1.0);
    try std.testing.expect(std.math.isNan(res));
}
