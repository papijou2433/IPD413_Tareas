import numpy as np
import matplotlib.pyplot as plt

file_path = "simulations/"
file_name = "cs_amp_bode.raw"
file = file_path + file_name

# Load Freq and Magnitude[dB]
data = []
with open(file, "r") as f:
    for line in f:
        try:
            numbers = [float(x) for x in line.strip().split()]
            if len(numbers) == 2:
                data.append(numbers)
        except ValueError:
            continue

data = np.array(data)
Freq = data[:, 0]
Magnitude_dB = data[:, 1]

# Plot magnitude (Bode)
plt.figure(figsize=(8, 5))
plt.semilogx(Freq, Magnitude_dB, label="|Vout| [dB]")
plt.xlabel("Frequency [Hz]")
plt.ylabel("Magnitude [dB]")
plt.title("Bode Magnitude Plot")
plt.grid(True, which="both")
plt.legend()
plt.tight_layout()
plt.show()
