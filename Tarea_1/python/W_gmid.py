import numpy as np
import matplotlib.pyplot as plt  # <-- corrección importante
from scipy.stats import linregress

data = []
i = 0
file_path = "simulations/"
file_name = "gmid_sweep_w.raw"
file = file_path + file_name

with open(file, "r") as f:
    for line in f:
        try:
            numbers = [float(x) for x in line.strip().split()]
            if len(numbers) >= 4:
                data.append(numbers[:4])
        except ValueError:
            continue

# Convert to numpy arrays
VGS = []
gmID = []
idW = []

for dataset in data:
    VGS.append(dataset[0])
    gmID.append(dataset[1])
    idW.append(dataset[3])

VGS = np.array(VGS)
gmID = np.array(gmID)
idW = np.array(idW)


plt.plot(idW, gmID)

plt.xlabel("Id/W [A/m]")
plt.ylabel("gm/id [S/A]]")
plt.tight_layout()
plt.grid(True)
plt.show()
