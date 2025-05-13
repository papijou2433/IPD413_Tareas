import numpy as np
import matplotlib.pyplot as plt  # <-- corrección importante
from scipy.stats import linregress

data = [[]]
i = 0
file_path = "simulations/"
file_name = "nmos_char_gmid-ft.raw"
file = file_path + file_name

with open(file, "r") as f:
    for line in f:
        try:
            numbers = [float(x) for x in line.strip().split()]
            if len(numbers) >= 4:
                data[i].append(numbers[:4])
                if numbers[0] > 1.79:
                    i += 1
                    data.append([])
        except ValueError:
            continue

# Convert to numpy arrays
VGS = []
gmID = []
ft = []

for dataset in data:
    arr = np.array(dataset)
    if arr.shape[0] > 0:  # evita errores por listas vacías
        VGS.append(arr[:, 0])
        gmID.append(arr[:, 1])
        ft.append(arr[:, 3])


fig, ax1 = plt.subplots(figsize=(8, 5))
color1 = "tab:blue"
ax1.set_xlabel("Vgs [V]")
ax1.set_ylabel("gm/Id [S/A]", color=color1)
ax1.plot(
    VGS[7],
    gmID[7],
    color=color1,  ##marker='o',
    label="gm/Id",
    linewidth=3,
)
ax1.tick_params(axis="y", labelcolor=color1)
ax1.grid(True)

# Create secondary y-axis sharing the same x-axis
ax2 = ax1.twinx()
color2 = "tab:red"
ax2.set_ylabel("fT [GHz]", color=color2)
ax2.plot(
    VGS[7],
    ft[7],
    color=color2,  ##marker='s'##,
    linestyle="--",
    label="fT",
    linewidth=2,
)
ax2.tick_params(axis="y", labelcolor=color2)

# Add titles and layout
plt.title("gm/Id and fT vs Vgs")
fig.tight_layout()
plt.show()
