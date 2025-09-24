const addmod = @import("basic-arithmetic/add.zig");
const submod = @import("basic-arithmetic/sub.zig");
const multmod = @import("basic-arithmetic/mul.zig");
const dividemod = @import("basic-arithmetic/div.zig");
const powmod = @import("basic-arithmetic/pow.zig");

// add u8
pub export fn add_u8(a: u8, b: u8) u8 {
    return addmod.add(u8, a, b) catch 0;
}

// add u16
pub export fn add_u16(a: u16, b: u16) u16 {
    return addmod.add(u16, a, b) catch 0;
}

// add i32
pub export fn add_i32(a: i32, b: i32) i32 {
    return addmod.add(i32, a, b) catch 0;
}

// add f64
pub export fn add_f64(a: f64, b: f64) f64 {
    return addmod.add(f64, a, b) catch 0;
}

// sub u8
pub export fn sub_u8(a: u8, b: u8) u8 {
    return submod.sub(u8, a, b) catch 0;
}

// sub u16
pub export fn sub_u16(a: u16, b: u16) u16 {
    return submod.sub(u16, a, b) catch 0;
}

// sub i32
pub export fn sub_i32(a: i32, b: i32) i32 {
    return submod.sub(i32, a, b) catch 0;
}

// sub f64
pub export fn sub_f64(a: f64, b: f64) f64 {
    return submod.sub(i32, a, b) catch 0;
}

// mult u8
pub export fn mult_u8(a: u8, b: u8) u8 {
    return multmod.mul(u8, a, b) catch 0;
}

// mult u16
pub export fn mult_u16(a: u16, b: u16) u16 {
    return multmod.mul(u16, a, b) catch 0;
}

// mult i32
pub export fn mult_i32(a: i32, b: i32) i32 {
    return multmod.mul(i32, a, b) catch 0;
}

// mult f64
pub export fn mult_f64(a: f64, b: f64) f64 {
    return multmod.mul(f64, a, b) catch 0;
}

// divide u8
pub export fn divide_u8(a: u8, b: u8) u8 {
    return dividemod.div(u8, a, b) catch 0;
}

// divide u16
pub export fn divide_u16(a: u16, b: u16) u16 {
    return dividemod.div(u16, a, b) catch 0;
}

// divide i32
pub export fn divide_i32(a: i32, b: i32) i32 {
    return dividemod.div(i32, a, b) catch 0;
}

// divide f64
pub export fn divide_f64(a: f64, b: f64) f64 {
    return dividemod.div(f64, a, b) catch 0;
}

// pow u8
pub export fn powx_u8(a: u8, b: u8) u8 {
    return powmod.powx(u8, a, b) catch 0;
}

// pow u16
pub export fn powx_u16(a: u16, b: u16) u16 {
    return powmod.powx(u16, a, b) catch 0;
}

// pow i32
pub export fn powx_i32(a: i32, b: i32) i32 {
    return powmod.powx(i32, a, b) catch 0;
}

// pow f64
pub export fn powx_f64(a: f64, b: f64) f64 {
    return powmod.powx(f64, a, b) catch 0;
}
