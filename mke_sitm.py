from pathlib import Path
import numpy as np
import polars as pl
import matplotlib

matplotlib.use("QtAgg")
matplotlib.interactive(True)
from matplotlib import pyplot as plt

config_dir = Path.cwd()


def make_slm_pattern_vector(num_neurons: int,
              initial_delay: int,
              stim_duration: int,
              stim_interval: int,
              max_voltage: float = 5.0):
    total_duration = initial_delay + (stim_duration + stim_interval) * num_neurons
    voltage_step = max_voltage / num_neurons
    neuron_ids = np.arange(voltage_step, max_voltage + voltage_step, voltage_step)
    switch_buffer = 100 + stim_duration
    slm_pattern = np.zeros(total_duration)
    duration = stim_duration + stim_interval
    pattern_indices = np.arange(switch_buffer, total_duration + duration, duration)
    pattern_indices[-1] = -1
    for n in range(num_neurons):
        slm_pattern[pattern_indices[n]:pattern_indices[n+1]] = neuron_ids[n]
    dt = np.ones(total_duration)
    slm = pl.DataFrame({"dt": dt, "voltage": slm_pattern})
    slm.write_csv(config_dir.joinpath("test_waveform.csv"), include_header=False)


