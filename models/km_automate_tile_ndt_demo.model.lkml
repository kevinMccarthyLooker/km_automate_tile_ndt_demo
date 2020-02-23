connection: "thelook_events_redshift"

# include all the views
include: "/views/**/*.view"

datagroup: km_automate_tile_ndt_demo_default_datagroup {sql_trigger: SELECT MAX(id) FROM public.users;;}

persist_with: km_automate_tile_ndt_demo_default_datagroup

## Base explore (auto-generated)
explore: order_items {
  join: users {
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
  join: inventory_items {
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }
  join: products {
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: user_lifetime_summary {
    sql_on: ${user_lifetime_summary.user_id}=${order_items.user_id} ;;
    relationship: many_to_one
  }
}

include: "/tile_ndts/look_1"
