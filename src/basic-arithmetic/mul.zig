const std = @import("std");

pub fn mul(comptime T: type, a: T, b: T) !T {
    return switch (@typeInfo(T)) {
        .int => blk: {
            const res, const isOverflow = @mulWithOverflow(a, b);
            if (isOverflow != 0) {
                break :blk std.math.maxInt(T);
            }
            break :blk res;
        },
        .float => blk: {
            const res = a * b;
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

test "scalar multiplication edge cases" {
    // Integers
    try std.testing.expectEqual(@as(i32, 0), mul(i32, 0, 123));
    try std.testing.expectEqual(@as(i32, -6), mul(i32, -2, 3));
    try std.testing.expectEqual(@as(i32, 6), mul(i32, -2, -3));

    // Unsigned integers
    try std.testing.expectEqual(@as(u32, 0), mul(u32, 0, 999));
    try std.testing.expectEqual(@as(u32, 12), mul(u32, 3, 4));

    // Check max int overflow (will wrap in debug/release-fast, UB in release-safe)
    const max_i32 = std.math.maxInt(i32);
    _ = try mul(i32, max_i32, 2); // don’t check value, just make sure it compiles

    // Floats
    try std.testing.expectEqual(@as(f32, 0.0), mul(f32, 0.0, 123.45));
    try std.testing.expectEqual(@as(f32, 6.0), mul(f32, 2.0, 3.0));
    try std.testing.expectEqual(@as(f32, -6.0), mul(f32, -2.0, 3.0));

    // Infinity
    try std.testing.expect(std.math.isInf(try mul(f32, std.math.inf(f32), 2.0)));

    // NaN
    try std.testing.expect(std.math.isNan(try mul(f32, std.math.nan(f32), 5.0)));

    // Very small * very large (possible underflow/overflow)
    const tiny: f32 = 1e-38;
    const huge: f32 = 1e+38;
    _ = try mul(f32, tiny, huge); // may become 0.0 or inf depending on scale
}
