with
    dates_raw as (
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="'1970-01-01'",
        end_date="dateadd(year, 100, current_date())"
    ) }}
)

    , days_info as (
        select 
            cast(date_day as date) as date_full,
            extract(day from date_day) as day_param,
            extract(month from date_day) as month_param,
            extract(year from date_day) as year_param,
            case
                when extract(month from date_day) = 1 then 'January'
                when extract(month from date_day) = 2 then 'February'
                when extract(month from date_day) = 3 then 'March'
                when extract(month from date_day) = 4 then 'April'
                when extract(month from date_day) = 5 then 'May'
                when extract(month from date_day) = 6 then 'June'
                when extract(month from date_day) = 7 then 'July'
                when extract(month from date_day) = 8 then 'August'
                when extract(month from date_day) = 9 then 'September'
                when extract(month from date_day) = 10 then 'October'
                when extract(month from date_day) = 11 then 'November'
                else 'December'
            end as month_name
        from dates_raw
    )

select
    row_number() over (order by date_full) as sk_date_full
    , date_full
    , day_param
    , month_param
    , month_name
    , year_param
from
    days_info