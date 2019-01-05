module mod_arrays

  ! Utility functions that operate on arrays.

  use ieee_arithmetic, only: ieee_is_finite

  implicit none

  private
  public :: denan, normalize
  public :: operator(.denan.), operator(.normalize.)

  interface denan
    module procedure :: denan_int, denan_real
  end interface denan

  interface operator(.denan.)
    module procedure :: denan_int, denan_real
  end interface operator(.denan.)

  interface operator(.normalize.)
    module procedure :: normalize
  end interface operator(.normalize.)

contains

  pure function denan_int(x) result(denan)
    ! Returns the integer array x with NaN values removed.
    ! Overloaded by the generic function denan.
    integer, intent(in) :: x(:)
    integer, allocatable :: denan(:)
    denan = pack(x, ieee_is_finite(real(x)))
  end function denan_int

  pure function denan_real(x) result(denan)
    ! Returns the real array x with NaN values removed.
    ! Overloaded by the generic function denan.
    real, intent(in) :: x(:)
    real, allocatable :: denan(:)
    denan = pack(x, ieee_is_finite(x))
  end function denan_real

  pure function normalize(x) result(res)
    ! Normalizes the values of array x to the range [0, 1].
    real, intent(in) :: x(:)
    real :: res(size(x))
    res = (x - minval(x)) / (maxval(x) - minval(x))
  end function normalize

end module mod_arrays
