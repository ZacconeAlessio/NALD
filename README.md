For the NALD method to estimate the modulus, as shown in the flow chart PDF “NALD_Calculation_flow_chart.pdf”, there are three main input quantities: the density of states (DOS), the affine force-field correlator, and the friction kernel.

We start with a coarse-grained polymer melt system. First, the polymer melt is equilibrated at the particular temperature of interest. The equilibrated structure is then used to generate the Hessian matrix and affine force field using the LAMMPS input scripts “in.KG_cool_Hessian” and “in.KG_cool_affine”, respectively.

Next, the eigenvalues and eigenvectors are calculated from the Hessian matrix using the Python script “diagonalization.py”. After diagonalization, the density of states (DOS) is calculated using the script “cal_DOS_Gamma.py”, and the affine force-field correlator is also evaluated.

Finally, the storage and loss moduli over a range of externally applied frequencies are calculated using the Fortran codes “Gdp_KG.f90” and “Gp_KG.f90”.

In a similar way, one can formulate an atomistic system corresponding to real experimental situations and evaluate the viscoelastic modulus within the NALD framework.


/*
NALD Viscoelastic Modulus Calculation Package

```
This package implements the Non-Affine Lattice Dynamics (NALD)
framework for calculating the viscoelastic storage and loss
moduli of polymeric and amorphous materials.

Main components:
- Hessian matrix generation using LAMMPS
- Affine force-field calculation
- Eigenvalue and eigenvector analysis
- Density of States (DOS) evaluation
- Affine force-field correlator 
- Modulus calculation over frequency range

Typical workflow:
1. Equilibrate the polymer melt or atomistic structure
2. Generate Hessian matrix using:
     in.KG_cool_Hessian
3. Generate affine force field using:
     in.KG_cool_affine
4. Perform diagonalization using:
     diagonalization.py
5. Calculate DOS and correlators using:
     cal_DOS_Gamma.py
6. Evaluate G' and G'' using:
     Gp_KG.f90
     Gdp_KG.f90

This code can be used for coarse-grained polymer melts.

Developed by:
Zaccone Group's
University of Milan
Italy

Compilation examples:
gfortran Gp_KG.f90 -o Gp_KG.out
gfortran Gdp_KG.f90 -o Gdp_KG.out

License:
This code is provided for academic and research purposes only.
Users are free to modify and use the code with proper citation
to the original work and related publications.

V. V. Palyulin, C. Ness, R. Milkus, R. M. Elder, T. W. Sirk, and A. Zaccone,
Soft Matter 14, 8475 (2018).

A. Singh, V. Vaibhav, T. W. Sirk, and A. Zaccone, The Journal of Chemical
Physics 162 (2025).
```
*/
