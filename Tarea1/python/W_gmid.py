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
idw = []

for dataset in data:
    VGS.append(dataset[0])
    gmID.append(dataset[1])
    idw.append(dataset[3])


# Ejemplo: graficar curvas Id vs Vgs
# j=0
valor = 0
plt.plot(
    gmID,
    idw,
    label=f"W= {float(valor)/100} µ",
    linewidth=0.1,
    marker="o",
)
# j+=1

plt.xlabel("gm/Id [V]")
plt.ylabel("Id/W")
# plt.title("NMOS Id vs Vgs para diferentes Vds")
# plt.legend()
plt.grid(True)
plt.show()
