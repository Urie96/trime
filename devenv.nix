{ pkgs, ... }:

{
  env.BUILD_ABI = "arm64-v8a";
  env.BUILD_TIMESTAMP = "0";

  languages.kotlin.enable = true;

  android = {
    enable = true;

    # AGP 8.10+ requires build-tools >= 35.0.0
    buildTools.version = [ "35.0.0" ];

    # Trime's compileSdk/targetSdk is 35, which is not in the default
    # platform set (32/34/36).
    platforms.version = [
      "32"
      "34"
      "35"
      "36"
    ];

    # Trime pins cmake 3.31.6 and NDK 28 (native build), but the rolling
    # snapshot only ships cmake 3.22.1 / NDK 26.1; install the versions the
    # project expects.
    cmake.version = [ "3.31.6" ];
    ndk.version = [ "28.0.13004108" ];

    # System images + emulator are heavy; turn on if you need on-device testing.
    emulator.enable = false;
    systemImages.enable = false;
    sources.enable = false;

    # ABIs to fetch system images for (only relevant when emulator is on).
    abis = [
      "arm64-v8a"
    ];

    # Some add-ons/extras are not available in the rolling nixpkgs snapshot;
    # disable the ones that error out. Re-enable if your build needs them.
    googleAPIs.enable = false;
    googleTVAddOns.enable = false;
    extras = [ ];
    extraLicenses = [ ];
  };
}
