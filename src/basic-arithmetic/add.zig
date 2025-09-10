const std = @import("std");

pub fn add(comptime T: type, a: T, b: T) !T {
    switch (@typeInfo(T)) {
        .int => {
            const res, const isOverflow = @addWithOverflow(a, b);
            if (isOverflow != 0) {
                return std.math.maxInt(T);
            }
            return res;
        },
        .float => {
            const res = a + b;
            if (res > std.math.floatMax(T)) {
                return std.math.floatMax(T);
            }
            if (res < -std.math.floatMax(T)) {
                return -std.math.floatMax(T);
            }
            return res;
        },
        else => {
            return error.TypeNotAllowed;
        },
    }
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
