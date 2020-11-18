{%- macro generate_daily_time_series_values(start_date, stop_date) -%}
    {# Used in conjunction with generate_daily_time_series_from, this macro returns a time series
        of values based on the start_date and stop_date using 1 day increments
       ARGS:
         - start_date (date) the start date of the series
         - stop_date (date) the ending date of the series
       RETURNS: A new column containing the generated series.
    #}

    {%- if target.type in ['postgres'] -%} 
        generate_series
    {%- elif target.type == 'snowflake' -%}
        dateadd(day, '-' || seq4(), '{{ stop_date }}')
    {%- else -%}
        {{ xdb.not_supported_exception('generate_time_series_values') }}
    {%- endif -%}
{%- endmacro -%}