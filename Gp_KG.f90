Program G
implicit none
  integer, parameter :: n = 3*5000
  integer, parameter :: m = 3*5000
  real(8), parameter :: T = 0.5d0
  real(8), dimension(m) :: v, rk
  real(8), dimension(m) :: swp,wp, omega, ReK, ImK
  real(8), dimension(m) :: gamma
  integer i, j, k, l, p, tej
  real(8) :: sum,  constant, f, w, nu
  CHARACTER(50) F1,F2,F3,F4,F5,F6
  real(8), parameter :: G_A = 81   ! Depends on temperature
  real(8), parameter :: W_c = 1    ! Depends on temperature

rk=0
   do tej=0,2

write(F1,'(a,I1,a)')'run',tej,'/volume.dat'
open(unit=9,file=F1,status="old")
write(F2,'(a,I1,a,f3.1,a)')'run',tej,'/eigenvalues_T',T,'.data'
open(unit=10,file=F2,status="old")
write(F4,'(a,I1,a,f3.1,a)')'run',tej,'/gamma_T',T,'.data'
open(unit=111,file=F4,access='sequential',status='old',action='read')
write(F6,'(a,I1,a,f4.2,a)')'run',tej,'/G_prime_T',T,'.data'
open(unit=13,file=F6,status="unknown")

do k=1,1
read(9,*) v(k)
end do


do i=1,m
read(10,*) swp(i)
read(111,*) gamma(i)
end do

!++++++++++++++++++++++++++++

do i=1,m
   if(swp(i).le.0.d0) then
   wp(i)=-(sqrt(-swp(i)))
else
   wp(i)=  sqrt(swp(i))
end if
end do
!++++++++++++++++++++++++++++
do p=1,215
w=exp(-15+0.1d0*p)

nu=1.d0
constant=1.0*v(1)**(-1)

sum=0.d0
do i=1,m
if(abs(swp(i)).lt.+0.00001d0) then
gamma(i)=0.d0
elseif((swp(i)).gt.-W_c.and.(swp(i)).lt.+W_c) then 
gamma(i)=47.d0*abs(swp(i))
else
gamma(i)=gamma(i)
endif
f=-(swp(i)-w*w)*gamma(i)*((swp(i)-w*w)**(+2) + nu*nu*w*w)**(-1)
sum=sum+f
end do
write(13,*)w, sum*constant + G_A

end do

end do
14 format(2I7,15f10.2)
15 format(15f10.2)

!end do
end Program G

