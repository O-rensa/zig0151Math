const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const mathModule = b.addModule("zig0151Math", .{
        .root_source_file = b.path("src/math.zig"),
        .target = target,
        .optimize = optimize,
    });

    //mathModule.addImport("addmod", addModule);

    const lib = b.addLibrary(.{
        .name = "mathlib",
        .linkage = .static,
        .root_module = mathModule,
    });
    b.installArtifact(lib);
}
