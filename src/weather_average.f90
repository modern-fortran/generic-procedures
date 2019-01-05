program weather_average

  use mod_arrays, only: denan, normalize, &
    operator(.denan.), operator(.normalize.)
  use mod_average, only: average, operator(.average.)
  use mod_weather_data, only: weather_data

  implicit none

  type(weather_data) :: dataset
  character(len=4), parameter :: cities(*) = &
    ['EGLL', 'LAX ', 'LYBE', 'MIA ', 'MMMX', &
     'NYC ', 'OIII', 'SEA ', 'SKBO', 'ZGSZ']
  integer :: n
  integer, parameter :: nm = size(cities)
  real :: temperature(nm), humidity(nm), wind_speed(nm), clear_sky(nm)
  real :: temperature_score(nm), humidity_score(nm),&
          wind_score(nm), clear_score(nm), total_score(nm)

  ! Read data and compute the averages
  do n = 1, nm
    dataset = weather_data('data/processed/' // trim(cities(n)) // '.csv')
    temperature(n) = .average. (.denan. dataset % temperature)
    humidity(n) = .average. (.denan. dataset % humidity)
    wind_speed(n) = .average. (.denan. dataset % wind_speed)
    clear_sky(n) = .average. dataset % clear_sky
  end do

  ! Compute scores
  temperature_score = .normalize. temperature ! the higher the better
  humidity_score = 1 - .normalize. humidity ! the lower the better
  wind_score = .normalize. wind_speed ! the higher the better
  clear_score = .normalize. clear_sky ! the higher the better
  total_score = (temperature_score + humidity_score &
    + wind_score + clear_score) / 4

  ! Generate the score table
  print *, 'City | Temp. | Humidity | Wind  | Clear | Total'
  print *, 'Code | Score | Score    | Score | Score | Score'
  print *, '-----+-------+----------+-------+-------+------'
  do n = 1, nm
    write(*,'(1x, a4, 3x, 5(f4.2, 5x))') cities(n), temperature_score(n),&
      humidity_score(n), wind_score(n), clear_score(n), total_score(n)
  end do

end program weather_average
