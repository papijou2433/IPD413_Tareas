import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import linregress

# Path to the data file
file_path = "simulations/nmos_char_1d.raw"

# Load the data, skipping non-numeric lines (e.g., headers)
data = []
with open(file_path, "r") as f:
    for line in f:
        try:
            numbers = [float(x) for x in line.strip().split()]
            if len(numbers) >= 2:
                data.append(numbers[:2])
        except ValueError:
            # Skip lines that don't contain valid floats
            continue

# Convert to numpy array for easier indexing
data = np.array(data)

# Extract columns: VGS and IDS
VGS = data[:, 0]
IDS = data[:, 1]

# Create subplots: 1 row, 2 columns

# Plot with linear y-axis
plt.plot(VGS, IDS)
plt.xlabel("$V_{GS}$ (V)")
plt.ylabel("$I_{DS}$ (A)")
plt.title("$I_{DS}$ vs $V_{GS}$ (Linear Scale)")
plt.grid(True)

plt.figure()
# Plot with logarithmic y-axis
plt.plot(VGS, IDS)
plt.xlabel("$V_{GS}$ (V)")
plt.ylabel("$I_{DS}$ (A)")
plt.yscale("log")
plt.title("$I_{DS}$ vs $V_{GS}$ (Logarithmic Scale)")
plt.grid(True, which="both", linestyle="--")

# Calculate the subthreshold slope in the region 0 <= VGS <= 0.25 V
mask = (VGS >= 0) & (VGS <= 0.25)
VGS_sub = VGS[mask]
IDS_sub = IDS[mask]

# Ensure IDS values are positive before taking the logarithm
IDS_sub = np.abs(IDS_sub)

# Perform linear regression on log(IDS) vs VGS
slope, intercept, r_value, p_value, std_err = linregress(VGS_sub, np.log10(IDS_sub))

# Calculate subthreshold swing (S) in mV/decade
S = 1 / slope * 1000  # mV/decade

# Display the subthreshold swing value
print(f"Subthreshold Swing (S): {S:.2f} mV/decade")

# Adjust layout
plt.tight_layout()
plt.show()
