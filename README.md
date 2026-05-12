# NALD

Code for computing viscoelastic storage and loss moduli using the Non-Affine Lattice Dynamics (NALD) framework.

The NALD framework enables the calculation of frequency-dependent viscoelastic moduli from microscopic structural and dynamical information of amorphous and polymeric materials. The methodology combines molecular simulations, Hessian matrix analysis, affine force-field correlations, and non-affine lattice dynamics theory.

---

## Overview

The calculation of the viscoelastic modulus within the NALD framework requires three main quantities:

- Density of states (DOS)
- Affine force-field correlator
- Friction kernel

Starting from an equilibrated polymer melt or atomistic configuration at a given temperature, the workflow proceeds through Hessian matrix construction, eigenmode analysis, DOS evaluation, and finally the computation of the storage modulus G'(\omega) and loss modulus G''(\omega).

The same methodology can also be applied to atomistic systems representing experimentally relevant materials.

---

## Workflow

The overall workflow is illustrated in the file:

- `NALD_Calculation_flow_chart.pdf`

### Step 1 — Equilibrate the system

Prepare and equilibrate the polymer melt or atomistic configuration at the target temperature using molecular dynamics simulations.

### Step 2 — Generate the Hessian matrix

Use the LAMMPS input script:

```bash
in.KG_cool_Hessian
```

to generate the Hessian matrix of the equilibrated configuration.

### Step 3 — Generate the affine force field

Use the LAMMPS input script:

```bash
in.KG_cool_affine
```

to compute the affine force-field vectors.

### Step 4 — Diagonalize the Hessian matrix

Run:

```bash
python diagonalization.py
```

This script computes:

- Eigenvalues
- Eigenvectors
- Mode-resolved quantities required for NALD calculations

### Step 5 — Calculate DOS and affine correlator

Run:

```bash
python cal_DOS_Gamma.py
```

This script evaluates:

- Vibrational density of states (DOS)
- Affine force-field correlator

### Step 6 — Compute viscoelastic moduli

Compile the Fortran programs:

```bash
gfortran Gp_KG.f90 -o Gp_KG.out
gfortran Gdp_KG.f90 -o Gdp_KG.out
```

Run:

```bash
./Gp_KG.out
./Gdp_KG.out
```

These programs compute:

- Storage modulus \(G'(\omega)\)
- Loss modulus \(G''(\omega)\)

over a range of externally applied frequencies.

---

## Repository Contents

| File | Description |
|---|---|
| `in.KG_cool_Hessian` | LAMMPS input script for Hessian matrix generation |
| `in.KG_cool_affine` | LAMMPS input script for affine force-field calculation |
| `diagonalization.py` | Hessian diagonalization and eigenmode analysis |
| `cal_DOS_Gamma.py` | DOS and affine correlator evaluation |
| `Gp_KG.f90` | Storage modulus calculation |
| `Gdp_KG.f90` | Loss modulus calculation |
| `NALD_Calculation_flow_chart.pdf` | Workflow diagram for the NALD methodology |

---

## Requirements

The following software/packages are required:

- LAMMPS
- Python 3
- NumPy
- SciPy
- Fortran compiler (`gfortran` recommended)

---

## Typical Input Files

Depending on the workflow and simulation setup, the scripts may require files such as:

- Hessian matrices
- Affine force-field data
- Eigenvalue/eigenvector files
- Volume and thermodynamic data

Users may need to modify hard-coded parameters such as:

- Temperature
- Number of particles
- Frequency range
- Directory structure
- Material constants

directly within the Python and Fortran scripts.

---

## Viscosity of Liquids

In addition to computing the frequency-dependent storage and loss moduli, the NALD framework can also be used to estimate the zero-frequency shear viscosity of liquids and supercooled liquids.

This approach is based on instantaneous normal mode analysis and non-affine response theory. Instead of integrating long-time stress autocorrelation functions, as in the Green–Kubo method, the viscosity is obtained from the zero-frequency limit of the loss modulus:

```math
\eta = \lim_{\Omega \to 0} \frac{G''(\Omega)}{\Omega}
```

Within the NALD framework, this gives:

```math
\eta =
\frac{N \nu(0)}{V}
\int
\frac{\Gamma(\omega) g(\omega)}
{m^2 \omega^4}
d\omega
```

where:

- \(N\) is the number of particles
- \(V\) is the system volume
- \(m\) is the particle mass
- \(\nu(0)\) is the zero-frequency friction coefficient
- \(g(\omega)\) is the vibrational density of states
- \(\Gamma(\omega)\) is the affine force-field correlator

For finite-temperature liquid configurations, the Hessian matrix may contain both positive and negative eigenvalues. These correspond to real and imaginary instantaneous normal modes. Both branches can contribute to the viscosity and should be included in the integration where appropriate.

This method is particularly useful near the glass transition, where conventional Green–Kubo calculations become computationally expensive due to the slow decay of stress autocorrelation functions.

The viscosity calculation follows the methodology described in:

A. Singh, V. Vaibhav, T. W. Sirk, and A. Zaccone,  
*Viscosity of polymer melts using non-affine theory based on vibrational modes*,  
*The Journal of Chemical Physics* **162**, 244504 (2025).
## Applications

This package can be used for:

- Coarse-grained polymer melts
- Glassy and amorphous solids
- Atomistic materials models
- Frequency-dependent viscoelastic response calculations

---

## Developed By

**Zaccone Group**  
University of Milan  
Italy

---

## Citation

If you use this code in your research, please cite:

1. V. V. Palyulin, C. Ness, R. Milkus, R. M. Elder, T. W. Sirk, and A. Zaccone,  
   *Soft Matter* **14**, 8475 (2018).

2. A. Singh, V. Vaibhav, T. W. Sirk, and A. Zaccone,  
   *The Journal of Chemical Physics* **162** (2025).

---

## License

This code is provided for academic and research purposes only.

Users are free to use and modify the code with appropriate citation to the original publications.
