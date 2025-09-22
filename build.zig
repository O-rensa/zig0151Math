const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const math_basic_mod = b.addModule("basicmod", .{
        .root_source_file = b.path("src/basic.zig"),
        .target = target,
        .optimize = optimize,
    });

    const math_basic_lib = b.addLibrary(.{
        .name = "mathbasic",
        .linkage = .static,
        .root_module = math_basic_mod,
    });

    b.installArtifact(math_basic_lib);
}
