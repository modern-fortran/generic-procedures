module mod_average

  ! This module provides the generic function average that returns
  ! the average value of an integer, real, or logical array.

  implicit none

  private
  public :: average, operator(.average.)

  interface average
    module procedure :: average_int
    module procedure :: average_real
    module procedure :: average_logical
  end interface average

  interface operator(.average.)
    module procedure :: average_int, average_real, average_logical
  end interface operator(.average.)

contains

  pure real function average_int(x) result(res)
    ! Returns an average of a real array x.
    ! Overloaded by the generic function average.
    integer, intent(in) :: x(:)
    res = real(sum(x), kind=kind(res)) / size(x)
  end function average_int

  pure real function average_real(x) result(res)
    ! Returns an average of a real array x.
    ! Overloaded by the generic function average.
    real, intent(in) :: x(:)
    res = sum(x) / size(x)
  end function average_real

  pure real function average_logical(x) result(res)
    ! Returns an average of a real array x.
    ! Overloaded by the generic function average.
    logical, intent(in) :: x(:)
    res = real(count(x), kind=kind(res)) / size(x)
  end function average_logical

end module mod_average
