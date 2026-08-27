MODULE module_data_mineral_cri
!
! Mineral-resolved complex refractive index (CRI) tables for dust radiative
! calculations (namelist dust_mineral_opt=1). Values are n,k interpolated
! from Zhang et al. (2023) mineral optical constants (with an added
! iron-oxide entry), sampled at the same spectral points already used for
! the bulk dust CRI in module_data_rrtmgaeropt.F:
!   - shortwave: 300, 400, 600, 999 nm (the 4 GOCART AOD diagnostic
!     wavelengths -- see tauaer1..4 / tauaer300..999 in
!     module_ra_rrtmg_sw.F)
!   - longwave: the 16 RRTMG-LW band-center wavelengths (from wavenum1/
!     wavenum2 in phys/module_ra_rrtmg_lw.F). Source data (the "_60um"
!     dataset) spans 0.1-60um, which covers all 16 band centers (the
!     longest, band 1, is ~55.6um) -- no extrapolation/clamping needed.
!
! Mineral order MUST match DUST_MINERALOGY / the dust_<bin>_min<N>
! Registry species (N=1..8):
!   1=iron_oxide (treated as the Maxwell-Garnett inclusion/accretion),
!   2=calcite, 3=gypsum, 4=quartz, 5=feldspar, 6=illite, 7=kaolinite,
!   8=montmorillonite (2-8 form the volume-weighted-mean host).
!
      USE module_data_rrtmgaeropt, only: nswbands, nlwbands
      IMPLICIT NONE

      INTEGER, PARAMETER :: nmineral = 8
      INTEGER, PARAMETER :: mineral_fe = 1   ! iron_oxide index (MG inclusion)

      ! Mineral densities (g/cm3 = kg/m3 / 1000, matching this file's cgs
      ! mass/volume convention used throughout module_optical_averaging.F).
      REAL, DIMENSION(nmineral), PARAMETER :: dens_mineral =              &
        (/ 2.500, 2.710, 2.312, 2.655, 2.680, 2.795, 2.630, 2.350 /)
        ! iron_oxide, calcite, gypsum, quartz, feldspar, illite, kaolinite, montmorillonite

      ! Shortwave n (300/400/600/999nm columns, one column per mineral)
      REAL, DIMENSION(nswbands,nmineral), PARAMETER :: refrsw_mineral = RESHAPE( (/ &
        1.6820, 2.3960, 2.9170, 2.6832,  &  ! iron_oxide
        1.6353, 1.6069, 1.5872, 1.5762,  &  ! calcite
        1.5248, 1.5235, 1.5228, 1.5206,  &  ! gypsum
        1.5607, 1.5463, 1.5324, 1.5288,  &  ! quartz
        1.5561, 1.5438, 1.5355, 1.5276,  &  ! feldspar
        1.4010, 1.4230, 1.4110, 1.3870,  &  ! illite
        1.5775, 1.5415, 1.5305, 1.5310,  &  ! kaolinite
        1.5631, 1.5538, 1.5381, 1.5324   &  ! montmorillonite
        /), (/nswbands,nmineral/) )

      ! Shortwave k
      REAL, DIMENSION(nswbands,nmineral), PARAMETER :: refisw_mineral = RESHAPE( (/ &
        0.028710, 0.300400, 0.073200, 0.101384,  &  ! iron_oxide
        0.000262, 0.000251, 0.000251, 0.000251,  &  ! calcite
        0.000003, 0.000003, 0.000002, 0.000005,  &  ! gypsum
        0.000000, 0.000000, 0.000000, 0.000000,  &  ! quartz
        0.003435, 0.000760, 0.000899, 0.001004,  &  ! feldspar
        0.001820, 0.001175, 0.000708, 0.001230,  &  ! illite
        0.009586, 0.002857, 0.003319, 0.003129,  &  ! kaolinite
        0.007883, 0.002467, 0.000868, 0.000926   &  ! montmorillonite
        /), (/nswbands,nmineral/) )

      ! Longwave n (16 RRTMG-LW band centers, one column per mineral)
      REAL, DIMENSION(nlwbands,nmineral), PARAMETER :: refrlw_mineral = RESHAPE( (/ &
        1.6820,2.8368,0.6425,1.0287,1.6357,1.7946,1.9167,1.9854, &
        2.0785,2.2483,2.1354,2.1923,2.2214,2.2374,2.2534,2.2821, &  ! iron_oxide
        2.2255,0.9471,1.4269,1.5485,1.5759,1.4291,1.6585,1.7370, &
        1.9853,1.4339,1.0913,1.3724,1.4265,1.4469,1.4633,1.4865, &  ! calcite
        2.8003,1.5187,1.6507,1.3393,1.3956,1.5786,1.8893,1.5888, &
        1.1542,1.3263,1.2961,1.4014,1.4188,1.4218,1.4300,1.4529, &  ! gypsum
        1.9707,2.7105,1.2144,1.6095,2.0048,1.9013,3.1153,0.4027, &
        0.6739,1.1044,1.2898,1.3820,1.4100,1.4245,1.4380,1.4602, &  ! quartz
        1.8219,2.0348,1.8214,1.5309,1.7412,2.3801,1.7297,1.1119, &
        1.0857,1.3327,1.4578,1.5339,1.4601,1.4687,1.4797,1.4897, &  ! feldspar
        2.0537,2.4476,0.9675,1.3071,1.4956,1.8302,1.7578,0.6863, &
        1.1147,1.2532,1.3161,1.3611,1.3594,1.3670,1.3730,1.3711, &  ! illite
        2.3849,2.5111,1.1231,1.0571,1.3839,2.1076,2.1832,0.5894, &
        1.1237,1.2519,1.3208,1.3639,1.3624,1.3704,1.3768,1.3762, &  ! kaolinite
        2.1389,2.5846,1.0430,1.2811,1.5350,1.8579,2.0619,0.8262, &
        1.1294,1.2758,1.3534,1.4055,1.4537,1.4682,1.4914,1.4934  &  ! montmorillonite
        /), (/nlwbands,nmineral/) )

      ! Longwave k
      REAL, DIMENSION(nlwbands,nmineral), PARAMETER :: refilw_mineral = RESHAPE( (/ &
        0.028710,2.193679,1.733198,0.314244,0.154611,0.208753,0.095575,0.076964, &
        0.068636,0.102163,0.019792,0.020797,0.020368,0.019479,0.018964,0.016723, &  ! iron_oxide
        0.125921,0.118483,0.014727,0.009026,0.008099,0.042302,0.009073,0.013194, &
        0.044598,1.929479,0.048632,0.006421,0.003192,0.002294,0.001773,0.001085, &  ! calcite
        1.258671,0.464545,0.350710,0.596986,0.055650,0.056167,0.083482,1.971693, &
        0.067378,0.052417,0.095574,0.030008,0.026701,0.021724,0.006282,0.002890, &  ! gypsum
        0.012769,0.567199,0.158156,0.070899,0.188511,0.048913,0.584663,1.824642, &
        0.061559,0.008555,0.002008,0.000648,0.000445,0.000342,0.000245,0.000123, &  ! quartz
        0.265830,1.014185,0.771158,0.416962,0.363647,0.491961,1.327006,1.078117, &
        0.172012,0.127096,0.070067,0.025466,0.017713,0.015799,0.014225,0.010657, &  ! feldspar
        0.157123,0.756550,0.880475,0.194838,0.175949,0.167168,1.541886,0.609940, &
        0.056776,0.054459,0.041164,0.024294,0.041088,0.043472,0.047679,0.047428, &  ! illite
        0.268371,0.950243,1.740859,0.341775,0.157110,0.340371,1.825086,0.578602, &
        0.046511,0.042314,0.039478,0.029127,0.058379,0.055197,0.054997,0.050376, &  ! kaolinite
        0.135338,0.778666,0.874996,0.257356,0.181396,0.241747,1.304768,0.732666, &
        0.066189,0.033976,0.021774,0.011382,0.019024,0.016672,0.017820,0.022313  &  ! montmorillonite
        /), (/nlwbands,nmineral/) )

END MODULE module_data_mineral_cri
