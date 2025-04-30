{% macro string_col(column_name) %}
  CAST({{ column_name }} AS STRING)
{% endmacro %}

{% macro int_col(column_name) %}
  CAST({{ column_name }} AS INT)
{% endmacro %}