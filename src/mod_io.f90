module mod_io

  ! A helper module for parsing in CSV format.

  implicit none

  private
  public :: read_weather_data

contains

  integer function num_records(filename)
    ! Return the number of records (lines) of a text file.
    character(len=*), intent(in) :: filename
    integer :: fileunit
    open(newunit=fileunit, file=filename, status='old')
    num_records = 0
    do
      read(unit=fileunit, fmt=*, end=1)
      num_records = num_records + 1
    end do
    1 continue
    close(unit=fileunit)
  end function num_records

  subroutine read_weather_data(filename, temp, rh, wspd, clear)
    ! Read processed weather data from a CSV file.
    character(len=*), intent(in) :: filename
    real, allocatable, intent(out) :: temp(:), rh(:)
    integer, allocatable, intent(out) :: wspd(:)
    logical, allocatable, intent(out) :: clear(:)

    integer :: fileunit, n, nm
    nm = num_records(filename)

    allocate(temp(nm))
    allocate(rh(nm))
    allocate(wspd(nm))
    allocate(clear(nm))

    temp = 0
    rh = 0
    wspd = 0
    clear = .false.

    open(newunit=fileunit, file=filename, status='old')
    do n = 1, nm
      read(fileunit, fmt=*, end=1, err=2) temp(n), rh(n), wspd(n), clear(n)
      2 continue
    end do
    1 close(fileunit)

  end subroutine read_weather_data

end module mod_io
