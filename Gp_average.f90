Program Gave
implicit none
  integer, parameter :: n=3*5000
  integer, parameter :: m=3*5000
  real(8), parameter :: T=0.50
  real(8), dimension(0:m,m) ::  Gp
  real(8), dimension(m) :: w
  integer i, j, k, l, p, tej
  real(8) :: sum 
  CHARACTER(50) F1,F2
  integer, parameter :: run = 2

   do tej=0,run

   If(tej.lt.10) then

write(F1,'(a,I1,a,f4.2,a)')'run',tej,'/G_prime_T',T,'.data'
open(unit=1,file=F1,access='sequential',status='old',action='read')

write(F2,'(a,I1,a,f4.2,a)')'run',tej,'/G_pave_T',T,'.dat'
open(unit=2,file=F2,status='unknown',action='write')
   else
write(F1,'(a,I2,a,f4.2,a)')'run',tej,'/G_prime_T',T,'.data'
open(unit=1,file=F1,access='sequential',status='old',action='read')

write(F2,'(a,I2,a,f4.2,a)')'run',tej,'/G_pave_T',T,'.dat'
open(unit=2,file=F2,status='unknown',action='write')
end if

do p=1,215
read(1,*)w(p), Gp(tej,p)
end do
end do

do p=1,215
sum=0
do tej=0,run
sum=sum+Gp(tej,p)
end do
write(2,15) w(p),(sum/(run+1))
end do

15 format(5e15.7)

end Program Gave
