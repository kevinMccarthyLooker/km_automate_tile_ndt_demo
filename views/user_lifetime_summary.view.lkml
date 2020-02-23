view: user_lifetime_summary {
  derived_table: {
    sql:
select user_id, count(*) as lifetime_order_count from public.order_items group by 1
    ;;
  }
  dimension: user_id {primary_key:yes}
  dimension: lifetime_order_count {}
}
