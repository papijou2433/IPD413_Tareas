import numpy as np
import matplotlib.pyplot as plt  # <-- corrección importante
from scipy.stats import linregress

data = []
i = 0
file_path = "simulations/"
file_name = "nmos_char_gmid-vov.raw"
file = file_path + file_name

with open(file, "r") as f:
    for line in f:
        try:
            numbers = [float(x) for x in line.strip().split()]
            if len(numbers) >= 4:
                data.append(numbers[:6])
        except ValueError:
            continue

gmID = []
vov = []
vov2 = []

for dataset in data:
    gmID.append(dataset[1])
    vov.append(dataset[3])
    vov2.append(dataset[5])


fig, axes = plt.subplots(1, 2, figsize=(12, 5))

# Plot with linear y-axis
axes[0].plot(gmID, vov)
axes[0].set_xlabel("gm/Id")
axes[0].set_ylabel("$V_{ov}[V]$")
# axes[0].grid(True)

# Plot with linear y-axis
axes[1].plot(gmID, vov2)
axes[1].set_xlabel("gm/Id")
axes[1].set_ylabel("$V_{ov}[V]$")
# axes[0].grid(True)
fig.tight_layout()
plt.show()
