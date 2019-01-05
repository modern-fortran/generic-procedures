module mod_weather_data

  use mod_io, only: read_weather_data

  implicit none

  private
  public :: weather_data

  type :: weather_data
    character(len=:), allocatable :: name
    real, allocatable :: temperature(:), humidity(:)
    integer, allocatable :: wind_speed(:)
    logical, allocatable :: clear_sky(:)
  end type weather_data

  interface weather_data
    module procedure :: weather_data_constructor
  end interface weather_data

contains

  type(weather_data) function weather_data_constructor(filename) result(res)
    character(len=*), intent(in) :: filename
    call read_weather_data(filename, res % temperature,&
      res % humidity, res % wind_speed, res % clear_sky)
    res % name = filename
  end function weather_data_constructor

end module mod_weather_data
