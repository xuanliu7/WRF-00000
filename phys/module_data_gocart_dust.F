Module module_data_gocart_dust
  INTEGER, PARAMETER :: ndust=7,ndcls=3,ndsrc=1,maxstypes=100
  INTEGER, PARAMETER :: ngsalt=9
! GAC-->
! 20130219 - Drypoint no longer needed.  Use NOAA porosity for all schemes to
! allow use of AFWA dust scheme by all LSMs, not just NOAA and RUC.
!  real, dimension (maxstypes) :: drypoint
!  real, dimension (maxstypes) :: porosity
  real, dimension (19), PARAMETER :: porosity=(/0.339, 0.421, 0.434, 0.476, 0.476, 0.439, &
                                                0.404, 0.464, 0.465, 0.406, 0.468, 0.468, &
                                                0.439, 1.000, 0.200, 0.421, 0.468, 0.200, &
                                                0.339/)
! <--GAC

  REAL :: ch_dust(ndust,12)
  REAL,    PARAMETER :: dyn_visc = 1.5E-5
!  real*8, DIMENSION (ndust), PARAMETER :: den_dust(ndust)=(/2500.,2650.,2650.,2650.,2650.,2650.,2650./)
  real*8, DIMENSION (ndust)            :: den_dust(ndust)=(/2500.,2650.,2650.,2650.,2650.,2650.,2650./)
  ! reff_dust(6)/(7): arithmetic mean of ra_dust/rb_dust (same convention as
  ! bins 2-5; see ra_dust/rb_dust below). den_dust(6)/(7): same 2650 kg/m3
  ! crustal mineral density used for bins 2-5.
  real*8, DIMENSION (ndust), PARAMETER :: reff_dust(ndust)=(/0.73D-6,1.4D-6,2.4D-6,4.5D-6,8.0D-6,13.75D-6,24.375D-6/)
  INTEGER, DIMENSION (5), PARAMETER :: ipoint(5)=(/3,2,2,2,2/)
  REAL, DIMENSION (5), PARAMETER :: frac_s(5)=(/0.1,0.25,0.25,0.25,0.25/)

  real*8, DIMENSION (ngsalt), PARAMETER :: reff_salt=(/0.71D-6,1.37D-6,2.63D-6,5.00D-6,9.50D-6,18.1D-6,34.5D-6,65.5D-6,125.D-6/)
  real*8, DIMENSION (ngsalt), PARAMETER :: den_salt=(/2500.,2650.,2650.,2650.,2650.,2650.,2650.,2650.,2650./)
  INTEGER, DIMENSION (ngsalt), PARAMETER :: spoint=(/1,2,2,2,2,2,3,3,3/)  ! 1 Clay, 2 Silt, 3 Sand
  real*8, DIMENSION (ngsalt), PARAMETER :: frac_salt=(/1.,0.2,0.2,0.2,0.2,0.2,0.333,0.333,0.333/)

  ! distr_dust: fraction of total emitted dust mass assigned to each bin.
  ! Bins 1-5 (0.2-20um diameter) use the Meng et al. (2022, GRL,
  ! doi:10.1029/2021GL097287) BFT-supercoarse revision of Kok (2011)'s
  ! brittle fragmentation theory (revised Dbar_s=1.13um, sigma_s=1.92).
  ! Bins 6-7 (20-62.5um diameter, "super coarse" dust) extend the same
  ! formula using the size-dependent crack propagation length
  ! lambda=f_lambda*D_agg (f_lambda~0.15, lognormal soil aggregate size
  ! distribution: median 127um, sigma_agg=2.95). All 7 values normalized
  ! to sum to 1.
  real*8, DIMENSION (ndust), PARAMETER :: distr_dust=(/9.61D-2,6.28D-2,9.13D-2,1.895D-1,1.768D-1,2.05D-1,1.785D-1/)
! real*8, DIMENSION (ndust), PARAMETER :: lo_dust=(/0.1D-6,1.0D-6,1.8D-6,3.0D-6,6.0D-6,10.0D-6,17.5D-6/)
! real*8, DIMENSION (ndust), PARAMETER :: up_dust=(/1.0D-6,1.8D-6,3.0D-6,6.0D-6,10.0D-6,17.5D-6,31.25D-6/)

  !GOCART bins radii ranges
  real*8, DIMENSION (ndust), PARAMETER :: ra_dust(ndust)=(/1.d-1,1.0d0,1.8d0,3.0d0,6.0d0,10.0d0,17.5d0/)
  real*8, DIMENSION (ndust), PARAMETER :: rb_dust(ndust)=(/1.0d0,1.8d0,3.0d0,6.0d0,10.0d0,17.5d0,31.25d0/)


END Module module_data_gocart_dust


