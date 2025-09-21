const addmod = @import("./basic-arithmetic/add.zig");

pub export fn add_i32(a: i32, b: i32) i32 {
    return try addmod.add(i32, a, b);
}
