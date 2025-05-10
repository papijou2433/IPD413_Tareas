import numpy as np
import matplotlib.pyplot as plt  # <-- corrección importante
from scipy.stats import linregress

data = [[]]
i = 0
file_path = "simulations/"
file_name = "ao_sweep_l.raw"
file = file_path + file_name

with open(file, "r") as f:
    for line in f:
        try:
            numbers = [float(x) for x in line.strip().split()]
            if len(numbers) >= 2:
                data[i].append(numbers[:2])
                if numbers[0] > 1.79:
                    i += 1
                    data.append([])
        except ValueError:
            continue

# Convert to numpy arrays
VDS = []
Ao = []
L = []
for dataset in data:
    arr = np.array(dataset)
    if arr.shape[0] > 0:  # evita errores por listas vacías
        VDS.append(arr[:, 0])
        Ao.append(arr[:, 1][98])

# Ejemplo: graficar curvas Id vs Vgs
# j=0
valor = 0
for i in range(len(VDS)):
    L.append(i * 0.01 + 0.13)
print(len(L))
print(len(Ao))
dy_dx = np.gradient(Ao, L)

fig, ax1 = plt.subplots(figsize=(8, 5))

color1 = "tab:blue"
ax1.set_xlabel("Length [µm]")
ax1.set_ylabel("Ao", color=color1)
ax1.plot(
    L,
    Ao,
    color=color1,  ##marker='o',
    label="Ao",
    linewidth=1,
)
ax1.tick_params(axis="y", labelcolor=color1)
ax1.grid(True)

# Create secondary y-axis sharing the same x-axis
ax2 = ax1.twinx()
color2 = "tab:red"
ax2.set_ylabel("dAo/dL Ao/µm", color=color2)
ax2.plot(
    L,
    dy_dx,
    color=color2,  ##marker='s'##,
    linestyle="--",
    label="dAo/dL",
    linewidth=1,
)
ax2.tick_params(axis="y", labelcolor=color2)

# Add titles and layout
plt.title("Ao vs Length with VDS=1.0[v]")
fig.tight_layout()
plt.show()
