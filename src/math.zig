const addmod = @import("basic-arithmetic/add.zig");
const submod = @import("basic-arithmetic/sub.zig");
const multmod = @import("basic-arithmetic/mul.zig");
const dividemod = @import("basic-arithmetic/div.zig");

// add u8
pub export fn add_u8(a: u8, b: u8) u8 {
    return try addmod.add(u8, a, b);
}

// add u16
pub export fn add_u16(a: u16, b: u16) u16 {
    return try addmod.add(u16, a, b);
}

// add i32
pub export fn add_i32(a: i32, b: i32) i32 {
    return try addmod.add(i32, a, b);
}

// add f64
pub export fn add_f64(a: f64, b: f64) f64 {
    return try addmod.add(f64, a, b);
}

// sub u8

// sub u16

// sub i32
pub export fn sub_i32(a: i32, b: i32) i32 {
    return try submod.sub(i32, a, b);
}

// sub f64
pub export fn sub_f64(a: i32, b: i32) i32 {
    return try submod.sub(i32, a, b);
}

// mult u8

// mult u16

// mult i32

// mult f64

// divide u8

// divide u16

// divide i32

// divide f64
