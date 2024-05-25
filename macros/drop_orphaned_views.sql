{% macro drop_orphaned_views() %}

  -- Log the target schema
  {{ log("Target schema: " ~ target.schema, info=True) }}

  -- Query to get all existing views in the target schema
  {% set existing_views_query %}
    SELECT table_name
    FROM ANALYTICS.information_schema.views
    WHERE table_schema = 'DBT_MNICOLLE'
  {% endset %}

  -- Execute the query to get existing views
  {% set existing_views_result = run_query(existing_views_query) %}
  {% set existing_views = existing_views_result.columns['TABLE_NAME'] | map('upper') %}

  -- Log the existing views
  {{ log("Existing views: " ~ existing_views | join(', '), info=True) }}

  -- Get the list of DBT models
  {% set dbt_models = [] %}
  {% for model in graph.nodes.values() %}
    {% if model.resource_type == "model" and model.config.materialized == "view" %}
      {% set dbt_models = dbt_models.append(model.name) %}
    {% endif %}
  {% endfor %}

  -- Log the DBT models
  {{ log("DBT models: " ~ dbt_models | join(', '), info=True) }}

  -- Find and drop orphaned views
  {% for view in existing_views %}
    {% if view not in dbt_models %}
      {% set drop_view_query %}
        DROP VIEW IF EXISTS {{ target.schema }}.{{ view }}
      {% endset %}
      {{ log("Dropping orphaned view: " ~ view, info=True) }}
      {{ run_query(drop_view_query) }}
    {% endif %}
  {% endfor %}

{% endmacro %}
