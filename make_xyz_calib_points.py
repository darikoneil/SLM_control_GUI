from pathlib import Path
from shutil import copy, move
from tqdm import tqdm


def make_xyz_images(src: Path,
                    dst: Path,
                    step_size: int = 50,
                    num_steps: int = 4,
                    verbose: bool = True) -> None:

    assert src.is_file(), "Source file does not exist."
    assert dst.is_dir(), "Destination directory does not exist."


    if verbose:
        print(f"Generating  calibration images with {step_size} micron step size and "
              f"a maximum displacement of {step_size*num_steps} microns.")

    ext = src.suffix
    dst_temp = dst.joinpath(src.name).with_suffix(ext)
    max_displacement = step_size * num_steps
    min_displacement = max_displacement * -1
    steps = list(range(min_displacement, max_displacement + step_size, step_size))

    files = {f"xyz_x{step}_y0_z0" for step in steps}
    files = files.union({f"xyz_x0_y{step}_z0" for step in steps})

    for file in tqdm(files):
        copy(src, dst)
        move(dst_temp, dst.joinpath(file).with_suffix(ext))

if __name__ == "__main__":
    src_ = Path(R"C:\Users\rylab_901c_slm\Desktop\darik_shared_dump\all-016_Cycle00002_Ch1_000001.ome.tif")
    dst_ = Path(R"C:\Users\rylab_901c_slm\Desktop\darik_shared_dump\02_09_2025\xyz_stim")
    make_xyz_images(src_, dst_)
