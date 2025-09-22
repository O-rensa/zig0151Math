const std = @import("std");

pub fn powx(comptime T: type, a: T, b: T) !T {
    return switch (@typeInfo(T)) {
        .int => blk: {
            const result = std.math.powi(T, a, b);
            break :blk result;
        },
        .float => blk: {
            const result = std.math.pow(T, a, b);
            break :blk result;
        },
        else => blk: {
            break :blk error.TypeNotAllowed;
        },
    };
}

test "powx float basic" {
    try std.testing.expectEqual(@as(f64, 8.0), try powx(f64, 2.0, 3.0));
    try std.testing.expectEqual(@as(f32, 1.0), try powx(f32, 9.0, 0.0));
    try std.testing.expectEqual(@as(f32, 0.0), try powx(f32, 0.0, 5.0));
}

test "powx float negative exponent" {
    try std.testing.expectApproxEqAbs(@as(f64, 0.5), try powx(f64, 2.0, -1.0), 1e-10);
}

test "powx float large exponent" {
    const result = try powx(f64, 2.0, 1024.0);
    try std.testing.expect(std.math.isInf(result));
}

test "powx wrong type" {
    const result = powx(bool, true, true);
    try std.testing.expectError(error.TypeNotAllowed, result);
}
